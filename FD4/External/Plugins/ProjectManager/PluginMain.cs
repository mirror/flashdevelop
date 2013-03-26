using System;
using System.IO;
using System.Drawing;
using System.Diagnostics;
using System.Collections;
using System.Collections.Generic;
using System.Windows.Forms;
using System.ComponentModel;
using ProjectManager.Actions;
using ProjectManager.Controls;
using ProjectManager.Controls.AS2;
using ProjectManager.Projects.AS3;
using ProjectManager.Controls.TreeView;
using WeifenLuo.WinFormsUI.Docking;
using WeifenLuo.WinFormsUI;
using ProjectManager.Helpers;
using ProjectManager.Projects;
using PluginCore.Localization;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Controls;
using PluginCore.Helpers;
using PluginCore;
using PluginCore.Bridge;

namespace ProjectManager
{
    public static class ProjectManagerCommands
    {
        public const string NewProject = "ProjectManager.NewProject";
        public const string OpenProject = "ProjectManager.OpenProject";
        public const string SendProject = "ProjectManager.SendProject";
        public const string BuildProject = "ProjectManager.BuildProject";
        public const string PlayOutput = "ProjectManager.PlayOutput";
        public const string TestMovie = "ProjectManager.TestMovie";
        public const string CompileWithFlexShell = "ProjectManager.CompileWithFlexShell";
        public const string RestartFlexShell = "ProjectManager.RestartFlexShell";
        public const string SetConfiguration = "ProjectManager.SetConfiguration";
        public const string InstalledSDKsChanged = "ProjectManager.InstalledSDKsChanged";
        public const string LineEntryDialog = "ProjectManager.LineEntryDialog";
        public const string HotBuild = "ProjectManager.HotBuild";
    }

    public static class ProjectManagerEvents
    {
        public const string Menu = "ProjectManager.Menu";
        public const string ToolBar = "ProjectManager.ToolBar";
        public const string Project = "ProjectManager.Project";
        public const string CleanProject = "ProjectManager.CleanProject";
        public const string TestProject = "ProjectManager.TestingProject";
        public const string BuildProject = "ProjectManager.BuildingProject";
        public const string BuildComplete = "ProjectManager.BuildComplete";
        public const string BuildFailed = "ProjectManager.BuildFailed";
        public const string RunCustomCommand = "ProjectManager.RunCustomCommand";
        public const string FileMapping = "ProjectManager.FileMapping";
        public const string TreeSelectionChanged = "ProjectManager.TreeSelectionChanged";
        public const string OpenVirtualFile = "ProjectManager.OpenVirtualFile";
        public const string CreateProject = "ProjectManager.CreateProject";
        public const string ProjectCreated = "ProjectManager.ProjectCreated";
        public const string FileMoved = "ProjectManager.FileMoved";
        public const string FilePasted = "ProjectManager.FilePasted";
        public const string UserRefreshTree = "ProjectManager.UserRefreshTree";
        public const string BeforeSave = "ProjectManager.BeforeSave";
    }

	public class PluginMain : IPlugin
	{
        const string pluginName = "ProjectManager";
        const string pluginAuth = "FlashDevelop Team";
        const string pluginGuid = "30018864-fadd-1122-b2a5-779832cbbf23";
        const string pluginHelp = "www.flashdevelop.org/community/";
        private string pluginDesc = "Adds project management and building to FlashDevelop.";

        private FDMenus menus;
        private FileActions fileActions;
        private BuildActions buildActions;
        private ProjectActions projectActions;
        private FlashDevelopActions flashDevelopActions;
        private Queue<String> openFileQueue;
        private Boolean showProjectClasspaths;
        private Boolean showGlobalClasspaths;
        private DockContent pluginPanel;
        private PluginUI pluginUI;
        private Image pluginImage;
        private Project project;
        private OpenResourceForm projectResources;
        private Boolean runOutput;
        private Boolean buildingAll;
        private Queue<String> buildQueue;
        private Timer buildTimer;
        private bool listenToPathChange;

        private ProjectTreeView Tree { get { return pluginUI.Tree; } }
        public static IMainForm MainForm { get { return PluginBase.MainForm; } }
        public static ProjectManagerSettings Settings;

        const EventType eventMask = EventType.UIStarted | EventType.FileOpening
            | EventType.FileOpen | EventType.FileSave | EventType.FileSwitch | EventType.ProcessStart | EventType.ProcessEnd
            | EventType.ProcessArgs | EventType.Command | EventType.Keys | EventType.ApplySettings;

        #region Load/Save Settings

        static string SettingsDir { get { return Path.Combine(PathHelper.DataDir, pluginName); } }
        static string SettingsPath { get { return Path.Combine(SettingsDir, "Settings.fdb"); } }
        static string FDBuildHints { get { return Path.Combine(SettingsDir, "FDBuildHints.txt"); } }

        public void LoadSettings()
        {
            Settings = new ProjectManagerSettings();
            if (!Directory.Exists(SettingsDir)) Directory.CreateDirectory(SettingsDir);
            if (!File.Exists(SettingsPath)) this.SaveSettings();
            else
            {
                Object obj = ObjectSerializer.Deserialize(SettingsPath, Settings);
                Settings = (ProjectManagerSettings)obj;
            }
            // set manually to avoid dependency in FDBuild
            FileInspector.ExecutableFileTypes = Settings.ExecutableFileTypes;
            Settings.Changed += SettingChanged;
        }

        public void SaveSettings()
        {
            Settings.Changed -= SettingChanged;
            ObjectSerializer.Serialize(SettingsPath, Settings);
        }

        #endregion

        #region Plugin MetaData

        public Int32 Api { get { return 1; } }
        public string Name { get { return pluginName; } }
        public string Guid { get { return pluginGuid; } }
        public string Author { get { return pluginAuth; } }
        public string Description { get { return pluginDesc; } }
        public string Help { get { return pluginHelp; } }
        [Browsable(false)] // explicit implementation so we can reuse the "Settings" var name
        object IPlugin.Settings { get { return Settings; } }
		
