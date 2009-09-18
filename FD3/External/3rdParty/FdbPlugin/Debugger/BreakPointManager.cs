using System;
using System.Collections.Generic;
using System.Text;
using ScintillaNet;
using System.Xml.Serialization;
using System.IO;
using PluginCore;
using PluginCore.Helpers;
using PluginCore.Utilities;

namespace FdbPlugin
{
    public delegate void ChangeBreakPointEventHandler(object sender, BreakPointArgs e);
    public delegate void UpDateBreakPointEventHandler(object sender, UpDateBreakPointArgs e);
    public delegate void ConditionErrorEventHandler(object sender, BreakPointArgs e);

    public class BreakPointManager
    {
        private List<BreakPointInfo> breakPointList = new List<BreakPointInfo>();
        private Dictionary<string, BreakPointInfo> ChangeBreakPointDic = new Dictionary<string, BreakPointInfo>();

        private List<BreakPointCondition> breakPointConditionList = new List<BreakPointCondition>();

        private List<string> srcFileList = new List<string>();

        private IProject project;
        private string saveFileFullPath;

        Boolean isAccess = true;
   
        public event ChangeBreakPointEventHandler ChangeBreakPointEvent = null;
        public event UpDateBreakPointEventHandler UpDateBreakPointEvent = null;
        public event ConditionErrorEventHandler ConditionErrorEvent = null;

        public IProject Project
        {
            get { return project; }
            set 
            {
                if (value == null)
                {
                }
                else
                {
                    project = value;
                    this.ClearAll();
                    saveFileFullPath = GetBreakpointsFile(project.ProjectPath);
                }
            }
        }

        private string GetBreakpointsFile(string path)
        {
            string pluginDir = Path.Combine(PathHelper.DataDir, "FdbPlugin");
            string cacheDir = Path.Combine(pluginDir, "Breakpoints");
            string hashFileName = HashCalculator.CalculateSHA1(path);
            return Path.Combine(cacheDir, hashFileName + ".xml");
        }

        public void InitBreakPoints()
        {
            foreach (PluginCore.ITabbedDocument doc in PluginBase.MainForm.Documents)
            {
                if (Path.GetExtension(doc.SciControl.FileName) == ".as"
                    || Path.GetExtension(doc.SciControl.FileName) == ".mxml")
                {
                    List<int> lines = GetMarkers(doc.SciControl, 1);

                    BreakPointInfo cbinfo = breakPointList.Find(delegate(BreakPointInfo info)
                    {
                        return info.FileFullPath == doc.FileName;
                    });
                    string exp = string.Empty;
                    if (cbinfo != null)
                    {
                        exp = cbinfo.Exp;
                        breakPointList.Remove(cbinfo);
                    }

                    foreach (int i in lines)
                    {
                        breakPointList.Add(new BreakPointInfo(doc.SciControl.FileName, i, exp, false, true));
                    }
                }
            }
        }

        public void ClearAll()
        {
            breakPointList.Clear();
            ChangeBreakPointDic.Clear();
            ClearConditionError();
            ClearBreakPointConditionList();
        }

        private void ChangeAllBreakPointState(Boolean Enable)
        {
            foreach (BreakPointInfo info in breakPointList)
            {
                if (info.Enable != Enable)
                {
                    info.Enable = Enable;
                    if (ChangeBreakPointEvent != null)
                    {
                        ChangeBreakPointEvent(this, new BreakPointArgs(info.FileFullPath, info.Line, info.Exp, info.IsDelete, info.Enable));
                    }
                }
            }
        }

        private void ChangeAllBreakPointStateInDebug(Boolean Enable)
        {
            foreach (BreakPointInfo info in breakPointList)
            {
                if (info.Enable != Enable)
                {
                    if (ChangeBreakPointDic.ContainsKey(info.FileFullPath + info.Line.ToString()))
                    {
                        ChangeBreakPointDic[info.FileFullPath + info.Line.ToString()].Enable = Enable;
                    }
                    else
                    {
                        ChangeBreakPointDic.Add(info.FileFullPath + info.Line.ToString(),
                            new BreakPointInfo(info.FileFullPath, info.Line, info.Exp, info.IsDelete, Enable));
                    }

                    if (ChangeBreakPointEvent != null)
                    {
                        ChangeBreakPointEvent(this, new BreakPointArgs(info.FileFullPath, info.Line, info.Exp, info.IsDelete, Enable));
                    }
                }
            }
        }

        public void DisableAllBreakPoints(Boolean isDebugStart)
        {
            if(isDebugStart)
                ChangeAllBreakPointStateInDebug(false);
            else
                ChangeAllBreakPointState(false);
        }

        public void EnableAllBreakPoints(Boolean isDebugStart)
        {
            if (isDebugStart)
                ChangeAllBreakPointStateInDebug(true);
            else
                ChangeAllBreakPointState(true);
        }

