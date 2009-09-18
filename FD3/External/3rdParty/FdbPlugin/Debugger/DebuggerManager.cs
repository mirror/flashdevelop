using System;
using System.Collections.Generic;
using System.Text;
using PluginCore;
using System.Windows.Forms;
using PluginCore.Controls;
using System.Diagnostics;
using FdbPlugin.Properties;
using FdbPlugin.Controls;
using ScintillaNet;
using System.Drawing;
using PluginCore.Managers;
using System.ComponentModel;
using ProjectManager.Projects;
using System.Text.RegularExpressions;
using PluginCore.Localization;
using System.IO;
using ProjectManager.Projects.AS3;

namespace FdbPlugin
{
    public delegate void StateChangedEventHandler(object sender, FdbState state);

    public class DebuggerManager
    {
        public event StateChangedEventHandler StateChangedEvent;

        private static Char[] chTrims = { '.' };

        internal Project currentProject;
        internal string processname;
        internal string AssociateExecutableFilePath;

        private BackgroundWorker bgWorker;
        private FdbWrapper fdbWrapper;
        private Process adlProcess;

        public FdbWrapper FdbWrapper
        {
            get { return this.fdbWrapper; }
        }

        public DebuggerManager()
        {
            fdbWrapper = new FdbWrapper();
            fdbWrapper.breakPointManager = PluginMain.breakPointManager;

            fdbWrapper.ContinueEvent += new ContinueEventHandler(fdbWrapper_ContinueEvent);
            fdbWrapper.LocalValuesEvent += new ContinueEventHandler(fdbWrapper_LocalValuesEvent);
            fdbWrapper.StopEvent += new fdbEventHandler(fdbWrapper_StopEvent);
            fdbWrapper.TraceEvent += new TraceEventHandler(fdbWrapper_TraceEvent);
            fdbWrapper.PauseEvent += new fdbEventHandler(fdbWrapper_PauseEvent);
            fdbWrapper.ExceptionEvent += new fdbEventHandler(fdbWrapper_ExceptionEvent);
            fdbWrapper.PauseNotRespondEvent += new fdbEventHandler(fdbWrapper_PauseNotRespondEvent);

            fdbWrapper.PrintEvent += new PrintEventHandler(fdbWrapper_PrintEvent);
            fdbWrapper.ConditionErrorEvent += new fdbEventHandler(fdbWrapper_ConditionErrorEvent);
            fdbWrapper.StartadlEvent += new fdbEventHandler(fdbWrapper_StartadlEvent);
            fdbWrapper.InfoStackEvent += new PrintEventHandler(fdbWrapper_PrintStackfremaEvent);
            fdbWrapper.MoveFrameEvent += new ContinueEventHandler(fdbWrapper_MoveFrameEvent);
        }

        #region starting

        public void Start()
        {
            try
            {
                FdbPluginTrace.Trace("CheckCurrent()");
                CheckCurrent();
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return;
            }

            PluginMain.debugBuildStart = true;
            UpdateMenuState(FdbState.WAIT);
            if (PluginMain.settingObject.DebugWithCompile
                || !File.Exists(Path.Combine(Path.GetDirectoryName(currentProject.ProjectPath), currentProject.OutputPath)))
            {
                try
                {
                    BuildCurrentProject();
                }
                catch
                {
                    String message = TextHelper.GetString("FdbPlugin.Info.DebugWithoutCompiler");
                    String title = " " + TextHelper.GetString("FlashDevelop.Title.ConfirmDialog");
                    if (MessageBox.Show(message, title, MessageBoxButtons.OKCancel) == DialogResult.OK)
                    {
                        Start(currentProject.OutputPathAbsolute);
                    }
                }
            }
            else Start(currentProject.OutputPathAbsolute);
        }

