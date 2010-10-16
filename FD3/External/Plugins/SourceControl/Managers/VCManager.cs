﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using PluginCore;
using SourceControl.Actions;
using SourceControl.Sources;
using SourceControl.Sources.Subversion;
using SourceControl.Sources.Git;

namespace SourceControl.Managers
{
    class VCManager
    {
        Timer refreshTimer;
        OverlayManager ovManager;

        public VCManager(OverlayManager ovManager)
        {
            this.ovManager = ovManager;

            if (PluginMain.SCSettings.EnableSVN) AddVCManager(new SubversionManager());
            if (PluginMain.SCSettings.EnableGIT) AddVCManager(new GitManager());

            refreshTimer = new Timer();
            refreshTimer.Interval = 100;
            refreshTimer.Tick += new EventHandler(refreshTimer_Tick);
            refreshTimer.Stop();
        }

        public void Dispose()
        {
            ovManager = null;
            if (refreshTimer != null) refreshTimer.Stop();
        }

        void AddVCManager(IVCManager manager)
        {
            ProjectWatcher.VCManagers.Add(manager);
            manager.OnChange += manager_OnChange;
        }

        void manager_OnChange(IVCManager sender)
        {
            (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate
            {
                refreshTimer.Stop();
                refreshTimer.Start();
            });
        }

        void refreshTimer_Tick(object sender, EventArgs e)
        {
            refreshTimer.Stop();
            ovManager.Refresh();
        }
    }
}
