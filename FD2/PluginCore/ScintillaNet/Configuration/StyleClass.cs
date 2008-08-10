using System;
using System.Drawing;
using System.Globalization;
using System.Runtime;
using System.Runtime.InteropServices;
using System.Xml.Serialization;

namespace ScintillaNet.Configuration
{
    [SerializableAttribute()]
    public class StyleClass : ConfigItem
    {
        [XmlAttributeAttribute()]
        public string name;

        [XmlAttributeAttribute()]
        public string fore;

        [XmlAttributeAttribute()]
        public string back;

        [XmlAttributeAttribute()]
        public string size;

        [XmlAttributeAttribute()]
        public string font;

		[XmlAttributeAttribute()]
		public string bold;

		[XmlAttributeAttribute()]
		public string eolfilled;

		[XmlAttributeAttribute()]
        public string italics;

        [XmlAttributeAttribute("inherit-style")]
        public string inheritstyle;

        public StyleClass(){}
        
        public StyleClass ParentClass
        {
            get
            {
				if (inheritstyle != null && !inheritstyle.Equals(""))
				{
					return _parent.MasterScintilla.GetStyleClass(inheritstyle);
				}
				// If it has no parent, the default class will be the parent.
				// Caution: it is not programmatically guaranteed that there is a default.
				if (!name.Equals("default")) return _parent.MasterScintilla.GetStyleClass("default");
				return null;
			}
        }

        public bool HasItalics
        {
            get
            {
				if (italics != null) return true;
				StyleClass p = ParentClass;
				if (p != null) return p.HasItalics;
				return false;
			}
        }

		public bool HasBold
		{
			get
			{
				if (bold != null) return true;
				StyleClass p = ParentClass;
				if (p != null) return p.HasBold;
				return false;
			}
		}
		public bool HasEolFilled
		{
			get
			{
				if (eolfilled != null) return true;
				StyleClass p = ParentClass;
				if (p != null) return p.HasEolFilled;
				return false;
			}
		}

        public bool HasFontName
        {
            get
            {
				if (font != null) return true;
				StyleClass p = ParentClass;
				if (p != null) return p.HasFontName;
				return false;
			}
        }

        public bool HasFontSize
        {
            get
            {
				if (size != null) return true;
				StyleClass p = ParentClass;
				if (p != null) return p.HasFontSize;
				return false;
			}
        }

        public bool HasBackgroundColor
        {
            get
            {
				if (back != null) return true;
				StyleClass p = ParentClass;
				if (p != null) return p.HasBackgroundColor;
				return false;
			}
        }

        public bool HasForegroundColor
        {
            get
            {
				if (fore  != null) return true;
				StyleClass p = ParentClass;
				if (p != null) return p.HasForegroundColor;
				return false;
			}
        }

        public string FontName
        {
            get
            {
				if (font != null) return ResolveString(font);
				StyleClass p = ParentClass;
				if (p != null) return p.FontName;
				return "Courier New";

            }
        }

        public int FontSize
        {
            get
            {
				if (size != null) return ResolveNumber(size);
				StyleClass p = ParentClass;
				if (p != null) return p.FontSize;
				return 9;
			}
        }

        public int BackgroundColor
        {
            get
            {
				if (back != null) return ResolveColor(back);
				StyleClass p = ParentClass;
				if (p != null) return p.BackgroundColor;
				return 0;
			}
        }

        public int ForegroundColor
        {
            get
            {
				if (fore != null) return ResolveColor(fore);
				StyleClass p = ParentClass;
				if (p  != null) return p.ForegroundColor;
				return 0;
			}
        }

        public bool IsItalics
        {
            get
            {
				if (italics!= null) return italics.Equals("true");
				StyleClass p = ParentClass;
				if (p != null) return p.IsItalics;
				return false;
			}
        }

		public bool IsBold
		{
			get
			{
				if (bold != null) return bold.Equals("true");
				StyleClass p = ParentClass;
				if (p != null) return p.IsBold;
				return false;

			}
		}

		public bool IsEolFilled
		{
			get
			{
				if (eolfilled != null) return eolfilled.Equals("true");
				StyleClass p = ParentClass;
				if (p  != null) return p.IsEolFilled;
				return false;

			}
		}

		public int ResolveColor(string aColor)
		{
			if (aColor != null)
			{
				Value v = _parent.MasterScintilla.GetValue(aColor);
				while (v!= null)
				{
					aColor = v.val;
					v = _parent.MasterScintilla.GetValue(aColor);
				}
				System.Drawing.Color c = System.Drawing.Color.FromName(aColor);
				if (c.ToArgb() == 0)
				{
					if (aColor.IndexOf("0x") == 0) return TO_COLORREF(Int32.Parse(aColor.Substring(2), System.Globalization.NumberStyles.HexNumber));
					else 
					{
						try
						{
							return TO_COLORREF(Int32.Parse(aColor));
						}
						catch(Exception){}
					}
				}
				return TO_COLORREF(c.ToArgb() & 0x00ffffff);
			}
			return 0;
		}
		private int TO_COLORREF(int c)
		{
			return (((c & 0xff0000) >> 16) + ((c & 0x0000ff) << 16) + (c & 0x00ff00) );
		}
		
		public int ResolveNumber(string number)
		{
			if (number != null)
			{
				Value v = _parent.MasterScintilla.GetValue(number);
				while (v != null)
				{
					number = v.val;
					v = _parent.MasterScintilla.GetValue(number);
				}
				if (number.IndexOf("0x") == 0) return Int32.Parse(number.Substring(2), System.Globalization.NumberStyles.HexNumber);
				else
				{
					try
					{
						return Int32.Parse(number);
					}
					catch(Exception){}
				}
			}
			return 0;

		}

        public string ResolveString(string number)
        {
            Value value = null;
            if (number != null)
            {
                for (value = _parent.MasterScintilla.GetValue(number); value != null; value = _parent.MasterScintilla.GetValue(number))
                {
                    number = value.val;
                }
            }
            return number;
        }
        
    }

}