        /// <summary>
        /// 
        /// </summary>
        private void CheckCurrent()
        {
            String errormsg = String.Empty;
            try
            {
                String filename = PluginBase.CurrentProject.ProjectPath;
                ProjectManager.Projects.ProjectReader reader = new ProjectManager.Projects.ProjectReader(filename, new AS3Project(filename));
                currentProject = reader.ReadProject();
            }
            catch (Exception e)
            {
                errormsg = e.Message + System.Environment.NewLine;
            }
            if (!(currentProject.CompileTargets != null && currentProject.CompileTargets.Count != 0))
            {
                errormsg += TextHelper.GetString("FdbPlugin.Info.NoMainClass") + System.Environment.NewLine;
            }
            if (currentProject.Language != "as3")
            {
                errormsg += TextHelper.GetString("FdbPlugin.Info.LanguageNotAS3") + System.Environment.NewLine;
            }
            if (AS3Context.PluginMain.Settings.FlexSDK == null || AS3Context.PluginMain.Settings.FlexSDK == string.Empty || !Directory.Exists(AS3Context.PluginMain.Settings.FlexSDK))
            {
                errormsg += TextHelper.GetString("FdbPlugin.Info.CheckFlexSDKSetting") + System.Environment.NewLine;
            }
            try
            {
                //$(FlexSDK)\bin\adl.exe;application.xml bin
                if (currentProject.TestMovieCommand != null && currentProject.TestMovieCommand.Contains("adl.exe"))
                {
                    //AIR
                    processname = "adl";
                }
                else
                {
                    String cmd = Util.FindAssociatedExecutableFile(".swf", "open");
                    if (cmd != AssociateExecutableFilePath)
                    {
                        processname = Util.GetAssociateAppFileName(cmd);
                        AssociateExecutableFilePath = cmd;
                    }
                }
            }
            catch (Exception e)
            {
                errormsg += e.Message + System.Environment.NewLine;
            }
            if (errormsg != String.Empty) throw new Exception(errormsg);
        }

        private void BuildCurrentProject()
        {
            DataEvent de = new DataEvent(EventType.Command, "ProjectManager.BuildProject", null);
            EventManager.DispatchEvent(this, de);
        }

        /// <summary>
        /// 
        /// </summary>
        internal void Start(String filename)
        {
            FdbPluginTrace.TraceInfo("----Start(string filename)----");
            FdbPluginTrace.TraceInfo(PluginMain.settingObject.DebugFlashPlayerPath + " " + filename);

            //Application.DoEvents();
            fdbWrapper.CurrentProject = currentProject;
            fdbWrapper.CurrentSettings = AS3Context.PluginMain.Settings;
            fdbWrapper.Outputfilefullpath = filename;

            TraceManager.Add("[Debugging with FDB]");
            UpdateMenuState(FdbState.START);
            //OpenLocalVariablesPanel(null, null);

            bgWorker = new BackgroundWorker();
            bgWorker.DoWork += bgWorker_DoWork;
            bgWorker.RunWorkerAsync();
        }

        private void bgWorker_DoWork(object sender, DoWorkEventArgs e)
        {
            try
            {
                fdbWrapper.Start();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                fdbWrapper.Stop(processname, false);
            }
        }

        #endregion

        #region FdbWrapper control

        public void Cleanup()
        {
            fdbWrapper.Cleanup();
        }

        private void UpdateMenuState(FdbState state)
        {
            if (StateChangedEvent != null)
                StateChangedEvent(this, state);
        }

        public void PushPrint(object sender, string objname, string option)
        {
            PrintPushArgs args = new PrintPushArgs(sender, objname, option);
            fdbWrapper.PushPrintParams = args;
            fdbWrapper.PushCommand = "Print";
        }
        public void PushPrint(object sender, string[] objnames, string option)
        {
            PrintPushArgs args = new PrintPushArgs(sender, objnames, option);
            fdbWrapper.PushPrintParams = args;
            fdbWrapper.PushCommand = "Print";
        }

