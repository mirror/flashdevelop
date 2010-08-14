﻿using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;
using ASCompletion.Completion;
using ASCompletion.Context;
using FlashDevelop;
using PluginCore.Controls;
using PluginCore.Managers;
using PluginCore.Utilities;
using ScintillaNet;

namespace QuickNavigate
{
    class ControlClickManager
    {
        private Timer timer;
        private Word currentWord;
        private const int CLICK_AREA = 4; //pixels
        private POINT clickedPoint = new POINT();
        private ScintillaControl sciControl;

        #region MouseHook Definitions

        private int hHook = 0;
        private const int WH_MOUSE = 7;
        public delegate int HookProc(int nCode, IntPtr wParam, IntPtr lParam);

        // ReSharper disable InconsistentNaming

        private HookProc SafeHookProc;

        [StructLayout(LayoutKind.Sequential)]
        public class POINT
        {
            public int x;
            public int y;
        }

        [StructLayout(LayoutKind.Sequential)]
        public class MouseHookStruct
        {
            public POINT pt;
            public int hwnd;
            public int wHitTestCode;
            public int dwExtraInfo;
        }

        // ReSharper restore InconsistentNaming
        
        [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
        public static extern int SetWindowsHookEx(int idHook, HookProc lpfn, IntPtr hInstance, int threadId);

        [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
        public static extern bool UnhookWindowsHookEx(int idHook);

        [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
        public static extern int CallNextHookEx(int idHook, int nCode, IntPtr wParam, IntPtr lParam);

        #endregion

        public ControlClickManager()
        {
            timer = new Timer();
            timer.Interval = 10;
            timer.Tick += GoToDeclaration;
        }

        private void GoToDeclaration(object sender, EventArgs e)
        {
            timer.Stop();
            SetCurrentWord(null);
            ASComplete.DeclarationLookup(sciControl);
        }

        public ScintillaControl SciControl
        {
            get { return sciControl; }
            set
            {
                if (hHook == 0)
                {
                    SafeHookProc = new HookProc(MouseHookProc);
                    #pragma warning disable 618,612
                    hHook = SetWindowsHookEx(WH_MOUSE, SafeHookProc, (IntPtr)0, AppDomain.GetCurrentThreadId());
                    #pragma warning restore 618,612
                }
                sciControl = value;
            }
        }

        public int MouseHookProc(int nCode, IntPtr wParam, IntPtr lParam)
        {
            if (nCode >= 0 && sciControl != null)
            {
                MouseHookStruct hookStruct = (MouseHookStruct)Marshal.PtrToStructure(lParam, typeof(MouseHookStruct));
                if (wParam == (IntPtr) 513) // mouseDown
                {
                    clickedPoint.x = hookStruct.pt.x;
                    clickedPoint.y = hookStruct.pt.y;
                }
                if (Control.ModifierKeys ==  Keys.Control)
                {
                    if (wParam == (IntPtr) 514) // mouseUp
                    {
                        if (currentWord != null)
                        {
                            if (!timer.Enabled) timer.Start();
                        }
                    }
                    else
                    {
                        if (((Control.MouseButtons & MouseButtons.Left) > 0))
                        {
                            int dx = Math.Abs(clickedPoint.x - hookStruct.pt.x);
                            int dy = Math.Abs(clickedPoint.y - hookStruct.pt.y);
                            if (currentWord != null && dx > CLICK_AREA || dy > CLICK_AREA)
                            {
                                SetCurrentWord(null);
                            }
                        }
                        else
                        {
                            Point globalPoint = new Point(hookStruct.pt.x, hookStruct.pt.y);
                            Point localPoint = sciControl.PointToClient(globalPoint);
                            ProcessMouseMove(localPoint);
                        }
                    }
                }
                else
                {
                    if (currentWord != null) SetCurrentWord(null);
                }
            }
            return CallNextHookEx(hHook, nCode, wParam, lParam);
        }

        private void ProcessMouseMove(Point point)
        {
            int position = sciControl.PositionFromPointClose(point.X, point.Y);
            if (position < 0)
            {
                SetCurrentWord(null);
                return;
            }
            if (ASContext.Context.IsFileValid)
            {
                Word word = new Word();
                word.StartPos = sciControl.WordStartPosition(position, true);
                word.EndPos = sciControl.WordEndPosition(position, true);
                ASResult result = ASComplete.GetExpressionType(sciControl, word.EndPos);
                if (!result.IsNull()) SetCurrentWord(word);
                else SetCurrentWord(null);
            }
        }

        private void SetCurrentWord(Word word)
        {
            if (Word.Equals(word, currentWord)) return;
            if (currentWord != null) UnHighlight(currentWord);
            currentWord = word;
            if (currentWord != null) Highlight(currentWord);
        }

        private void UnHighlight(Word word)
        {
            sciControl.CursorType = -1;
            Int32 mask = 1 << sciControl.StyleBits;
            sciControl.StartStyling(word.StartPos, mask);
            sciControl.SetStyling(word.EndPos - word.StartPos, 0);
        }

        private void Highlight(Word word)
        {
            sciControl.CursorType = 8;
            Int32 mask = 1 << sciControl.StyleBits;
            ScintillaNet.Configuration.Language language = MainForm.Instance.SciConfig.GetLanguage(sciControl.ConfigurationLanguage);
            sciControl.SetIndicStyle(0, (Int32)ScintillaNet.Enums.IndicatorStyle.RoundBox);
            sciControl.SetIndicFore(0, language.editorstyle.HighlightBackColor);
            sciControl.StartStyling(word.StartPos, mask);
            sciControl.SetStyling(word.EndPos - word.StartPos, mask);
        }

    }

    class Word
    {
        public int EndPos;
        public int StartPos;

        public static bool Equals(Word word1, Word word2)
        {
            if (word1 == null && word2 == null) return true;
            if (word1 == null || word2 == null) return false;
            return word1.StartPos == word2.StartPos && word1.EndPos == word2.EndPos;
        }
    }

}


