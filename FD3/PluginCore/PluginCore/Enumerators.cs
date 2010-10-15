using System;

namespace PluginCore
{
    [Flags]
    public enum EventType : long
    {
        FileNew = 1 << 1, // TextEvent (file)
        FileOpen = 1 << 2, // TextEvent (file)
        FileOpening = 1 << 3, // TextEvent (file)
        FileClose = 1 << 4, // TextEvent (file)
        FileSwitch = 1 << 5, // NotifyEvent
        FileModify = 1 << 6, // TextEvent (file)
        FileSave = 1 << 7, // TextEvent (file)
        FileSaving = 1 << 8, // TextEvent (file)
        FileReload = 1 << 9, // TextEvent (file)
        FileRevert = 1 << 10, // TextEvent (file)
        FileEncode = 1 << 11, // DataEvent (file, text)
        FileDecode = 1 << 12, // DataEvent (file, null)
        FileEmpty = 1 << 13, // NotifyEvent
        FileTemplate = 1 << 14, // TextEvent (file)
        RestoreSession = 1 << 15, // DataEvent (file, session)
        RestoreLayout = 1 << 16, // TextEvent (file)
        SyntaxChange = 1 << 17, // TextEvent (language)
        SyntaxDetect = 1 << 18, // TextEvent (language)
        UIStarted = 1 << 19, // NotifyEvent
        UIRefresh = 1 << 20, // NotifyEvent
        UIClosing = 1 << 21, // NotifyEvent
        ApplySettings = 1 << 22, // NotifyEvent
        SettingChanged = 1 << 23, // TextEvent (setting)
        ProcessArgs = 1 << 24, // TextEvent (content)
        ProcessStart = 1 << 25, // NotifyEvent
        ProcessEnd = 1 << 26, // TextEvent (result)
        Command = 1 << 27, // DataEvent (command)
        Trace = 1 << 28, // NotifyEvent
        Keys = 1 << 29, // KeyEvent (keys)
        FileModifyRO = 1 << 30, // TextEvent (file)
        StartArgs = 1 << 55 // NotifyEvent
    }

    public enum SessionType
    {
        Startup = 0,
        Layout = 1,
        External = 2
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
