using System;
using System.Collections.Generic;
using System.Text;
using ICSharpCode.SharpZipLib.Zip;
using System.IO;
using SwfOp.IO;
using SwfOp.Data;
using SwfOp.Data.Tags;

namespace SwfOp
{
    public class ContentParser
    {
        public List<string> Errors;
        public List<string> Symbols;
        public List<string> Classes;
        public List<string> Fonts;
        public List<Abc> Abcs;
        public string Filename;
        public Dictionary<string, byte[]> Docs;
        private string frameInfo = " @Frame 0";

        public ContentParser(string filename)
        {
            Filename = filename;
            Errors = new List<string>();
            Symbols = new List<string>();
            Classes = new List<string>();
            Fonts = new List<string>();
            Abcs = new List<Abc>();
            Docs = new Dictionary<string, byte[]>();
        }

        public void Run()
        {
            try
            {
                Stream filestream = File.OpenRead(Filename);

                // SWC file: extract 'library.swf' file
                if (Filename.EndsWith(".swc", StringComparison.OrdinalIgnoreCase))
                {
                    ZipFile zfile = new ZipFile(filestream);
                    foreach (ZipEntry entry in zfile)
                    {
                        if (entry.Name.EndsWith(".swf", StringComparison.OrdinalIgnoreCase))
                        {
                            ExploreSWF(new MemoryStream(UnzipFile(zfile, entry)));
                        }
                        else if (entry.Name.EndsWith(".xml", StringComparison.OrdinalIgnoreCase)
                            && entry.Name.StartsWith("docs/"))
                        {
                            Docs[entry.Name] = UnzipFile(zfile, entry);
                        }
                    }
                    zfile.Close();
                    filestream.Close();
                }
                else
                {
                    byte[] data = new byte[filestream.Length];
                    filestream.Read(data, 0, (int)filestream.Length);
                    filestream.Close();
                    Stream dataStream = new MemoryStream(data);

                    // raw ABC bytecode
                    if (Filename.EndsWith(".abc", StringComparison.OrdinalIgnoreCase))
                    {
                        BinaryReader br = new BinaryReader(dataStream);
                        Abc abc = new Abc(br);
                        ExploreABC(abc);
                    }
                    // regular SWF
                    else if (Filename.EndsWith(".swf", StringComparison.OrdinalIgnoreCase))
                    {
                        ExploreSWF(dataStream);
                    }
                    else Errors.Add("Error: Not a supported filetype");
                }
            }
            catch (FileNotFoundException)
            {
                Errors.Add("Error: File not found");
            }
            catch (Exception ex)
            {
                Errors.Add("Error: " + ex.Message);
            }
        }

        private static byte[] UnzipFile(ZipFile zfile, ZipEntry entry)
        {
            Stream stream = zfile.GetInputStream(entry);
            byte[] data = new byte[entry.Size];
            int length = stream.Read(data, 0, (int)entry.Size);
            if (length != entry.Size)
                throw new Exception("Corrupted archive");
            return data;
        }

        private void ExploreSWF(Stream stream)
        {
            SwfExportTagReader reader = new SwfExportTagReader(stream);
            Swf swf = null;
            try
            {
                swf = reader.ReadSwf();
            }
            catch (Exception ex)
            {
                Errors.Add("Swf error: " + ex.Message);
            }
            if (swf == null) return;
			
			// list tags
            int currentFrame = 1;
            foreach (BaseTag tag in swf)
            {
                if (tag is ExportTag)
                {
                    ExportTag exportTag = tag as ExportTag;
                    foreach (string name in exportTag.Names)
                    {
                        if (name.StartsWith("__Packages."))
                        {
                            string cname = name.Substring(11);
                            if (!Classes.Contains(cname)) Classes.Add(cname + frameInfo);
                        }
                        else if (!Symbols.Contains(name)) Symbols.Add(name + frameInfo);
                    }
                }
                else if (tag is AbcTag)
                {
                    AbcTag abcTag = tag as AbcTag;
                    ExploreABC(abcTag.abc);
                }
                else if ((TagCodeEnum)tag.TagCode == TagCodeEnum.ShowFrame)
                {
                    currentFrame++;
                    frameInfo = " @Frame " + currentFrame;
                }
                else if (tag  is FrameTag)
                {
                    frameInfo = " @Frame " + currentFrame + ": " + (tag as FrameTag).name;
                }
                else if (tag is DefineFontTag)
                {
                    DefineFontTag ftag = tag as DefineFontTag;
                    string style = "";
                    if (ftag.IsBold) style += "Bold ";
                    if (ftag.IsItalics) style += "Italic ";
                    Fonts.Add(ftag.Name + " (" + style + ftag.GlyphCount + ")" + frameInfo);
                }
            }
        }

        private void ExploreABC(Abc abc)
        {
            Abcs.Add(abc);

            foreach (Traits trait in abc.instances)
            {
                string name = trait.ToString();
                if (!Classes.Contains(name)) Classes.Add(name + frameInfo);
            }
        }
    }
}
