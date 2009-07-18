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
using ICSharpCode.SharpZipLib.Zip;
using System.Collections.Generic;

namespace SwfOp
{
	/// <summary>
	/// C:\as3\projets\MonProjet\deploy\App.swf
    /// C:\as3\projets\MonProjet\App2.swf
    /// C:\flex_sdk_2\frameworks\libs\framework.swc
    /// C:\flex_sdk_2\frameworks\libs\playerglobal.swc
    /// C:\as3\library\ImageProcessing.swc
    /// C:\as3\corelib\bin\corelib.swc
	/// </summary>
	public class PokeSwf
	{
        static string operation;

		public static void Main(string[] args)
		{
			if (args.Length < 1)
			{
				Console.WriteLine("SwfOp <file.swf>: list all library symbols of the SWF");
                return;
			}
            string filename = args[args.Length-1];
            operation = (args.Length > 1) ? args[0] : "-list";
			
			// read SWF
			try
			{
                Stream filestream = File.OpenRead(filename);

                // SWC file: extract 'library.swf' file
                if (filename.EndsWith(".swc", StringComparison.OrdinalIgnoreCase))
                {
                    ZipFile zfile = new ZipFile(filestream);
                    foreach(ZipEntry entry in zfile)
                    {
                        if (entry.Name.EndsWith(".swf", StringComparison.OrdinalIgnoreCase))
                        {
                            // decompress in memory
                            Stream stream = zfile.GetInputStream(entry);
                            byte[] data = new byte[entry.Size];
                            int length = stream.Read(data, 0, (int)entry.Size);
                            if (length != entry.Size)
                            {
                                Console.WriteLine("Error: corrupted content");
                                return;
                            }
                            ExploreSWF(new MemoryStream(data));
                        }
                    }
                    zfile.Close();
                    filestream.Close();
                }
                else if (filename.EndsWith(".abc", StringComparison.OrdinalIgnoreCase))
                {
                    byte[] data = new byte[filestream.Length];
                    filestream.Read(data, 0, (int)filestream.Length);
                    BinaryReader br = new BinaryReader(new MemoryStream(data));
                    Abc abc = new Abc(br);
                }
                // regular SWF
                else ExploreSWF(new BufferedStream(filestream));
			}
			catch(FileNotFoundException)
			{
				Console.WriteLine("-- SwfOp Error: File not found");
			}
			catch(Exception ex)
			{
				Console.WriteLine("-- SwfOp Error: "+ex.Message);
			}
            Console.ReadLine();
		}
		
		static void ExploreSWF(Stream stream)
		{
            if (stream == null) return;
            //SwfReader reader = new SwfReader(stream);
            SwfExportTagReader reader = new SwfExportTagReader(stream);
            Swf swf = null;
            try
            {
                swf = reader.ReadSwf();
                foreach (BaseTag tag in swf)
                {
                    if (tag is AbcTag)
                    {
                        AbcTag abcTag = tag as AbcTag;
                        foreach (Traits trait in abcTag.abc.classes)
                        {
                            Console.WriteLine(trait);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("-- Swf error: " + ex.Message);
            }
		}
	}
}
