using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;

namespace ProjectManager.Projects.Haxe
{
    public class HaxeProject : Project
    {
        public HaxeProject(string path)
            : base(path, new HaxeOptions())
        {
            movieOptions = new HaxeMovieOptions();
        }

        public override string Language { get { return "haxe"; } }
        public override bool HasLibraries { get { return !NoOutput && IsFlashOutput; } }
        public override bool RequireLibrary { get { return IsFlashOutput; } }
        public override String LibrarySWFPath
        {
            get
            {
                string projectName = ProjectManager.Helpers.ProjectCreator.RemoveDiacritics(Name);
                return Path.Combine("obj", projectName + "Resources.swf");
            }
        }

        public new HaxeOptions CompilerOptions { get { return (HaxeOptions)base.CompilerOptions; } }

        public bool IsFlashOutput
        {
            get { return MovieOptions.Version < 11; }
        }
        public bool IsJavacriptOutput
        {
            get { return MovieOptions.Version == 11; }
        }
        public bool IsNekoOutput
        {
            get { return MovieOptions.Version == 12; }
        }
        public bool IsPhpOutput
        {
            get { return MovieOptions.Version == 13; }
        }
        public bool IsCppOutput
        {
            get { return MovieOptions.Version == 14; }
        }

        public override string GetInsertFileText(string inFile, string path, string export, string nodeType)
        {
            bool isInjectionTarget = (UsesInjection && path == GetAbsolutePath(InputPath));
            if (export != null) return export;
            if (IsLibraryAsset(path) && !isInjectionTarget)
                return GetAsset(path).ID;
            else if (!NoOutput && FileInspector.IsHaxeFile(inFile, Path.GetExtension(inFile).ToLower()))
                return ProjectPaths.GetRelativePath(Path.GetDirectoryName(ProjectPath), path).Replace('\\', '/');
            else
                return ProjectPaths.GetRelativePath(Path.GetDirectoryName(inFile), path).Replace('\\', '/');
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
            try
            {
                HaxeProjectWriter writer = new HaxeProjectWriter(this, fileName);
                writer.WriteProject();
                writer.Flush();
                writer.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "IO Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        #endregion
    }
}
