using System;
using System.Collections;
using System.IO;
using System.Text;

namespace ProjectManager.Projects
{
	class FileInspector
	{
        public static string[] ExecutableFileTypes = null;

		public static bool IsActionScript(string path, string ext)
		{
			return ext.ToLower() == ".as";
		}

        public static bool IsFLA(string path, string ext)
        {
            return ext.ToLower() == ".fla";
        }

		public static bool IsActionScript(ICollection paths)
		{
            foreach (string path in paths)
            {
                if (!IsActionScript(path, Path.GetExtension(path).ToLower())) return false;
            }
			return true;
		}

        public static bool IsHaxeFile(string path, string ext)
        {
            return ext.ToLower() == ".hx";
        }

        public static bool IsMxml(string path, string ext)
        {
            return ext.ToLower() == ".mxml";
        }

        public static bool IsCss(string path, string ext)
        {
            return ext.ToLower() == ".css";
        }

        public static bool IsImage(string path, string ext)
		{
            return ext.ToLower() == ".png" || ext.ToLower() == ".jpg" || ext.ToLower() == ".jpeg" || ext.ToLower() == ".gif";
		}

        public static bool IsSwf(string path, string ext)
		{
            return ext.ToLower() == ".swf";
        }

        public static bool IsSwc(string path)
        {
            return IsSwc(path, Path.GetExtension(path).ToLower());
        }

        public static bool IsSwc(string path, string ext)
        {
            return ext.ToLower() == ".swc";
        }

        public static bool IsFont(string path, string ext)
		{
            return ext.ToLower() == ".ttf" || ext.ToLower() == ".otf";
        }

        public static bool IsSound(string path, string ext)
        {
            return ext.ToLower() == ".mp3";
        }

        public static bool IsResource(string path, string ext)
		{
            return IsImage(path, ext) || IsSwf(path, ext) || IsFont(path, ext) || IsSound(path, ext);
		}

		public static bool IsResource(ICollection paths)
		{
            foreach (string path in paths)
            {
                if (!IsResource(path, Path.GetExtension(path).ToLower())) return false;
            }
			return true;
		}

		public static bool ShouldUseShellExecute(string path)
		{
            string ext = Path.GetExtension(path).ToLower();
            if (ExecutableFileTypes != null)
            foreach (string type in ExecutableFileTypes)
            {
                if (type.ToLower() == ext.ToLower()) return true;
            }
			return false;
		}

		public static bool IsHtml(string path, string ext)
		{
            return ext.ToLower() == ".html" || ext.ToLower() == ".htm";
		}

		public static bool IsXml(string path, string ext)
		{
			// allow for mxml, sxml, asml, etc
            return (ext.ToLower() == ".xml" || (ext.ToLower().Length == 5 && ext.ToLower().EndsWith("ml")));
		}

		public static bool IsText(string path, string ext)
		{
            return ext.ToLower() == ".txt" || Path.GetFileName(path).StartsWith(".");
		}

        public static bool IsAS2Project(string path, string ext)
        {
            return ext.ToLower() == ".fdp" || ext.ToLower() == ".as2proj";
        }

        public static bool IsAS3Project(string path, string ext)
        {
            return ext.ToLower() == ".as3proj" || IsFlexBuilderProject(path);
        }

        public static bool IsFlexBuilderProject(string path)
        {
            return Path.GetFileName(path).ToLower() == ".actionscriptproperties";
        }

        public static bool IsHaxeProject(string path, string ext)
        {
            return ext.ToLower() == ".hxproj";
        }

        public static bool IsProject(string path)
        {
            return IsProject(path, Path.GetExtension(path).ToLower());
        }

        public static bool IsProject(string path, string ext)
        {
            return IsAS2Project(path, ext) || IsAS3Project(path, ext) || IsHaxeProject(path, ext);
        }

        public static bool IsTemplate(string path, string ext)
        {
            return ext.ToLower() == ".template";
        }

    }

}
