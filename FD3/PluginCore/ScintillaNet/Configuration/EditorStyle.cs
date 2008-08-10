using System;
using System.Runtime;
using System.Xml.Serialization;

namespace ScintillaNet.Configuration
{
	[SerializableAttribute()]
	public class EditorStyle : ConfigItem
	{
		[XmlAttributeAttribute("caret-fore")]
		public string caretfore;
		
		[XmlAttributeAttribute("caretline-back")]
		public string caretlineback;

		[XmlAttributeAttribute("selection-fore")]
		public string selectionfore;

		[XmlAttributeAttribute("selection-back")]
		public string selectionback;
		
		[XmlAttributeAttribute("edge-back")]
		public string edgeback;

		public int ResolveColor(string aColor)
		{
			if (aColor != null)
			{
				Value v = _parent.MasterScintilla.GetValue(aColor);
				while (v != null)
				{
					aColor = v.val;
					v = _parent.MasterScintilla.GetValue(aColor);
				}
				System.Drawing.Color c = System.Drawing.Color.FromName(aColor);
				if (c.ToArgb() == 0)
				{
					if (aColor.IndexOf("0x") == 0)
					{
						return TO_COLORREF(Int32.Parse(aColor.Substring(2), System.Globalization.NumberStyles.HexNumber));
					} 
					else 
					{
						try
						{
							return TO_COLORREF(Int32.Parse(aColor));
						}
						catch (Exception){}
					}
				}
				return TO_COLORREF(c.ToArgb() & 0x00ffffff);
			}
			return 0;
		}
		private int TO_COLORREF(int c)
		{
			return (((c & 0xff0000) >> 16)+((c & 0x0000ff) << 16)+(c & 0x00ff00));
		}
		
		public int CaretForegroundColor
		{
			get
			{
				if (caretfore != null && caretfore.Length > 0)
				{
					return ResolveColor(caretfore);
				}
				return ResolveColor("0x000000");
			}
		}
		
		public int CaretLineBackgroundColor
		{
			get
			{
				if (caretlineback != null && caretlineback.Length > 0)
				{
					return ResolveColor(caretlineback);
				}
				return ResolveColor("0xececec");
			}
		}
		
		public int SelectionForegroundColor
		{
			get
			{
				if (selectionfore != null && selectionfore.Length > 0)
				{
					return ResolveColor(selectionfore);
				}
				return ResolveColor("0xffffff");
			}
		}
		
		public int SelectionBackgroundColor
		{
			get
			{
				if (selectionback != null && selectionback.Length > 0)
				{
					return ResolveColor(selectionback);
				}
				return ResolveColor("0x000000");
			}
		}
		
		public int EdgeBackgroundColor
		{
			get
			{
				if (edgeback != null && edgeback.Length > 0)
				{
					return ResolveColor(edgeback);
				}
				return ResolveColor("0x000000");
			}
		}
		
	}
	
}
