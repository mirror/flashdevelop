using System;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using PluginCore;
using System.IO;
using PluginCore.Helpers;
using PluginCore.Localization;
using PluginCore.Managers;
using System.Net.Sockets;
using System.Text.RegularExpressions;
using System.Collections.Generic;

namespace AS3Context.Controls
{
    public partial class ProfilerUI : DockPanelControl
    {
        static private readonly Byte[] RESULT_OK = Encoding.Default.GetBytes("<flashconnect status=\"0\"/>\0");
        static private readonly Byte[] RESULT_IGNORED = Encoding.Default.GetBytes("<flashconnect status=\"3\"/>\0");
        static private readonly Byte[] RESULT_GC = Encoding.Default.GetBytes("<flashconnect status=\"4\"/>\0");

        static private ProfilerUI instance;
        static private bool gcWanted;
        static private byte[] snapshotWanted;
        private bool autoStart;
        private bool running;
        private string current;
        private List<String> previous = new List<string>();
        private ObjectRefsGrid objectRefsGrid;
        private ProfilerLiveObjectsView liveObjectsView;
        private ProfilerMemView memView;
        private ProfilerObjectsView objectRefsView;
        private Timer detectDisconnect;

        public bool AutoStart
        {
            get { return autoStart; }
        }

        public static void HandleFlashConnect(object sender, object data)
        {
            Socket client = sender as Socket;

            if (instance == null || data == null || !instance.running)
            {
                if (client.Connected) client.Send(RESULT_IGNORED);
                return;
            }

            instance.OnProfileData((string)data);

            if (client.Connected) client.Send(RESULT_OK);

            if (gcWanted)
            {
                if (client.Connected) client.Send(RESULT_GC);
                gcWanted = false;
            }
            if (snapshotWanted != null)
            {
                if (client.Connected) client.Send(snapshotWanted);
                snapshotWanted = null;
            }
        }

        #region UI Init

        public ProfilerUI()
        {
            instance = this;

            InitializeComponent();
            objectRefsGrid = new ObjectRefsGrid();
            objectsPage.Controls.Add(objectRefsGrid);

            InitializeLocalization();

            toolStrip.Renderer = new DockPanelStripRenderer();
            runButton.Image = PluginBase.MainForm.FindImage("127");
            gcButton.Image = PluginBase.MainForm.FindImage("90");
            gcButton.Enabled = false;
            autoButton.Image = PluginBase.MainForm.FindImage("514");

            detectDisconnect = new Timer();
            detectDisconnect.Interval = 5000;
            detectDisconnect.Tick += new EventHandler(detectDisconnect_Tick);

            memView = new ProfilerMemView(memLabel, memStatsLabel, memScaleCombo, memoryPage);
            liveObjectsView = new ProfilerLiveObjectsView(listView);
            liveObjectsView.OnViewObject += new ViewObjectEvent(liveObjectsView_OnViewObject);
            objectRefsView = new ProfilerObjectsView(objectRefsGrid);

            StopProfiling();
        }

        void liveObjectsView_OnViewObject(TypeItem item)
        {
            snapshotWanted = Encoding.Default.GetBytes("<flashconnect status=\"5\" qname=\"" + item.QName.Replace("<", "&#60;") + "\"/>\0");
            objectRefsView.Clear();
            tabControl.SelectedTab = objectsPage;
        }

        private void InitializeLocalization()
        {
            this.labelTarget.Text = "";
            this.autoButton.Text = TextHelper.GetString("Label.AutoStartProfilerOFF");
            this.gcButton.Text = TextHelper.GetString("Label.RunGC");
            this.runButton.Text = TextHelper.GetString("Label.StartProfiler");
            this.typeColumn.Text = TextHelper.GetString("Column.Type");
            this.countColumn.Text = TextHelper.GetString("Column.Count");
            this.memColumn.Text = TextHelper.GetString("Column.Memory");
            this.pkgColumn.Text = TextHelper.GetString("Column.Package");
            this.maxColumn.Text = TextHelper.GetString("Column.Maximum");
            this.memScaleLabel.Text = TextHelper.GetString("Label.MemoryGraphScale");
            this.liveObjectsPage.Text = TextHelper.GetString("Label.LiveObjectsTab");
            this.objectsPage.Text = TextHelper.GetString("Label.ObjectsTab");
            this.memoryPage.Text = TextHelper.GetString("Label.MemoryTab");
        }

