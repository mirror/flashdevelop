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
        private bool running;
        private string current;
        private ObjectRefsGrid objectRefsGrid;
        private ProfilerLiveObjectsView liveObjectsView;
        private ProfilerMemView memView;
        private ProfilerObjectsView objectRefsView;
        private Timer detectDisconnect;

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

            detectDisconnect = new Timer();
            detectDisconnect.Interval = 5000;
            detectDisconnect.Tick += new EventHandler(detectDisconnect_Tick);

            memView = new ProfilerMemView(memLabel);
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
            this.gcButton.Text = TextHelper.GetString("Label.RunGC");
            this.runButton.Text = TextHelper.GetString("Label.StartProfiler");
            this.memLabel.Text = String.Format(TextHelper.GetString("Label.MemoryDisplay"), 0, 0);
            this.typeColumn.Text = TextHelper.GetString("Column.Type");
            this.countColumn.Text = TextHelper.GetString("Column.Count");
            this.memColumn.Text = TextHelper.GetString("Column.Memory");
            this.pkgColumn.Text = TextHelper.GetString("Column.Package");
            this.maxColumn.Text = TextHelper.GetString("Column.Maximum");
            this.liveObjectsPage.Text = TextHelper.GetString("Label.LiveObjectsTab");
            this.objectsPage.Text = TextHelper.GetString("Label.ObjectsTab");
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
            gcWanted = false;
            snapshotWanted = null;
            
            liveObjectsView.Clear();
            memView.Clear();

            tabControl.SelectedTab = liveObjectsPage;
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

            // type snapshot
            if (info[0] == "stacks") 
            {
                objectRefsView.Display(info[1], data.Substring(p + 1).Split('|'));
                return true;
            }

            // live objects count
            if (current == null)
            {
                current = info[0];
                SetProfilerCfg(false);
            }
            else if (current != info[0]) return false;

            detectDisconnect.Stop();
            detectDisconnect.Start();

            memView.UpdateStats(info);
            liveObjectsView.UpdateTypeGrid(data.Substring(p + 1).Split('|'));
            return true;
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
                // write profiler
                string profilerSWF = CheckResource("Profiler2.swf", "Profiler.swf");
                // local security
                ASCompletion.Commands.CreateTrustFile.Run("FDProfiler.cfg", Path.GetDirectoryName(profilerSWF));
                // honor FlashConnect settings
                FlashConnect.Settings settings = GetFlashConnectSettings();
                // mm.cfg profiler config
                src += "\r\nPreloadSwf=" + profilerSWF + "?host=" + settings.Host + "&port=" + settings.Port + "\r\n";
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
            File.WriteAllText(mmCfg, 
@"PolicyFileLog=1
ErrorReportingEnable=1
TraceOutputFileEnable=1");
        }

        #endregion
    }

    

}
