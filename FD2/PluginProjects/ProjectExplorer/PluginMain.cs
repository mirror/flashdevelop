using System;
using System.ComponentModel;
using System.IO;
using System.Collections;
using System.Drawing;
using System.Diagnostics;
using System.Windows.Forms;
using WeifenLuo.WinFormsUI;
using PluginCore;
using ProjectExplorer.Controls;
using ProjectExplorer.Controls.TreeView;
using ProjectExplorer.Actions;
using ProjectExplorer.Helpers;
using ProjectExplorer.ProjectFormat;

namespace ProjectExplorer
{
	public class PluginMain : IPlugin
	{
		public static IMainForm MainFormRef; // Mika: added
		
		PluginUI pluginUI;
		IPluginHost pluginHost; // set by FD
		DockContent pluginPanel;
		FDMenus menus;
		Timer startupTimer;

		FileActions fileActions;
		BuildActions buildActions;
		ProjectActions projectActions;
		FlashDevelopActions flashDevelopActions;

		string COMMAND_HOTBUILD = "HotBuild";
		string COMMAND_SENDPROJECTINFO = "ProjectExplorer;SendProjectInfo";
		string COMMAND_BUILDPROJECT = "ProjectExplorer;BuildProject";
		string COMMAND_POPUPSWF = "FlashOut;PopupSwf;";
		string EVENT_PROJECTINFO = "ProjectExplorer.ProjectInfo";
		string EVENT_BUILDCOMPLETE = "ProjectExplorer.BuildComplete";

		bool showProjectClasspaths;
		bool showGlobalClasspaths;
		
		#region IPlugin Required Properties
		
		public string Name { get { return "ProjectExplorer"; } }
		public string Guid { get { return "30018864-fadd-1122-b2a5-779832cbbf23"; } }
		public string Author { get { return "Nick Farina"; } }
		public string Description { get { return "Adds project management and building to FlashDevelop."; } }
		public string Help { get { return "www.flashdevelop.org/community/"; } }
		public EventType EventMask { get { return eventMask; } }

		static EventType eventMask 
			= EventType.FileOpening
			| EventType.FileOpen
			| EventType.ProcessStart
			| EventType.ProcessEnd
			| EventType.ProcessArgs
			| EventType.Command
			| EventType.SettingUpdate
			| EventType.Shortcut;

		[Browsable(false)]
		public IPluginHost Host
		{
			get { return this.pluginHost; }
			set { this.pluginHost = value; }
		}

		[Browsable(false)] public DockContent Panel { get { return this.pluginPanel; } }
		[Browsable(false)] private IMainForm MainForm { get { return this.pluginHost.MainForm; } }

		#endregion
		
