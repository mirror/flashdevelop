/*
 * 
 * User: Philippe Elsass
 * Date: 07/03/2006
 * Time: 22:40
 */

using System;
using System.IO;
using SwfOp.Data;
using SwfOp.Data.Tags;
using System.Text;
using System.Collections;

namespace SwfOp.IO
{
	/// <summary>
	/// Specialized SWF parser to extract some specific tags
	/// </summary>
	public class SwfExportTagReader: SwfReader
	{
		public SwfExportTagReader(Stream stream): base(stream) 
		{ 
		}
		
		override protected BaseTag ReadTag() 
		{
			long posBefore = br.BaseStream.Position;
			RecordHeader rh = ReadRecordHeader();
			int offset = (int)(br.BaseStream.Position-posBefore);		
			br.BaseStream.Position = posBefore;

            TagCodeEnum tag = (TagCodeEnum)rh.TagCode;
            //if (tag != TagCodeEnum.End) Console.WriteLine("Tag: " + (TagCodeEnum)rh.TagCode);
            switch (tag)
            {
				//-- Parse sub-clips
				case TagCodeEnum.DefineSprite: 
                    return ReadDefineSpriteTag();
									
				case TagCodeEnum.ExportAssets:
                case TagCodeEnum.SymbolClass:
                    return ReadExportTag(offset);

                case TagCodeEnum.DoABCDefine:
                    return new AbcTag(br.ReadBytes(rh.TagLength + offset), offset, true);

                case TagCodeEnum.DoABC:
                    return new AbcTag(br.ReadBytes(rh.TagLength + offset), offset, false);
				
                case TagCodeEnum.FrameLabel:
                    return ReadFrameTag(offset);

				default:
                    // Dump tag
                    /*br.BaseStream.Position += offset;
                    byte b;
                    for (int i = 0; i < rh.TagLength; i++)
                    {
                        b = br.ReadByte();
                        Console.Write((b >= 32) ? ((char)b).ToString() : b.ToString());
                    }
                    br.BaseStream.Position = posBefore;*/
                    return new BaseTag(br.ReadBytes(rh.TagLength+offset), rh.TagCode);
			}
				
		}

        BaseTag ReadExportTag(int offset)
        {
            br.BaseStream.Position += offset;
            ushort count = br.ReadUInt16();
            ushort id;
            ArrayList ids = new ArrayList();
            ArrayList names = new ArrayList();
            for (int i = 0; i < count; i++)
            {
                id = br.ReadUInt16();
                ids.Add(id);
                names.Add(ReadString());
            }
            return new ExportTag(ids, names);
        }

        BaseTag ReadFrameTag(int offset)
        {
            br.BaseStream.Position += offset;
            string name = ReadString();
            return new FrameTag(name);
        }

        private string ReadString()
        {
            StringBuilder sb = new StringBuilder();
            byte c = br.ReadByte();
            while (c != 0)
            {
                sb.Append((char)c);
                c = br.ReadByte();
            }
            return sb.ToString();
        }
	}
}
