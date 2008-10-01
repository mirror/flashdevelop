using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Diagnostics;
using System.Windows.Forms;
using System.ComponentModel;
using WeifenLuo.WinFormsUI;
using WeifenLuo.WinFormsUI.Docking;
using ProjectManager.Actions;
using ProjectManager.Controls;
using ProjectManager.Controls.AS2;
using ProjectManager.Projects.AS3;
using ProjectManager.Controls.TreeView;
using ProjectManager.Helpers;
using ProjectManager.Projects;
using PluginCore.Localization;
using PluginCore.Managers;
using PluginCore.Utilities;
using PluginCore.Helpers;
using PluginCore;

namespace ProjectManager
{
    public static class ProjectManagerCommands
    {
        public const string NewProject = "ProjectManager.NewProject";
        public const string OpenProject = "ProjectManager.OpenProject";
        public const string SendProject = "ProjectManager.SendProject";
        public const string BuildProject = "ProjectManager.BuildProject";
        public const string TestMovie = "ProjectManager.TestMovie";
        public const string CompileWithFlexShell = "ProjectManager.CompileWithFlexShell";
        public const string RestartFlexShell = "ProjectManager.RestartFlexShell";
    }

    public static class ProjectManagerEvents
    {
        public const string Project = "ProjectManager.Project";
        public const string TestProject = "ProjectManager.TestingProject";
        public const string BuildProject = "ProjectManager.BuildingProject";
        public const string BuildComplete = "ProjectManager.BuildComplete";
        public const string BuildFailed = "ProjectManager.BuildFailed";
        public const string FileMapping = "ProjectManager.FileMapping";
        public const string TreeSelectionChanged = "ProjectManager.TreeSelectionChanged";
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

        private ProjectTreeView Tree { get { return pluginUI.Tree; } }
        public static IMainForm MainForm { get { return PluginBase.MainForm; } }
        public static ProjectManagerSettings Settings;

        const EventType eventMask = EventType.UIStarted | EventType.FileOpening
            | EventType.FileOpen | EventType.FileSave | EventType.ProcessStart | EventType.ProcessEnd 
            | EventType.ProcessArgs | EventType.Command | EventType.Keys;

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
            if (Settings.ShortcutTestMovie == Keys.None && Settings.ShortcutBuildProject == Keys.None)
            {
                Settings.ShortcutTestMovie = ProjectManagerSettings.DEFAULT_TESTMOVIE;
                Settings.ShortcutBuildProject = ProjectManagerSettings.DEFAULT_BUILDPROJECT;
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

            MainForm.IgnoredKeys.Add(Settings.ShortcutTestMovie);
            MainForm.IgnoredKeys.Add(Settings.ShortcutBuildProject);

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
                pluginUI.IsTraceDisabled = menus.ConfigurationSelector.SelectedIndex == 1;
            };
            
            menus.ProjectMenu.NewProject.Click += delegate { NewProject(); };
            menus.ProjectMenu.OpenProject.Click += delegate { OpenProject(); };
            menus.ProjectMenu.ImportProject.Click += delegate { ImportProject(); };
            menus.ProjectMenu.CloseProject.Click += delegate { CloseProject(false); };
            menus.ProjectMenu.TestMovie.Click += delegate { TestMovie(); };
            menus.ProjectMenu.BuildProject.Click += delegate { BuildProject(); };
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

            projectActions = new ProjectActions(pluginUI);

            pluginUI = new PluginUI(this, menus, fileActions, projectActions);
            pluginUI.NewProject += delegate { NewProject(); };
            pluginUI.OpenProject += delegate { OpenProject(); };
            pluginUI.ImportProject += delegate { ImportProject(); };
            pluginUI.Rename += fileActions.Rename;
            pluginUI.TreeBar.ShowHidden.Click += delegate { ToggleShowHidden(); };
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

            Tree.MovePath += fileActions.Move;
            Tree.CopyPath += fileActions.Copy;
            Tree.DoubleClick += delegate { TreeDoubleClick(); };

            #endregion