		public void Initialize()
		{
			MainFormRef = MainForm; // Mika: added
			
			Icons.Initialize(MainForm);
			Settings.Initialize(MainForm);
			PluginData.Load();

			showProjectClasspaths = Settings.ShowProjectClasspaths;
			showGlobalClasspaths = Settings.ShowGlobalClasspaths;

			MainForm.IgnoredKeys.Add(Keys.F5);
			MainForm.IgnoredKeys.Add(Keys.F8);

			#region Actions and Event Listeners

			menus = new FDMenus(MainForm);
			menus.View.Click += new EventHandler(OpenPanel);
			menus.GlobalClasspaths.Click += new EventHandler(OpenGlobalClasspaths);
			menus.ProjectMenu.NewProject.Click += new EventHandler(NewProject);
			menus.ProjectMenu.OpenProject.Click += new EventHandler(OpenProject);
			menus.ProjectMenu.CloseProject.Click += new EventHandler(CloseProject);
			menus.ProjectMenu.TestMovie.Click += new EventHandler(TestMovie);
			menus.ProjectMenu.BuildProject.Click += new EventHandler(BuildProject);
			menus.ProjectMenu.Properties.Click += new EventHandler(OpenProjectProperties);
			menus.RecentComboBox.RequestProject += new ProjectRequestHandler(GetProject);
			menus.RecentComboBox.OpenProject += new ProjectOpenHandler(OpenProjectSilent);

			buildActions = new BuildActions(MainForm);
			buildActions.BuildComplete += new BuildCompleteHandler(BuildComplete);
			buildActions.ClasspathsChanged += new EventHandler(ProjectClasspathsChanged);

			flashDevelopActions = new FlashDevelopActions(MainForm);

			fileActions = new FileActions(pluginUI);
			fileActions.OpenFile += new FileNameHandler(OpenFile);
			fileActions.FileDeleted += new FileNameHandler(FileDeleted);
			fileActions.FileMoved += new FileMovedHandler(FileMoved);

			projectActions = new ProjectActions(pluginUI);
		
			// create our UI surface and a docking panel for it
			pluginUI = new PluginUI(this,menus,fileActions,projectActions);
			pluginUI.NewProject += new EventHandler(NewProject);
			pluginUI.OpenProject += new EventHandler(OpenProject);
			pluginUI.Rename += new RenameEventHandler(fileActions.Rename);
			pluginUI.Tree.MovePath += new DragPathEventHandler(fileActions.Move);
			pluginUI.Tree.CopyPath += new DragPathEventHandler(fileActions.Copy);
			pluginUI.Menu.Open.Click += new EventHandler(TreeOpenItems);
			pluginUI.Menu.Execute.Click += new EventHandler(TreeExecuteItems);
			pluginUI.Menu.Insert.Click += new EventHandler(TreeInsertItem);
			pluginUI.Menu.AddLibrary.Click += new EventHandler(TreeAddLibraryItems);
			pluginUI.Menu.AlwaysCompile.Click += new EventHandler(TreeAlwaysCompileItems);
			pluginUI.Menu.Cut.Click += new EventHandler(TreeCutItems);
			pluginUI.Menu.Copy.Click += new EventHandler(TreeCopyItems);
			pluginUI.Menu.Paste.Click += new EventHandler(TreePasteItems);
			pluginUI.Menu.Delete.Click += new EventHandler(TreeDeleteItems);
			pluginUI.Menu.LibraryOptions.Click += new EventHandler(TreeLibraryOptions);
			pluginUI.Menu.Hide.Click += new EventHandler(TreeHideItems);
			pluginUI.Menu.ShowHidden.Click += new EventHandler(ToggleShowHidden);
			pluginUI.Menu.AddNewClass.Click += new EventHandler(TreeAddNewClass);
			pluginUI.Menu.AddNewXml.Click += new EventHandler(TreeAddXml);
			pluginUI.Menu.AddNewFile.Click += new EventHandler(TreeAddFile);
			pluginUI.Menu.AddNewFolder.Click += new EventHandler(TreeAddFolder);
			pluginUI.Menu.AddLibraryAsset.Click += new EventHandler(TreeAddAsset);
			pluginUI.Menu.AddExistingFile.Click += new EventHandler(TreeAddExistingFile);
			pluginUI.TreeBar.Refresh.Click += new EventHandler(TreeRefreshNode);

			menus.RecentComboBox.Rebuild();

			#endregion

			pluginPanel = MainForm.CreateDockingPanel(pluginUI, Guid, 
				Icons.Project.Img, DockState.DockRight);

			// try to open the last opened project
			string lastProject = Settings.LastProject;

			if (Settings.LastProject != "" && File.Exists(Settings.LastProject))
			{
				OpenProjectSilent(lastProject);
				// if we open the last project right away, we need to give ASCompletion
				// some time before we can trust that it received our classpaths ok
				startupTimer = new Timer();
				startupTimer.Tick += new EventHandler(ProjectClasspathsChanged);
				startupTimer.Interval = 1000;
				startupTimer.Start();
			}
			else Project = null;

			try
			{
				ProjectIcon.Associate(); // make sure .fdp points to this instance of FD
			}
			catch(UnauthorizedAccessException)
			{
				// silent
			}
			catch(Exception)
			{
				// silent?
			}
		}

		public void Dispose()
		{
			if (Project != null)
			{
				ProjectPreferences prefs = PluginData.GetPrefs(Project);
				prefs.ExpandedPaths = pluginUI.Tree.ExpandedPaths;
				prefs.EnableTrace = !pluginUI.IsTraceDisabled;
				PluginData.Save();
			}
		}

		#region Current Project

		[Browsable(false)]
		Project Project
		{
			get { return pluginUI.Project; }
			set
			{
				pluginUI.Project = value;
				menus.ProjectMenu.ItemsEnabled = (value != null);
				projectActions.UpdateASCompletion(MainForm,pluginUI.Project);
				BroadcastProjectInfo();

				if (value != null)
				{
					OpenPanel(this, new EventArgs());
					pluginUI.Focus();
					Settings.LastProject = value.ProjectPath;
					menus.RecentComboBox.Add(Project);
					pluginUI.TreeBar.EnableTrace.IsChecked = 
						PluginData.GetPrefs(value).EnableTrace;
				}
				else
				{
					Settings.LastProject = "";
					menus.RecentComboBox.SelectNone();
				}
			}
		}

