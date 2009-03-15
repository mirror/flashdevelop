using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

namespace FdbPlugin
{
    #region public models

    public enum FdbState
    {
        INIT,
        START,
        PRELOAD,
        STOP,
        PAUSE,
        PAUSE_SET_BREAKPOINT,
        CONTINUE,
        BREAK,
        STEP,
        NEXT,
        WAIT,
        UNLOAD,
        EXCEPTION,
        CONDITIONERROR
    }

    class CurrentDebugPostion
    {
        public static string fullpath;
    }

    public class SourceNotFoundException : ApplicationException
    {
        public string CurrentFileName;
        public string PreFileFullPath;
        public int PreLine;

        private string msg;
        public SourceNotFoundException(string currentFileName, string preFileFullPath, int preLine)
        {
            CurrentFileName = currentFileName;
            PreFileFullPath = preFileFullPath;
            PreLine = preLine;

            msg = string.Format("{0} not find", currentFileName);
        }
        public override string Message
        {
            get
            {
                return msg;
            }
        }
        public override string ToString()
        {
            return msg;
        }
    }

    public class FdbMsg
    {
        public string filefillpath;
        public string filename;
        public int line;
        public List<string> output;
        public bool ismove;

        public void SetParam(string filefillpath, string filename, int line, bool ismove)
        {
            this.filefillpath = filefillpath;
            this.filename = filename;
            this.line = line;
            this.ismove = ismove;
        }
    }

    public class PrintPushArgs
    {
        public object sender;
        public string objname;
        public string[] objnames;
        public object option;

        public PrintPushArgs(object sender, string objname, object option)
        {
            this.sender = sender;
            this.objname = objname;
            this.option = option;
        }
        public PrintPushArgs(object sender, string[] objnames, object option)
        {
            this.sender = sender;
            this.objnames = objnames;
            this.option = option;
        }
    }

    public class PrintArg : EventArgs
    {
        public string valname;
        public List<string> output;
        public object option;

        public PrintArg(string valname, List<string> output)
        {
            this.valname = valname;
            this.output = new List<string>(output);
            this.option = null;
        }

        public PrintArg(string valname, List<string> output, object option)
        {
            this.valname = valname;
            this.output = new List<string>(output);
            this.option = option;
        }
    }
    
    #endregion

    #region internal models

    interface ISetData
    {
        void SetData(string name, List<string> datalist, object option);
        Control TargetControl { get; }
    }

    class FdbBreakPointInfo
    {
        private string filefullpath;
        private string filename;
        private string breakpointnum;
        private int breakpointline;

        public FdbBreakPointInfo(string filefullpath, string filename, string breakpointnum, int breakpointline)
        {
            this.filefullpath = filefullpath;
            this.filename = filename;
            this.breakpointnum = breakpointnum;
            this.breakpointline = breakpointline;
        }
        public string FileFullPath
        {
            get { return this.filefullpath; }
            set { this.filefullpath = value; }
        }
        public string Filename
        {
            get { return this.filename; }
            set { this.filename = value; }
        }
        public string BreakPointNum
        {
            get { return this.breakpointnum; }
            set { this.breakpointnum = value; }
        }
        public int BreakPoinLine
        {
            get { return this.breakpointline; }
            set { this.breakpointline = value; }
        }
    }

    class CurrentFileInfo:ICloneable
    {
        public string filefullpath;
        public string filename;
        public string function;
        public int line;

        public void SetParam(string filefullpath, string filename, string function, int line)
        {
            this.filefullpath = filefullpath;
            this.filename = filename;
            this.function = function;
            this.line = line;
        }

        public void Clear()
        {
            this.filefullpath = string.Empty;
            this.filename = string.Empty;
            this.function = string.Empty;
            this.line = 0;
        }

        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }

    class SrcFileInfo
    {
        public string num;
        public string filefullpath;
        public List<FunctionInfo> functionInfoList;

        public SrcFileInfo(string num, string filefullpath)
        {
            this.num = num;
            this.filefullpath = filefullpath;
            functionInfoList = new List<FunctionInfo>();
        }

        public void SortFunction()
        {
            functionInfoList.Sort(delegate(FunctionInfo x, FunctionInfo y)
            {
                return y.startline - x.startline;
            });
        }

        public string GetFunction(int line)
        {
            foreach (FunctionInfo info in functionInfoList)
            {
                if (info.startline <= line)
                {
                    return info.functionname;
                }
            }
            return string.Empty;
        }
    }

    class FunctionInfo
    {
        public string functionname;
        public int startline;

        public FunctionInfo(string functionname, int startline)
        {
            this.functionname = functionname;
            this.startline = startline;
        }
    }

    #endregion 
}
