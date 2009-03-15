using System;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Design;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
using System.Windows.Forms.Design;
using PluginCore.Localization;

namespace FdbPlugin
{
    public delegate void PathChangedEventHandler(String path);
    public delegate void FlexSDKLocaleChangedEventHandler(FlexSDKLocale locate);

    public enum FlexSDKLocale
    {
        en_US,
        ja_JP
    }

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

        private Keys toggleBreakPointShortcut;
        private Keys finishShortcut;
        private Keys toggleBreakPointEnableShortcut;

        private Keys disableAllBreakPointsShortcut;
        private Keys enableAllBreakPointsShortcut;

        private String debugFlashPlayerPath;
        private Boolean debugWithCompile = true;
        private Boolean alwaysCheckDebugStop = true;
        private Boolean isTraceLog = false;

        private Boolean saveBreakPoints = false;
        private FlexSDKLocale flexSdkLocale = FlexSDKLocale.en_US;

        private Color breakPointEnableLineColor = Color.Yellow;
        private Color breakPointDisableLineColor = Color.Gray;

        [NonSerialized]
        private PathChangedEventHandler pathChangedEvent = null;

        [NonSerialized]
        private FlexSDKLocaleChangedEventHandler flexSDKLocaleChangedEvent = null;

        // We need to create events "manually" so that the list of delegates is not serialized
        // along with the class!
        public event PathChangedEventHandler PathChangedEvent
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            add { pathChangedEvent = (PathChangedEventHandler)Delegate.Combine(pathChangedEvent, value); }
            [MethodImpl(MethodImplOptions.Synchronized)]
            remove { pathChangedEvent = (PathChangedEventHandler)Delegate.Remove(pathChangedEvent, value); }
        }

        public event FlexSDKLocaleChangedEventHandler FlexSDKLocaleChangedEvent
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            add { flexSDKLocaleChangedEvent = (FlexSDKLocaleChangedEventHandler)Delegate.Combine(flexSDKLocaleChangedEvent, value); }
            [MethodImpl(MethodImplOptions.Synchronized)]
            remove { flexSDKLocaleChangedEvent = (FlexSDKLocaleChangedEventHandler)Delegate.Remove(flexSDKLocaleChangedEvent, value); }
        }

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

        [LocalizedCategory("FdbPlugin.Category.Shortcuts")]
        public Keys Finish
        {
            get { return this.finishShortcut; }
            set { this.finishShortcut = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.Shortcuts")]
        public Keys ToggleBreakPoint
        {
            get { return this.toggleBreakPointShortcut; }
            set { this.toggleBreakPointShortcut = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.Shortcuts")]
        public Keys DisableAllBreakPoints
        {
            get { return this.disableAllBreakPointsShortcut; }
            set { this.disableAllBreakPointsShortcut = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.Shortcuts")]
        public Keys EnableAllBreakPoints
        {
            get { return this.enableAllBreakPointsShortcut; }
            set { this.enableAllBreakPointsShortcut = value; }
        }


        [LocalizedCategory("FdbPlugin.Category.Misc")]
        [Editor(typeof(FileNameEditor), typeof(UITypeEditor))]
        [LocalizedDescription("FdbPlugin.Description.DebugFlashPlayerPath")]
        public String DebugFlashPlayerPath
        {
            get { return debugFlashPlayerPath; }
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

        [LocalizedCategory("FdbPlugin.Category.Misc")]
        [Description("Enable debugger logging (requires restart)"), DefaultValue(false)]
        public bool EnableLogging
        {
            get { return this.isTraceLog; }
            set { this.isTraceLog = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.Misc")]
        [Description("Save BreakPoints"), DefaultValue(false)]
        public bool SaveBreakPoints
        {
            get { return this.saveBreakPoints; }
            set { this.saveBreakPoints = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.Misc")]
        [Description("Flex SDK Locate"), DefaultValue(FlexSDKLocale.en_US)]
        public FlexSDKLocale FlexSdkLocale
        {
            get { return this.flexSdkLocale; }
            set
            {
                if (value == this.flexSdkLocale) return;
                this.flexSdkLocale = value;
                if (flexSDKLocaleChangedEvent != null)
                    flexSDKLocaleChangedEvent(this.flexSdkLocale);
            }
        }

        [LocalizedCategory("FdbPlugin.Category.Shortcuts")]
        public Keys ToggleBreakPointEnable
        {
            get { return this.toggleBreakPointEnableShortcut; }
            set { this.toggleBreakPointEnableShortcut = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.View")]
        [DefaultValue(typeof(Color), "Yellow")]
        public Color BreakPointEnableLineColor
        {
            get { return this.breakPointEnableLineColor; }
            set { this.breakPointEnableLineColor = value; }
        }

        [LocalizedCategory("FdbPlugin.Category.View")]
        [DefaultValue(typeof(Color), "Gray")]
        public Color BrekPointDisableLineColor
        {
            get { return this.breakPointDisableLineColor; }
            set { this.breakPointDisableLineColor = value; }
        }

        [Browsable(false)]
        private void FireChanged()
        {
            if (pathChangedEvent != null) pathChangedEvent(debugFlashPlayerPath);
        }

    }

}
