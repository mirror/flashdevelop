using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

namespace FdbPlugin
{
    interface ISetData
    {
        void SetData(string name, List<string> datalist, object option);
        Control TargetControl { get; }
    }
}