            pluginPanel = MainForm.CreateDockablePanel(pluginUI, Guid, Icons.Project.Img, DockState.DockRight);
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
                    pluginUI.BeginInvoke((MethodInvoker)delegate { OpenLastProject(); });
                    break;
                // replace $(SomeVariable) type stuff with things we know about
                case EventType.ProcessArgs:
                    if (project != null && te.Value.IndexOf('$') >= 0)
                    {
                        // steal macro names and values from the very useful BuildEvent macros
                        BuildEventVars vars = new BuildEventVars(project);

                        // this operation requires a message to ASCompletion so we don't add it to the BuildEventVars
                        string cpath = BuildActions.GetCompilerPath(project);
                        if (File.Exists(cpath)) cpath = Path.GetDirectoryName(cpath);

                        vars.AddVar("CompilerPath", cpath);
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
                    break;
                case EventType.FileOpen:
                    SetDocumentIcon(MainForm.CurrentDocument);
                    OpenNextFile(); // it's safe to open any other files on the queue
                    break;
                case EventType.FileSave:
                    // refresh the tree to update any included <mx:Script> tags
                    string path = MainForm.CurrentDocument.FileName;
                    if (FileInspector.IsMxml(path) && Tree.NodeMap.ContainsKey(path))
                        Tree.RefreshNode(Tree.NodeMap[path]);
                    break;
                case EventType.ProcessStart:
                    buildActions.NotifyBuildStarted();
                    break;
                case EventType.ProcessEnd:
                    string result = te.Value;
                    buildActions.NotifyBuildEnded(result);
                    break;
                case EventType.Command:
                    if (de.Action == ProjectManagerCommands.NewProject)
                    {
                        NewProject();
                        e.Handled = true;
                    }
                    else if (de.Action == ProjectManagerCommands.OpenProject)
                    {
                        OpenProject();
                        e.Handled = true;
                    }
                    else if (de.Action == ProjectManagerCommands.SendProject)
                    {
                        BroadcastProjectInfo();
                        e.Handled = true;
                    }
                    else if (de.Action == ProjectManagerCommands.BuildProject)
                    {
                        if (project != null)
                        {
                            BuildProject();
                            e.Handled = true;
                        }
                    }
                    else if (de.Action == ProjectManagerCommands.TestMovie)
                    {
                        if (project != null)
                        {
                            TestMovie();
                            e.Handled = true;
                        }
                    }
                    /*else if (de.Action == ProjectManagerCommands.CompileWithFlexShell)
                    {
                        Hashtable hashtable = (Hashtable)de.Data;
                        if (File.Exists(FlexCompilerShell.FcshPath))
                        {
                            FlexCompilerShell shell = new FlexCompilerShell();
                            string arguments = (string)hashtable["arguments"];
                            string output;
                            string[] errors;
                            shell.Compile(arguments, out output, out errors, hashtable["compiler"] as string);
                            hashtable["output"] = output;
                            hashtable["errors"] = errors;
                            de.Handled = true;
                        }
                    }*/
                    else if (de.Action == ProjectManagerCommands.RestartFlexShell)
                    {
                        FlexCompilerShell.Cleanup();
                    }
                    else if (de.Action == "HotBuild")
                    {
                        if (project != null)
                        {
                            TestMovie();
                            e.Handled = true;
                        }
                    }
                    break;

                case EventType.Keys:
                    e.Handled = HandleKeyEvent(e as KeyEvent);
                    break;
            }
		}

