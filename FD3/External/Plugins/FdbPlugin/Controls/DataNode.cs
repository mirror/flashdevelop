using System;
using System.Collections.Generic;
using System.Text;
using Aga.Controls.Tree;
using System.Text.RegularExpressions;

namespace FdbPlugin.Controls
{
    public class DataNode : Node
    {
        static Regex reObject = new Regex(@".*\[Object\s\d*, class='.*'\]", RegexOptions.Compiled);

        public override string Text
        {
            get { return base.Text; }
            set
            {
                if (string.IsNullOrEmpty(value))
                    throw new ArgumentNullException();
  
                base.Text = value;
            }
        }

        private string _value;
        public string Value
        {
            get { return _value; }
            set { _value = value; }
        }

        public override bool IsLeaf
        {
            get
            {
                if (reObject.IsMatch(this._value))
                {
                    return false;
                }
                return true;
            }
        }

        public DataNode(string text, string value)
            : base(text.Trim())
        {
            this._value = value.Trim();
        }
    }
}
