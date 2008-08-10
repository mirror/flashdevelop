using System;
using System.Collections;
using System.IO;
using System.Text;

namespace ProjectExplorer.ProjectFormat
{
	class FileHelper
	{
		public static bool IsActionScript(string path)
		{
			return Path.GetExtension(path).ToLower() == ".as";
		}

		public static bool IsActionScript(ICollection paths)
		{
			foreach (string path in paths)
				if (!IsActionScript(path))
					return false;
			return true;
		}

		public static bool IsImage(string path)
		{
			string ext = Path.GetExtension(path).ToLower();
			return ext == ".png" || ext == ".jpg" || ext == ".jpeg";
		}

		public static bool IsSwf(string path)
		{
			return Path.GetExtension(path).ToLower() == ".swf";
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
			return Path.GetExtension(path).ToLower() == ".fla";
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
	}
}