        void detectDisconnect_Tick(object sender, EventArgs e)
        {
            detectDisconnect.Stop();
            StopProfiling();
        }

        public void Cleanup()
        {
            SetProfilerCfg(false);
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

        public void StopProfiling()
        {
            running = false;
            runButton.Image = PluginBase.MainForm.FindImage("125");
            runButton.Text = TextHelper.GetString("Label.StartProfiler");
            gcButton.Enabled = false;

            SetProfilerCfg(false);
        }

        public void StartProfiling()
        {
            running = true;
            current = null;
            gcWanted = false;
            snapshotWanted = null;
            
            liveObjectsView.Clear();
            memView.Clear();

            if (tabControl.SelectedTab == objectsPage) 
                tabControl.SelectedTab = liveObjectsPage;
            runButton.Image = PluginBase.MainForm.FindImage("126");
            runButton.Text = TextHelper.GetString("Label.StopProfiler");
            gcButton.Enabled = false;

            if (!SetProfilerCfg(true)) 
                StopProfiling();
        }

        private void autoButton_Click(object sender, EventArgs e)
        {
            autoStart = !autoStart;
            autoButton.Image = PluginBase.MainForm.FindImage(autoStart ? "510" : "514");
            autoButton.Text = TextHelper.GetString(autoStart ? "Label.AutoStartProfilerON" : "Label.AutoStartProfilerOFF");
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

            // type snapshot
            if (info[0] == "stacks") 
            {
                objectRefsView.Display(info[1], data.Substring(p + 1).Split('|'));
                return true;
            }

            // live objects count
            if (current != info[0])
            {
                if (!previous.Contains(info[0]))
                {
                    current = info[0];
                    labelTarget.Text = info.Length > 2 ? info[2].Replace('\\', '/') : "";
                    previous.Add(current);
                    SetProfilerCfg(false);
                    gcButton.Enabled = true;
                }
                else return false;
            }

            detectDisconnect.Stop();
            detectDisconnect.Start();

            memView.UpdateStats(info);
            liveObjectsView.UpdateTypeGrid(data.Substring(p + 1).Split('|'));
            return true;
        }

        #endregion

        #region MM configuration

        private bool SetProfilerCfg(bool active)
        {
            try
            {
                string home = Environment.GetEnvironmentVariable("USERPROFILE");
                if (!Directory.Exists(home))
                    return false;
                string mmCfg = Path.Combine(home, "mm.cfg");
                if (!File.Exists(mmCfg)) CreateDefaultCfg(mmCfg);
                string src = File.ReadAllText(mmCfg).Trim();
                src = Regex.Replace(src, "PreloadSwf=.*", "").Trim();
                if (active)
                {
                    // write profiler
                    string profilerSWF = CheckResource("Profiler4.swf", "Profiler.swf");
                    // local security
                    ASCompletion.Commands.CreateTrustFile.Run("FDProfiler.cfg", Path.GetDirectoryName(profilerSWF));
                    // honor FlashConnect settings
                    FlashConnect.Settings settings = GetFlashConnectSettings();
                    // mm.cfg profiler config
                    src += "\r\nPreloadSwf=" + profilerSWF + "?host=" + settings.Host + "&port=" + settings.Port + "\r\n";
                }
                File.WriteAllText(mmCfg, src);
            }
            catch 
            {
                return false; // unable to set the profiler
            }
            return true;
        }

        private FlashConnect.Settings GetFlashConnectSettings()
        {
            IPlugin flashConnect = PluginBase.MainForm.FindPlugin("425ae753-fdc2-4fdf-8277-c47c39c2e26b");
            return flashConnect != null ? (FlashConnect.Settings)flashConnect.Settings : new FlashConnect.Settings();
        }

        static private string CheckResource(string fileName, string resName)
        {
            string path = Path.Combine(PathHelper.DataDir, "AS3Context");
            string fullPath = Path.Combine(path, fileName);
            if (!File.Exists(fullPath))
            {
                string id = "AS3Context.Resources." + resName;
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
            try
            {
                String contents = "PolicyFileLog=1\r\nPolicyFileLogAppend=0\r\nErrorReportingEnable=1\r\nTraceOutputFileEnable=1\r\n";
                FileHelper.WriteFile(mmCfg, contents, Encoding.UTF8);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        #endregion

    }

    

}