		#endregion

		#region Event Broadcasting

		public void BroadcastProjectInfo()
		{
			IDictionary projectInfo = new Hashtable();

			if (Project != null)
			{
				projectInfo["projectPath"] = Project.ProjectPath;
				projectInfo["outputPath"] = Project.GetAbsolutePath(Project.OutputPath);
				projectInfo["classpaths"] = Project.AbsoluteClasspaths.ToArray();
				projectInfo["width"] = Project.MovieOptions.Width;
				projectInfo["height"] = Project.MovieOptions.Height;
			}

			MainForm.DispatchEvent(new DataEvent(EventType.CustomData,EVENT_PROJECTINFO,projectInfo));
		}

		public void BroadcastBuildComplete()
		{
			MainForm.DispatchEvent(new DataEvent(EventType.CustomData,EVENT_BUILDCOMPLETE,null));
		}

		#endregion

		#region Event Handling

		Project GetProject()
		{
			return Project;
		}

		void TestMovie(object sender, EventArgs e) {
			buildActions.Build(Project,true,pluginUI.IsTraceDisabled);
		}
		
		void BuildProject(object sender, EventArgs e) {
			buildActions.Build(Project,false,pluginUI.IsTraceDisabled);
		}

		void BuildComplete(bool runOutput)
		{
			BroadcastBuildComplete();

			if (runOutput)
				OpenSwf(Project.AbsoluteOutputPath);
		}

		void ProjectClasspathsChanged(object sender, EventArgs e)
		{
			if (startupTimer != null)
				startupTimer.Stop();

			projectActions.UpdateASCompletion(MainForm,Project);
		}

		void NewProject(object sender, EventArgs e)
		{
			Project project = projectActions.NewProject();

			if (project != null)
				Project = project;
		}

		void OpenProject(object sender, EventArgs e)
		{
			Project project = projectActions.OpenProject();

			if (project != null)
				Project = project;
		}

		private void OpenProjectSilent(string projectPath)
		{
			Project project = projectActions.OpenProjectSilent(projectPath);
			if (project != null)
				Project = project;
		}

		void CloseProject(object sender, EventArgs e)
		{
			Project = null;
		}

		private void FileDeleted(string path)
		{
			flashDevelopActions.CloseDocument(path);
			projectActions.RemoveAllReferences(Project,path);
			pluginUI.WatchParentOf(path);
			Project.Save();
		}

		private void FileMoved(string fromPath, string toPath)
		{
			flashDevelopActions.MoveDocument(fromPath,toPath);
			projectActions.MoveReferences(Project,fromPath,toPath);
			pluginUI.WatchParentOf(fromPath);
			pluginUI.WatchParentOf(toPath);
			Project.Save();
		}

		#endregion

		#region Plugin Event Handling
		
