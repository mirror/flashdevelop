using System;
using System.Drawing;
using System.Drawing.Design;
using System.Windows.Forms;
using System.ComponentModel;
using System.ComponentModel.Design;
using System.Windows.Forms.Design;
using System.Runtime.CompilerServices;
using PluginCore.Localization;

namespace FlashDebugger
{
    public delegate void PathChangedEventHandler(String path);
	
	[Serializable]
	[DefaultProperty("Path")]
	public class Folder
	{
		private String m_Value;

		public Folder()
		{
			m_Value = "";
		}

		public Folder(String value)
		{
			m_Value = value;
		}

		public override String ToString()
		{
			return m_Value;
		}

		[Editor(typeof(FolderNameEditor), typeof(UITypeEditor))]
		public String Path
		{
			get { return m_Value; }
			set { m_Value = value; }
		}
	}

    [Serializable]
    public class Settings
    {
		private Keys m_StartContinueShortcut;
		private Keys m_CurrentShortcut;
		private Keys m_StopShortcut;
		private Keys m_RunToCursorShortcut;
		private Keys m_StepShortcut;
		private Keys m_NextShortcut;
		private Keys m_PauseShortcut;
		private Keys m_FinishShortcut;
        private Keys m_DeleteAllBreakPoints;
		private Keys m_ToggleBreakPointShortcut;
		private Keys m_ToggleBreakPointEnableShortcut;
		private Keys m_DisableAllBreakPointsShortcut;
		private Keys m_EnableAllBreakPointsShortcut;
		private Folder[] m_SourcePaths = new Folder[] {};
        private Boolean m_SaveBreakPoints = true;
        private Boolean m_VerboseOutput = true;
        private Boolean m_StartDebuggerOnTestMovie = true;

        [DisplayName("Save Breakpoints")]
        [LocalizedCategory("FlashDebugger.Category.Misc")]
        [LocalizedDescription("FlashDebugger.Description.SaveBreakPoints")]
		[DefaultValue(true)]
		public bool SaveBreakPoints
		{
			get { return m_SaveBreakPoints; }
			set { m_SaveBreakPoints = value; }
		}

        [DisplayName("Verbose Output")]
        [LocalizedCategory("FlashDebugger.Category.Misc")]
        [LocalizedDescription("FlashDebugger.Description.VerboseOutput")]
        [DefaultValue(false)]
        public bool VerboseOutput
        {
            get { return m_VerboseOutput; }
            set { m_VerboseOutput = value; }
        }

        [DisplayName("Source Paths")]
        [LocalizedCategory("FlashDebugger.Category.Misc")]
        [LocalizedDescription("FlashDebugger.Description.SourcePaths")]
		[Editor(typeof(ArrayEditor), typeof(UITypeEditor))]
		public Folder[] SourcePaths
		{
			get
			{
				if (m_SourcePaths == null || m_SourcePaths.Length == 0)
				{
                    m_SourcePaths = new Folder[] {};
				}
				return m_SourcePaths;
			}
			set { m_SourcePaths = value; }
		}

        [DisplayName("Stop Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.Stop")]
        [DefaultValue(Keys.None)]
        public Keys Stop
        {
			get { return m_StopShortcut; }
			set { m_StopShortcut = value; }
        }

        [DisplayName("Start Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.StartContinue")]
        [DefaultValue(Keys.None)]
        public Keys StartContinue
        {
			get { return m_StartContinueShortcut; }
			set { m_StartContinueShortcut = value; }
        }

        [DisplayName("Current Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.Current")]
        [DefaultValue(Keys.None)]
		public Keys Current
		{
			get { return m_CurrentShortcut; }
			set { m_CurrentShortcut = value; }
		}

        [DisplayName("Run To Cursor Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.RunToCursor")]
        [DefaultValue(Keys.None)]
		public Keys RunToCursor
		{
			get { return m_RunToCursorShortcut; }
			set { m_RunToCursorShortcut = value; }
		}

        [DisplayName("Step Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.Step")]
        [DefaultValue(Keys.None)]
        public Keys Step
        {
			get { return m_StepShortcut; }
			set { m_StepShortcut = value; }
        }

        [DisplayName("Next Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.Next")]
        [DefaultValue(Keys.None)]
        public Keys Next
        {
			get { return m_NextShortcut; }
			set { m_NextShortcut = value; }
        }

        [DisplayName("Pause Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.Pause")]
        [DefaultValue(Keys.None)]
        public Keys Pause
        {
			get { return m_PauseShortcut; }
			set { m_PauseShortcut = value; }
        }

        [DisplayName("Finish Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.Finish")]
        [DefaultValue(Keys.None)]
		public Keys Finish
        {
			get { return m_FinishShortcut; }
			set { m_FinishShortcut = value; }
        }

        [DisplayName("Toggle Breakpoint Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.ToggleBreakPoint")]
        [DefaultValue(Keys.None)]
		public Keys ToggleBreakPoint
        {
			get { return m_ToggleBreakPointShortcut; }
			set { m_ToggleBreakPointShortcut = value; }
        }

        [DisplayName("Toggle Breakpoints Enabled Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.ToggleBreakPointEnable")]
        [DefaultValue(Keys.None)]
		public Keys ToggleBreakPointEnable
		{
			get { return m_ToggleBreakPointEnableShortcut; }
			set { m_ToggleBreakPointEnableShortcut = value; }
		}

        [DisplayName("Delete All Breakpoints Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.DeleteAllBreakPoints")]
        [DefaultValue(Keys.None)]
        public Keys DeleteAllBreakPoints
        {
            get { return m_DeleteAllBreakPoints; }
            set { m_DeleteAllBreakPoints = value; }
        }

        [DisplayName("Disable All Breakpoints Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.DisableAllBreakPoints")]
        [DefaultValue(Keys.None)]
		public Keys DisableAllBreakPoints
        {
			get { return m_DisableAllBreakPointsShortcut; }
			set { m_DisableAllBreakPointsShortcut = value; }
        }

        [DisplayName("Enable All Breakpoints Shortcut")]
        [LocalizedCategory("FlashDebugger.Category.Shortcuts")]
        [LocalizedDescription("FlashDebugger.Description.EnableAllBreakPoints")]
        [DefaultValue(Keys.None)]
		public Keys EnableAllBreakPoints
        {
			get { return m_EnableAllBreakPointsShortcut; }
			set { m_EnableAllBreakPointsShortcut = value; }
        }

        [DisplayName("Start Debugger On Test Movie")]
        [LocalizedCategory("FlashDebugger.Category.Misc")]
        [LocalizedDescription("FlashDebugger.Description.StartDebuggerOnTestMovie")]
        [DefaultValue(true)]
        public bool StartDebuggerOnTestMovie
        {
            get { return m_StartDebuggerOnTestMovie; }
            set { m_StartDebuggerOnTestMovie = value; }
        }

    }

}