        public List<Int32> GetMarkers(ScintillaControl sci, int markerNum)
        {
            Int32 line = 0;
            Int32 maxLine = 0;
            List<Int32> markerLines = new List<Int32>();
            while (true)
            {
                int i = sci.MarkerNext(line, GetMarkerMask(markerNum));
                if ((sci.MarkerNext(line, GetMarkerMask(markerNum)) == -1) || (line > sci.LineCount)) break;
                line = sci.MarkerNext(line, GetMarkerMask(markerNum));
                markerLines.Add(line);
                maxLine = Math.Max(maxLine, line);
                line++;
            }
            return markerLines;
        }
        private static Int32 GetMarkerMask(Int32 marker)
        {
            return 1 << marker;
        }

        public Boolean IsContainBrekPoint(string filefullpath, int line)
        {
            int index = breakPointList.FindIndex(delegate(BreakPointInfo info)
            {
                return (info.FileFullPath == filefullpath) && (info.Line == line);
            });

            return index < 0 ? false : true;
        }

        public void SetSrcFileList(string[] files)
        {
            srcFileList.Clear();
            srcFileList.AddRange(files);
        }

        public void SetBreakPointsToEditor(PluginCore.ITabbedDocument[] documents)
        {
            isAccess = false;

            for (int i = 0; i < documents.Length; i++)
            {
                ScintillaControl sci = documents[i].SciControl;
                if (sci == null)
                    continue;

                if (Path.GetExtension(sci.FileName) == ".as"
                    || Path.GetExtension(sci.FileName) == ".mxml")
                {
                    foreach (BreakPointInfo info in breakPointList)
                    {
                        if (info.FileFullPath == sci.FileName)
                        {
                            sci.MarkerAdd(info.Line, 1);
                            if (!info.Enable)
                            {
                                sci.MarkerAdd(info.Line, 4);
                            }
                        }
                    }
                }
            }

            isAccess = true;
        }

        public void SetBreakPointsToEditor(string filefullpath)
        {
            isAccess = false;

            PluginCore.ITabbedDocument[] documents = PluginBase.MainForm.Documents;
            for (int i = 0; i < documents.Length; i++)
            {
                ScintillaControl sci = documents[i].SciControl;
                if (sci == null)
                    continue;

                if (sci.FileName == filefullpath)
                {
                    foreach (BreakPointInfo info in breakPointList)
                    {
                        if (info.FileFullPath == sci.FileName)
                        {
                            sci.MarkerAdd(info.Line, 1);
                            if (!info.Enable)
                            {
                                sci.MarkerAdd(info.Line, 4);
                            }
                        }
                    }
                    break;
                }
            }

            isAccess = true;
        }

        internal void SetBreakPointInfo(string filefullpath, int line, Boolean isdelete, Boolean enable)
        {
            if (!isAccess) return;

            BreakPointInfo cbinfo = breakPointList.Find(delegate(BreakPointInfo info)
            {
                return (info.FileFullPath == filefullpath) & (info.Line == line);
            });
            string exp = string.Empty;
            if (cbinfo != null)
            {
                exp = cbinfo.Exp;
                breakPointList.Remove(cbinfo);
            }
            if (!isdelete)
            {
                breakPointList.Add(new BreakPointInfo(filefullpath, line, exp, isdelete, enable));
            }

            if (ChangeBreakPointEvent != null)
            {
                ChangeBreakPointEvent(this, new BreakPointArgs(filefullpath, line, exp, isdelete, enable));
            }
            
        }

        public void SetBreakPointInfoInDeubg(string filename, int line, Boolean isdelete, Boolean enable)
        {
            if (!isAccess) return;

            string exp = string.Empty;
            if (ChangeBreakPointDic.ContainsKey(filename + line.ToString()))
            {
                exp = ChangeBreakPointDic[filename + line.ToString()].Exp;
                ChangeBreakPointDic[filename + line.ToString()].IsDelete = isdelete;
                ChangeBreakPointDic[filename + line.ToString()].Enable = enable;
            }
            else
            {
                ChangeBreakPointDic.Add(filename + line.ToString(), new BreakPointInfo(filename, line, exp, isdelete, enable));
            }

            if (ChangeBreakPointEvent != null)
            {
                ChangeBreakPointEvent(this, new BreakPointArgs(filename, line, exp, isdelete, enable));
            }
        }

        public void GetBreakPoints(out List<BreakPointInfo> breakPoints, out List<BreakPointCondition> conditions)
        {
            breakPoints = new List<BreakPointInfo>();
            conditions = new List<BreakPointCondition>();

            foreach (BreakPointInfo info in breakPointList)
            {
                int index = srcFileList.FindIndex(delegate(string path)
                {
                    return path == info.FileFullPath;
                });
                if (info.Enable && index >= 0)
                {
                    breakPoints.Add(new BreakPointInfo(info.FileFullPath, info.Line + 1, info.Exp, info.IsDelete, info.Enable));
                    
                    if(info.Exp != string.Empty)
                        conditions.Add(new BreakPointCondition(info.FileFullPath, info.Line + 1, info.Exp));
                }
            }
            breakPointConditionList.Clear();
        }

