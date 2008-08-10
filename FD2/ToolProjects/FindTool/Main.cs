/*
 * FindTool - Find In Files utility
 * Author: Philippe Elsass
 */
using System;
using System.IO;
using System.Collections;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;

namespace FIF
{
	class MainClass
	{
		// already explored pathes
		static ArrayList known;
		// parameters
		static Regex re_pattern;
		static string fileMask;
		static string pattern;
		static bool recursive;
		static bool noCase;
		static bool isRegex;
		static bool wholeWord;

		/// <summary>
		/// Recursively convert classes
		/// </summary>
		/// <param name="path">folder to convert</param>
		static void ExploreFolder(string path)
		{
			known.Add(path);

			// convert classes
			string[] files = Directory.GetFiles(path, fileMask);
			string src;
			Encoding enc;
			int line = 0;
			TextReader sr;
			foreach(string file in files)
			{
				line = 1;
				enc = GetEncoding(file);
				using( sr = new StreamReader(file, enc) )
				{
					src = sr.ReadLine();
					while (src != null)
					{
						if (re_pattern.IsMatch(src))
						{
							byte[] ba = Encoding.Convert(enc, Encoding.Default, enc.GetBytes(src));
							src = Console.Out.Encoding.GetString(ba);
							Console.WriteLine(file+":"+line+": "+src.TrimEnd());
						}
						src = sr.ReadLine();
						line++;
					}
					sr.Close();
				}
			}
			if (!recursive)
				return;

			// explore subfolders
			string[] dirs = Directory.GetDirectories(path);
			foreach(string dir in dirs)
			{
				if (!known.Contains(dir)) ExploreFolder(dir);
			}
		}

		/// <summary>
		/// Adapted from FlashDevelop: FileSystem.cs
		/// Detects the file encoding from the file data.
		/// </summary>
		static Encoding GetEncoding(string file)
		{
			byte[] bom = new byte[4];
			System.IO.FileStream fs = new System.IO.FileStream(file, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Read);
			if (fs.CanSeek)
			{
				fs.Read(bom, 0, 4); fs.Close();
				if ((bom[0] == 0xef && bom[1] == 0xbb && bom[2] == 0xbf))
				{
					return Encoding.UTF8;
				}
				else if ((bom[0] == 0xff && bom[1] == 0xfe))
				{
					return Encoding.Unicode;
				}
				else if ((bom[0] == 0xfe && bom[1] == 0xff))
				{
					return Encoding.BigEndianUnicode;
				}
				else if ((bom[0] == 0x2b && bom[1] == 0x2f && bom[2] == 0xfe && bom[3] == 0x76))
				{
					return Encoding.UTF7;
				}
				else
				{
					return Encoding.Default;
				}
			}
			else
			{
				return Encoding.Default;
			}
		}

		/// <summary>
		/// Check options in parameters
		/// </summary>
		/// <param name="param">Parameter</param>
		/// <returns>An option was found</returns>
		static bool TestOption(string param)
		{
			if (param == "-r")
			{
				recursive = true;
				return true;
			}
			else if (param == "-i")
			{
				noCase = true;
				return true;
			}
			else if (param == "-e")
			{
				isRegex = true;
				return true;
			}
			else if (param == "-w")
			{
				wholeWord = true;
				return true;
			}
			return false;
		}


		public static int Main(string[] args)
		{
			// options
			int count = args.Length;
			int skip = 0;
			while (count > skip && TestOption(args[skip])) skip++;

			// invalid parameter count
			if (count-skip < 2)
			{
				Console.WriteLine("FindTool - Find In Files utility");
				Console.WriteLine("Copyright (c) 2006 Philippe Elsass");
				Console.WriteLine("");
				Console.WriteLine("Usage: FindTool [options] [<folder>]* <pattern> <file mask>");
				Console.WriteLine("");
				Console.WriteLine("Options: -r: Recursive search");
				Console.WriteLine("         -i: Ignore case");
				Console.WriteLine("         -e: Regular expression");
				Console.WriteLine("         -w: Whole word only");
				return 1;
			}

			// parameters
			fileMask = args[args.Length-1];
			pattern = args[args.Length-2];
			if (!isRegex) pattern = Regex.Escape(pattern);
			if (wholeWord) pattern = "(^|[^\\w])"+pattern+"([^\\w]|$)";

			// create Regex
			RegexOptions options = RegexOptions.Compiled | RegexOptions.Singleline;
			if (noCase) options |= RegexOptions.IgnoreCase;
			re_pattern = new Regex(pattern, options);

			// exploration context
			known = new ArrayList();

			// explore
			try
			{
				// no path specified, use working directory
				if (skip == count-2)
				{
					string dir = Directory.GetCurrentDirectory();
					known.Add(dir);
					ExploreFolder(dir);
				}
				else
				for (int i=skip; i<count-2; i++)
				{
					known.Add(args[i]);
					ExploreFolder(args[i]);
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine("Exception: "+ex.Message);
				return 3;
			}
			return 0;
		}
	}
}
