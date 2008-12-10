using System;
using System.IO;
using System.Xml;
using System.Text;
using System.Drawing;
using System.Collections;
using System.Windows.Forms;
using ScintillaNet;
using PluginCore;
using System.Collections.Generic;

namespace XMLCompletion
{
    public enum XMLType
    {
        Unknown = 0,
        Invalid,
        XML,
        Known
    }

    public struct XMLContextTag
    {
        public String Tag;
        public String Name;
        public String NameSpace;
        public Int32 Position;
    }

    public class HTMLTag : IComparable
    {
        public String Tag;
        public String Name;
        public String NS;
        public List<string> Attributes;
        public Boolean IsLeaf;

        public HTMLTag(String tag, String ns, Boolean isLeaf)
        {
            Name = tag;
            NS = ns ?? "";
            Tag = (ns != null) ? ns + ":" + tag : tag;
            IsLeaf = isLeaf;
        }

        /// <summary>
        /// Compares tags
        /// </summary>
        public Int32 CompareTo(Object obj)
        {
            if (!(obj is HTMLTag)) throw new InvalidCastException("This object is not of type HTMLTag");
            return String.Compare(Tag, ((HTMLTag)obj).Tag);
        }
    }

    public class HtmlTagItem : ICompletionListItem
    {
        private String tag;
        private String label;

        public HtmlTagItem(String name, String tag)
        {
            this.label = name;
            this.tag = tag;
        }

        /// <summary>
        /// Gets the label of the list item
        /// </summary>
        public String Label
        {
            get { return label; }
        }

        /// <summary>
        /// Gets the description of the list item
        /// </summary>
        public String Description
        {
            get { return "Tag <" + tag + ">"; }
        }

        /// <summary>
        /// Gets the icon of the list item
        /// </summary>
        public Bitmap Icon
        {
            get { return XMLComplete.HtmlTagIcon; }
        }

        /// <summary>
        /// Gets the value of the list item
        /// </summary>
        public String Value
        {
            get { return tag; }
        }

    }

    public class NamespaceItem : ICompletionListItem
    {
        private String label;

        public NamespaceItem(String name)
        {
            this.label = name;
        }

        /// <summary>
        /// Gets the label of the list item
        /// </summary>
        public String Label
        {
            get { return label; }
        }

        /// <summary>
        /// Gets the description of the list item
        /// </summary>
        public String Description
        {
            get { return "Namespace <" + label + ":"; }
        }

        /// <summary>
        /// Gets the icon of the list item
        /// </summary>
        public Bitmap Icon
        {
            get { return XMLComplete.NamespaceTagIcon; }
        }

        /// <summary>
        /// Gets the value of the list item
        /// </summary>
        public String Value
        {
            get { return label; }
        }

    }

    public class HtmlAttributeItem : ICompletionListItem
    {
        private String label;
        private String desc;
        private Bitmap icon;

        public HtmlAttributeItem(String name)
        {
            Int32 p = name.IndexOf(':');
            if (p > 0)
            {
                String ic = name.Substring(p + 1);
                if (ic == "s" || ic == "style")
                {
                    this.icon = XMLComplete.StyleAttributeIcon;
                    this.desc = "Styling attribute";
                }
                else if (ic == "e" || ic == "event")
                {
                    this.icon = XMLComplete.EventAttributeIcon;
                    this.desc = "Event attribute";
                }
                else if (ic == "x" || ic == "effect")
                {
                    this.icon = XMLComplete.EffectAttributeIcon;
                    this.desc = "Effect attribute";
                }
                else
                {
                    this.icon = XMLComplete.HtmlAttributeIcon;
                    this.desc = "Attribute";
                }
                name = name.Substring(0, p);
            }
            else
            {
                this.icon = XMLComplete.HtmlAttributeIcon;
                this.desc = "Attribute";
            }
            this.label = name;
        }

        /// <summary>
        /// Gets the label of the list item
        /// </summary>
        public String Label
        {
            get { return this.label; }
        }

        /// <summary>
        /// Gets the description of the list item
        /// </summary>
        public String Description
        {
            get { return this.desc; }
        }

        /// <summary>
        /// Gets the icon of the list item
        /// </summary>
        public Bitmap Icon
        {
            get { return this.icon; }
        }

        /// <summary>
        /// Gets the value of the list item
        /// </summary>
        public String Value
        {
            get { return this.label; }
        }
    }

    public class XMLBlockItem : ICompletionListItem
    {
        private String desc;
        private String label;
        private String replace;
 
        public XMLBlockItem(String label, String desc, String replace)
        {
            this.desc = desc;
            this.label = label;
            this.replace = replace;
        }

        /// <summary>
        /// Gets the label of the list item
        /// </summary>
        public String Label
        {
            get { return this.label; }
        }

        /// <summary>
        /// Gets the description of the list item
        /// </summary>
        public String Description
        {
            get { return this.desc; }
        }

        /// <summary>
        /// Gets the icon of the list item
        /// </summary>
        public Bitmap Icon
        {
            get { return XMLComplete.HtmlTagIcon; }
        }

        /// <summary>
        /// Gets the value of the list item
        /// </summary>
        public String Value
        {
            get
            {
                ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
                Int32 position = sci.SelectionStart;
                String[] rep = replace.Split('|');
                sci.ReplaceSel(rep[0]);
                sci.ReplaceSel(rep[1]);
                sci.SetSel(position + rep[0].Length, position + rep[0].Length);
                return null;
            }
        }

    }

    public class ListItemComparer : IComparer<ICompletionListItem>
    {

        public int Compare(ICompletionListItem a, ICompletionListItem b)
        {
            return string.Compare(a.Label, b.Label);
        }

    }
}
