using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using ProjectManager.Projects.AS3;

namespace ProjectManager.Projects.Haxe
{
    public class HaxeProject : Project
    {
        // hack : we cannot reference settings HaxeProject is also used by FDBuild
        public static bool saveHXML = false;

        public HaxeProject(string path)
            : base(path, new HaxeOptions())
        {
            movieOptions = new HaxeMovieOptions();
        }

        public override string Language { get { return "haxe"; } }
        public override bool HasLibraries { get { return OutputType == OutputType.Application && IsFlashOutput; } }
        public override bool RequireLibrary { get { return IsFlashOutput; } }
        public override string DefaultSearchFilter { get { return "*.hx"; } }
        
        public override bool EnableInteractiveDebugger 
        { 
            get 
            {
                return movieOptions.DebuggerSupported && CompilerOptions.EnableDebug
                    && (movieOptions.Platform != HaxeMovieOptions.NME_PLATFORM || TestMovieCommand == "flash");
            } 
        }

        public override String LibrarySWFPath
        {
            get
            {
                string projectName = RemoveDiacritics(Name);
                return Path.Combine("obj", projectName + "Resources.swf");
            }
        }

        public new HaxeOptions CompilerOptions { get { return (HaxeOptions)base.CompilerOptions; } }

        public bool IsFlashOutput
        {
            get { return movieOptions.Platform == HaxeMovieOptions.FLASHPLAYER_PLATFORM 
                || movieOptions.Platform == HaxeMovieOptions.AIR_PLATFORM
                || movieOptions.Platform == HaxeMovieOptions.NME_PLATFORM;
            }
        }
        public bool IsJavacriptOutput
        {
            get { return movieOptions.Platform == HaxeMovieOptions.JAVASCRIPT_PLATFORM; }
        }
        public bool IsNekoOutput
        {
            get { return movieOptions.Platform == HaxeMovieOptions.NEKO_PLATFORM; }
        }
        public bool IsPhpOutput
        {
            get { return movieOptions.Platform == HaxeMovieOptions.PHP_PLATFORM; }
        }
        public bool IsCppOutput
        {
            get { return movieOptions.Platform == HaxeMovieOptions.CPP_PLATFORM; }
        }
        public bool IsNmeOutput
        {
            get { return movieOptions.Platform == HaxeMovieOptions.NME_PLATFORM; }
        }

        public override string GetInsertFileText(string inFile, string path, string export, string nodeType)
        {
            bool isInjectionTarget = (UsesInjection && path == GetAbsolutePath(InputPath));
            if (export != null) return export;
            if (IsLibraryAsset(path) && !isInjectionTarget)
                return GetAsset(path).ID;
            
            if (FileInspector.IsHaxeFile(inFile, Path.GetExtension(inFile).ToLower()))
                return ProjectPaths.GetRelativePath(Path.GetDirectoryName(ProjectPath), path).Replace('\\', '/');
            else
                return ProjectPaths.GetRelativePath(Path.GetDirectoryName(inFile), path).Replace('\\', '/');
        }

        internal override CompileTargetType AllowCompileTarget(string path, bool isDirectory)
        {
            if (isDirectory || Path.GetExtension(path) != ".hx") return CompileTargetType.None;

            foreach (string cp in AbsoluteClasspaths)
                if (path.StartsWith(cp, StringComparison.OrdinalIgnoreCase))
                    return CompileTargetType.AlwaysCompile;
            return CompileTargetType.None;
        }

        string Quote(string s)
        {
            if (s.IndexOf(" ") >= 0)
                return "\"" + s + "\"";
            return s;
        }

