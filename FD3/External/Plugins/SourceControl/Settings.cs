using System;
using System.ComponentModel;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Text;

namespace SourceControl
{
    [Serializable]
    public class Settings
    {
        private bool enableSVN;
        private string svnPath;
        private string tortoiseSVNProcPath;
        private bool enableGIT;
        private string gitPath;
        private string tortoiseGitProcPath;

        [Category("SVN"),
         Description("Enable SVN integration in projects."),
         DefaultValue(false)]
        public bool EnableSVN
        {
            get { return this.enableSVN; }
            set { this.enableSVN = value; }
        }

        [Category("SVN"),
         Description("Path to SVN command line tool. Example: 'svn.exe' if the tool is already installed in the environment path."), 
         DefaultValue("Tools\\SlikSvn\\bin\\svn.exe")]
        public String SvnPath 
        {
            get { return this.svnPath ?? "Tools\\SlikSvn\\bin\\svn.exe"; }
            set { this.svnPath = value; }
        }

        [Category("SVN"),
         Description("Path to TortoiseSVN's TortoiseProc tool. Example: 'TortoiseProc.exe'"), 
         DefaultValue("TortoiseProc.exe")]
        public String TortoiseSVNProcPath
        {
            get { return this.tortoiseSVNProcPath ?? "TortoiseProc.exe"; }
            set { this.tortoiseSVNProcPath = value; }
        }

        [Category("GIT"),
         Description("Enable GIT integration in projects."),
         DefaultValue(false)]
        public bool EnableGIT
        {
            get { return this.enableGIT; }
            set { this.enableGIT = value; }
        }

        [Category("GIT"),
         Description("Path to GIT command line tool. Example: 'git' if the tool is already installed in the environment path."),
         DefaultValue("git")]
        public String GitPath
        {
            get { return this.gitPath ?? "git"; }
            set { this.gitPath = value; }
        }

        [Category("GIT"),
         Description("Path to TortoiseGit's TortoiseProc tool. Example: 'TortoiseProc.exe'"),
         DefaultValue("TortoiseProc.exe")]
        public String TortoiseGitProcPath
        {
            get { return this.tortoiseGitProcPath ?? "TortoiseProc.exe"; }
            set { this.tortoiseGitProcPath = value; }
        }


    }

}
