using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;
using System.Windows.Forms;

namespace SourceControl.Sources
{
    public interface IVCManager
    {
        event VCManagerStatusChange OnChange;

        IVCMenuItems MenuItems { get; }
        IVCFileActions FileActions { get; }

        bool IsPathUnderVC(string path);

        VCItemStatus GetOverlay(string path, string rootPath);
        List<VCStatusReport> GetAllOverlays(string path, string rootPath);

        void GetStatus(string rootPath);

        bool SetPathDirty(string path, string rootPath);
    }

    public interface IVCMenuItems
    {
        TreeNode[] CurrentNodes { set; }
        IVCManager CurrentManager { set; }

        ToolStripItem Update { get; }
        ToolStripItem Commit { get; }
        ToolStripItem Push { get; }
        ToolStripItem ShowLog { get; }
        ToolStripItem MidSeparator { get; }
        ToolStripItem Diff { get; }
        ToolStripItem DiffChange { get; }
        ToolStripItem Add { get; }
        ToolStripItem Ignore { get; }
        ToolStripItem UndoAdd { get; }
        ToolStripItem Revert { get; }
        ToolStripItem EditConflict { get; }
    }

    public interface IVCFileActions
    {
        bool FileBeforeRename(string path);
        bool FileRename(string path, string newName);
        bool FileDelete(string[] paths, bool confirm);
        bool FileMove(string fromPath, string toPath);
    }

    public class VCStatusReport
    {
        public string Path;
        public VCItemStatus Status;

        public VCStatusReport(string path, VCItemStatus status)
        {
            Path = path;
            Status = status;
        }
    }

    public delegate void VCManagerStatusChange(IVCManager sender);

    public enum VCItemStatus : int
    {
        Unknown = 0,
        External = 1,
        Ignored = 2,
        UpToDate = 3,
        Added = 4,
        Deleted = 5,
        Replaced = 6,
        Missing = 7,
        Modified = 8,
        Conflicted = 9
    }
}
