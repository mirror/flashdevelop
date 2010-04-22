using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using System.Collections;
using PluginCore;
using System.IO;
using PluginCore.Helpers;
using System.Text.RegularExpressions;
using PluginCore.Localization;
using PluginCore.Managers;
using System.Net.Sockets;

namespace AS3Context.Controls
{
    public partial class ProfilerUI : DockPanelControl
    {
        static private readonly Byte[] RESULT_OK = Encoding.Default.GetBytes("<flashconnect status=\"0\"/>\0");
        static private readonly Byte[] RESULT_IGNORED = Encoding.Default.GetBytes("<flashconnect status=\"3\"/>\0");
        static private readonly Byte[] RESULT_GC = Encoding.Default.GetBytes("<flashconnect status=\"4\"/>\0");

        static private ProfilerUI instance;
        static private bool gcWanted;
        private bool running;
        private Dictionary<string, TypeItem> items;
        private Dictionary<string, bool> finished = new Dictionary<string,bool>();
        private string current;
        private TypeItemComparer comparer;
        private Stack<int> memStack = new Stack<int>();
        private int maxMemory = 0;
        private Timer detectDisconnect;

        public static void HandleFlashConnect(object sender, object data)
        {
            Socket client = sender as Socket;

            if (instance == null || data == null || !instance.running)
            {
                client.Send(RESULT_IGNORED);
                return;
            }

            instance.OnProfileData((string)data);

            client.Send(RESULT_OK);

            if (gcWanted)
            {
                client.Send(RESULT_GC);
                gcWanted = false;
            }
        }

        #region UI Init

        public ProfilerUI()
        {
            instance = this;

            InitializeComponent();
            InitializeLocalization();
            toolStrip.Renderer = new DockPanelStripRenderer();
            runButton.Image = PluginBase.MainForm.FindImage("127");
            gcButton.Image = PluginBase.MainForm.FindImage("90");

            detectDisconnect = new Timer();
            detectDisconnect.Interval = 5000;
            detectDisconnect.Tick += new EventHandler(detectDisconnect_Tick);

            comparer = new TypeItemComparer();
            comparer.SortColumn = 2;
            comparer.Sorting = SortOrder.Descending;
            listView.ListViewItemSorter = comparer;

            StopProfiling();
        }

        private void InitializeLocalization()
        {
            this.gcButton.Text = TextHelper.GetString("Label.RunGC");
            this.runButton.Text = TextHelper.GetString("Label.StartProfiler");
            this.memLabel.Text = String.Format(TextHelper.GetString("Label.MemoryDisplay"), 0, 0);
            this.typeColumn.Text = TextHelper.GetString("Column.Type");
            this.countColumn.Text = TextHelper.GetString("Column.Count");
            this.memColumn.Text = TextHelper.GetString("Column.Memory");
            this.pkgColumn.Text = TextHelper.GetString("Column.Package");
            this.maxColumn.Text = TextHelper.GetString("Column.Maximum");
        }

        void detectDisconnect_Tick(object sender, EventArgs e)
        {
            detectDisconnect.Stop();
            StopProfiling();
        }

        public void Cleanup()
        {
            if (running) SetProfilerCfg(false);
        }

        private void runButton_Click(object sender, EventArgs e)
        {
            if (running) StopProfiling();
            else StartProfiling();
        }

        private void gcButton_Click(object sender, EventArgs e)
        {
            if (running && current != null) gcWanted = true;
        }

        private void StopProfiling()
        {
            running = false;
            runButton.Image = PluginBase.MainForm.FindImage("125");
            runButton.Text = TextHelper.GetString("Label.StartProfiler");
        }

        private void StartProfiling()
        {
            running = true;
            current = null;
            items = new Dictionary<string, TypeItem>();
            memLabel.Text = String.Format(TextHelper.GetString("Label.MemoryDisplay"), 0, 0);
            listView.Items.Clear();
            runButton.Image = PluginBase.MainForm.FindImage("126");
            runButton.Text = TextHelper.GetString("Label.StopProfiler");
            SetProfilerCfg(true);
        }

        #endregion

        #region Display profiling data

        /// <summary>
        /// Recieved profiling data
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        internal bool OnProfileData(string data)
        {
            // check sampler
            int p = data.IndexOf('|');
            string[] info = data.Substring(0, p).Split('/');
            if (current == null)
            {
                current = info[0];
                SetProfilerCfg(false);
            }
            else if (current != info[0]) return false;

            detectDisconnect.Stop();
            detectDisconnect.Start();

            UpdateStats(info);
            UpdateTypeGrid(data.Substring(p + 1).Split('|'));
            return true;
        }

        /// <summary>
        /// Live objects stats
        /// </summary>
        /// <param name="lines"></param>
        private void UpdateTypeGrid(string[] lines)
        {
            listView.BeginUpdate();
            foreach (TypeItem item in items.Values)
                item.Zero();

            try
            {
                foreach (string line in lines)
                {
                    string[] parts = line.Split('/');
                    TypeItem item;
                    if (parts.Length == 4)
                    {
                        item = new TypeItem(parts[3]);
                        items[parts[0]] = item;
                        listView.Items.Add(item.ListItem);
                    }
                    else if (!items.ContainsKey(parts[0])) continue;
                    else item = items[parts[0]];
                    item.Update(parts[1], parts[2]);
                }
                listView.Sort();
            }
            finally
            {
                listView.EndUpdate();
            }
        }