		#endregion
		
		#region Initialize/Dispose
		
		public void Initialize()
		{
            LoadSettings();
            pluginImage = MainForm.FindImage("100");
            pluginDesc = TextHelper.GetString("Info.Description");
            openFileQueue = new Queue<String>();

            Icons.Initialize(MainForm);
            EventManager.AddEventHandler(this, eventMask);

            showProjectClasspaths = Settings.ShowProjectClasspaths;
            showGlobalClasspaths = Settings.ShowGlobalClasspaths;

            #region Actions and Event Listeners

            menus = new FDMenus(MainForm);
            menus.ProjectMenu.ProjectItemsEnabled = false;
            menus.TestMovie.Enabled = false;
            menus.TestMovie.Click += delegate { TestMovie(); };
            menus.BuildProject.Enabled = false;
            menus.BuildProject.Click += delegate { BuildProject(); };
            menus.View.Click += delegate { OpenPanel(); };
            menus.GlobalClasspaths.Click += delegate { OpenGlobalClasspaths(); };
            menus.ConfigurationSelector.SelectedIndexChanged += delegate 
            {
                bool isDebug = menus.ConfigurationSelector.Text == TextHelper.GetString("Info.Debug");
                FlexCompilerShell.Cleanup();
                pluginUI.IsTraceDisabled = !isDebug;
                if (project != null) project.TraceEnabled = isDebug;
            };
            menus.TargetBuildSelector.KeyDown += new KeyEventHandler(TargetBuildSelector_KeyDown);
            menus.TargetBuildSelector.SelectedIndexChanged += delegate { ApplyTargetBuild(); };
            menus.TargetBuildSelector.LostFocus += delegate { ApplyTargetBuild(); };
            
            menus.ProjectMenu.NewProject.Click += delegate { NewProject(); };
            menus.ProjectMenu.OpenProject.Click += delegate { OpenProject(); };
            menus.ProjectMenu.ImportProject.Click += delegate { ImportProject(); };
            menus.ProjectMenu.CloseProject.Click += delegate { CloseProject(false); };
            menus.ProjectMenu.OpenResource.Click += delegate { OpenResource(); };
            menus.ProjectMenu.TestMovie.Click += delegate { TestMovie(); };
            menus.ProjectMenu.BuildProject.Click += delegate { BuildProject(); };
            menus.ProjectMenu.CleanProject.Click += delegate { CleanProject(); };
            menus.ProjectMenu.Properties.Click += delegate { OpenProjectProperties(); };
            menus.RecentProjects.ProjectSelected += delegate(string projectPath) { OpenProjectSilent(projectPath); };

            buildActions = new BuildActions(MainForm,menus);
            buildActions.BuildComplete += BuildComplete;
            buildActions.BuildFailed += BuildFailed;

            flashDevelopActions = new FlashDevelopActions(MainForm);

            fileActions = new FileActions(MainForm,flashDevelopActions);
            fileActions.OpenFile += OpenFile;
            fileActions.FileDeleted += FileDeleted;
            fileActions.FileMoved += FileMoved;
            fileActions.FileCopied += FilePasted;

            projectActions = new ProjectActions(pluginUI);

            pluginUI = new PluginUI(this, menus, fileActions, projectActions);
            pluginUI.NewProject += delegate { NewProject(); };
            pluginUI.OpenProject += delegate { OpenProject(); };
            pluginUI.ImportProject += delegate { ImportProject(); };
            pluginUI.Rename += fileActions.Rename;
            pluginUI.TreeBar.ShowHidden.Click += delegate { ToggleShowHidden(); };
            pluginUI.TreeBar.Synchronize.Click += delegate { TreeSyncToCurrentFile(); };
            pluginUI.TreeBar.SynchronizeMain.Click += delegate { TreeSyncToMainFile(); };
            pluginUI.TreeBar.ProjectProperties.Click += delegate { OpenProjectProperties(); };
            pluginUI.TreeBar.RefreshSelected.Click += delegate { TreeRefreshSelectedNode(); };
            pluginUI.TreeBar.ProjectTypes.Click += delegate 
            {
                DataEvent de = new DataEvent(EventType.Command, "ASCompletion.TypesExplorer", null);
                EventManager.DispatchEvent(this, de);
            };

            pluginUI.Menu.Open.Click += delegate { TreeOpenItems(); };
            pluginUI.Menu.Execute.Click += delegate { TreeExecuteItems(); };
            pluginUI.Menu.Insert.Click += delegate { TreeInsertItem(); };
            pluginUI.Menu.AddLibrary.Click += delegate { TreeAddLibraryItems(); };
            pluginUI.Menu.AlwaysCompile.Click += delegate { TreeAlwaysCompileItems(); };
            pluginUI.Menu.SetDocumentClass.Click += delegate { TreeDocumentClass(); };
            pluginUI.Menu.DocumentClass.Click += delegate { TreeDocumentClass(); };
            pluginUI.Menu.Browse.Click += delegate { TreeBrowseItem(); };
            pluginUI.Menu.Cut.Click += delegate { TreeCutItems(); };
            pluginUI.Menu.Copy.Click += delegate { TreeCopyItems(); };
            pluginUI.Menu.Paste.Click += delegate { TreePasteItems(); };
            pluginUI.Menu.Delete.Click += delegate { TreeDeleteItems(); };
            pluginUI.Menu.LibraryOptions.Click += delegate { TreeLibraryOptions(); };
            pluginUI.Menu.HideItem.Click += delegate { TreeHideItems(); };
            pluginUI.Menu.ShowHidden.Click += delegate { ToggleShowHidden(); };
            pluginUI.Menu.AddFileFromTemplate += TreeAddFileFromTemplate;
            pluginUI.Menu.AddNewFolder.Click += delegate { TreeAddFolder(); };
            pluginUI.Menu.AddLibraryAsset.Click += delegate { TreeAddAsset(); };
            pluginUI.Menu.AddExistingFile.Click += delegate { TreeAddExistingFile(); };
            pluginUI.Menu.TestMovie.Click += delegate { TestMovie(); };
            pluginUI.Menu.BuildProject.Click += delegate { BuildProject(); };
            pluginUI.Menu.CloseProject.Click += delegate { CloseProject(false); };
            pluginUI.Menu.Properties.Click += delegate { OpenProjectProperties(); };
            pluginUI.Menu.ShellMenu.Click += delegate { TreeShowShellMenu(); };
            pluginUI.Menu.BuildProjectFile.Click += delegate { BackgroundBuild(); };
            pluginUI.Menu.BuildProjectFiles.Click += delegate { BackgroundBuild(); };
            pluginUI.Menu.BuildAllProjects.Click += delegate { FullBuild(); };
            pluginUI.Menu.TestAllProjects.Click += delegate { TestBuild(); };
            pluginUI.Menu.FindInFiles.Click += delegate { FindInFiles(); };
            pluginUI.Menu.CopyClassName.Click += delegate { CopyClassName(); };
            pluginUI.Menu.AddSourcePath.Click += delegate { AddSourcePath(); };
            pluginUI.Menu.RemoveSourcePath.Click += delegate { RemoveSourcePath(); };
            pluginUI.Menu.Opening += new CancelEventHandler(this.MenuOpening);

            Tree.MovePath += fileActions.Move;
            Tree.CopyPath += fileActions.Copy;
            Tree.DoubleClick += delegate { TreeDoubleClick(); };

            #endregion

            pluginPanel = MainForm.CreateDockablePanel(pluginUI, Guid, Icons.Project.Img, DockState.DockRight);
            buildQueue = new Queue<String>();
            buildTimer = new Timer();
            buildTimer.Interval = 500;
            buildTimer.Tick += new EventHandler(OnBuildTimerTick);
            buildingAll = false;
            runOutput = false;
        }

