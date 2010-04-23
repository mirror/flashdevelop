using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using PluginCore.Localization;

namespace AS3Context.Controls
{
    class ProfilerMemView
    {
        ToolStripLabel memLabel;
        private Stack<int> memStack;
        private int maxMemory = 0;

        public ProfilerMemView(ToolStripLabel label)
        {
            memLabel = label;
        }

        public void Clear()
        {
            memStack = new Stack<int>();
            memLabel.Text = String.Format(TextHelper.GetString("Label.MemoryDisplay"), 0, 0);
        }

        /// <summary>
        /// Memory stats display
        /// </summary>
        /// <param name="info"></param>
        public void UpdateStats(string[] info)
        {
            int mem = 0;
            int.TryParse(info[1], out mem);
            memStack.Push(mem);
            if (mem > maxMemory) maxMemory = mem;
            string raw = TextHelper.GetString("Label.MemoryDisplay");
            memLabel.Text = String.Format(raw, FormatMemory(mem), FormatMemory(maxMemory));
        }

        private string FormatMemory(int mem)
        {
            double m = mem / 1024.0;
            return (Math.Round(m * 10.0) / 10.0).ToString();
        }
    }
}
