#region imports

using System;
using System.IO;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;
using System.Diagnostics;
using System.Collections;

using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore;

using ProjectManager.Projects;
using ProjectManager.Projects.AS3;
using ProjectManager.Projects.AS2;

using ASCompletion.Model;
using ASCompletion.Context;

using ASClassWizard.Resources;
using ASClassWizard.Wizards;

using System.Text.RegularExpressions;
using ASCompletion.Completion;

#endregion

namespace ASClassWizard
{
	public class PluginMain : IPlugin
	{
        private String pluginName = "ASClassWizard";
        private String pluginGuid = "a2c159c1-7d21-4483-aeb1-38d9fdc4c7f3";
        private String pluginHelp = "www.flashdevelop.org";
        private String pluginDesc = "Provides an ActionScript class wizard for FlashDevelop.";
        private String pluginAuth = "FlashDevelop Team";
        
        private String settingFilename;
        private Settings settingObject;
        private AS3ClassOptions lastFileOptions;
        private String lastFileFromTemplate;
        private String processOnSwitch;

        public static IMainForm MainForm { get { return PluginBase.MainForm; } }

	    #region Required Properties

        /// <summary>
        /// Name of the plugin
        /// </summary> 
        public String Name
		{
			get { return this.pluginName; }
		}

        /// <summary>
        /// GUID of the plugin
        /// </summary>
        public String Guid
		{
			get { return this.pluginGuid; }
		}

        /// <summary>
        /// Author of the plugin
        /// </summary> 
        public String Author
		{
			get { return this.pluginAuth; }
		}

        /// <summary>
        /// Description of the plugin
        /// </summary> 
        public String Description
		{
			get { return this.pluginDesc; }
		}

        /// <summary>
        /// Web address for help
        /// </summary> 
        public String Help
		{
			get { return this.pluginHelp; }
		}

        /// <summary>
        /// Object that contains the settings
        /// </summary>
        [Browsable(false)]
        public Object Settings
        {
            get { return null; }
        }
		
		#endregion
		
		#region Required Methods
		
		public void Initialize()
		{
            // Load and initialize settings
            this.InitBasics();
            this.LoadSettings();

            this.AddEventHandlers();
            this.InitLocalization();
        }
		
		public void Dispose()
		{
            this.SaveSettings();
		}
		
		public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
		{
            Project project;

            switch (e.Type)
            {
                case EventType.Command:
                    DataEvent evt = (DataEvent)e;
                    if (evt.Action == "ProjectManager.CreateNewFile")
                    {
                        Hashtable table = evt.Data as Hashtable;
                        project = PluginBase.CurrentProject as Project;
                        if ((project.Language == "as3" || project.Language == "as2") 
                            && Path.GetFileName(table["templatePath"] as String).Equals("Class.as.fdt"))
                        {
                            evt.Handled = true;
                            DisplayClassWizard(table["inDirectory"] as String);
                        }
                    }
                    break;

                case EventType.FileSwitch:
                    if (PluginBase.MainForm.CurrentDocument.FileName == processOnSwitch)
                    {
                        processOnSwitch = null;
                        if (lastFileOptions == null || lastFileOptions.interfaces == null)
                            return;

                        foreach (String cname in lastFileOptions.interfaces)
                        {
                            ASContext.Context.CurrentModel.Check();
                            ClassModel inClass = ASContext.Context.CurrentModel.GetPublicClass();
                            ASGenerator.SetJobContext(null, cname, null, null);
                            ASGenerator.GenerateJob(GeneratorJobType.ImplementInterface, null, inClass);
                        }
                    }
                    break;

                case EventType.ProcessArgs:
                    TextEvent te = e as TextEvent;
                    project = PluginBase.CurrentProject as Project;
                    if (lastFileFromTemplate != null && project != null 
                        && (project.Language == "as3" || project.Language == "as2"))
                    {
                        //te.Handled = true;
                        /*BuildEventVars vars = new BuildEventVars(project);
                        foreach (BuildEventInfo info in vars.GetVars())
                            te.Value = te.Value.Replace("$(" + info.Name + ")", info.Value);*/

                        te.Value = ProcessArgs(project, te.Value);
                    }
                    
                    break;
            }
		}
		
		#endregion

        #region Settings

        public void InitBasics()
        {
            String dataPath = Path.Combine(PathHelper.DataDir, "ASClassWizard");
            if (!Directory.Exists(dataPath)) Directory.CreateDirectory(dataPath);
            this.settingFilename = Path.Combine(dataPath, "Settings.fdb");
        }

