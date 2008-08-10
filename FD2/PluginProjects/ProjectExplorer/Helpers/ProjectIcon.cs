using System;
using System.IO;
using System.Collections;
using System.Diagnostics;
using System.Reflection;
using System.Windows.Forms;
using Org.Mentalis.Utilities;

namespace ProjectExplorer.Helpers
{
	public class ProjectIcon
	{
		public static void Associate()
		{
			string flashDevelopPath = Application.ExecutablePath;
			string codeBase = Assembly.GetExecutingAssembly().GetName().EscapedCodeBase;
			Uri uri = new Uri(codeBase);
			string dllPath = uri.LocalPath;

			string toolsDir = Path.Combine(Application.StartupPath,"tools");
			string fdbuildDir = Path.Combine(toolsDir,"fdbuild");
			string fdbuildPath = Path.Combine(fdbuildDir,"fdbuild.exe");

			FileAssociation fa = new FileAssociation();
			fa.Extension = "fdp";
			fa.ContentType = "application/flashdevelopproject";
			fa.FullName = "FlashDevelop Project file";
			fa.ProperName = "FlashDevelop Project file";
			fa.IconPath = dllPath;
			fa.IconIndex = 0;
			fa.AddCommand("open", "\"" + flashDevelopPath + "\" \"%1\"");
			fa.AddCommand("Compile with FDBuild","\"" + fdbuildPath + "\" -pause \"%1\"");
			fa.Create();
		}
	}
}