		// Receives only events in EventMask
		public void HandleEvent(object sender, NotifyEvent e)
		{
			TextEvent te = e as TextEvent;

			switch (e.Type)
			{
				// replace @MACRO type stuff with things we know about
				case EventType.ProcessArgs:
					if (Project != null)
					{
						// steal macro names and values from the very useful
						// BuildEvent macros, except instead of $(Var) we expect @VAR
						string[] globalCP = Settings.GlobalClasspaths.Split(';');
						BuildEventVars vars = new BuildEventVars(Project,globalCP);

						foreach (BuildEventInfo info in vars.GetVars())
							te.Text = te.Text.Replace("@"+info.Name.ToUpper(),info.Value);
					}
					break;
				case EventType.FileOpening:
					// if this is an .fdp file, we can handle it ourselves
					if (Path.GetExtension(te.Text).ToLower() == ".fdp")
					{
						te.Handled = true;
						OpenProjectSilent(te.Text);
						menus.RecentComboBox.Add(Project);
					}
					break;
				case EventType.FileOpen:
					
					if (fileActions.DocumentSeekRequest > 0)
					{
						// we just created a new class, put the cursor between the brackets.
						MainForm.CurSciControl.GotoPos(fileActions.DocumentSeekRequest);
						fileActions.DocumentSeekRequest = 0;
					}
					// add some support for additional known xml files (like asml)
					if (MainForm.CurSciControl.ConfigurationLanguage == "text" &&
					    FileHelper.IsXml(MainForm.CurFile))
						MainForm.CallCommand("ChangeSyntax","xml");

					OpenNextFile(); // it's safe to open any other files on the queue
					break;
				case EventType.ProcessStart:
					buildActions.NotifyBuildStarted();
					break;
				case EventType.ProcessEnd:
					string result = (e as TextEvent).Text;
					buildActions.NotifyBuildEnded(result);
					break;
				case EventType.Command:
					if (te.Text == COMMAND_SENDPROJECTINFO)
					{
						BroadcastProjectInfo();
						e.Handled = true;
					}
					else if (te.Text == COMMAND_BUILDPROJECT)
					{
						if (Project != null)
						{
							buildActions.Build(Project,false,pluginUI.IsTraceDisabled);
							e.Handled = true;
						}
					}
					else if (te.Text == COMMAND_HOTBUILD)
					{
						if (Project != null && Project.OutputPath.Length > 0)
						{
							buildActions.Build(Project,true,pluginUI.IsTraceDisabled);
							e.Handled = true;
						}
					}
					break;
				case EventType.SettingUpdate:
					if (Project == null)
						return;

					if (showProjectClasspaths != Settings.ShowProjectClasspaths ||
						showGlobalClasspaths != Settings.ShowGlobalClasspaths)
					{
						showProjectClasspaths = Settings.ShowProjectClasspaths;
						showGlobalClasspaths = Settings.ShowGlobalClasspaths;
						pluginUI.Tree.RebuildTree(true);
					}
					break;
					
				// PHILIPPE: handle copy/paste shortcuts
				case EventType.Shortcut:
					KeyEvent ke = e as KeyEvent;
					if (pluginUI.Tree.Focused && !pluginUI.IsEditingLabel && ke != null)
					{
						switch (ke.Value)
						{
							case Keys.Control|Keys.C:
								if (pluginUI.Menu.Copy.IsEnabled) TreeCopyItems(null, null);
								ke.Handled = true;
								break;
							case Keys.Control|Keys.X:
								if (pluginUI.Menu.Cut.IsEnabled) TreeCutItems(null, null);
								ke.Handled = true;
								break;
							case Keys.Control|Keys.V:
								if (pluginUI.Menu.Paste.IsEnabled) TreePasteItems(null, null);
								ke.Handled = true;
								break;
							case Keys.Delete:
								if (pluginUI.Menu.Delete.IsEnabled) TreeDeleteItems(null,null);
								ke.Handled = true;
								break;
							case Keys.Enter:
								
								break;
						}
					}
					break;
			}
		}
		
		#endregion

		#region Methods
		
		void OpenPanel(object sender, EventArgs e)
		{
			this.pluginPanel.Show();
		}

		void OpenGlobalClasspaths(object sender, EventArgs e)
		{
			using (ClasspathDialog dialog = new ClasspathDialog())
			{
				dialog.ClasspathString = Settings.GlobalClasspaths;
				if (dialog.ShowDialog(pluginUI) == DialogResult.OK)
					Settings.GlobalClasspaths = dialog.ClasspathString;
			}
		}
		
		void OpenProjectProperties(object sender, EventArgs e)
		{
			using (PropertiesDialog dialog = new PropertiesDialog(Project))
			{
				dialog.OpenGlobalClasspaths += new EventHandler(OpenGlobalClasspaths);
				dialog.ShowDialog(pluginUI);
				
				if (dialog.ClasspathsChanged)
					projectActions.UpdateASCompletion(MainForm,Project);
				
				if (dialog.ClasspathsChanged || dialog.AssetsChanged)
					pluginUI.Tree.RebuildTree(true);
				
				if (dialog.PropertiesChanged)
				{
					BroadcastProjectInfo();
					Project.Save();
				}
			}
		}

		void OpenFile(string path)
		{
			if (FileHelper.ShouldUseShellExecute(path))
				ProcessHelper.StartAsync(path);
			else if (FileHelper.IsSwf(path))
				OpenSwf(path);
			else MainForm.OpenSelectedFile(path);
		}

		void OpenSwf(string path)
		{
			bool isOutput = path.ToLower() == Project.AbsoluteOutputPath.ToLower();
			int w = Project.MovieOptions.Width;
			int h = Project.MovieOptions.Height;

			if (!isOutput ||  Project.MovieOptions.TestMovieBehavior == TestMovieBehavior.NewTab)
				MainForm.OpenSelectedFile(path);
			else if (Project.MovieOptions.TestMovieBehavior == TestMovieBehavior.NewWindow)
				MainForm.CallCommand("PluginCommand",COMMAND_POPUPSWF+path+";"+w+";"+h);
			else
				ProcessHelper.StartAsync(path);
		}

