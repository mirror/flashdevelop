using System;
using System.Drawing;
using System.ComponentModel;
using System.Windows.Forms;
using System.Windows.Forms.Design;
using System.Drawing.Design;
using PluginCore.Localization;
using System.Xml.Serialization;

namespace FdbPlugin
{
    public delegate void PathChangedEventHandler(String path);

    [Serializable]
    public class Settings
    {
        private Color debugLineColor = Color.Red;
        private Keys startNoDebugShortcut;
        private Keys stopShortcut;
        private Keys continueShortcut;
        private Keys stepShortcut;
        private Keys nextShortcut;
        private Keys pauseShortcut;
        private String debugFlashPlayerPath;
        private Boolean debugWithCompile = true;
        private Boolean alwaysCheckDebugStop = true;
        public event PathChangedEventHandler PathChangedEvent = null;

        [LocalizedCategory("FdbPlugin.Category.View")]
        [LocalizedDescription("FdbPlugin.Description.DebugLineColor")] 
        [DefaultValue(typeof(Color), "Red")]
        public Color DebugLineColor
        {
            get { return this.debugLineColor; }
            set { this.debugLineColor = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.Shortcuts")]
        [LocalizedDescription("FdbPlugin.Description.StartNoDebug")]
        public Keys StartNoDebug
        {
            get { return this.startNoDebugShortcut; }
            set { this.startNoDebugShortcut = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.Shortcuts")]
        [LocalizedDescription("FdbPlugin.Description.Stop")]
        public Keys Stop
        {
            get { return this.stopShortcut; }
            set { this.stopShortcut = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.Shortcuts")]
        [LocalizedDescription("FdbPlugin.Description.Continue")]
        public Keys Continue
        {
            get { return this.continueShortcut; }
            set { this.continueShortcut = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.Shortcuts")]
        [LocalizedDescription("FdbPlugin.Description.Step")]
        public Keys Step
        {
            get { return this.stepShortcut; }
            set { this.stepShortcut = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.Shortcuts")]
        [LocalizedDescription("FdbPlugin.Description.Next")]
        public Keys Next
        {
            get { return this.nextShortcut; }
            set { this.nextShortcut = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.Shortcuts")]
        [LocalizedDescription("FdbPlugin.Description.Pause")]
        public Keys Pause
        {
            get { return this.pauseShortcut; }
            set { this.pauseShortcut = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.Misc")]
        [Editor(typeof(FileNameEditor), typeof(UITypeEditor))]
        [LocalizedDescription("FdbPlugin.Description.DebugFlashPlayerPath")]
        public String DebugFlashPlayerPath
        {
            get 
            { 
                String cmd;
                try
                {
                    cmd = Util.FindAssociatedExecutableFile(".swf", "open");
                    debugFlashPlayerPath = Util.GetAssociateAppFullPath(cmd);

                    if (debugFlashPlayerPath != null && debugFlashPlayerPath != string.Empty)
                    {
                        debugFlashPlayerPath = debugFlashPlayerPath.Trim().Trim(new char[] { '"' });
                    }
                    return debugFlashPlayerPath; 
                }
                catch
                {
                    debugFlashPlayerPath = String.Empty;
                    return debugFlashPlayerPath; 
                }
            }
            set
            {
                if (value == debugFlashPlayerPath) return;
                debugFlashPlayerPath = value;
                FireChanged();
            }
        }

        [DefaultValue(true)]
        [LocalizedCategory("FdbPlugin.Category.Misc")]
        [LocalizedDescription("FdbPlugin.Description.DebugWithCompile")]
        public Boolean DebugWithCompile
        {
            get { return this.debugWithCompile; }
            set { this.debugWithCompile = value; }
        }

        [DefaultValue(true)]
        [LocalizedCategory("FdbPlugin.Category.Misc")]
        [LocalizedDescription("FdbPlugin.Description.AlwaysCheckDebugStop")]
        public Boolean AlwaysCheckDebugStop
        {
            get { return this.alwaysCheckDebugStop; }
            set { this.alwaysCheckDebugStop = value; }
        }
        
        [Browsable(false)]
        private void FireChanged()
        {
            if (PathChangedEvent != null) PathChangedEvent(debugFlashPlayerPath);
        }

    }

}
