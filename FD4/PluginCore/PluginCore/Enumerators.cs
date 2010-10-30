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
        FileModifyRO = 1 << 7, // TextEvent (file)
        FileSave = 1 << 8, // TextEvent (file)
        FileSaving = 1 << 9, // TextEvent (file)
        FileReload = 1 << 10, // TextEvent (file)
        FileRevert = 1 << 11, // TextEvent (file)
        FileRename = 1 << 12, // TextEvent (old;new)
        FileRenaming = 1 << 13, // TextEvent (old;new)
        FileEncode = 1 << 14, // DataEvent (file, text)
        FileDecode = 1 << 15, // DataEvent (file, null)
        FileEmpty = 1 << 16, // NotifyEvent
        FileTemplate = 1 << 17, // TextEvent (file)
        RestoreSession = 1 << 18, // DataEvent (file, session)
        RestoreLayout = 1 << 19, // TextEvent (file)
        SyntaxChange = 1 << 20, // TextEvent (language)
        SyntaxDetect = 1 << 21, // TextEvent (language)
        UIStarted = 1 << 22, // NotifyEvent
        UIRefresh = 1 << 23, // NotifyEvent
        UIClosing = 1 << 24, // NotifyEvent
        ApplySettings = 1 << 25, // NotifyEvent
        SettingChanged = 1 << 26, // TextEvent (setting)
        ProcessArgs = 1 << 27, // TextEvent (content)
        ProcessStart = 1 << 28, // NotifyEvent
        ProcessEnd = 1 << 29, // TextEvent (result)
        StartArgs = 1 << 30, // NotifyEvent
        Command = 1 << 31, // DataEvent (command)
        Trace = 1 << 32, // NotifyEvent
        Keys = 1 << 33, // KeyEvent (keys)
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
