using System;
using System.Drawing;
using System.Windows.Forms;
using System.Collections;
using System.ComponentModel;
using FlashDevelop.Utilities;
using FlashDevelop.Utilities.Types;
using PluginCore;

namespace FlashDevelop.Windows
{
	public class InstalledPlugins : System.Windows.Forms.Form
	{
		private System.Windows.Forms.ListBox pluginList;
		private System.Windows.Forms.Button okButton;
		private System.Windows.Forms.PropertyGrid pluginPropertyGrid;
		private System.Windows.Forms.Label helpLabel;
		private MainForm mainForm;
		private ArrayList plugins;
		
		public InstalledPlugins(MainForm mainForm)
		{
			this.mainForm = mainForm;
			this.InitializeComponent();
		}
		
		#region Windows Forms Designer generated code
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			this.helpLabel = new System.Windows.Forms.Label();
			this.pluginPropertyGrid = new System.Windows.Forms.PropertyGrid();
			this.okButton = new System.Windows.Forms.Button();
			this.pluginList = new System.Windows.Forms.ListBox();
			this.SuspendLayout();
			// 
			// helpLabel
			// 
			this.helpLabel.Location = new System.Drawing.Point(7, 260);
			this.helpLabel.Name = "helpLabel";
			this.helpLabel.Size = new System.Drawing.Size(367, 16);
			this.helpLabel.TabIndex = 3;
			this.helpLabel.Text = "For assistance, contact the help address provided with the plugin.";
			// 
			// pluginPropertyGrid
			// 
			this.pluginPropertyGrid.CommandsVisibleIfAvailable = true;
			this.pluginPropertyGrid.LargeButtons = false;
			this.pluginPropertyGrid.LineColor = System.Drawing.SystemColors.ScrollBar;
			this.pluginPropertyGrid.Location = new System.Drawing.Point(126, 10);
			this.pluginPropertyGrid.Name = "pluginPropertyGrid";
			this.pluginPropertyGrid.PropertySort = System.Windows.Forms.PropertySort.Alphabetical;
			this.pluginPropertyGrid.Size = new System.Drawing.Size(349, 238);
			this.pluginPropertyGrid.TabIndex = 2;
			this.pluginPropertyGrid.Text = "Plugin Properties";
			this.pluginPropertyGrid.ToolbarVisible = false;
			this.pluginPropertyGrid.ViewBackColor = System.Drawing.SystemColors.Window;
			this.pluginPropertyGrid.ViewForeColor = System.Drawing.SystemColors.WindowText;
			// 
			// okButton
			// 
			this.okButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.okButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.okButton.Location = new System.Drawing.Point(401, 256);
			this.okButton.Name = "okButton";
			this.okButton.TabIndex = 0;
			this.okButton.Text = "&OK";
			this.okButton.Click += new System.EventHandler(this.OkButtonClick);
			// 
			// pluginList
			// 
			this.pluginList.Location = new System.Drawing.Point(8, 10);
			this.pluginList.Name = "pluginList";
			this.pluginList.Size = new System.Drawing.Size(109, 238);
			this.pluginList.TabIndex = 1;
			this.pluginList.SelectedIndexChanged += new System.EventHandler(this.PluginListSelectedIndexChanged);
			// 
			// InstalledPlugins
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.CancelButton = this.okButton;
			this.ClientSize = new System.Drawing.Size(484, 287);
			this.Controls.Add(this.helpLabel);
			this.Controls.Add(this.pluginList);
			this.Controls.Add(this.okButton);
			this.Controls.Add(this.pluginPropertyGrid);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
			this.MaximumSize = new System.Drawing.Size(492, 313);
			this.MinimumSize = new System.Drawing.Size(492, 313);
			this.Name = "InstalledPlugins";
			this.ShowInTaskbar = false;
			this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = " Installed Plugins";
			this.Load += new System.EventHandler(this.InstalledPluginsLoad);
			this.ResumeLayout(false);
		}
		#endregion
	
		#region EventHandlersAndMethods
		
		public void InstalledPluginsLoad(object sender, System.EventArgs e)
		{
			this.PopulatePluginsList();
		}
		
		public void PopulatePluginsList()
		{
			this.pluginList.Items.Clear();
			this.plugins = Global.Plugins.AvailablePlugins.GetAll();
			for (int i = 0; i<this.plugins.Count; i++)
			{
				AvailablePlugin plugin = (AvailablePlugin)this.plugins[i];
				this.pluginList.Items.Add(plugin.Instance.Name);
			}
			this.pluginList.SelectedIndex = 0;
		}
		
		public void PluginListSelectedIndexChanged(object sender, System.EventArgs e)
		{
			int selectedIndex = this.pluginList.SelectedIndex;
			AvailablePlugin plugin = (AvailablePlugin)this.plugins[selectedIndex];
			this.pluginPropertyGrid.SelectedObject = plugin.Instance;
		}
		
		public void OkButtonClick(object sender, System.EventArgs e)
		{
			this.Close();
		}
		
		#endregion
		
	}

}
