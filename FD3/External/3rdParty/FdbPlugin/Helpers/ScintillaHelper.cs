using System;
using System.Collections.Generic;
using ScintillaNet;
using PluginCore;
using PluginCore.Utilities;
using System.IO;

namespace FdbPlugin
{
    public class ScintillaHelper
    {
        public const int markerNumBreakPoint = 1;
        public const int markerNumBreakPointEnable = 3;
        public const int markerNumBreakPointDisable = 4;

        #region scintilla events

        /// <summary>
        /// 
        /// </summary>
        static public void AddSciEvent(String value)
        {
            ScintillaControl sci = GetScintillaControl(value);
            sci.ModEventMask |= (Int32)ScintillaNet.Enums.ModificationFlags.ChangeMarker;
            sci.MarkerChanged += new MarkerChangedHandler(SciControl_MarkerChanged);

            sci.MarkerSetBack(markerNumBreakPointEnable, DataConverter.ColorToInt32(PluginMain.settingObject.BreakPointEnableLineColor)); //enable
            sci.MarkerSetBack(markerNumBreakPointDisable, DataConverter.ColorToInt32(PluginMain.settingObject.BrekPointDisableLineColor)); //dis

            sci.Modified += new ModifiedHandler(sci_Modified);
        }

        static public void sci_Modified(ScintillaControl sender, int position, int modificationType, string text, int length, int linesAdded, int line, int foldLevelNow, int foldLevelPrev)
        {
            if (linesAdded != 0)
            {
                int modline = sender.LineFromPosition(position);
                PluginMain.breakPointManager.UpDateBreakPoint(sender.FileName, modline, linesAdded);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        static public void SciControl_MarkerChanged(ScintillaControl sender, Int32 line)
        {
            if (line < 0) return;

            Boolean breakPointMark = IsMarker(sender, markerNumBreakPoint, line);
            if ((breakPointMark)
                || (!breakPointMark && PluginMain.breakPointManager.IsContainBrekPoint(sender.FileName, line)))
            {
                Boolean enable = !IsMarker(sender, markerNumBreakPointDisable, line);

                if (PluginMain.debugManager.FdbWrapper.IsDebugStart)
                {
                    PluginMain.breakPointManager.SetBreakPointInfoInDeubg(sender.FileName, line, !breakPointMark, enable);
                }
                else
                {
                    PluginMain.breakPointManager.SetBreakPointInfo(sender.FileName, line, !breakPointMark, enable);
                }
            }

            if (breakPointMark)
            {
                if (!IsMarker(sender, markerNumBreakPointEnable, line))
                    sender.MarkerAdd(line, markerNumBreakPointEnable);
            }
            else
            {
                if (IsMarker(sender, markerNumBreakPointEnable, line))
                {
                    sender.MarkerDelete(line, markerNumBreakPointEnable);
                }
                if (IsMarker(sender, markerNumBreakPointDisable, line))
                {
                    sender.MarkerDelete(line, markerNumBreakPointDisable);
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        static public void RemoveSciEvent(String value)
        {
            ScintillaControl sci = GetScintillaControl(Path.GetFileName(value));
            sci.ModEventMask |= (Int32)ScintillaNet.Enums.ModificationFlags.ChangeMarker;
            sci.MarkerChanged -= new MarkerChangedHandler(SciControl_MarkerChanged);
        }

        #endregion

        #region helper methods

        /// <summary>
        /// 
        /// </summary>
        static public void ToggleMarker(ScintillaControl sci, Int32 marker, Int32 line)
        {
            Int32 lineMask = sci.MarkerGet(line);
            if ((lineMask & GetMarkerMask(marker)) == 0)
                sci.MarkerAdd(line, marker);
            else
                sci.MarkerDelete(line, marker);
        }

        static public Boolean IsBreakPointEnable(ScintillaControl sci, Int32 line)
        {
            Int32 lineMask = sci.MarkerGet(line);
            return (lineMask & GetMarkerMask(markerNumBreakPoint)) != 0 ? true : false;
        }

        static public Boolean IsMarker(ScintillaControl sci, Int32 marker, Int32 line)
        {
            Int32 lineMask = sci.MarkerGet(line);
            return (lineMask & GetMarkerMask(marker)) != 0 ? true : false;
        }

        /// <summary>
        /// 
        /// </summary>
        static public Int32 GetMarkerMask(Int32 marker)
        {
            return 1 << marker;
        }

        #endregion

        #region highlighting

        /// <summary>
        /// 
        /// </summary>
        static public void AddHighlights(ScintillaControl sci, Int32 line)
        {
            Int32 start = sci.PositionFromLine(line);
            Int32 end = start + sci.LineLength(line);
            Int32 position = start;
            Int32 es = sci.EndStyled;
            Int32 mask = 1 << sci.StyleBits;
            sci.SetIndicStyle(0, (Int32)ScintillaNet.Enums.IndicatorStyle.Max);
            sci.SetIndicFore(0, DataConverter.ColorToInt32(PluginMain.settingObject.DebugLineColor));
            sci.StartStyling(position, mask);
            sci.SetStyling(end - start, mask);
            sci.StartStyling(es, mask - 1);
        }

        /// <summary>
        /// 
        /// </summary>
        static public void RemoveHighlights(ScintillaControl sci)
        {
            if (sci == null) return;
            Int32 es = sci.EndStyled;
            Int32 mask = (1 << sci.StyleBits);
            sci.StartStyling(0, mask);
            sci.SetStyling(sci.TextLength, 0);
            sci.StartStyling(es, mask - 1);
        }

        #endregion

        #region active document management

        /// <summary>
        /// 
        /// </summary>
        static public ScintillaControl GetScintillaControl(string name)
        {
            ITabbedDocument[] documents = PluginBase.MainForm.Documents;
            foreach (ITabbedDocument docment in documents)
            {
                ScintillaControl sci = docment.SciControl;
                if (sci != null && name == sci.FileName) return sci;
            }
            return null;
        }

        /// <summary>
        /// 
        /// </summary>
        static public Int32 GetScintillaControlIndex(ScintillaControl sci)
        {
            ITabbedDocument[] documents = PluginBase.MainForm.Documents;
            for (Int32 i = 0; i < documents.Length; i++)
            {
                if (documents[i].SciControl == sci) return i;
            }
            return -1;
        }

        static public ITabbedDocument GetDocument(string filefullpath)
        {
            ITabbedDocument[] documents = PluginBase.MainForm.Documents;
            foreach (ITabbedDocument docment in documents)
            {
                ScintillaControl sci = docment.SciControl;
                if (sci != null && filefullpath == sci.FileName) return docment;
            }

            return null;
        }

        static public void ActiveDocument(string filefullpath)
        {
            ActiveDocument(filefullpath, -1, false);
        }

        static public void ActiveDocument(string filefullpath, int line, Boolean selectline)
        {
            ScintillaControl sci = GetScintillaControl(filefullpath);
            if (sci == null)
            {
                PluginBase.MainForm.OpenEditableDocument(filefullpath);
                sci = GetScintillaControl(filefullpath);
            }

            CurrentDebugPostion.fullpath = filefullpath;
            Int32 i = GetScintillaControlIndex(sci);
            PluginBase.MainForm.Documents[i].Activate();
            if (line >= 0)
            {
                sci.GotoLine(line);
                if (selectline)
                {
                    Int32 start = sci.PositionFromLine(line);
                    Int32 end = start + sci.LineLength(line);
                    sci.SelectionStart = start;
                    sci.SelectionEnd = end;
                }
            }
        }

        #endregion

        #region breakpoints management

        static internal void ToggleBreakPoint_Click(Object sender, EventArgs e)
        {
            ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
            int line = sci.LineFromPosition(sci.CurrentPos);
            ScintillaHelper.ToggleMarker(sci, ScintillaHelper.markerNumBreakPoint, line);
        }

        static internal void DeleteAllBreakPoints_Click(Object sender, EventArgs e)
        {
            foreach (ITabbedDocument doc in PluginBase.MainForm.Documents)
            {
                doc.SciControl.MarkerDeleteAll(markerNumBreakPoint);
                doc.SciControl.MarkerDeleteAll(markerNumBreakPointDisable);
                doc.SciControl.MarkerDeleteAll(markerNumBreakPointEnable);
            }
            PluginMain.breakPointManager.ClearAll();
            PanelsHelper.breakPointUI.Clear();
        }

        static internal void ToggleBreakPointEnable_Click(Object sender, EventArgs e)
        {
            ScintillaControl sci = PluginBase.MainForm.CurrentDocument.SciControl;
            Int32 line = sci.LineFromPosition(sci.CurrentPos);

            if (IsMarker(sci, markerNumBreakPointEnable, line))
            {
                ToggleMarker(sci, markerNumBreakPointDisable, line);
            }
        }

        static internal void DisableAllBreakPoints_Click(Object sender, EventArgs e)
        {
            foreach (ITabbedDocument doc in PluginBase.MainForm.Documents)
            {
                List<int> list = PluginMain.breakPointManager.GetMarkers(doc.SciControl, markerNumBreakPoint);
                foreach (int line in list)
                {
                    doc.SciControl.MarkerAdd(line, markerNumBreakPointDisable);
                }
            }

            PluginMain.breakPointManager.DisableAllBreakPoints(PluginMain.debugManager.FdbWrapper.IsDebugStart);
        }

        static internal void EnableAllBreakPoints_Click(Object sender, EventArgs e)
        {
            foreach (ITabbedDocument doc in PluginBase.MainForm.Documents)
            {
                List<int> list = PluginMain.breakPointManager.GetMarkers(doc.SciControl, markerNumBreakPoint);
                foreach (int line in list)
                {
                    if (IsMarker(doc.SciControl, markerNumBreakPointDisable, line))
                    {
                        ToggleMarker(doc.SciControl, markerNumBreakPointDisable, line);
                    }
                }
            }

            PluginMain.breakPointManager.EnableAllBreakPoints(PluginMain.debugManager.FdbWrapper.IsDebugStart);
        }
        
        #endregion

        
    }
}