        public void GetChangedBreakPoint(out List<BreakPointInfo> changedBreakPointList, out List<BreakPointCondition> changedConditionList)
        {
            changedBreakPointList = new List<BreakPointInfo>();
            foreach (BreakPointInfo val in ChangeBreakPointDic.Values)
            {
                int index = srcFileList.FindIndex(delegate(string path)
                {
                    return path == val.FileFullPath;
                });
                if (index < 0) continue;

                BreakPointInfo cbinfo = breakPointList.Find(delegate(BreakPointInfo info)
                {
                    return info.FileFullPath == val.FileFullPath && info.Line == val.Line;
                });
                if (cbinfo != null)
                {
                    if (val.IsDelete)
                    {
                        changedBreakPointList.Add(new BreakPointInfo(val.FileFullPath, val.Line + 1, val.Exp, val.IsDelete, val.Enable));
                        breakPointList.Remove(cbinfo);
                    }
                    else //if (!val.Enable)
                    {
                        changedBreakPointList.Add(new BreakPointInfo(val.FileFullPath, val.Line + 1, val.Exp, val.IsDelete, val.Enable));
                    }
                }
                else
                {
                    if (!val.IsDelete && val.Enable)
                    {
                        changedBreakPointList.Add(new BreakPointInfo(val.FileFullPath, val.Line + 1, val.Exp, val.IsDelete, val.Enable));
                        breakPointList.Add(new BreakPointInfo(val.FileFullPath, val.Line, val.Exp, val.IsDelete, val.Enable));
                    }
                }
            }
            ChangeBreakPointDic.Clear();

            changedConditionList = new List<BreakPointCondition>();
            foreach (BreakPointInfo info in breakPointList)
            {
                BreakPointCondition condition = breakPointConditionList.Find(delegate(BreakPointCondition cond)
                {
                    return cond.FileFullPath == info.FileFullPath && cond.Line == info.Line;
                });

                if (condition != null)
                {
                    changedConditionList.Add(new BreakPointCondition(info.FileFullPath, info.Line + 1, condition.Exp));
                }
            }
            breakPointConditionList.Clear();
        }

        internal void ConditionError(string filefullpath, int line)
        {
            if (ConditionErrorEvent != null)
            {
                BreakPointInfo binfo = breakPointList.Find(delegate(BreakPointInfo info)
                {
                    return (info.FileFullPath == filefullpath) && (info.Line == line);
                });
                if(binfo != null)
                {
                    ConditionErrorEvent(this, new BreakPointArgs(binfo.FileFullPath, binfo.Line, binfo.Exp, binfo.IsDelete, binfo.Enable));
                }
            }
        }

        internal Boolean IsConditionError
        {
            get { return errorlist.Count == 0 ? false : true; }
        }

        internal BreakPointCondition[] GetErrorsArray()
        {
           return errorlist.ToArray();
        }
        List<BreakPointCondition> errorlist = new List<BreakPointCondition>();
        internal void AddConditionError(string filefullpath, int line)
        {
            errorlist.Add(new BreakPointCondition(filefullpath, line-1, ""));
        }

        internal void ClearConditionError()
        {
            errorlist.Clear();
        }

        internal void ClearBreakPointConditionList()
        {
            breakPointConditionList.Clear();
        }

        internal void AddBreakPointCondition(string filefullpath, int line, string exp)
        {

            int index = breakPointConditionList.FindIndex(delegate(BreakPointCondition cond)
            {
                return cond.FileFullPath == filefullpath && cond.Line == line;
            });

            if (index >=0)
            {
                breakPointConditionList[index].Exp = exp;
            }
            else if(exp != string.Empty)
            {
                breakPointConditionList.Add(new BreakPointCondition(filefullpath, line, exp));
            }

            index = breakPointList.FindIndex(delegate(BreakPointInfo info)
            {
                return info.FileFullPath == filefullpath && info.Line == line;
            });
            if (index >= 0)
            {
                breakPointList[index].Exp = exp;
            }
        }

        internal void RemoveBreakPointCondition(string filefullpath, int line)
        {

            BreakPointCondition condition = breakPointConditionList.Find(delegate(BreakPointCondition cond)
            {
                return cond.FileFullPath == filefullpath && cond.Line == line;
            });

            if (condition != null)
            {
                condition.Exp = string.Empty;
            }
        }

