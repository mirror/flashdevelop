/*
 * 
 * User: Philippe Elsass
 * Date: 07/03/2006
 * Time: 20:47
 */

using System;
using System.IO;
using System.Collections;
using SwfOp.IO;
using SwfOp.Data;
using SwfOp.Data.Tags;

namespace SwfOp
{
	/// <summary>
	/// Description of Main.
	/// </summary>
	public class PokeSwf
	{
		public static void Main(string[] args)
		{
			if (args.Length < 1)
			{
				Console.WriteLine("SwfOp <file.swf>: list all library symbols of the SWF");
				return;
			}
			string swfname = args[0];
			
			// read SWF
			try
			{
				ExploreSWF(swfname);
			}
			catch(FileNotFoundException)
			{
				Console.WriteLine("SwfOp Error: File not found");
			}
			catch(Exception ex)
			{
				Console.WriteLine("SwfOp Error: "+ex.Message);
			}
		}
		
		static void ExploreSWF(string swfname)
		{
			Stream stream = File.OpenRead(swfname);
			SwfExportTagReader reader = new SwfExportTagReader(new BufferedStream(stream)); 
			Swf swf = reader.ReadSwf(); 
			
			Hashtable tagsSeen = new Hashtable();

			// list tags
			ExportTag export;
			foreach(BaseTag tag in swf)
			{
				export = tag as ExportTag;
				if (export != null)
				{
					foreach(string name in export.Names)
					{
						if (!tagsSeen.Contains(name))
						{
							Console.WriteLine(name);
							tagsSeen.Add(name,true);
						}
					}
				}
			}
		}
	}
}