        /// <summary>
        /// 
        /// </summary>
        private void UpdatelocalVariablesLeaf()
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate()
                {
                    UpdatelocalVariablesLeaf();
                });
                return;
            }

            List<DataNode> nodelist = PanelsHelper.pluginUI.TreeControl.AllHasChildNodes;
            if (nodelist.Count == 0)
            {
                UpdateMenuState(fdbWrapper.State);
                return;
            }
            List<string> objlist = new List<string>();
            foreach (DataNode node in nodelist)
            {
                String fullpath = PanelsHelper.pluginUI.TreeControl.GetFullPath(node);
                objlist.Add(fullpath + ".");
            }
            //fdbWrapper.Print(pluginUI, objlist.ToArray());
            PushPrint(PanelsHelper.pluginUI, objlist.ToArray(), null);
        }

        #endregion

        #region FdbWrapper events

        void fdbWrapper_StartadlEvent(object sender)
        {
            FdbPluginTrace.TraceInfo("fdbWrapper_StartadlEvent start");
            string cmd = PluginBase.MainForm.ProcessArgString(currentProject.TestMovieCommand);
            string[] args = (cmd + ';').Split(';');
            ProcessStartInfo psi = new ProcessStartInfo(args[0], args[1]);
            psi.CreateNoWindow = true;
            psi.UseShellExecute = false;
            psi.WorkingDirectory = currentProject.Directory;
            FdbPluginTrace.Trace("psi.WorkingDirectory = " + psi.WorkingDirectory);
            adlProcess = Process.Start(psi);
        }

        void fdbWrapper_PauseNotRespondEvent(object sender)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate()
                {
                    fdbWrapper_PauseNotRespondEvent(sender);
                });
                return;
            }

            DialogResult res = MessageBox.Show(PluginBase.MainForm, "Close Process?", "Process not responding", MessageBoxButtons.OKCancel);
            if (res == DialogResult.OK)
            {
                fdbWrapper.Stop(processname, false);
            }
            else
            {
                UpdateMenuState(FdbState.CONTINUE);
            }
        }

        void fdbWrapper_PrintEvent(object sender, PrintArg e)
        {
            if (sender is ISetData)
            {
                ISetData si = sender as ISetData;
                if (si.TargetControl == null)
                {
                    si.SetData(e.valname, e.output, e.option);
                }
                else
                {
                    si.TargetControl.Invoke((MethodInvoker)delegate()
                    {
                        si.SetData(e.valname, e.output, e.option);
                    });
                }
            }
        }

        void fdbWrapper_MoveFrameEvent(object sender, FdbMsg e)
        {
            (PluginBase.MainForm as Form).Invoke((MethodInvoker)delegate()
            {
                ScintillaHelper.ActiveDocument(e.filefillpath, e.line - 1, true);
            });

            PanelsHelper.stackframeUI.Invoke((MethodInvoker)delegate()
            {
                PanelsHelper.stackframeUI.ActiveItem();
            });
        }

        void fdbWrapper_PrintStackfremaEvent(object sender, PrintArg e)
        {
            PanelsHelper.stackframeUI.Invoke((MethodInvoker)delegate()
            {
                PanelsHelper.stackframeUI.AddItem(e.output);
            });
        }

        void fdbWrapper_ConditionErrorEvent(object sender)
        {
            fdbWrapper.Stop(processname, false);

            (PluginBase.MainForm as Form).Invoke((MethodInvoker)delegate()
            {
                MessageBox.Show("Condition Error");
            });
            PanelsHelper.breakPointPanel.Invoke((MethodInvoker)delegate()
            {
                PanelsHelper.breakPointPanel.Show();
            });
        }

        /// <summary>
        /// 
        /// </summary>
        void fdbWrapper_ExceptionEvent(object sender)
        {
            targetHwnd = IntPtr.Zero;
            Process[] allProcesses = Process.GetProcessesByName(processname);
            foreach (Process oneProcess in allProcesses)
            {
                targetProcess = oneProcess;
            }
            Util.EnumWindows(new Util.EnumerateWindowsCallback(EnumerateWindows), 0);
            if (targetHwnd == IntPtr.Zero)
            {
                return;
            }
            Util.SetForegroundWindow(targetHwnd);
            UpdateMenuState(FdbState.WAIT);
        }

        /// <summary>
        /// 
        /// </summary>
        private void fdbWrapper_PauseEvent(Object sender)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate()
                {
                    fdbWrapper_PauseEvent(sender);
                });
                return;
            }

            UpdateMenuState(fdbWrapper.State);
            (PluginBase.MainForm as Form).Activate();
        }

        /// <summary>
        /// 
        /// </summary>
        private void fdbWrapper_TraceEvent(Object sender, String trace)
        {
            Int32 p = trace.IndexOf(']');
            if (p > 0) TraceManager.AddAsync(trace.Substring(p + 1).TrimStart(), 1);
            else TraceManager.AddAsync(trace, 1);
        }

        /// <summary>
        /// 
        /// </summary>
        private void fdbWrapper_StopEvent(Object sender)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate()
                {
                    fdbWrapper_StopEvent(sender);
                });
                return;
            }

            ScintillaHelper.RemoveHighlights(ScintillaHelper.GetScintillaControl(CurrentDebugPostion.fullpath));
            UpdateMenuState(FdbState.INIT);

            PanelsHelper.pluginUI.TreeControl.Nodes.Clear();

            PanelsHelper.stackframeUI.ClearItem();

            //Close window(AIR)
            if (adlProcess != null && !adlProcess.HasExited)
            {
                adlProcess.CloseMainWindow();
                adlProcess.WaitForExit();
                adlProcess = null;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void fdbWrapper_LocalValuesEvent(Object sender, FdbMsg e)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate()
                {
                    fdbWrapper_LocalValuesEvent(sender, e);
                });
                return;
            }

            DataTreeControl treeControl = PanelsHelper.pluginUI.TreeControl;

            treeControl.Tree.BeginUpdate();
            try
            {
                if (treeControl.Nodes.Count == 0)
                {
                    foreach (String data in e.output)
                    {
                        Match m = null;
                        if ((m = RegexManager.RegexNameValue.Match(data)).Success)
                        {
                            treeControl.AddRootNode(new DataNode(m.Groups["name"].Value.Trim(), m.Groups["value"].Value.Trim()));
                        }
                    }
                }
                else
                {
                    foreach (String data in e.output)
                    {
                        Match m;
                        if ((m = RegexManager.RegexNameValue.Match(data)).Success)
                        {
                            String name = m.Groups["name"].Value.Trim();
                            name = name.TrimEnd(chTrims);
                            String value = m.Groups["value"].Value.Trim();
                            DataNode node = treeControl.GetNode(name);//.Value = value;
                            if (node != null)
                            {
                                if (node.Nodes.Count == 0 && node.IsLeaf && RegexManager.RegexObject.IsMatch(value))
                                {
                                    node.Parent.Nodes.Insert(node.Index, new DataNode(name, value));
                                    node.Parent.Nodes.Remove(node);
                                }
                                else node.Value = value;
                            }
                        }
                    }
                }
            }
            finally
            {
                treeControl.Tree.EndUpdate();
            }
            UpdateMenuState(fdbWrapper.State);
        }

        /// <summary>
        /// 
        /// </summary>
        private void fdbWrapper_ContinueEvent(Object sender, FdbMsg e)
        {
            if ((PluginBase.MainForm as Form).InvokeRequired)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate()
                {
                    fdbWrapper_ContinueEvent(sender, e);
                });
                return;
            }

            if (e.ismove)
                PanelsHelper.pluginUI.TreeControl.Nodes.Clear();

            ScintillaControl sci = ScintillaHelper.GetScintillaControl(e.filefillpath);
            if (sci == null)
            {
                PluginBase.MainForm.OpenEditableDocument(e.filefillpath);
                sci = ScintillaHelper.GetScintillaControl(e.filefillpath);
            }

            CurrentDebugPostion.fullpath = e.filefillpath;
            Int32 i = ScintillaHelper.GetScintillaControlIndex(sci);
            PluginBase.MainForm.Documents[i].Activate();
            Int32 line = e.line - 1;
            sci.GotoLine(line);
            ScintillaHelper.AddHighlights(sci, line);

            (PluginBase.MainForm as Form).Activate();
        }

        #endregion

        #region process management

        private static Process targetProcess = null;
        private static IntPtr targetHwnd = IntPtr.Zero;

        /// <summary>
        /// find player exception dialog
        /// </summary>
        public static int EnumerateWindows(IntPtr hWnd, int lParam)
        {
            uint procId = 0;
            uint result = Util.GetWindowThreadProcessId(hWnd, out procId);
            if (procId == targetProcess.Id)
            {
                StringBuilder sb = new StringBuilder(0x1000);
                if (Util.GetWindowText(hWnd, sb, 0x1000) != 0)
                {
                    if (sb.ToString().Contains("Adobe Flash Player"))
                    {
                        targetHwnd = hWnd;
                        return 0;
                    }
                }
            }
            return 1;
        }

        #endregion

        #region MenuItem Event Handling

        /// <summary>
        /// 
        /// </summary>
        internal void Stop_Click(Object sender, EventArgs e)
        {
            LiveDataTip.dataTip.Hide();

            fdbWrapper.PushCommand = "Stop";
            fdbWrapper.Stop(processname, PluginMain.settingObject.AlwaysCheckDebugStop);
            FdbPluginTrace.TraceInfo("Stop() fdbWrapper.Stop; end");
        }

        /// <summary>
        /// 
        /// </summary>
        internal void Next_Click(Object sender, EventArgs e)
        {
            if (fdbWrapper.State == FdbState.EXCEPTION)
            {
                FdbPluginTrace.TraceInfo("Next() fdbWrapper.ExceptionContinue(); start");
                //fdbWrapper.ExceptionContinue();
                fdbWrapper.PushCommand = "ExceptionContinue";
                FdbPluginTrace.TraceInfo("Next() fdbWrapper.ExceptionContinue(); end");
            }
            else
            {
                UpdateMenuState(FdbState.NEXT);
                ScintillaHelper.RemoveHighlights(ScintillaHelper.GetScintillaControl(CurrentDebugPostion.fullpath));
                //fdbWrapper.Next();
                fdbWrapper.PushCommand = "Next";
            }
        }

        /// <summary>
        /// 
        /// </summary>
        internal void Step_Click(Object sender, EventArgs e)
        {
            try
            {
                if (fdbWrapper.State == FdbState.EXCEPTION)
                {
                    FdbPluginTrace.TraceInfo("Step() fdbWrapper.ExceptionContinue(); start");
                    //fdbWrapper.ExceptionContinue();
                    fdbWrapper.PushCommand = "ExceptionContinue";
                    FdbPluginTrace.TraceInfo("Step() fdbWrapper.ExceptionContinue(); end");
                }
                else
                {
                    UpdateMenuState(FdbState.STEP);
                    ScintillaHelper.RemoveHighlights(ScintillaHelper.GetScintillaControl(CurrentDebugPostion.fullpath));
                    //fdbWrapper.Step();
                    fdbWrapper.PushCommand = "Step";
                }
            }
            catch (SourceNotFoundException ex)
            {
                MessageBox.Show(ex.Message);
                UpdateMenuState(FdbState.BREAK);

                ITabbedDocument doc = ScintillaHelper.GetDocument(ex.PreFileFullPath);
                if (doc != null)
                {
                    ScintillaControl sci = doc.SciControl;
                    ScintillaHelper.AddHighlights(sci, ex.PreLine - 1);
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        internal void Continue_Click(Object sender, EventArgs e)
        {
            try
            {
                if (fdbWrapper.State == FdbState.EXCEPTION)
                {
                    FdbPluginTrace.TraceInfo("Continue() fdbWrapper.ExceptionContinue(); start");
                    //fdbWrapper.ExceptionContinue();
                    fdbWrapper.PushCommand = "ExceptionContinue";
                    FdbPluginTrace.TraceInfo("Continue() fdbWrapper.ExceptionContinue(); end");
                }
                else
                {
                    //break
                    UpdateMenuState(FdbState.CONTINUE);
                    ScintillaHelper.RemoveHighlights(ScintillaHelper.GetScintillaControl(CurrentDebugPostion.fullpath));
                    //fdbWrapper.Continue();
                    fdbWrapper.PushCommand = "Continue";
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        internal void Pause_Click(Object sender, EventArgs e)
        {
            UpdateMenuState(FdbState.WAIT);
            ScintillaHelper.RemoveHighlights(ScintillaHelper.GetScintillaControl(CurrentDebugPostion.fullpath));
            FdbPluginTrace.TraceInfo("Pause() fdbWrapper.Pause();");
            fdbWrapper.Pause();
            //fdbWrapper.PushCommand = "Pause";
        }

        /// <summary>
        /// 
        /// </summary>
        internal void Killfdb_Click(Object sender, EventArgs e)
        {
            fdbWrapper.Cleanup();
        }

        internal void Finish_Click(Object sender, EventArgs e)
        {
            UpdateMenuState(FdbState.CONTINUE);
            ScintillaHelper.RemoveHighlights(ScintillaHelper.GetScintillaControl(CurrentDebugPostion.fullpath));
            FdbPluginTrace.TraceInfo("Finish() fdbWrapper.Pause();");
            //fdbWrapper.Finish();
            fdbWrapper.PushCommand = "Finish";
        }

        #endregion

    }
}