        public string[] BuildHXML(string[] paths, string outfile, bool release )
        {
            List<String> pr = new List<String>();

            // class paths
            List<String> classPaths = new List<String>();
            foreach (string cp in paths)
                classPaths.Add(cp);
            foreach (string cp in this.Classpaths)
                classPaths.Add(cp);
            foreach (string cp in classPaths) {
                String ccp = String.Join("/",cp.Split('\\'));
                pr.Add("-cp " + Quote(ccp));
            }

            // libraries
            foreach (string lib in CompilerOptions.Libraries)
                pr.Add("-lib " + lib);

            // compilation mode
            string mode = null;
            if (IsFlashOutput) 
                mode = (MovieOptions.MajorVersion < 6/*AIR*/ || MovieOptions.MajorVersion >= 9) ? "swf9" : "swf";
            else if (IsJavacriptOutput) mode = "js";
            else if (IsNekoOutput) mode = "neko";
            else if (IsPhpOutput) mode = "php";
            else if (IsCppOutput) mode = "cpp";
            //else throw new SystemException("Unknown mode");

            outfile = String.Join("/",outfile.Split('\\'));
            pr.Add("-" + mode + " " + Quote(outfile));

            // nme options
            if (IsNmeOutput)
            {
                pr.Add("--remap flash:nme");
            }

            // flash options
            if (IsFlashOutput)
            {
                string htmlColor = this.MovieOptions.Background.Substring(1);

                if( htmlColor.Length > 0 )
                    htmlColor = ":" + htmlColor;

                pr.Add("-swf-header " + string.Format("{0}:{1}:{2}{3}", MovieOptions.Width, MovieOptions.Height, MovieOptions.Fps, htmlColor));

                if( !UsesInjection && LibraryAssets.Count > 0 )
                    pr.Add("-swf-lib " + Quote(LibrarySWFPath));

                if( CompilerOptions.FlashStrict )
                    pr.Add("--flash-strict");

                // convert Flash version to haxe supported parameter
                string param = null;
                int majorVersion = MovieOptions.MajorVersion;
                int minorVersion = MovieOptions.MinorVersion;
                if (MovieOptions.Platform == "AIR")
                    AS3Project.GuessFlashPlayerForAIR(ref majorVersion, ref minorVersion);
                if (movieOptions.Platform == "NME")
                    HaxeProject.GuessFlashPlayerForNME(ref majorVersion, ref minorVersion);
                if (majorVersion >= 10)
                {
                    if (minorVersion > 0) param = majorVersion + "." + minorVersion;
                    else param = "" + majorVersion;
                }
                else param = "" + majorVersion;
                if (param != null) pr.Add("-swf-version " + param);
            }

            // debug 
            if (!release)
            {
                pr.Add("-debug");
                if (IsFlashOutput && MovieOptions.DebuggerSupported && CompilerOptions.EnableDebug)
                {
                    pr.Add("--no-inline");
                    pr.Add("-D fdb");
                }
            }

            // defines
            foreach (string def in CompilerOptions.Directives)
                pr.Add("-D "+Quote(def));

            // add project files marked as "always compile"
            foreach( string relTarget in CompileTargets )
            {
                string absTarget = GetAbsolutePath(relTarget);
                // guess the class name from the file name
                foreach (string cp in classPaths)
                    if( absTarget.StartsWith(cp, StringComparison.OrdinalIgnoreCase) ) {
                        string className = absTarget.Substring(cp.Length);
                        className = className.Substring(0, className.LastIndexOf('.'));
                        className = Regex.Replace(className, "[\\\\/]+", ".");
                        if( className.StartsWith(".") ) className = className.Substring(1);
                        if( CompilerOptions.MainClass != className )
                            pr.Add(className);
                    }
            }

            // add main class
            if( CompilerOptions.MainClass != null && CompilerOptions.MainClass.Length > 0)
                pr.Add("-main " + CompilerOptions.MainClass);


            // extra options
            foreach (string opt in CompilerOptions.Additional) {
                String p = opt.Trim();                   
                if( p == "" || p[0] == '#' )
                    continue;    
                char[] space = {' '};
                string[] parts = p.Split(space, 2);
                if (parts.Length == 1)
                    pr.Add(p);
                else
                    pr.Add(parts[0] + ' ' + Quote(parts[1]));
            }

            return pr.ToArray();
        }

        private static void GuessFlashPlayerForNME(ref int majorVersion, ref int minorVersion)
        {
            majorVersion = 10;
        }

        #region Load/Save

        public static HaxeProject Load(string path)
        {
            HaxeProjectReader reader = new HaxeProjectReader(path);

            try
            {
                return reader.ReadProject();
            }
            catch (System.Xml.XmlException exception)
            {
                string format = string.Format("Error in XML Document line {0}, position {1}.",
                    exception.LineNumber, exception.LinePosition);
                throw new Exception(format, exception);
            }
            finally { reader.Close(); }
        }

        public override void Save()
        {
            SaveAs(ProjectPath);
        }

        public override void SaveAs(string fileName)
        {
            if (!AllowedSaving(fileName)) return;
            try
            {
                HaxeProjectWriter writer = new HaxeProjectWriter(this, fileName);
                writer.WriteProject();
                writer.Flush();
                writer.Close();
                if (saveHXML) {
                    StreamWriter hxml = File.CreateText(Path.ChangeExtension(fileName, "hxml"));
                    foreach( string e in BuildHXML(new string[0],this.OutputPath,true) )
                        hxml.WriteLine(e);
                    hxml.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "IO Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        #endregion
    }
}