        public void LoadSettings()
        {
            this.settingObject = new Settings();
            if (!File.Exists(this.settingFilename)) this.SaveSettings();
            else
            {
                Object obj = ObjectSerializer.Deserialize(this.settingFilename, this.settingObject);
                this.settingObject = (Settings)obj;
            }
        }

        public void SaveSettings()
        {
            ObjectSerializer.Serialize(this.settingFilename, this.settingObject);
        }

        #endregion

        #region Custom Methods

        public void AddEventHandlers()
        {
            EventManager.AddEventHandler(this, EventType.Command | EventType.ProcessArgs);
            EventManager.AddEventHandler(this, EventType.FileSwitch, HandlingPriority.Low);
        }

        public void InitLocalization()
        {
            this.pluginDesc = TextHelper.GetString("Info.Description");
        }

        private void DisplayClassWizard(String inDirectory)
        {
            Project project = PluginBase.CurrentProject as Project;

            String classpath = project.AbsoluteClasspaths.GetClosestParent(inDirectory);
            String package;

            try
            {
                package = Path.GetDirectoryName(ProjectPaths.GetRelativePath(classpath, Path.Combine(inDirectory, "foo")));
            }
            catch (System.NullReferenceException)
            {
                package = "";
            }

            AS3ClassWizard dialog = new AS3ClassWizard();
            dialog.Project        = project;
            dialog.Directory      = inDirectory;

            if (package != null)
            {
                package = package.Replace(Path.DirectorySeparatorChar, '.');
                dialog.StartupPackage = package;
            }

            if (dialog.ShowDialog() == DialogResult.OK)
            {
                string cPackage     = dialog.getPackage();
                string newFilePath  = Path.ChangeExtension(Path.Combine(dialog.Directory, dialog.getClassName()), ".as");

                if (File.Exists(newFilePath))
                {
                    string title = " " + TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
                    string message = TextHelper.GetString("ProjectManager.Info.FolderAlreadyContainsFile");

                    DialogResult result = MessageBox.Show(PluginBase.MainForm, string.Format(message, newFilePath, "\n"),
                        title, MessageBoxButtons.YesNoCancel, MessageBoxIcon.Warning);

                    if (result == DialogResult.Cancel) return;
                }

                string templatePath = Path.Combine(ProjectPaths.FileTemplatesDirectory, Path.Combine(project.GetType().Name, "Class.as.fdt"));
                lastFileFromTemplate = newFilePath;

                lastFileOptions = new AS3ClassOptions(
                    project.Language,
                    dialog.getSuperClass(),
                    dialog.hasInterfaces() ? dialog.getInterfaces() : null,
                    dialog.isPublic(),
                    dialog.isDynamic(),
                    dialog.isFinal(),
                    dialog.getGenerateInheritedMethods(),
                    dialog.getGenerateConstructor()
                  );

                MainForm.FileFromTemplate(templatePath, newFilePath);
            }
        }