        private bool HandleKeyEvent(KeyEvent ke)
        {
            if (project == null) return false;

            if (ke.Value == Settings.ShortcutBuildProject)
                BuildProject();
            
            else if (ke.Value == Settings.ShortcutTestMovie)
                TestMovie();

            // Handle tree-level simple shortcuts like copy/paste/del
            else if (Tree.Focused && !pluginUI.IsEditingLabel && ke != null)
            {
                if (ke.Value == (Keys.Control | Keys.C) && pluginUI.Menu.Contains("Copy"))
                    TreeCopyItems();
                else if (ke.Value == (Keys.Control | Keys.X) && pluginUI.Menu.Contains("Cut"))
                    TreeCutItems();
                else if (ke.Value == (Keys.Control | Keys.V) && pluginUI.Menu.Contains("Paste"))
                    TreePasteItems();
                else if (ke.Value == Keys.Delete && pluginUI.Menu.Contains("Delete"))
                    TreeDeleteItems();
                else if (ke.Value == Keys.Enter && pluginUI.Menu.Contains("Open"))
                    TreeOpenItems();
                else if (ke.Value == Keys.Enter && pluginUI.Menu.Contains("Insert"))
                    TreeInsertItem();
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

            pluginUI.SetProject(project);
            project.ClasspathChanged += delegate { ProjectClasspathsChanged(); };
            Settings.LastProject = project.ProjectPath;
            Settings.Language = project.Language;
            menus.RecentProjects.AddOpenedProject(project.ProjectPath);
            menus.ConfigurationSelector.Enabled = true;
            menus.ProjectMenu.ProjectItemsEnabled = true;
            menus.TestMovie.Enabled = true;
            menus.BuildProject.Enabled = true;

            PluginBase.CurrentProject = project;
            PluginBase.MainForm.RefreshUI();
            BroadcastProjectInfo();

            if (!internalOpening) RestoreProjectSession();

            if (stealFocus)
            {
                OpenPanel();
                pluginUI.Focus();
            }

            // We can't update ASCompletion right now because we could be starting up and ASCompletion
            // might not be ready yet. So we'll let this thread finish first.
            Timer timer = new Timer();
            timer.Interval = 100;
            timer.Tick += delegate { projectActions.UpdateASCompletion(MainForm, project); timer.Stop(); };
            timer.Start();
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
            prefs.EnableTrace = !pluginUI.IsTraceDisabled;
            
            if (!PluginBase.MainForm.ClosingEntirely) SaveProjectSession();

            project = null;
            FlexCompilerShell.Cleanup(); // clear compile cache for this project

            if (!internalClosing)
            {
                pluginUI.SetProject(null);
                Settings.LastProject = "";
                menus.ProjectMenu.ProjectItemsEnabled = false;
                menus.TestMovie.Enabled = false;
                menus.BuildProject.Enabled = false;
                menus.ConfigurationSelector.Enabled = false;

                PluginBase.CurrentProject = null;
                PluginBase.MainForm.RefreshUI();

                BroadcastProjectInfo();
                projectActions.UpdateASCompletion(MainForm, null);
            }
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
                if (project != null) dialog.Language = project.Language;
                dialog.ShowDialog(pluginUI);
            }
        }

        void OpenProjectProperties()
        {
            using (PropertiesDialog dialog = project.CreatePropertiesDialog())
            {
                dialog.SetProject(project);
                dialog.OpenGlobalClasspaths += delegate { OpenGlobalClasspaths(); };
                dialog.ShowDialog(pluginUI);

                if (dialog.ClasspathsChanged || dialog.PropertiesChanged)
                    projectActions.UpdateASCompletion(MainForm, project);

                if (dialog.ClasspathsChanged || dialog.AssetsChanged)
                    Tree.RebuildTree(true);

                if (dialog.PropertiesChanged)
                {
                    project.PropertiesChanged();
                    pluginUI.NoOutput = project.NoOutput;
                    BroadcastProjectInfo();
                    project.Save();
                }
            }
        }

