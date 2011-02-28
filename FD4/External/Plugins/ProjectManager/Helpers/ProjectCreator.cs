using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Diagnostics;
using ProjectManager.Projects;
using ProjectManager.Controls.TreeView;
using PluginCore.Helpers;
using System.Text;
using PluginCore;
using System.Text.RegularExpressions;
using System.Globalization;
using PluginCore.Utilities;
using PluginCore.Managers;
using ProjectManager.Projects.AS2;
using ProjectManager.Projects.AS3;
using ProjectManager.Projects.Haxe;
using System.Windows.Forms;

namespace ProjectManager.Helpers
{
	/// <summary>
	/// Contains methods useful for working with project templates.
	/// </summary>
	public class ProjectCreator
	{
        private static Regex reArgs = new Regex("\\$\\(([a-z$]+)\\)", RegexOptions.IgnoreCase | RegexOptions.Compiled);
		string projectName;
        string projectId;
        string packageName;
        string packagePath;
        string packageDot = "";
        string packageSlash = "";
        Argument[] arguments;

        private static Hashtable projectTypes = new Hashtable();
        private static bool projectTypesSet = false;

        private static bool isRunning;
        public static bool IsRunning { get { return isRunning; } }

		/// <summary>
		/// Creates a new project based on the specified template directory.
		/// </summary>
		public Project CreateProject(string templateDirectory, string projectLocation, string projectName, string packageName)
		{
            isRunning = true;
            if (!projectTypesSet) SetInitialProjectHash();
			this.projectName = projectName;
            this.packageName = packageName;
            projectId = Regex.Replace(Project.RemoveDiacritics(projectName), "[^a-z0-9]", "", RegexOptions.IgnoreCase);
            packagePath = packageName.Replace('.', '\\');
            if (packageName.Length > 0)
            {
                packageDot = packageName + ".";
                packageSlash = packagePath + "\\";
            }
            string projectTemplate = FindProjectTemplate(templateDirectory);
            string projectPath = Path.Combine(projectLocation, projectName + Path.GetExtension(projectTemplate));
            projectPath = PathHelper.GetPhysicalPathName(projectPath);
            // notify & let a plugin handle project creation
            Hashtable para = new Hashtable();
            para["template"] = projectTemplate;
            para["location"] = projectLocation;
            para["project"] = projectPath;
            para["id"] = projectId;
            para["package"] = packageName;
            DataEvent de = new DataEvent(EventType.Command, ProjectManagerEvents.CreateProject, para);
            EventManager.DispatchEvent(this, de);
            if (!de.Handled)
            {
                int addArgs = 1;
                arguments = new Argument[PluginBase.MainForm.CustomArguments.Count + addArgs];
                arguments[0] = new Argument("FlexSDK", PluginBase.MainForm.ProcessArgString("$(FlexSDK)"));
                PluginBase.MainForm.CustomArguments.CopyTo(arguments, addArgs);
                Directory.CreateDirectory(projectLocation);
                // manually copy important files
                CopyFile(projectTemplate, projectPath);
                CopyProjectFiles(templateDirectory, projectLocation, true);
            }
            isRunning = false;
            if (File.Exists(projectPath))
            {
                projectPath = PathHelper.GetPhysicalPathName(projectPath);
                de = new DataEvent(EventType.Command, ProjectManagerEvents.ProjectCreated, para);
                EventManager.DispatchEvent(this, de);
                return ProjectLoader.Load(projectPath);
            }
            else return null;
		}

        public static string FindProjectTemplate(string templateDirectory)
        {
            string path = "";
            if (!projectTypesSet) SetInitialProjectHash();
            foreach (string key in projectTypes.Keys)
            {
                path = Path.Combine(templateDirectory, key);
                if (File.Exists(path)) return path;
            }
            return null;
        }

		private void CopyProjectFiles(string sourceDir, string destDir, bool filter)
		{
			Directory.CreateDirectory(destDir);

			foreach (string file in Directory.GetFiles(sourceDir))
			{
				if (filter && ShouldSkip(file))
					continue;

				string fileName = Path.GetFileName(file);
				string destFile = Path.Combine(destDir,fileName);

				CopyFile(file,destFile);
			}

            List<string> excludedDirs = new List<string>(PluginMain.Settings.ExcludedDirectories);

			foreach (string dir in Directory.GetDirectories(sourceDir))
			{
				string dirName = Path.GetFileName(dir);
                if (dirName.ToUpper() == "$(PACKAGENAME)" || dirName.ToUpper() == "$(PACKAGEPATH)") 
                    dirName = packagePath;
				string destSubDir = Path.Combine(destDir, dirName);

				// don't copy like .svn and stuff
				if (excludedDirs.Contains(dirName.ToLower()))
					continue;

				CopyProjectFiles(dir,destSubDir,false); // only filter the top directory
			}
		}

		// copy a file, if it's an .as or .fdp file, replace template keywords
		private void CopyFile(string source, string dest)
		{
            dest = ReplaceKeywords(dest); // you can use keywords in filenames too
            string ext = Path.GetExtension(source).ToLower();
			if (FileInspector.IsProject(source, ext) || FileInspector.IsTemplate(source, ext))
			{
                if (FileInspector.IsTemplate(source, ext)) dest = dest.Substring(0, dest.LastIndexOf('.'));

                Boolean saveBOM = PluginBase.MainForm.Settings.SaveUnicodeWithBOM;
                Encoding encoding = Encoding.GetEncoding((Int32)PluginBase.MainForm.Settings.DefaultCodePage);
                // batch files must be encoded in ASCII
                ext = Path.GetExtension(dest).ToLower();
                if (ext == ".bat" || ext == ".cmd" || ext.StartsWith(".php")) encoding = Encoding.ASCII;

                string src = File.ReadAllText(source);
                src = ReplaceKeywords(ProcessCodeStyleLineBreaks(src));
                FileHelper.WriteFile(dest, src, encoding, saveBOM);
			}
			else File.Copy(source, dest);
        }