        public string ProcessArgs(Project project, string args)
        {
            if (lastFileFromTemplate != null)
            {
                string fileName = Path.GetFileNameWithoutExtension(lastFileFromTemplate);

                args = args.Replace("$(FileName)", fileName);

                if (args.Contains("$(FileNameWithPackage)") || args.Contains("$(Package)"))
                {
                    string package = "";
                    string path = lastFileFromTemplate;

                    // Find closest parent
                    string classpath = project.AbsoluteClasspaths.GetClosestParent(path);

                    // Can't find parent, look in global classpaths
                    if (classpath == null)
                    {
                        PathCollection globalPaths = new PathCollection();
                        foreach (string cp in ProjectManager.PluginMain.Settings.GlobalClasspaths)
                            globalPaths.Add(cp);
                        classpath = globalPaths.GetClosestParent(path);
                    }
                    if (classpath != null)
                    {
                        // Parse package name from path
                        package = Path.GetDirectoryName(ProjectPaths.GetRelativePath(classpath, path));
                        package = package.Replace(Path.DirectorySeparatorChar, '.');
                    }

                    args = args.Replace("$(Package)", package);

                    if (package != "")
                        args = args.Replace("$(FileNameWithPackage)", package + "." + fileName);
                    else
                        args = args.Replace("$(FileNameWithPackage)", fileName);

                    if (lastFileOptions != null)
                    {
                        Int32 eolMode = (Int32)MainForm.Settings.EOLMode;
                        String lineBreak = LineEndDetector.GetNewLineMarker(eolMode);
                        ClassModel cmodel;
                        IASContext context;

                        string imports = "";
                        string extends = "";
                        string implements = "";
                        string access = "";
                        string inheritedMethods = "";
                        string paramString = "";
                        string superConstructor = "";
                        int index;

                        context = ASContext.GetLanguageContext( lastFileOptions.Language );

                        // resolve imports
                        if (lastFileOptions.interfaces != null && lastFileOptions.interfaces.Count > 0)
                        {
                            implements = " implements ";
                            string[] _implements;
                            index = 0;
                            foreach (string item in lastFileOptions.interfaces)
                            {
                                if (item.Split('.').Length > 1)
                                    imports += (lastFileOptions.Language == "as3" ? "\t" : "") 
                                        + "import " + item + ";" + lineBreak;
                                _implements = item.Split('.');
                                implements += (index > 0 ? ", " : "") + _implements[_implements.Length - 1];

                                if (lastFileOptions.createInheritedMethods)
                                {
                                    processOnSwitch = lastFileFromTemplate; 
                                    // let ASCompletion generate the implementations when file is opened
                                }

                                index++;
                            }
                        }

                        if (lastFileOptions.superClass != "")
                        {
                            String super = lastFileOptions.superClass;
                            if(lastFileOptions.superClass.Split('.').Length > 1)
                                imports += (lastFileOptions.Language == "as3" ? "\t" : "")
                                    + "import " + super + ";" + lineBreak;
                            string[] _extends = super.Split('.');
                            extends = " extends " + _extends[_extends.Length - 1];

                            if (lastFileOptions.createConstructor)
                            {
                                cmodel = context.GetModel(
                                    super.LastIndexOf('.') < 0 ? super : super.Substring(0, super.LastIndexOf('.')), 
                                    _extends[_extends.Length - 1], 
                                    "");
                                if (!cmodel.IsVoid())
                                {
                                    foreach (MemberModel member in cmodel.Members)
                                    {
                                        if (member.Name == cmodel.Constructor)
                                        {
                                            paramString = member.ParametersString();
                                            imports += AddImports(member, cmodel, lineBreak);

                                            superConstructor = "super(";

                                            index = 0;
                                            if (member.Parameters != null)
                                            foreach (MemberModel param in member.Parameters)
                                            {
                                                superConstructor += (index > 0 ? ", " : "") + param.Name;
                                                index++;
                                            }
                                            superConstructor += ");\n" + (lastFileOptions.Language == "as3" ? "\t\t\t" : "\t\t");
                                            break;
                                        }
                                    }
                                }
                            }
                        }

                        if (lastFileOptions.Language == "as3")
                        {
                            access = lastFileOptions.isPublic ? "public " : "internal ";
                            access += lastFileOptions.isDynamic ? "dynamic " : "";
                            access += lastFileOptions.isFinal ? "final " : "";
                        }
                        else
                        {
                            access = lastFileOptions.isDynamic ? "dynamic " : "";
                        }

                        if (imports.Length > 0)
                            imports += (lastFileOptions.Language == "as3" ? "\t" : "") + lineBreak;

                        args = args.Replace("$(Import)", imports);
                        args = args.Replace("$(Extends)", extends);
                        args = args.Replace("$(Implements)", implements);
                        args = args.Replace("$(Access)", access);
                        args = args.Replace("$(InheritedMethods)", inheritedMethods);
                        args = args.Replace("$(ConstructorArguments)", paramString);
                        args = args.Replace("$(Super)", superConstructor);

                        lastFileFromTemplate = null;
                    }

                }
            }
            return args;
        }

        private String AddImports(MemberModel member, ClassModel inClass, String lineBreak)
        {
            String imports = AddImport(member.Type, inClass, lineBreak);
            if (member.Parameters != null)
                foreach (MemberModel item in member.Parameters)
                    imports += AddImport(item.Type, inClass, lineBreak);
            return imports;
        }

        private String AddImport(String cname, ClassModel inClass, String lineBreak)
        {
            ClassModel aClass = ASContext.Context.ResolveType(cname, inClass.InFile);
            if (aClass != null && !aClass.IsVoid() && aClass.InFile.Package != "")
                return (lastFileOptions.Language == "as3" ? "\t" : "")
                    + "import " + aClass.QualifiedName + ";" + lineBreak;
            return "";
        }

		#endregion

	}
	
}
