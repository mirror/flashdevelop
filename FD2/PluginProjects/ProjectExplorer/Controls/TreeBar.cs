using System;
using System.Collections;
using System.Diagnostics;
using System.Windows.Forms;
using ProjectExplorer.Controls.TreeView;

namespace ProjectExplorer.Controls
{
	/// <summary>
	/// 
	/// </summary>
	public class TreeBar : CommandBar
	{
		FDMenus menus;
		ProjectContextMenu treeMenu;

		public new CommandBarButton Refresh;
		public CommandBarCheckBox EnableTrace;

		public TreeBar(FDMenus menus, ProjectContextMenu treeMenu)
		{
			this.menus = menus;
			this.treeMenu = treeMenu;

			Refresh = new CommandBarButton("Refresh");
			Refresh.Image = Icons.Refresh.Img;

			EnableTrace = new CommandBarCheckBox(Icons.Debug.Img,"Enable Trace");

			Items.Add(treeMenu.ShowHidden);
			Items.Add(Refresh);
			Items.Add(new CommandBarSeparator());
			Items.Add(menus.ProjectMenu.Properties);
			Items.Add(new CommandBarSeparator());
			Items.Add(EnableTrace);
		}
	}
}