        /// <summary>
        /// Memory stats display
        /// </summary>
        /// <param name="info"></param>
        private void UpdateStats(string[] info)
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

        private void listView_ColumnClick(object sender, ColumnClickEventArgs e)
        {
            if (e.Column == comparer.SortColumn)
            {
                if (comparer.Sorting == SortOrder.Ascending) comparer.Sorting = SortOrder.Descending;
                else comparer.Sorting = SortOrder.Ascending;
            }
            else comparer.SortColumn = e.Column;
            listView.Sort();
        }

        #endregion

        #region MM configuration

        private void SetProfilerCfg(bool active)
        {
            string home = Path.GetDirectoryName(Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
            string mmCfg = Path.Combine(home, "mm.cfg");
            if (!File.Exists(mmCfg)) CreateDefaultCfg(mmCfg);

            string src = File.ReadAllText(mmCfg).Trim();
            src = Regex.Replace(src, "PreloadSwf=.*", "").Trim();
            if (active)
            {
                string profilerSWF = CheckResource("Profiler.swf");
                ASCompletion.Commands.CreateTrustFile.Run("FDProfiler", profilerSWF);
                src += "\r\nPreloadSwf=" + profilerSWF + "\r\n";
            }
            try
            {
                File.WriteAllText(mmCfg, src);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        static private string CheckResource(string fileName)
        {
            string path = Path.Combine(PathHelper.DataDir, "AS3Context");
            string fullPath = Path.Combine(path, fileName);
            if (!File.Exists(fullPath))
            {
                string id = "AS3Context.Resources." + fileName;
                System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
                using (BinaryReader br = new BinaryReader(assembly.GetManifestResourceStream(id)))
                {
                    using (FileStream bw = File.Create(fullPath))
                    {
                        byte[] buffer = br.ReadBytes(1024);
                        while (buffer.Length > 0)
                        {
                            bw.Write(buffer, 0, buffer.Length);
                            buffer = br.ReadBytes(1024);
                        }
                        bw.Close();
                    }
                    br.Close();
                }
            }
            return fullPath;
        }

        private void CreateDefaultCfg(string mmCfg)
        {
            File.WriteAllText(mmCfg, 
@"PolicyFileLog=1
ErrorReportingEnable=1
TraceOutputFileEnable=1");
        }

        #endregion
    }

    #region Model

    class TypeItemComparer : IComparer
    {
        public int SortColumn = 0;
        public SortOrder Sorting;

        int IComparer.Compare(object x, object y)
        {
            TypeItem a = (TypeItem)((ListViewItem)x).Tag;
            TypeItem b = (TypeItem)((ListViewItem)y).Tag;

            int comp;
            switch (SortColumn)
            {
                case TypeItem.COL_PKG: comp = a.Package.CompareTo(b.Package); break;
                case TypeItem.COL_MAX: comp = a.Maximum.CompareTo(b.Maximum); break;
                case TypeItem.COL_COUNT: comp = a.Count.CompareTo(b.Count); break;
                case TypeItem.COL_MEM: comp = a.Memory.CompareTo(b.Memory); break;
                default: comp = a.Name.CompareTo(b.Name); break;
            }

            return Sorting == SortOrder.Ascending ? comp : -comp;
        }
    }


    class TypeItem
    {
        public const int COL_PKG = 1;
        public const int COL_MAX = 2;
        public const int COL_COUNT = 3;
        public const int COL_MEM = 4;

        public string Name;
        public string Package = "";
        public int Count;
        public int Maximum;
        public int Memory;
        public ListViewItem ListItem;
        public bool zero;

        public TypeItem(string fullName)
        {
            int p = fullName.IndexOf(':');
            if (p >= 0)
            {
                Name = fullName.Substring(p + 2);
                Package = fullName.Substring(0, p);
            }
            else Name = fullName;
            ListItem = new ListViewItem(Name);
            ListItem.Tag = this;
            ListItem.SubItems.Add(new ListViewItem.ListViewSubItem(ListItem, Package));
            ListItem.SubItems.Add(new ListViewItem.ListViewSubItem(ListItem, "0"));
            ListItem.SubItems.Add(new ListViewItem.ListViewSubItem(ListItem, "0"));
            ListItem.SubItems.Add(new ListViewItem.ListViewSubItem(ListItem, "0"));
        }

        public void Update(string cpt, string mem)
        {
            zero = false;

            ListItem.SubItems[COL_COUNT].Text = cpt;
            int.TryParse(cpt, out Count);

            if (Maximum < Count)
            {
                Maximum = Count;
                ListItem.SubItems[COL_MAX].Text = cpt;
            }

            int.TryParse(mem, out Memory);
            ListItem.SubItems[COL_MEM].Text = mem;
        }

        public void Zero()
        {
            if (zero) return;
            zero = true;
            ListItem.SubItems[COL_COUNT].Text = "0";
            ListItem.SubItems[COL_MEM].Text = "0";
        }
    }

    #endregion

    
}