        private string ReplaceKeywords(string line)
		{
            if (line.IndexOf("$") < 0) return line;
            return line = reArgs.Replace(line, new MatchEvaluator(ReplaceVars));
        }

        private string ReplaceVars(Match match)
        {
            if (match.Groups.Count > 0)
            {
                string name = match.Groups[1].Value.ToUpper();
                switch (name)
                {
                    case "CBI": return PluginBase.Settings.CommentBlockStyle == CommentBlockStyle.Indented ? " " : "";
                    case "QUOTE": return "\"";
                    case "CLIPBOARD": return GetClipboard();
                    case "TIMESTAMP": return DateTime.Now.ToString("g");
                    case "PROJECTNAME": return projectName; 
                    case "PROJECTID": return projectId; 
                    case "PACKAGENAME": return packageName;
                    case "PACKAGEPATH": return packagePath;
                    case "PACKAGEPATHALT": return packagePath.Replace(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar); 
                    case "PACKAGEDOT": return packageDot;
                    case "PACKAGESLASH": return packageSlash;
                    case "PACKAGESLASHALT": return packageSlash.Replace(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
                    case "DOLLAR": return "$";
                    default:
                        foreach (Argument arg in arguments)
                            if (arg.Key.ToUpper() == name) return arg.Value;
                        break;
                }
            }
            return match.Value;
		}

        /// <summary>
        /// Gets the clipboard text
        /// </summary>
        public static String GetClipboard()
        {
            IDataObject cbdata = Clipboard.GetDataObject();
            if (cbdata.GetDataPresent("System.String", true))
            {
                return cbdata.GetData("System.String", true).ToString();
            }
            else return String.Empty;
        }

		private bool ShouldSkip(string path)
		{
			string filename = Path.GetFileName(path).ToLower();
			return projectTypes.ContainsKey(filename)
				|| filename == "project.txt"
				|| filename == "project.png";
		}

        private static void SetInitialProjectHash()
        {
            projectTypes["project.fdp"] = typeof(AS2Project);
            projectTypes["project.as2proj"] = typeof(AS2Project);
            projectTypes["project.as3proj"] = typeof(AS3Project);
            projectTypes["project.hxproj"] = typeof(HaxeProject);
            projectTypesSet = true;
        }

        public static void AppendProjectType(string templateName, Type projectType)
        {
            if (!projectTypesSet) SetInitialProjectHash();
            if (projectTypes.ContainsKey(templateName.ToLower())) return;
            projectTypes[templateName] = projectType;
        }

        public static bool IsKnownProject(string ext)
        {
            if (!projectTypesSet) SetInitialProjectHash();
            return projectTypes.ContainsKey("project" + ext);
        }

        public static Type GetProjectType(string key)
        {
            if (!projectTypesSet) SetInitialProjectHash();
            if (projectTypes.ContainsKey(key)) return (Type)projectTypes[key];
            return null;
        }

        public static string KeyForProjectPath(string path)
        {
            return "project" + Path.GetExtension(path).ToLower();
        }

        public static string GetProjectFilters()
        {
            string filters = "FlashDevelop Projects (*.as2proj,*.as3proj,*.hxproj,*.fdp)|*.as2proj;*.as3proj;*.hxproj;*.fdp|Adobe Flex Builder Project (.actionScriptProperties)|.actionScriptProperties";
            string desc = "|Custom Projects ";
            string ext;
            string parens = "(";
            string exts = "";
            foreach (string key in projectTypes.Keys)
            {
                ext = key.Replace("project", "*");
                if (filters.IndexOf(ext) > -1) continue;
                parens += ext + ",";
                exts += ext + ";";
            }
            if (parens.Length > 1)
            {
                parens = parens.Substring(0, parens.Length - 1) + ")|";
                exts = exts.Substring(0, exts.Length - 1);
                desc += parens + exts;
            }
            else desc = "";
            return filters + desc;
        }

        #region ArgsProcessor duplicated code
        /// <summary>
        /// Gets the correct coding style line break chars
        /// </summary>
        public static String ProcessCodeStyleLineBreaks(String text)
        {
            String CSLB = "$(CSLB)";
            Int32 nextIndex = text.IndexOf(CSLB);
            if (nextIndex < 0) return text;
            CodingStyle cs = PluginBase.Settings.CodingStyle;
            if (cs == CodingStyle.BracesOnLine) return text.Replace(CSLB, "");
            Int32 eolMode = (Int32)PluginBase.Settings.EOLMode;
            String lineBreak = LineEndDetector.GetNewLineMarker(eolMode);
            String result = ""; Int32 currentIndex = 0;
            while (nextIndex >= 0)
            {
                result += text.Substring(currentIndex, nextIndex - currentIndex) + lineBreak + GetLineIndentation(text, nextIndex);
                currentIndex = nextIndex + CSLB.Length;
                nextIndex = text.IndexOf(CSLB, currentIndex);
            }
            return result + text.Substring(currentIndex);
        }

        /// <summary>
        /// Gets the line intendation from the text
        /// </summary>
        private static String GetLineIndentation(String text, Int32 position)
        {
            Char c;
            Int32 startPos = position;
            while (startPos > 0)
            {
                c = text[startPos];
                if (c == 10 || c == 13) break;
                startPos--;
            }
            Int32 endPos = ++startPos;
            while (endPos < position)
            {
                c = text[endPos];
                if (c != '\t' && c != ' ') break;
                endPos++;
            }
            return text.Substring(startPos, endPos - startPos);
        }
        #endregion
	}
}
