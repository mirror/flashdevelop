using System;

namespace PluginCore
{
    [Flags]
    public enum EventType
    {
        FileNew = 1 << 1,
        FileOpen = 1 << 2,
        FileOpening = 1 << 3,
        FileClose = 1 << 4,
        FileSwitch = 1 << 5,
        FileModify = 1 << 6,
        FileSave = 1 << 7,
        FileSaving = 1 << 8,
        FileReload = 1 << 9,
        FileRevert = 1 << 10,
        FileEncode = 1 << 11,
        FileDecode = 1 << 12,
        FileEmpty = 1 << 13,
        RestoreSession = 1 << 14,
        RestoreLayout = 1 << 15,
        SyntaxChange = 1 << 16,
        SyntaxDetect = 1 << 17,
        UIStarted = 1 << 18,
        UIRefresh = 1 << 19,
        UIClosing = 1 << 20,
        ProcessArgs = 1 << 21,
        ProcessStart = 1 << 22,
        ProcessEnd = 1 << 23,
        Command = 1 << 24,
        Trace = 1 << 25,
        Keys = 1 << 26
    }

    public enum CodingStyle
    {
        BracesOnLine = 0,
        BracesAfterLine = 1
    }

    public enum CommentBlockStyle
    {
        Indented = 0,
        NotIndented = 1
    }

    public enum UiRenderMode
    {
        Professional,
        System
    }

    public enum HandlingPriority
    {
        High = 0,
        Normal = 1,
        Low = 2
    }

    public enum TraceType
    {
        ProcessStart = -1,
        ProcessEnd = -2,
        ProcessError = -3,
        Info = 0,
        Debug = 1,
        Warning = 2,
        Error = 3,
        Fatal = 4
    }

    public enum CodePage
    {
        EightBits = 0,
        BigEndian = 1201,
        LittleEndian = 1200,
        UTF32 = 65005,
        UTF8 = 65001,
        UTF7 = 65000
    }

}
