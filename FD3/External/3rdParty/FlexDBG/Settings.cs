/*
    Copyright (C) 2009  Robert Nelson

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/

using System;
using System.ComponentModel;
using System.ComponentModel.Design;
using System.Drawing;
using System.Drawing.Design;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
using System.Windows.Forms.Design;
using FlexDbg.Localization;

namespace FlexDbg
{
    public delegate void PathChangedEventHandler(String path);
    public delegate void FlexSDKLocaleChangedEventHandler(FlexSDKLocale locate);

    public enum FlexSDKLocale
    {
		[StringValue("en-US")]
		en_US = 0,
		[StringValue("ja-JP")]
		ja_JP = 1
    }
	
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
			get
			{
				return m_Value;
			}

			set
			{
				m_Value = value;
			}
		}
	};

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

		private Keys m_ToggleBreakPointShortcut;
		private Keys m_ToggleBreakPointEnableShortcut;

		private Keys m_DisableAllBreakPointsShortcut;
		private Keys m_EnableAllBreakPointsShortcut;

		private Folder[] m_SourcePaths = new Folder[] { };

		// private String m_DebugFlashPlayerPath;
		private Boolean m_CompileBeforeDebug = false;
		private Boolean m_bTraceLog = false;

		private Boolean m_SaveBreakPoints = true;
		// private FlexSDKLocale m_FlexSdkLocale = FlexSDKLocale.en_US;

		private Color m_BreakPointEnableLineColor = Color.Red;
		private Color m_BreakPointDisableLineColor = Color.Gray;
		private Color m_DebugLineColor = Color.Yellow;

        private Boolean m_WaitForExternal = false;

#if false
		private Point debugToolBarLocation = new Point(0, 0);

		public Point DebugToolBarLocation
		{
			get
			{
				return debugToolBarLocation;
			}

			set
			{
				debugToolBarLocation = value;
			}
		}
#endif

#if false
        [NonSerialized]
        private PathChangedEventHandler m_PathChangedEvent = null;

        [NonSerialized]
		private FlexSDKLocaleChangedEventHandler m_FlexSDKLocaleChangedEvent = null;

        // We need to create events "manually" so that the list of delegates is not serialized
        // along with the class!
        public event PathChangedEventHandler PathChangedEvent
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
			add { m_PathChangedEvent = (PathChangedEventHandler)Delegate.Combine(m_PathChangedEvent, value); }
            [MethodImpl(MethodImplOptions.Synchronized)]
			remove { m_PathChangedEvent = (PathChangedEventHandler)Delegate.Remove(m_PathChangedEvent, value); }
        }

        public event FlexSDKLocaleChangedEventHandler FlexSDKLocaleChangedEvent
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
			add { m_FlexSDKLocaleChangedEvent = (FlexSDKLocaleChangedEventHandler)Delegate.Combine(m_FlexSDKLocaleChangedEvent, value); }
            [MethodImpl(MethodImplOptions.Synchronized)]
			remove { m_FlexSDKLocaleChangedEvent = (FlexSDKLocaleChangedEventHandler)Delegate.Remove(m_FlexSDKLocaleChangedEvent, value); }
        }

		[LocalizedCategory("Category.Misc")]
		[Editor(typeof(FileNameEditor), typeof(UITypeEditor))]
		[LocalizedDescription("Description.DebugFlashPlayerPath")]
		public String DebugFlashPlayerPath
		{
			get { return m_DebugFlashPlayerPath; }
			set
			{
				if (value == m_DebugFlashPlayerPath)
					return;
				m_DebugFlashPlayerPath = value;
				FireChanged();
			}
		}
#endif

		[LocalizedCategory("Category.Misc")]
		[LocalizedDescription("Description.CompileBeforeDebug")]
		[DefaultValue(false)]
		public Boolean CompileBeforeDebug
		{
			get { return m_CompileBeforeDebug; }
			set { m_CompileBeforeDebug = value; }
		}

		[LocalizedCategory("Category.Misc")]
		[LocalizedDescription("Description.EnableLogging")]
		[DefaultValue(false)]
		public bool EnableLogging
		{
			get { return m_bTraceLog; }
			set { m_bTraceLog = value; }
		}

		[LocalizedCategory("Category.Misc")]
		[LocalizedDescription("Description.SaveBreakPoints")]
		[DefaultValue(true)]
		public bool SaveBreakPoints
		{
			get { return m_SaveBreakPoints; }
			set { m_SaveBreakPoints = value; }
		}

		[LocalizedCategory("Category.Misc")]
		[LocalizedDisplayName("DisplayName.SourcePaths")]
		[LocalizedDescription("Description.SourcePaths")]
		[Editor(typeof(ArrayEditor), typeof(UITypeEditor))]
		public Folder[] SourcePaths
		{
			get
			{
				if (m_SourcePaths == null || m_SourcePaths.Length == 0)
				{
					m_SourcePaths = new Folder[] { };
				}

				return m_SourcePaths;
			}
			set
			{
				m_SourcePaths = value;
			}
		}

#if false
		[LocalizedCategory("Category.Misc")]
		[LocalizedDescription("Description.FlexSdkLocale")]
		[DefaultValue(FlexSDKLocale.en_US)]
		public FlexSDKLocale FlexSdkLocale
		{
			get { return m_FlexSdkLocale; }
			set
			{
				if (value == m_FlexSdkLocale) return;
				m_FlexSdkLocale = value;
				if (m_FlexSDKLocaleChangedEvent != null)
					m_FlexSDKLocaleChangedEvent(m_FlexSdkLocale);
			}
		}
#endif

		[LocalizedCategory("Category.Shortcuts")]
        [LocalizedDescription("Description.Stop")]
        public Keys Stop
        {
			get { return m_StopShortcut; }
			set { m_StopShortcut = value; }
        }

        [LocalizedCategory("Category.Shortcuts")]
        [LocalizedDescription("Description.StartContinue")]
        public Keys StartContinue
        {
			get { return m_StartContinueShortcut; }
			set { m_StartContinueShortcut = value; }
        }

		[LocalizedCategory("Category.Shortcuts")]
		[LocalizedDescription("Description.Current")]
		public Keys Current
		{
			get { return m_CurrentShortcut; }
			set { m_CurrentShortcut = value; }
		}

		[LocalizedCategory("Category.Shortcuts")]
		[LocalizedDescription("Description.RunToCursor")]
		public Keys RunToCursor
		{
			get { return m_RunToCursorShortcut; }
			set { m_RunToCursorShortcut = value; }
		}

		[LocalizedCategory("Category.Shortcuts")]
        [LocalizedDescription("Description.Step")]
        public Keys Step
        {
			get { return m_StepShortcut; }
			set { m_StepShortcut = value; }
        }

        [LocalizedCategory("Category.Shortcuts")]
        [LocalizedDescription("Description.Next")]
        public Keys Next
        {
			get { return m_NextShortcut; }
			set { m_NextShortcut = value; }
        }

        [LocalizedCategory("Category.Shortcuts")]
        [LocalizedDescription("Description.Pause")]
        public Keys Pause
        {
			get { return m_PauseShortcut; }
			set { m_PauseShortcut = value; }
        }

        [LocalizedCategory("Category.Shortcuts")]
		[LocalizedDescription("Description.Finish")]
		public Keys Finish
        {
			get { return m_FinishShortcut; }
			set { m_FinishShortcut = value; }
        }

        [LocalizedCategory("Category.Shortcuts")]
		[LocalizedDescription("Description.ToggleBreakPoint")]
		public Keys ToggleBreakPoint
        {
			get { return m_ToggleBreakPointShortcut; }
			set { m_ToggleBreakPointShortcut = value; }
        }

		[LocalizedCategory("Category.Shortcuts")]
		[LocalizedDescription("Description.ToggleBreakPointEnable")]
		public Keys ToggleBreakPointEnable
		{
			get { return m_ToggleBreakPointEnableShortcut; }
			set { m_ToggleBreakPointEnableShortcut = value; }
		}

		[LocalizedCategory("Category.Shortcuts")]
		[LocalizedDescription("Description.DisableAllBreakPoints")]
		public Keys DisableAllBreakPoints
        {
			get { return m_DisableAllBreakPointsShortcut; }
			set { m_DisableAllBreakPointsShortcut = value; }
        }

        [LocalizedCategory("Category.Shortcuts")]
		[LocalizedDescription("Description.EnableAllBreakPoints")]
		public Keys EnableAllBreakPoints
        {
			get { return m_EnableAllBreakPointsShortcut; }
			set { m_EnableAllBreakPointsShortcut = value; }
        }

		[LocalizedCategory("Category.View")]
		[LocalizedDescription("Description.DebugLineColor")]
		[DefaultValue(typeof(Color), "Red")]
		public Color DebugLineColor
		{
			get { return m_DebugLineColor; }
			set { m_DebugLineColor = value; }
		}

		[LocalizedCategory("Category.View")]
		[LocalizedDescription("Description.BreakPointEnableLineColor")]
		[DefaultValue(typeof(Color), "Yellow")]
        public Color BreakPointEnableLineColor
        {
			get { return m_BreakPointEnableLineColor; }
			set { m_BreakPointEnableLineColor = value; }
        }

        [LocalizedCategory("Category.View")]
		[LocalizedDescription("Description.BreakPointDisableLineColor")]
		[DefaultValue(typeof(Color), "Gray")]
        public Color BreakPointDisableLineColor
        {
			get { return m_BreakPointDisableLineColor; }
			set { m_BreakPointDisableLineColor = value; }
        }

#if false
        [Browsable(false)]
        private void FireChanged()
        {
			if (m_PathChangedEvent != null)
				m_PathChangedEvent(m_DebugFlashPlayerPath);
        }
#endif

        [LocalizedCategory("Category.Misc")]
        [LocalizedDescription("Description.WaitForExternal")]
        [DefaultValue(false)]
        public bool WaitForExternal
        {
            get { return m_WaitForExternal; }
            set { m_WaitForExternal = value; }
        }
    }
}
