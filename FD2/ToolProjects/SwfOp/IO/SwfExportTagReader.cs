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
			
			switch (rh.TagCode) {
				
				//-- Parse sub-clips? 
				case (int)TagCodeEnum.DefineSprite: return this.ReadDefineSpriteTag();
									
				case (int)TagCodeEnum.Export:
				case 76:
					br.BaseStream.Position += offset;
					ushort count = br.ReadUInt16();
					ushort id;
					byte c;
					ArrayList ids = new ArrayList();
					ArrayList names = new ArrayList();
					StringBuilder sb;
					for(int i=0; i<count; i++)
					{
						sb = new StringBuilder();
						id = br.ReadUInt16();
						ids.Add(id);
						c = br.ReadByte();
						while(c != 0) {
							sb.Append((char)c);
							c = br.ReadByte();
						}
						names.Add(sb.ToString());
					}
					return new ExportTag(ids, names);
				
				default: return new BaseTag(br.ReadBytes(rh.TagLength+offset));
			}
				
		}
	}
}
