using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;

namespace ProjectManager.Projects.AS2
{
    public class AS2Project : Project
    {
        public AS2Project(string path)
            : base(path, new MtascOptions()) 
        {
            movieOptions = new AS2MovieOptions();
        }

        public override string Language { get { return "as2"; } }
        public override bool UsesInjection { get { return InputPath != ""; } }
        public override bool HasLibraries { get { return !NoOutput && !UsesInjection; } }
        public override bool RequireLibrary { get { return true; } }

        public new MtascOptions CompilerOptions { get { return (MtascOptions)base.CompilerOptions; } }

        internal override ProjectManager.Controls.PropertiesDialog CreatePropertiesDialog()
        {
            return new ProjectManager.Controls.AS2.AS2PropertiesDialog();
        }

        public override void ValidateBuild(out string error)
        {
            if (CompilerOptions.UseMain && CompileTargets.Count == 0)
                error = "Description.MissingTarget";
            else
                error = null;
        }

        public override string GetInsertFileText(string inFile, string path, string export, string nodeType)
        {
            bool isInjectionTarget = (UsesInjection && path == GetAbsolutePath(InputPath));
            if (export != null) return export;
            if (IsLibraryAsset(path) && !isInjectionTarget)
                return GetAsset(path).ID;
            else if (!NoOutput && FileInspector.IsActionScript(inFile, Path.GetExtension(inFile).ToLower()))
                return ProjectPaths.GetRelativePath(Path.GetDirectoryName(ProjectPath), path).Replace('\\', '/');
            else
                return ProjectPaths.GetRelativePath(Path.GetDirectoryName(inFile), path).Replace('\\', '/');
        }

        #region Load/Save

		public static AS2Project Load(string path)
		{
			AS2ProjectReader reader = new AS2ProjectReader(path);

			try
			{
				return reader.ReadProject();
			}
			catch (System.Xml.XmlException exception)
			{
				string format = string.Format("Error in XML Document line {0}, position {1}.",
					exception.LineNumber,exception.LinePosition);
				throw new Exception(format,exception);
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
                AS2ProjectWriter writer = new AS2ProjectWriter(this, fileName);
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
