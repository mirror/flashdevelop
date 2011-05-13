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
        public List<DeclEntry> Symbols;
        public List<DeclEntry> Frames;
        public List<DeclEntry> Classes;
        public List<DeclEntry> Fonts;
        public List<Abc> Abcs;
        public long TotalSize;
        public long AbcSize;
        public long FontsSize;
        public string Filename;
        public Dictionary<string, byte[]> Docs;
        public byte[] Catalog;
        static internal int currentFrame;

        public ContentParser(string filename)
        {
            Filename = filename;
            Errors = new List<string>();
            Symbols = new List<DeclEntry>();
            Classes = new List<DeclEntry>();
            Fonts = new List<DeclEntry>();
            Frames = new List<DeclEntry>();
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
                        else if (entry.Name == "catalog.xml")
                        {
                            Catalog = UnzipFile(zfile, entry);
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
            currentFrame = 0;
            DeclEntry frame = new DeclEntry("Frame 0");
            Frames.Add(frame);
            string nextFrameName = null;

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
                            Classes.Add(new DeclEntry(cname));
                        }
                        else Symbols.Add(new DeclEntry(name));
                    }
                }
                else if (tag is DoActionTag)
                {
                    AbcSize += tag.Data.Length;
                }
                else if (tag is AbcTag)
                {
                    ExploreABC((tag as AbcTag).abc);
                    AbcSize += tag.Data.Length;
                }
                else if ((TagCodeEnum)tag.TagCode == TagCodeEnum.ShowFrame)
                {
                    currentFrame++;
                    if (nextFrameName == null) frame = new DeclEntry("Frame " + currentFrame);
                    else frame = new DeclEntry("Frame '" + nextFrameName + "'");
                    nextFrameName = null;
                    Frames.Add(frame);
                }
                else if (tag is FrameTag)
                {
                    nextFrameName = (tag as FrameTag).name;
                }
                else if (tag is DefineFontTag)
                {
                    DefineFontTag ftag = tag as DefineFontTag;
                    string style = "";
                    if (ftag.IsBold) style += "Bold ";
                    if (ftag.IsItalics) style += "Italic ";
                    Fonts.Add(new DeclEntry(ftag.Name + " (" + style + ftag.GlyphCount + ")"));
                    FontsSize += tag.Size;
                }

                if (tag is DoActionTag || tag is AbcTag) frame.AbcSize += tag.Size;
                else if (tag is DefineFontTag) frame.FontSize += tag.Size;
                else frame.DataSize += tag.Size;
                TotalSize += tag.Size;
            }

            // empty frame at the end
            if (Frames.Count > 1 && frame.DataSize == 4) Frames.Remove(frame);
        }

        private void ExploreABC(Abc abc)
        {
            Abcs.Add(abc);
            
            foreach (Traits trait in abc.instances)
            {
                string name = trait.ToString();
                Classes.Add(new DeclEntry(name));
            }
            foreach (Traits trait in abc.scripts)
            {
                foreach (MemberInfo member in trait.members)
                {
                    if (member.kind != TraitMember.Class)
                    {
                        if (member is MethodInfo) Classes.Add(new DeclEntry(member.name + "()"));
                        else if (member is SlotInfo)
                        {
                            if (member.kind == TraitMember.Const) Classes.Add(new DeclEntry(member.name + "#"));
                            else Classes.Add(new DeclEntry(member.name + "$"));
                        }
                    }
                }
            }
        }
    }

    public class DeclEntry
    {
        public string Name;
        public int Frame;
        public long DataSize;
        public long AbcSize;
        public long FontSize;

        public DeclEntry(string name)
        {
            Name = name;
            Frame = ContentParser.currentFrame;
        }
    }
}