        private void ApplyTargetBuild()
        {
            string target = menus.TargetBuildSelector.Text;
            if (project != null && project.MovieOptions.TargetBuildTypes != null
                && project.TargetBuild != target)
            {
                if (!menus.TargetBuildSelector.Items.Contains(target))
                    menus.TargetBuildSelector.Items.Insert(0, target);
                FlexCompilerShell.Cleanup();
                project.TargetBuild = menus.TargetBuildSelector.Text;
                projectActions.UpdateASCompletion(MainForm, project);
            }
        }

        void TargetBuildSelector_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter) // leave target build input field to apply
                PluginBase.MainForm.CurrentDocument.Activate();
        }
		
		public void Dispose()
		{
            // we have to fiddle this a little since we only get once change to save our settings!
            // (further saves will be ignored by FD design)
            string lastProject = (project != null) ? project.ProjectPath : "";
            CloseProject(true);
            Settings.LastProject = lastProject;
            FlexCompilerShell.Cleanup(); // in case it was used
            SaveSettings();
		}
		
        #endregion

        #region Plugin Events

        public void HandleEvent(Object sender, NotifyEvent e, HandlingPriority priority)
		{
            TextEvent te = e as TextEvent;
            DataEvent de = e as DataEvent;
            switch (e.Type)
            {
                case EventType.UIStarted:
                    // for some reason we have to do this on the next message loop for the tree
                    // state to be restored properly.
                    pluginUI.BeginInvoke((MethodInvoker)delegate 
                    { 
                        BroadcastMenuInfo(); 
                        BroadcastToolBarInfo(); 
                        OpenLastProject(); 
                    });
                    break;

                // replace $(SomeVariable) type stuff with things we know about
                case EventType.ProcessArgs:
                    if (!ProjectCreator.IsRunning && project != null && te.Value.IndexOf('$') >= 0)
                    {
                        // steal macro names and values from the very useful BuildEvent macros
                        BuildEventVars vars = new BuildEventVars(project);

                        vars.AddVar("CompilerConfiguration", menus.ConfigurationSelector.Text);
                        vars.AddVar("BuildConfiguration", pluginUI.IsTraceDisabled ? "release" : "debug");
                        vars.AddVar("BuildIPC", buildActions.IPCName);

                        foreach (BuildEventInfo info in vars.GetVars())
                            te.Value = te.Value.Replace(info.FormattedName, info.Value);

                        // give the FileActions class an opportunity to process arguments
                        // it may know about (if it was responsible for creating the file)
                        te.Value = fileActions.ProcessArgs(project, te.Value);
                    }
                    break;

                case EventType.FileOpening:
                    // if this is a project file, we can handle it ourselves
                    if (FileInspector.IsProject(te.Value))
                    {
                        te.Handled = true;
                        OpenProjectSilent(te.Value);
                    }
                    else if (project != null && te.Value.EndsWith(".swf"))
                    {
                        te.Handled = true;
                        OpenSwf(te.Value);
                    }
                    break;

                case EventType.FileOpen:
                    SetDocumentIcon(MainForm.CurrentDocument);
                    OpenNextFile(); // it's safe to open any other files on the queue
                    break;

                case EventType.FileSave:
                    // refresh the tree to update any included <mx:Script> tags
                    string path = MainForm.CurrentDocument.FileName;
                    if (Settings.EnableMxmlMapping && FileInspector.IsMxml(path, Path.GetExtension(path).ToLower()) && Tree.NodeMap.ContainsKey(path))
                    {
                        Tree.RefreshNode(Tree.NodeMap[path]);
                    }
                    TabColors.UpdateTabColors(Settings);
                    break;

                case EventType.FileSwitch:
                    TabColors.UpdateTabColors(Settings);
                    break;

                case EventType.ProcessStart:
                    buildActions.NotifyBuildStarted();
                    break;

                case EventType.ProcessEnd:
                    string result = te.Value;
                    buildActions.NotifyBuildEnded(result);
                    break;

                case EventType.ApplySettings:
                    TabColors.UpdateTabColors(Settings);
                    break;

                case EventType.Command:
                    if (de.Action.StartsWith("ProjectManager."))
                    if (de.Action == ProjectManagerCommands.NewProject)
                    {
                        NewProject();
                        e.Handled = true;
                    }
                    else if (de.Action == ProjectManagerCommands.OpenProject)
                    {
                        if (de.Data != null && File.Exists((string)de.Data))
                        {
                            projectActions.OpenProjectSilent((string)de.Data);
                        }
                        else OpenProject();
                        e.Handled = true;
                    }
                    else if (de.Action == ProjectManagerCommands.SendProject)
                    {
                        BroadcastProjectInfo();
                        e.Handled = true;
                    }
                    else if (de.Action == ProjectManagerCommands.InstalledSDKsChanged)
                    {
                        BuildActions.GetCompilerPath(project); // refresh project's SDK
                        e.Handled = true;
                    }
                    else if (de.Action == ProjectManagerCommands.BuildProject)
                    {
                        if (project != null)
                        {
                            AutoSelectConfiguration((string)de.Data);
                            BuildProject();
                            e.Handled = true;
                        }
                    }
                    else if (de.Action == ProjectManagerCommands.TestMovie)
                    {
                        if (project != null)
                        {
                            AutoSelectConfiguration((string)de.Data);
                            TestMovie();
                            e.Handled = true;
                        }
                    }
                    else if (de.Action == ProjectManagerCommands.PlayOutput)
                    {
                        OpenSwf((string)de.Data);
                    }
                    else if (de.Action == ProjectManagerCommands.RestartFlexShell)
                    {
                        FlexCompilerShell.Cleanup();
                    }
                    else if (de.Action == ProjectManagerCommands.SetConfiguration)
                    {
                        AutoSelectConfiguration((string)de.Data);
                    }
                    else if (de.Action == ProjectManagerCommands.HotBuild)
                    {
                        if (project != null)
                        {
                            AutoSelectConfiguration((string)de.Data);
                            TestMovie();
                            e.Handled = true;
                        }
                    }
                    else if (de.Action == ProjectManagerCommands.LineEntryDialog)
                    {
                        Hashtable info = (Hashtable)de.Data;
                        LineEntryDialog askName = new LineEntryDialog((string)info["title"], (string)info["label"], (string)info["suggestion"]);
                        DialogResult choice = askName.ShowDialog();
                        if (choice == DialogResult.OK && askName.Line.Trim().Length > 0 && askName.Line.Trim() != (string)info["suggestion"])
                        {
                            info["suggestion"] = askName.Line.Trim();
                        }
                        if (choice == DialogResult.OK)
                        {
                            e.Handled = true;
                        }
                    }
                    break;

                case EventType.Keys:
                    e.Handled = HandleKeyEvent(e as KeyEvent);
                    break;
            }
        }

        private void AutoSelectConfiguration(string configuration)
        {
            if (configuration != null)
            {
                int newIdx = menus.ConfigurationSelector.Items.IndexOf(configuration);
                if (newIdx >= 0) menus.ConfigurationSelector.SelectedIndex = newIdx;
            }
        }

        private bool HandleKeyEvent(KeyEvent ke)
        {
            if (project == null) return false;
            // Handle tree-level simple shortcuts like copy/paste/del
            else if (Tree.Focused && !pluginUI.IsEditingLabel && ke != null)
            {
                if (ke.Value == (Keys.Control | Keys.C) && pluginUI.Menu.Contains(pluginUI.Menu.Copy)) TreeCopyItems();
                else if (ke.Value == (Keys.Control | Keys.X) && pluginUI.Menu.Contains(pluginUI.Menu.Cut)) TreeCutItems();
                else if (ke.Value == (Keys.Control | Keys.V) && pluginUI.Menu.Contains(pluginUI.Menu.Paste)) TreePasteItems();
                else if (ke.Value == Keys.Delete && pluginUI.Menu.Contains(pluginUI.Menu.Delete)) TreeDeleteItems();
                else if (ke.Value == Keys.Enter && pluginUI.Menu.Contains(pluginUI.Menu.Open)) TreeOpenItems();
                else if (ke.Value == Keys.Enter && pluginUI.Menu.Contains(pluginUI.Menu.Insert)) TreeInsertItem();
                else return false;
            }
            else return false;
            return true;
        }
		
		#endregion

        #region Custom Methods

        bool RestoreProjectSession()
        {
            if (project == null || !Settings.UseProjectSessions) return false;
            String hash = HashCalculator.CalculateSHA1(project.ProjectPath.ToLower());
            String sessionDir = Path.Combine(SettingsDir, "Sessions");
            String sessionFile = Path.Combine(sessionDir, hash + ".fdb");
            if (File.Exists(sessionFile))
            {
                PluginBase.MainForm.CallCommand("RestoreSession", sessionFile);
                return true;
            }
            return false;
        }

        void SaveProjectSession()
        {
            if (project == null || !Settings.UseProjectSessions) return;
            String hash = HashCalculator.CalculateSHA1(project.ProjectPath.ToLower());
            String sessionDir = Path.Combine(SettingsDir, "Sessions");
            String sessionFile = Path.Combine(sessionDir, hash + ".fdb");
            if (!Directory.Exists(sessionDir)) Directory.CreateDirectory(sessionDir);
            PluginBase.MainForm.CallCommand("SaveSession", sessionFile);
        }

        void SetProject(Project project, Boolean stealFocus, Boolean internalOpening)
        {
            if (this.project == project) return;
            if (this.project != null) CloseProject(true);

            this.project = project;
            project.UpdateVars(true);

            // init
            Environment.CurrentDirectory = project.Directory;
            Settings.LastProject = project.ProjectPath;
            Settings.Language = project.Language;

            // ui
            pluginUI.SetProject(project);

            // notify
            PluginBase.CurrentSolution = project;
            PluginBase.CurrentProject = project;
            PluginBase.MainForm.RefreshUI();
            BroadcastProjectInfo();

            projectActions.UpdateASCompletion(MainForm, project);
            pluginUI.NotifyIssues();
            menus.SetProject(project);
            project.ClasspathChanged += new ChangedHandler(ProjectClasspathsChanged);
            project.BeforeSave += new BeforeSaveHandler(ProjectBeforeSave);
            listenToPathChange = true;

            // activate
            if (!internalOpening) RestoreProjectSession();

            if (stealFocus)
            {
                OpenPanel();
                pluginUI.Focus();
            }
            TabColors.UpdateTabColors(Settings);
        }

        void SetProject(Project project, Boolean stealFocus)
        {
            SetProject(project, stealFocus, false);
        }
        void SetProject(Project project)
        {
            SetProject(project, true, false);
        }

        void CloseProject(bool internalClosing)
        {
            if (project == null) return; // already closed

            // save project prefs
            ProjectPreferences prefs = Settings.GetPrefs(project);
            prefs.ExpandedPaths = Tree.ExpandedPaths;
            prefs.DebugMode = project.TraceEnabled;
            prefs.TargetBuild = project.TargetBuild;
            
            if (!PluginBase.MainForm.ClosingEntirely) SaveProjectSession();

            project = null;
            if (projectResources != null)
            {
                projectResources.Close();
                projectResources = null;
            }
            FlexCompilerShell.Cleanup(); // clear compile cache for this project

            if (!internalClosing)
            {
                pluginUI.SetProject(null);
                Settings.LastProject = "";
                menus.DisabledForBuild = true;
                
                PluginBase.CurrentSolution = null;
                PluginBase.CurrentProject = null;
                PluginBase.CurrentSDK = null;
                PluginBase.MainForm.RefreshUI();

                BroadcastProjectInfo();
                projectActions.UpdateASCompletion(MainForm, null);
            }
            TabColors.UpdateTabColors(Settings);
        }
        
        public void OpenPanel()
        {
            this.pluginPanel.Show();
        }

        public void OpenLastProject()
        {
            // try to open the last opened project
            string lastProject = Settings.LastProject;
            if (lastProject != null && lastProject != "" && File.Exists(lastProject))
            {
                SetProject(projectActions.OpenProjectSilent(lastProject), false, true);
            }
        }

        void OpenGlobalClasspaths()
        {
            using (ClasspathDialog dialog = new ClasspathDialog(Settings))
            {
                dialog.Language = "as2";
                if (project != null && project.Language != "*")
                {
                    dialog.Language = project.Language;
                }
                dialog.ShowDialog(pluginUI);
            }
        }

        void OpenProjectProperties()
        {
            using (PropertiesDialog dialog = project.CreatePropertiesDialog())
            {
                project.UpdateVars(false);
                dialog.SetProject(project);
                dialog.OpenGlobalClasspaths += delegate { OpenGlobalClasspaths(); };
                dialog.ShowDialog(pluginUI);

                if (dialog.ClasspathsChanged || dialog.AssetsChanged)
                    Tree.RebuildTree(true);

                if (dialog.PropertiesChanged)
                {
                    project.PropertiesChanged();
                    project.UpdateVars(true);
                    BroadcastProjectInfo();
                    project.Save();
                    menus.ProjectChanged(project);
                }
                else projectActions.UpdateASCompletion(MainForm, project);
            }
        }

        public void OpenFile(string path)
        {
            if (FileInspector.ShouldUseShellExecute(path)) ShellOpenFile(path);
            else if (FileInspector.IsSwf(path, Path.GetExtension(path).ToLower())) PlaySwf(path);
            else if (path.IndexOf("::") > 0)
            {
                DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.OpenVirtualFile, path);
                EventManager.DispatchEvent(this, de);
            }
            else MainForm.OpenEditableDocument(path);
        }

        private void SetDocumentIcon(ITabbedDocument doc)
        {
            Bitmap bitmap = null;

            // try to open with the same icon that the treeview is using
            if (doc.FileName != null)
            {
                if (Tree.NodeMap.ContainsKey(doc.FileName))
                    bitmap = Tree.ImageList.Images[Tree.NodeMap[doc.FileName].ImageIndex] as Bitmap;
                else
                    bitmap = Icons.GetImageForFile(doc.FileName).Img as Bitmap;
            }
            if (bitmap != null)
            {
                doc.UseCustomIcon = true;
                doc.Icon = Icon.FromHandle(bitmap.GetHicon());
            }
        }

        void PlaySwf(string path)
        {
            // Let FlashViewer handle it..
            DataEvent de = new DataEvent(EventType.Command, "FlashViewer.Default", path);
            EventManager.DispatchEvent(this, de);
        }

        void OpenSwf(string path)
        {
            DataEvent de;

            if (path == null)
            {
                if (project == null) return;
                path = project.OutputPath;
            }
            if (project == null) // use default player
            {
                de = new DataEvent(EventType.Command, "FlashViewer.Default", path);
                EventManager.DispatchEvent(this, de);
                return;
            }

            int w = project.MovieOptions.Width;
            int h = project.MovieOptions.Height;
            bool isOutput = path.ToLower() == project.OutputPathAbsolute.ToLower();
            if (path.StartsWith(project.Directory)) 
                path = project.FixDebugReleasePath(path);

            if (project.TestMovieBehavior == TestMovieBehavior.NewTab)
            {
                de = new DataEvent(EventType.Command, "FlashViewer.Document", path);
                EventManager.DispatchEvent(this, de);
            }
            else if (project.TestMovieBehavior == TestMovieBehavior.NewWindow)
            {
                de = new DataEvent(EventType.Command, "FlashViewer.Popup", path + "," + w + "," + h);
                EventManager.DispatchEvent(this, de);
            }
            else if (project.TestMovieBehavior == TestMovieBehavior.ExternalPlayer)
            {
                de = new DataEvent(EventType.Command, "FlashViewer.External", path);
                EventManager.DispatchEvent(this, de);
            }
            else if (project.TestMovieBehavior == TestMovieBehavior.OpenDocument)
            {
                if (project.TestMovieCommand != null && project.TestMovieCommand.Length > 0)
                {
                    if (project.TraceEnabled && project.EnableInteractiveDebugger)
                    {
                        de = new DataEvent(EventType.Command, "AS3Context.StartProfiler", null);
                        EventManager.DispatchEvent(this, de);
                        de = new DataEvent(EventType.Command, "AS3Context.StartDebugger", null);
                        EventManager.DispatchEvent(this, de);
                    }
                    string doc = project.TestMovieCommand;
                    try
                    {
                        doc = project.GetAbsolutePath(doc);
                        doc = project.FixDebugReleasePath(doc);
                    }
                    catch { }
                    ProcessStartInfo psi = new ProcessStartInfo(doc);
                    psi.WorkingDirectory = project.Directory;
                    ProcessHelper.StartAsync(psi);
                }
            }
            else if (project.TestMovieBehavior == TestMovieBehavior.Custom)
            {
                if (project.TraceEnabled && project.EnableInteractiveDebugger)
                {
                    de = new DataEvent(EventType.Command, "AS3Context.StartProfiler", null);
                    EventManager.DispatchEvent(this, de);
                    de = new DataEvent(EventType.Command, "AS3Context.StartDebugger", null);
                    EventManager.DispatchEvent(this, de);
                }
                if (project.TestMovieCommand != null && project.TestMovieCommand.Length > 0)
                {
                    string cmd = MainForm.ProcessArgString(project.TestMovieCommand).Trim();
                    cmd = project.FixDebugReleasePath(cmd);

                    // let plugins handle the command
                    de = new DataEvent(EventType.Command, ProjectManagerEvents.RunCustomCommand, cmd);
                    EventManager.DispatchEvent(this, de);
                    if (de.Handled) return;

                    // shell execute
                    int semi = cmd.IndexOf(';');
                    if (semi < 0) semi = cmd.IndexOf(' ');
                    string args = semi > 0 ? cmd.Substring(semi + 1) : "";
                    cmd = semi > 0 ? cmd.Substring(0, semi) : cmd;

                    ProcessStartInfo psi = new ProcessStartInfo(cmd, args);
                    psi.UseShellExecute = true;
                    psi.WorkingDirectory = project.Directory;
                    ProcessHelper.StartAsync(psi);
                }
                else
                {
                    // let plugins handle the command
                    de = new DataEvent(EventType.Command, ProjectManagerEvents.RunCustomCommand, "");
                    EventManager.DispatchEvent(this, de);
                    if (de.Handled) return;
                }
            }
            else
            {
                // Default: Let FlashViewer handle it..
                de = new DataEvent(EventType.Command, "FlashViewer.Default", path + "," + w + "," + h);
                EventManager.DispatchEvent(this, de);
            }
        }
        
		#endregion

        #region Event Handlers

        private void BuildComplete(IProject project, bool runOutput)
        {
            BroadcastBuildComplete(project);
            if (buildQueue.Count > 0) ProcessBuildQueue();
            else if (this.buildingAll)
            {
                this.buildingAll = false;
                this.buildTimer.Tag = "buildAll";
                this.buildTimer.Start();
            }
            else if (runOutput)
            {
                OpenSwf(project.OutputPathAbsolute);
            }
        }

        private void BuildFailed(IProject project, bool runOutput)
        {
            buildQueue.Clear();
            this.runOutput = false;
            this.buildingAll = false;
            BroadcastBuildFailed(project);
        }

        private bool ProjectBeforeSave(string fileName)
        {
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.BeforeSave, fileName);
            EventManager.DispatchEvent(project, de);
            return !de.Handled; // saving handled or not allowed
        }

        private void ProjectClasspathsChanged()
        {
            if (!listenToPathChange) return;
            listenToPathChange = false;
            projectActions.UpdateASCompletion(MainForm, project);
            pluginUI.NotifyIssues();
            FlexCompilerShell.Cleanup(); // clear compile cache for this project
            Tree.RebuildTree(true);
            listenToPathChange = true;
        }

        private void NewProject()
        {
            SetProject(projectActions.NewProject() ?? project);
        }

        private void OpenProject()
        {
            SetProject(projectActions.OpenProject() ?? project);
        }

        private void ImportProject()
        {
            string imported = projectActions.ImportProject();
            if (imported != null) OpenProjectSilent(imported);
        }

        private void OpenProjectSilent(string projectPath)
        {
            SetProject(projectActions.OpenProjectSilent(projectPath) ?? project);
        }

        private void TestMovie()
        {
            bool noTrace = pluginUI.IsTraceDisabled;
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.TestProject, (noTrace) ? "Release" : "Debug");
            EventManager.DispatchEvent(this, de);
            if (de.Handled) return;
            if (!buildActions.Build(project, true, noTrace))
            {
                BroadcastBuildFailed(project);
            }
        }

        private void BuildProject() 
        {
            bool noTrace = pluginUI.IsTraceDisabled;
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.BuildProject, (noTrace) ? "Release" : "Debug");
            EventManager.DispatchEvent(this, de);
            if (de.Handled) return;
            if (!buildActions.Build(project, false, noTrace))
            {
                BroadcastBuildFailed(project);
            }
        }

        private void CleanProject()
        {
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.CleanProject, project);
            EventManager.DispatchEvent(this, de);
            if (de.Handled) return;

            FlexCompilerShell.Cleanup();
            if (!project.Clean())
                ErrorManager.ShowInfo(TextHelper.GetString("Info.UnableToCleanProject"));
        }

        private void FileDeleted(string path)
        {
            PluginCore.Managers.DocumentManager.CloseDocuments(path);
            projectActions.RemoveAllReferences(project, path);
            pluginUI.WatchParentOf(path);
            project.Save();
        }

        private void FileMoved(string fromPath, string toPath)
        {
            PluginCore.Managers.DocumentManager.MoveDocuments(fromPath, toPath);
            projectActions.MoveReferences(project, fromPath, toPath);
            pluginUI.WatchParentOf(fromPath);
            pluginUI.WatchParentOf(toPath);
            project.Save();
            Hashtable data = new Hashtable();
            data["fromPath"] = fromPath;
            data["toPath"] = toPath;
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.FileMoved, data);
            EventManager.DispatchEvent(this, de);
        }

        private void FilePasted(string fromPath, string toPath)
        {
            Hashtable data = new Hashtable();
            data["fromPath"] = fromPath;
            data["toPath"] = toPath;
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.FilePasted, data);
            EventManager.DispatchEvent(this, de);
        }

        public void PropertiesClick(object sender, EventArgs e)
        {
            OpenProjectProperties();
        }

        private void SettingChanged(string setting)
        {
            if (setting == "ExcludedFileTypes" || setting == "ExcludedDirectories" || setting == "ShowProjectClasspaths" || setting == "ShowGlobalClasspaths" || setting == "GlobalClasspath")
            {
                Tree.RebuildTree(true);
            }
            else if (setting == "ExecutableFileTypes")
            {
                FileInspector.ExecutableFileTypes = Settings.ExecutableFileTypes;
            }
            else if (setting == "GlobalClasspath")
            {
                FlexCompilerShell.Cleanup(); // clear compile cache for all projects
            }
        }

        #endregion

        #region Event Broadcasting

        public void BroadcastMenuInfo()
        {
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.Menu, this.menus.ProjectMenu);
            EventManager.DispatchEvent(this, de);
        }

        public void BroadcastToolBarInfo()
        {
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.ToolBar, this.pluginUI.TreeBar);
            EventManager.DispatchEvent(this, de);
        }

        public void BroadcastProjectInfo()
        {
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.Project, project);
            EventManager.DispatchEvent(this, de);
        }

        public void BroadcastBuildComplete(IProject project)
        {
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.BuildComplete, project);
            EventManager.DispatchEvent(this, de);
        }

        public void BroadcastBuildFailed(IProject project)
        {
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.BuildFailed, project);
            EventManager.DispatchEvent(this, de);
        }

        #endregion

        #region Project Tree Event Handling

        private void MenuOpening(Object sender, CancelEventArgs e)
        {
            if (Control.ModifierKeys == Keys.Control)
            {
                this.TreeShowShellMenu();
            }
        }

        private void TreeDoubleClick()
        {
            if (pluginUI.Menu.Contains(pluginUI.Menu.Open)) TreeOpenItems();
            else if (pluginUI.Menu.Contains(pluginUI.Menu.Insert)) TreeInsertItem();
        }

        private void TreeOpenItems()
        {
            foreach (string path in Tree.SelectedPaths)
            {
                openFileQueue.Enqueue(path);
            }
            OpenNextFile();
        }

        private void OpenNextFile()
        {
            if (openFileQueue.Count > 0)
            {
                String file = openFileQueue.Dequeue() as String;
                if (File.Exists(file)) OpenFile(file);
                if (file.IndexOf("::") > 0 && File.Exists(file.Substring(0, file.IndexOf("::")))) // virtual files
                {
                    OpenFile(file);
                }
            }
        }

        private void TreeExecuteItems()
        {
            foreach (string path in Tree.SelectedPaths)
                ShellOpenFile(path);
        }

        private void ShellOpenFile(string path)
        {
            if (BridgeManager.Active && BridgeManager.IsRemote(path) && !BridgeManager.AlwaysOpenLocal(path))
            {
                BridgeManager.RemoteOpen(path);
                return;
            }
            ProcessStartInfo psi = new ProcessStartInfo(path);
            psi.WorkingDirectory = Path.GetDirectoryName(path);
            ProcessHelper.StartAsync(psi);
        }

        private void TreeInsertItem()
        {
            // special behavior if this is a fake export node inside a SWF file
            ExportNode node = Tree.SelectedNode as ExportNode;
            string path = (node != null) ? node.ContainingSwfPath : Tree.SelectedPath;
            projectActions.InsertFile(MainForm, project, path, node);
        }

        private void TreeAddLibraryItems()
        {
            // we want to deselect all nodes when toggling library so you can see
            // them turn blue to get some feedback
            string[] selectedPaths = Tree.SelectedPaths;
            Tree.SelectedNodes = null;
            projectActions.ToggleLibraryAsset(project, selectedPaths);
        }

        private void TreeAlwaysCompileItems()
        {
            projectActions.ToggleAlwaysCompile(project, Tree.SelectedPaths);
        }

        private void TreeDocumentClass()
        {
            projectActions.ToggleDocumentClass(project, Tree.SelectedPaths);
        }

        private void TreeBrowseItem()
        {
            string path = Tree.SelectedPath;
            DataEvent de = new DataEvent(EventType.Command, "FileExplorer.Explore", path);
            EventManager.DispatchEvent(this, de);
        }

        private void TreeCutItems()
        {
            fileActions.CutToClipboard(Tree.SelectedPaths);
        }

        private void TreeCopyItems()
        {
            fileActions.CopyToClipboard(Tree.SelectedPaths);
        }

        private void TreePasteItems()
        {
            fileActions.PasteFromClipboard(Tree.SelectedPath);
        }

        private void TreeDeleteItems()
        {
            fileActions.Delete(Tree.SelectedPaths);
        }

        private void TreeLibraryOptions()
        {
            LibraryAssetDialog dialog = new LibraryAssetDialog(Tree.SelectedAsset, project);
            if (dialog.ShowDialog(pluginUI) == DialogResult.OK)
            {
                Tree.SelectedNode.Refresh(false);
                project.Save();
            }
        }

        private void TreeAddFileFromTemplate(string templatePath, bool noName)
        {
            fileActions.AddFileFromTemplate(project, Tree.SelectedPath, templatePath, noName);
        }

        private void TreeAddFolder()
        {
            fileActions.AddFolder(Tree.SelectedPath);
        }

        private void TreeAddAsset()
        {
            fileActions.AddLibraryAsset(project, Tree.SelectedPath);
        }

        private void TreeAddExistingFile()
        {
            fileActions.AddExistingFile(Tree.SelectedPath);
        }

        private void TreeHideItems()
        {
            projectActions.ToggleHidden(project, Tree.SelectedPaths);
        }

        public void ToggleShowHidden()
        {
            projectActions.ToggleShowHidden(project);
            pluginUI.ShowHiddenPaths(project.ShowHiddenPaths);
        }

        public void TreeRefreshSelectedNode()
        {
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.UserRefreshTree, Tree);
            EventManager.DispatchEvent(this, de);

            Tree.RefreshTree();
        }

        /// <summary>
        /// Shows the explorer shell menu
        /// </summary>
        private void TreeShowShellMenu()
        {
            String parentDir = null;
            ShellContextMenu scm = new ShellContextMenu();
            List<FileInfo> selectedPathsAndFiles = new List<FileInfo>();
            for (Int32 i = 0; i < Tree.SelectedPaths.Length; i++)
            {
                String path = Tree.SelectedPaths[i];
                // only select files in the same directory
                if (parentDir == null) parentDir = Path.GetDirectoryName(path);
                else if (Path.GetDirectoryName(path) != parentDir) continue;
                selectedPathsAndFiles.Add(new FileInfo(path));
            }
            this.pluginUI.Menu.Hide(); /* Hide default menu */
            Point location = new Point(this.pluginUI.Menu.Bounds.Left, this.pluginUI.Menu.Bounds.Top);
            scm.ShowContextMenu(selectedPathsAndFiles.ToArray(), location);
        }


        private void TestBuild()
        {
            this.runOutput = true;
            this.FullBuild();
        }

        private void FullBuild()
        {
            this.buildingAll = true;
            foreach (GenericNode node in Tree.SelectedNode.Nodes)
            {
                if (IsBuildable(node.BackingPath) && !buildQueue.Contains(node.BackingPath))
                {
                    buildQueue.Enqueue(node.BackingPath);
                }
            }
            ProcessBuildQueue();
        }

        private void BackgroundBuild()
        {
            foreach (String path in Tree.SelectedPaths)
            {
                if (IsBuildable(path) && !buildQueue.Contains(path))
                {
                    buildQueue.Enqueue(path);
                }
            }
            ProcessBuildQueue();
        }

        private void ProcessBuildQueue()
        {
            if (buildQueue.Count > 0)
            {
                buildTimer.Start();
            }
        }

        void OnBuildTimerTick(Object sender, EventArgs e)
        {
            buildTimer.Stop();
            if (buildTimer.Tag == null)
            {
                Project project = ProjectLoader.Load(buildQueue.Dequeue());
                Boolean debugging = this.buildingAll ? !this.project.TraceEnabled : !project.TraceEnabled;
                this.buildActions.Build(project, false, debugging);
            } 
            else
            {
                this.buildTimer.Tag = null;
                if (this.runOutput) this.TestMovie();
                else this.BuildProject();
                this.runOutput = false;
            }
        }

        private bool IsBuildable(String path)
        {
            String ext = Path.GetExtension(path).ToLower();
            if (FileInspector.IsAS2Project(path, ext)) return true;
            else if (FileInspector.IsAS3Project(path, ext)) return true;
            else if (FileInspector.IsHaxeProject(path, ext)) return true;
            else return false;
        }

        private void AddSourcePath()
        {
            String path = Tree.SelectedPath;
            if (path.StartsWith(project.Directory)) path = project.GetRelativePath(path);
            if (project.Classpaths.Count == 1 && project.Classpaths[0] == ".")
                project.Classpaths.Clear();
            project.Classpaths.Add(path);
            project.Save();
            project.OnClasspathChanged();
        }

        private void RemoveSourcePath()
        {
            String path = Tree.SelectedPath;
            project.Classpaths.Remove(project.GetRelativePath(path));
            if (project.Classpaths.Count == 0) project.Classpaths.Add(".");
            project.Save();
            project.OnClasspathChanged();
        }

        private void CopyClassName()
        {
            String path = Tree.SelectedPath;
            DataEvent copyCP = new DataEvent(EventType.Command, "ASCompletion.GetClassPath", path);
            EventManager.DispatchEvent(this, copyCP);
            if (copyCP.Handled) // UI needs refresh on clipboard change...
            {
                PluginBase.MainForm.RefreshUI();
            }
        }

        private void FindInFiles()
        {
            String path = Tree.SelectedPath;
            if (path != null && Directory.Exists(path))
            {
                PluginBase.MainForm.CallCommand("FindAndReplaceInFilesFrom", path);
            }
        }
        
        private void TreeSyncToMainFile()
        {
            if(Tree.Project.CompileTargets.Count > 0)
            {
               Tree.Select(Tree.Project.GetAbsolutePath(Tree.Project.CompileTargets[0]));
            }
        }

        private void TreeSyncToCurrentFile()
        {
            ITabbedDocument doc = PluginBase.MainForm.CurrentDocument;
            if (doc != null && doc.IsEditable && !doc.IsUntitled)
            {
                Tree.Select(doc.FileName);
                Tree.SelectedNode.EnsureVisible();
            }
        }

        private void OpenResource()
        {
            if (PluginBase.CurrentProject != null)
            {
                if (projectResources == null) projectResources = new OpenResourceForm(this);
                projectResources.ShowDialog(pluginUI);
            }
        }

        #endregion

	}

}