        internal void CheckBreakPoint()
        {
            if (srcFileList.Count == 0) return;

            List<string> list = new List<string>();
            foreach (BreakPointInfo info in breakPointList)
            {
                if (!srcFileList.Contains(info.FileFullPath))
                {
                    list.Add(info.FileFullPath);
                }
            }
            foreach (string fullpath in list)
            {
                breakPointList.RemoveAll(delegate(BreakPointInfo info)
                {
                    return info.FileFullPath == fullpath;
                });
            }
        }

        public void UpDateBreakPoint(string filefullpath, int line, int linesAdded)
        {
            foreach (BreakPointInfo info in breakPointList)
            {
                if (info.FileFullPath == filefullpath
                    && info.Line > line)
                {
                    int oldline = info.Line; 
                    info.Line += linesAdded;
                    if (ChangeBreakPointEvent != null)
                    {
                        UpDateBreakPointEvent(this, new UpDateBreakPointArgs(info.FileFullPath, oldline+1, info.Line+1));
                    }
                }
            }
        }

        public void Save()
        {
            if (project != null)
            {
                Uri u1 = new Uri(project.ProjectPath);
                foreach (BreakPointInfo info in breakPointList)
                {
                    Uri u2 = new Uri(u1, info.FileFullPath);
                    info.FileFullPath = u1.MakeRelativeUri(u2).ToString();
                }
                Util.SerializeXML<List<BreakPointInfo>>.SaveFile(saveFileFullPath, breakPointList);
            }
        }

        public void Load()
        {
            if (File.Exists(saveFileFullPath))
            {
                breakPointList = Util.SerializeXML<List<BreakPointInfo>>.LoadFile(saveFileFullPath);

                Uri u1 = new Uri(project.ProjectPath);
                foreach (BreakPointInfo info in breakPointList)
                {
                    Uri u2 = new Uri(u1, info.FileFullPath);
                    info.FileFullPath = u2.LocalPath;
                    if (ChangeBreakPointEvent != null)
                    {
                        ChangeBreakPointEvent(this, new BreakPointArgs(info.FileFullPath, info.Line, info.Exp, info.IsDelete, info.Enable));
                    }
                }
            }
        }
    }

    #region internal models

    public class BreakPointArgs : EventArgs
    {
        public string FileFullPath;
        public int Line;
        public string Exp;
        public Boolean IsDelete;
        public Boolean Enable;

        public BreakPointArgs(string filefullpath, int line, string exp, Boolean isdelete, Boolean enable)
        {
            FileFullPath = filefullpath;
            Line = line;
            Exp = exp;
            IsDelete = isdelete;
            Enable = enable;
        }
    }

    public class UpDateBreakPointArgs : EventArgs
    {
        public string FileFullPath;
        public int OldLine;
        public int NewLine;

        public UpDateBreakPointArgs(string filefullpath, int oldline, int newline)
        {
            FileFullPath = filefullpath;
            OldLine = oldline;
            NewLine = newline;
        }
    }

    public class BreakPointInfo
    {
        private string fileFullPath;
        private int line;
        private Boolean isdelete;
        private Boolean enable;
        private string exp;

        public string FileFullPath
        {
            get { return fileFullPath; }
            set { fileFullPath = value; }
        }
        public int Line
        {
            get { return line; }
            set { line = value; }
        }
        public Boolean IsDelete
        {
            get { return isdelete; }
            set { isdelete = value; }
        }
        public Boolean Enable
        {
            get { return enable; }
            set { enable = value; }
        }
        public string Exp
        {
            get { return exp; }
            set { exp = value; }
        }

        public BreakPointInfo()
        {
        }

        public BreakPointInfo(string fileFullPath, int line, string exp, Boolean isdelete, Boolean enable)
        {
            this.fileFullPath = fileFullPath;
            this.line = line;
            this.exp = exp;
            this.isdelete = isdelete;
            this.enable = enable;
        }
    }

    public class BreakPointCondition
    {
        private string breakpointNum;
        private string fileFullPath;
        private int line;
        private string exp;

        public string BreakPointNum
        {
            get { return breakpointNum; }
            set { breakpointNum = value; }
        }
        public string FileFullPath
        {
            get { return fileFullPath; }
            set { fileFullPath = value; }
        }
        public int Line
        {
            get { return line; }
            set { line = value; }
        }
        public string Exp
        {
            get { return exp; }
            set { exp = value; }
        }

        public BreakPointCondition()
        {
        }

        public BreakPointCondition(string fileFullPath, int line, string exp)
        {
            this.fileFullPath = fileFullPath;
            this.line = line;
            this.exp = exp;
        }
        public BreakPointCondition(string breakpointNum, string fileFullPath, int line, string exp)
        {
            this.breakpointNum = breakpointNum;
            this.fileFullPath = fileFullPath;
            this.line = line;
            this.exp = exp;
        }
    }

    #endregion
}