        public void OpenFile(string path)
        {
            if (FileInspector.ShouldUseShellExecute(path))
            {
                ProcessStartInfo psi = new ProcessStartInfo(path);
                psi.WorkingDirectory = Path.GetDirectoryName(path);
                ProcessHelper.StartAsync(psi);
            }
            else if (FileInspector.IsSwf(path)) OpenSwf(path);
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

        void OpenSwf(string path)
        {
            if (!pluginUI.IsTraceDisabled)
            {
                DataEvent de = new DataEvent(EventType.Command, "RunDebugger", path);
                EventManager.DispatchEvent(this, de);
                if (de.Handled) return;
            }
            int w = project.MovieOptions.Width;
            int h = project.MovieOptions.Height;
            bool isOutput = path.ToLower() == project.OutputPathAbsolute.ToLower();
            path = project.FixDebugReleasePath(path);
            if (!isOutput || project.TestMovieBehavior == TestMovieBehavior.NewTab)
            {
                DataEvent de = new DataEvent(EventType.Command, "FlashViewer.Document", path);
                EventManager.DispatchEvent(this, de);
            }
            else if (project.TestMovieBehavior == TestMovieBehavior.NewWindow)
            {
                DataEvent de = new DataEvent(EventType.Command, "FlashViewer.Popup", path + "," + w + "," + h);
                EventManager.DispatchEvent(this, de);
            }
            else if (project.TestMovieBehavior == TestMovieBehavior.ExternalPlayer)
            {
                DataEvent de = new DataEvent(EventType.Command, "FlashViewer.External", path);
                EventManager.DispatchEvent(this, de);
            }
            else if (project.TestMovieBehavior == TestMovieBehavior.OpenDocument)
            {
                if (project.TestMovieCommand != null && project.TestMovieCommand.Length > 0)
                {
                    if (project.Language == "as3" && project.TraceEnabled)
                    {
                        DataEvent de = new DataEvent(EventType.Command, "AS3Context.StartDebugger", null);
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
                if (project.TestMovieCommand != null && project.TestMovieCommand.Length > 0)
                {
                    if (project.Language == "as3" && project.TraceEnabled)
                    {
                        DataEvent de = new DataEvent(EventType.Command, "AS3Context.StartDebugger", null);
                        EventManager.DispatchEvent(this, de);
                    }
                    string cmd = MainForm.ProcessArgString(project.TestMovieCommand);
                    cmd = project.FixDebugReleasePath(cmd);
                    string[] args = (cmd + ';').Split(';');
                    ProcessStartInfo psi = new ProcessStartInfo(args[0], args[1]);
                    psi.UseShellExecute = true;
                    psi.WorkingDirectory = project.Directory;
                    ProcessHelper.StartAsync(psi);
                }
            }
            else
            {
                // Default: Let FlashViewer handle it..
                DataEvent de = new DataEvent(EventType.Command, "FlashViewer.Default", path + "," + w + "," + h);
                EventManager.DispatchEvent(this, de);
            }
        }
        
		#endregion

        #region Event Handlers

        private void BuildComplete(bool runOutput)
        {
            BroadcastBuildComplete();
            if (runOutput) OpenSwf(project.OutputPathAbsolute);
        }

        private void BuildFailed(bool runOutput)
        {
            BroadcastBuildFailed();
        }

        private void ProjectClasspathsChanged()
        {
            projectActions.UpdateASCompletion(MainForm, project);
            FlexCompilerShell.Cleanup(); // clear compile cache for this project
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
            if (imported != null)
                OpenProjectSilent(imported);
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
                BroadcastBuildFailed();
        }

        private void BuildProject() 
        {
            bool noTrace = pluginUI.IsTraceDisabled;
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.BuildProject, (noTrace) ? "Release" : "Debug");
            EventManager.DispatchEvent(this, de);
            if (de.Handled) return;
            if (!buildActions.Build(project, false, noTrace))
                BroadcastBuildFailed();
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
        }

        public void PropertiesClick(object sender, EventArgs e)
        {
            OpenProjectProperties();
        }

        private void SettingChanged(string setting)
        {
            if (setting == "ExcludedFileTypes" || setting == "ExcludedDirectories" || setting == "ShowProjectClasspaths" || setting == "ShowGlobalClasspaths")
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

        public void BroadcastProjectInfo()
        {
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.Project, project);
            EventManager.DispatchEvent(this, de);
        }

        public void BroadcastBuildComplete()
        {
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.BuildComplete, null);
            EventManager.DispatchEvent(this, de);
        }

        public void BroadcastBuildFailed()
        {
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.BuildFailed, null);
            EventManager.DispatchEvent(this, de);
        }

        #endregion

        #region Project Tree Event Handling

        private void TreeDoubleClick()
        {
            if (pluginUI.Menu.Contains("Open")) TreeOpenItems();
            else if (pluginUI.Menu.Contains("Insert")) TreeInsertItem();
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
                OpenFile(openFileQueue.Dequeue() as string);
            }
        }

        private void TreeExecuteItems()
        {
            foreach (string path in Tree.SelectedPaths)
            {
                ProcessStartInfo psi = new ProcessStartInfo(path);
                psi.WorkingDirectory = Path.GetDirectoryName(path);
                ProcessHelper.StartAsync(psi);
            }
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

        private void TreeBrowseItem()
        {
            string path = Tree.SelectedPath;
            ProcessStartInfo psi = new ProcessStartInfo("explorer.exe");
            psi.Arguments = "/e,\"" + path + "\"";
            psi.WorkingDirectory = path;
            ProcessHelper.StartAsync(psi);
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

        private void TreeAddFileFromTemplate(string templatePath)
        {
            fileActions.AddFileFromTemplate(project, Tree.SelectedPath, templatePath);
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
            Tree.RefreshNode(Tree.SelectedNode);
        }

        #endregion

	}

}