		#endregion

		#region Project Tree Event Handling

		// we can't open files too quickly, so we have to wait
		Queue openFileQueue = new Queue();

		public void TreeOpenItems(object sender, EventArgs e)
		{
			foreach (string path in pluginUI.Tree.SelectedPaths)
				openFileQueue.Enqueue(path);
			OpenNextFile();
		}

		private void OpenNextFile()
		{
			if (openFileQueue.Count > 0)
				OpenFile(openFileQueue.Dequeue() as string);
		}

		private void TreeExecuteItems(object sender, EventArgs e) {
			foreach (string path in pluginUI.Tree.SelectedPaths)
				ProcessHelper.StartAsync(path);
		}

		public void TreeInsertItem(object sender, EventArgs e)
		{
			// special behavior if this is a fake export node inside a SWF file
			ExportNode node = pluginUI.Tree.SelectedNode as ExportNode;

			if (node != null)
				projectActions.InsertFile(MainForm,Project,node.ContainingSwfPath,node.Export);
			else
				projectActions.InsertFile(MainForm,Project,pluginUI.Tree.SelectedPath,null);
		}

		private void TreeAddLibraryItems(object sender, EventArgs e) {
			// we want to deselect all nodes when toggling library so you can see
			// them turn blue to get some feedback
			string[] selectedPaths = pluginUI.Tree.SelectedPaths;
			pluginUI.Tree.SelectedNodes = null;
			projectActions.ToggleLibraryAsset(Project,selectedPaths);
		}

		private void TreeAlwaysCompileItems(object sender, EventArgs e) {
			projectActions.ToggleAlwaysCompile(Project,pluginUI.Tree.SelectedPaths);
		}

		private void TreeCutItems(object sender, EventArgs e) {
			fileActions.CutToClipboard(pluginUI.Tree.SelectedPaths);
		}

		private void TreeCopyItems(object sender, EventArgs e) {
			fileActions.CopyToClipboard(pluginUI.Tree.SelectedPaths);
		}

		private void TreePasteItems(object sender, EventArgs e) {
			fileActions.PasteFromClipboard(pluginUI.Tree.SelectedPath);
		}

		private void TreeDeleteItems(object sender, EventArgs e)  {
			fileActions.Delete(pluginUI.Tree.SelectedPaths);
		}

		private void TreeLibraryOptions(object sender, EventArgs e)
		{
			LibraryAssetDialog dialog = new LibraryAssetDialog(pluginUI.Tree.SelectedAsset);
			if (dialog.ShowDialog(pluginUI) == DialogResult.OK)
			{
				pluginUI.Tree.SelectedNode.Refresh(false);
				Project.Save();
			}
		}

		private void TreeAddNewClass(object sender, EventArgs e){
			fileActions.AddClass(Project,pluginUI.Tree.SelectedPath);
		}

		private void TreeAddXml(object sender, EventArgs e){
			fileActions.AddXmlFile(pluginUI.Tree.SelectedPath);
		}

		private void TreeAddFile(object sender, EventArgs e){
			fileActions.AddFile(pluginUI.Tree.SelectedPath);
		}

		private void TreeAddFolder(object sender, EventArgs e) {
			fileActions.AddFolder(pluginUI.Tree.SelectedPath);
		}

		private void TreeAddAsset(object sender, EventArgs e) {
			fileActions.AddLibraryAsset(Project,pluginUI.Tree.SelectedPath);
		}

		private void TreeAddExistingFile(object sender, EventArgs e) {
			fileActions.AddExistingFile(pluginUI.Tree.SelectedPath);
		}

		private void TreeHideItems(object sender, EventArgs e) {
			projectActions.ToggleHidden(Project,pluginUI.Tree.SelectedPaths);
		}

		private void ToggleShowHidden(object sender, EventArgs e) {
			projectActions.ToggleShowHidden(Project);
		}

		private void TreeRefreshNode(object sender, EventArgs e)
		{
			GenericNode node = pluginUI.Tree.SelectedNode;
			
			// refresh the first parent that *can* be refreshed
			while (!node.IsRefreshable)
				node = node.Parent as GenericNode;

			// if you refresh a SwfFileNode this way (by asking for it), you get
			// special feedback
			SwfFileNode swfNode = node as SwfFileNode;

			if (swfNode != null)
				swfNode.RefreshWithFeedback(true);
			else
				node.Refresh(true);
		}

		#endregion
	}
}
