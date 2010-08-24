using System;
using System.Text;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using System.Windows.Forms.Design;
using PluginCore.Localization;
using System.Drawing.Design;

namespace SourceControl
{
    [Serializable]
    public class Settings
    {
        private String gitPath;
        private String svnPath;
        private String tortoiseSVNProcPath;
        private String tortoiseGitProcPath;
        private Boolean enableSVN;
        private Boolean enableGIT;

        [DefaultValue(false)]
        [DisplayName("Enable SVN")]
        [LocalizedCategory("SourceControl.Category.SVN")]
        [LocalizedDescription("SourceControl.Description.EnableSVN")]
        public Boolean EnableSVN
        {
            get { return this.enableSVN; }
            set { this.enableSVN = value; }
        }

        [DefaultValue("svn.exe")]
        [DisplayName("SVN Path")]
        [LocalizedCategory("SourceControl.Category.SVN")]
        [LocalizedDescription("SourceControl.Description.SVNPath")]
        [Editor(typeof(FileNameEditor), typeof(UITypeEditor))]
        public String SVNPath 
        {
            get { return this.svnPath ?? "svn.exe"; }
            set { this.svnPath = value; }
        }

        [DefaultValue("TortoiseProc.exe")]
        [DisplayName("TortoiseSVN Proc Path")]
        [LocalizedCategory("SourceControl.Category.SVN")]
        [LocalizedDescription("SourceControl.Description.TortoiseSVNProcPath")]
        [Editor(typeof(FileNameEditor), typeof(UITypeEditor))]
        public String TortoiseSVNProcPath
        {
            get { return this.tortoiseSVNProcPath ?? "TortoiseProc.exe"; }
            set { this.tortoiseSVNProcPath = value; }
        }

        [DefaultValue(false)]
        [DisplayName("Enable GIT")]
        [LocalizedCategory("SourceControl.Category.GIT")]
        [LocalizedDescription("SourceControl.Description.EnableGIT")]
        public Boolean EnableGIT
        {
            get { return this.enableGIT; }
            set { this.enableGIT = value; }
        }

        [DefaultValue("git")]
        [DisplayName("GIT Path")]
        [LocalizedCategory("SourceControl.Category.GIT")]
        [LocalizedDescription("SourceControl.Description.GITPath")]
        [Editor(typeof(FileNameEditor), typeof(UITypeEditor))]
        public String GITPath
        {
            get { return this.gitPath ?? "git"; }
            set { this.gitPath = value; }
        }

        [DefaultValue("TortoiseProc.exe")]
        [DisplayName("TortoiseGIT Proc Path")]
        [LocalizedCategory("SourceControl.Category.GIT")]
        [LocalizedDescription("SourceControl.Description.TortoiseGITProcPath")]
        [Editor(typeof(FileNameEditor), typeof(UITypeEditor))]
        public String TortoiseGITProcPath
        {
            get { return this.tortoiseGitProcPath ?? "TortoiseProc.exe"; }
            set { this.tortoiseGitProcPath = value; }
        }

    }

}
