using System;
using System.Collections;
using System.IO;
using System.Text;

namespace ProjectManager.Projects
{
	class FileInspector
	{
        public static string[] ExecutableFileTypes = null;

		public static bool IsActionScript(string path)
		{
			return Path.GetExtension(path).ToLower() == ".as";
		}

        public static bool IsFlashCS3(string path)
        {
            return Path.GetExtension(path).ToLower() == ".fla";
        }

		public static bool IsActionScript(ICollection paths)
		{
			foreach (string path in paths)
				if (!IsActionScript(path))
					return false;
			return true;
		}

        public static bool IsHaxeFile(string path)
        {
            return Path.GetExtension(path).ToLower() == ".hx";
        }

		public static bool IsImage(string path)
		{
			string ext = Path.GetExtension(path).ToLower();
            return ext == ".png" || ext == ".jpg" || ext == ".jpeg" || ext == ".gif";
		}

		public static bool IsSwf(string path)
		{
			return Path.GetExtension(path).ToLower() == ".swf";
        }

        public static bool IsSwc(string path)
        {
            return Path.GetExtension(path).ToLower() == ".swc";
        }

		public static bool IsFont(string path)
		{
			return Path.GetExtension(path).ToLower() == ".ttf";
		}

		public static bool IsResource(string path)
		{
			return IsImage(path) || IsSwf(path) || IsFont(path);
		}

		public static bool IsResource(ICollection paths)
		{
			foreach (string path in paths)
				if (!IsResource(path))
					return false;
			return true;
		}

		public static bool ShouldUseShellExecute(string path)
		{
            string ext = Path.GetExtension(path).ToLower();
            if (ExecutableFileTypes != null)
            foreach (string type in ExecutableFileTypes)
            {
                if (type == ext) return true;
            }
			return false;
		}

		public static bool IsHtml(string path)
		{
			string ext = Path.GetExtension(path).ToLower();
			return ext == ".html" || ext == ".htm";
		}

		public static bool IsXml(string path)
		{
			string ext = Path.GetExtension(path).ToLower();
			// allow for mxml, sxml, asml, etc
			return (ext == ".xml" || (ext.Length == 5 && ext.EndsWith("ml")));
		}

		public static bool IsText(string path)
		{
			return Path.GetExtension(path).ToLower() == ".txt" ||
				Path.GetFileName(path).StartsWith(".");
		}

        public static bool IsAS2Project(string path)
        {
            string ext = Path.GetExtension(path).ToLower();
            return ext == ".fdp" || ext == ".as2proj";
        }

        public static bool IsAS3Project(string path)
        {
            string ext = Path.GetExtension(path).ToLower();
            return ext == ".as3proj" || IsFlexBuilderProject(path);
        }

        public static bool IsFlexBuilderProject(string path)
        {
            return Path.GetFileName(path) == ".actionScriptProperties";
        }

        public static bool IsHaxeProject(string path)
        {
            string ext = Path.GetExtension(path).ToLower();
            return ext == ".hxproj";
        }

        public static bool IsProject(string path)
        {
            return IsAS2Project(path) || IsAS3Project(path) || IsHaxeProject(path);
        }

        public static bool IsMxml(string path)
        {
            return Path.GetExtension(path).ToLower() == ".mxml";
        }

        public static bool IsTemplate(string path)
        {
            return Path.GetExtension(path).ToLower() == ".template";
        }
    }
}
