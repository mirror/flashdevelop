using System;
using System.Collections;
using System.Diagnostics;
using System.Windows.Forms;
using PluginCore.Localization;
using ProjectManager.Controls.TreeView;
using System.Drawing.Drawing2D;
using System.Drawing;

namespace ProjectManager.Controls
{
	/// <summary>
	/// Tree view top toolbar
	/// </summary>
	public class TreeBar : ToolStrip
	{
        ProjectContextMenu treeMenu;

        public ToolStripButton ShowHidden;
        public ToolStripButton RefreshSelected;
        public ToolStripButton ProjectProperties;
        public ToolStripButton ProjectTypes;

        public TreeBar(FDMenus menus, ProjectContextMenu treeMenu)
        {
            this.treeMenu = treeMenu;
            this.Renderer = new DockPanelStripRenderer();
            this.GripStyle = ToolStripGripStyle.Hidden;
            this.Padding = new Padding(1, 0, 1, 0);
            this.CanOverflow = false;

            RefreshSelected = new ToolStripButton(Icons.Refresh.Img);
            RefreshSelected.ToolTipText = TextHelper.GetString("ToolTip.Refresh");

            ShowHidden = new ToolStripButton(Icons.HiddenItems.Img);
            ShowHidden.ToolTipText = TextHelper.GetString("ToolTip.ShowHiddenItems");

            ProjectProperties = new ToolStripButton(Icons.Options.Img);
            ProjectProperties.ToolTipText = TextHelper.GetString("ToolTip.ProjectProperties");

            ProjectTypes = new ToolStripButton(Icons.AllClasses.Img);
            ProjectTypes.Alignment = ToolStripItemAlignment.Right;
            ProjectTypes.ToolTipText = TextHelper.GetString("ToolTip.ProjectTypes");

            Items.Add(ShowHidden);
            Items.Add(RefreshSelected);

            Items.Add(new ToolStripSeparator());

            Items.Add(ProjectProperties);
            Items.Add(ProjectTypes);
        }
	}    
}
