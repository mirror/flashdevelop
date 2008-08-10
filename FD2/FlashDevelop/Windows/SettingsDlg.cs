using System;
using System.Drawing;
using System.Windows.Forms;
using System.Collections;
using FlashDevelop.Utilities;
using PluginCore;

namespace FlashDevelop.Windows
{
	public class SettingsDlg : System.Windows.Forms.Form
	{
		private System.Windows.Forms.ColumnHeader settingValueHeader;
		private System.Windows.Forms.ColumnHeader settingKeyHeader;
		private System.Windows.Forms.ComboBox filterBox;
		private System.Windows.Forms.ListView settingView;
		private System.Windows.Forms.Button applyButton;
		private System.Windows.Forms.Button cancelButton;
		private System.Windows.Forms.Panel buttonPanel;
		private System.Windows.Forms.Button newButton;
		private System.Windows.Forms.Button deleteButton;
		private FlashDevelop.MainForm mainForm;
		private string noFilter = "No filter";	

		public SettingsDlg(MainForm mainForm)
		{
			this.mainForm = mainForm;
			this.InitializeComponent();
			this.PopulateSettingsView(null);
			this.InitFilterBox();
		}

		#region Windows Forms Designer generated code
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent() {
			this.deleteButton = new System.Windows.Forms.Button();
			this.newButton = new System.Windows.Forms.Button();
			this.buttonPanel = new System.Windows.Forms.Panel();
			this.cancelButton = new System.Windows.Forms.Button();
			this.applyButton = new System.Windows.Forms.Button();
			this.settingView = new System.Windows.Forms.ListView();
			this.filterBox = new System.Windows.Forms.ComboBox();
			this.settingKeyHeader = new System.Windows.Forms.ColumnHeader();
			this.settingValueHeader = new System.Windows.Forms.ColumnHeader();
			this.buttonPanel.SuspendLayout();
			this.SuspendLayout();
			// 
			// deleteButton
			// 
			this.deleteButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.deleteButton.Enabled = false;
			this.deleteButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.deleteButton.Location = new System.Drawing.Point(260, 5);
			this.deleteButton.Name = "deleteButton";
			this.deleteButton.Size = new System.Drawing.Size(56, 23);
			this.deleteButton.TabIndex = 5;
			this.deleteButton.Text = "&Delete";
			this.deleteButton.Click += new System.EventHandler(this.DeleteButtonClick);
			// 
			// newButton
			// 
			this.newButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.newButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.newButton.Location = new System.Drawing.Point(201, 5);
			this.newButton.Name = "newButton";
			this.newButton.Size = new System.Drawing.Size(56, 23);
			this.newButton.TabIndex = 4;
			this.newButton.Text = "&New";
			this.newButton.Click += new System.EventHandler(this.NewButtonClick);
			// 
			// buttonPanel
			// 
			this.buttonPanel.Controls.Add(this.deleteButton);
			this.buttonPanel.Controls.Add(this.newButton);
			this.buttonPanel.Controls.Add(this.filterBox);
			this.buttonPanel.Controls.Add(this.applyButton);
			this.buttonPanel.Controls.Add(this.cancelButton);
			this.buttonPanel.Dock = System.Windows.Forms.DockStyle.Bottom;
			this.buttonPanel.Location = new System.Drawing.Point(0, 360);
			this.buttonPanel.Name = "buttonPanel";
			this.buttonPanel.Size = new System.Drawing.Size(456, 33);
			this.buttonPanel.TabIndex = 4;
			// 
			// cancelButton
			// 
			this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.cancelButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.cancelButton.Location = new System.Drawing.Point(319, 5);
			this.cancelButton.Name = "cancelButton";
			this.cancelButton.Size = new System.Drawing.Size(64, 23);
			this.cancelButton.TabIndex = 2;
			this.cancelButton.Text = "&Cancel";
			this.cancelButton.Click += new System.EventHandler(this.CancelButtonClick);
			// 
			// applyButton
			// 
			this.applyButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.applyButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.applyButton.Location = new System.Drawing.Point(386, 5);
			this.applyButton.Name = "applyButton";
			this.applyButton.Size = new System.Drawing.Size(64, 23);
			this.applyButton.TabIndex = 3;
			this.applyButton.Text = "&Apply";
			this.applyButton.Click += new System.EventHandler(this.ApplyButtonClick);
			// 
			// settingView
			// 
			this.settingView.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
						| System.Windows.Forms.AnchorStyles.Left) 
						| System.Windows.Forms.AnchorStyles.Right)));
			this.settingView.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
						this.settingKeyHeader,
						this.settingValueHeader});
			this.settingView.FullRowSelect = true;
			this.settingView.GridLines = true;
			this.settingView.Location = new System.Drawing.Point(0, 0);
			this.settingView.MultiSelect = false;
			this.settingView.Name = "settingView";
			this.settingView.Size = new System.Drawing.Size(456, 359);
			this.settingView.TabIndex = 0;
			this.settingView.View = System.Windows.Forms.View.Details;
			this.settingView.DoubleClick += new System.EventHandler(this.SettingViewDoubleClick);
			this.settingView.SelectedIndexChanged += new System.EventHandler(this.SettingViewSelectedIndexChanged);
			// 
			// filterBox
			// 
			this.filterBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.filterBox.Location = new System.Drawing.Point(6, 6);
			this.filterBox.Name = "filterBox";
			this.filterBox.Size = new System.Drawing.Size(170, 21);
			this.filterBox.TabIndex = 1;
			this.filterBox.SelectedIndexChanged += new System.EventHandler(this.SettingViewSelectedIndexChanged);
			// 
			// settingKeyHeader
			// 
			this.settingKeyHeader.Text = "Key";
			this.settingKeyHeader.Width = 224;
			// 
			// settingValueHeader
			// 
			this.settingValueHeader.Text = "Value";
			this.settingValueHeader.Width = 210;
			// 
			// SettingsDlg
			// 
			this.AcceptButton = this.applyButton;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.CancelButton = this.cancelButton;
			this.ClientSize = new System.Drawing.Size(456, 393);
			this.Controls.Add(this.settingView);
			this.Controls.Add(this.buttonPanel);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.MinimumSize = new System.Drawing.Size(350, 200);
			this.Name = "SettingsDlg";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = " Settings";
			this.buttonPanel.ResumeLayout(false);
			this.ResumeLayout(false);
		}
		#endregion

		#region MethodsPropsAndEventHandlers

		/**
		* Access to the MainForm
		*/
		public MainForm MainForm 
		{
			get 
			{ 
				return this.mainForm;
			}
		}
		
		/**
		* Access to the ListView
		*/
		public ListView SettingView 
		{
			get 
			{ 
				return this.settingView;
			}
		}
		
		/**
		* Add all settings to settings table
		*/
		public void PopulateSettingsView(string filter)
		{
			this.settingView.Items.Clear();
			this.mainForm.Settings.SortByKey();
			int count = this.mainForm.Settings.Settings.Count;
			for (int i = 0; i<count; i++)
			{
				SettingEntry se = (SettingEntry)this.mainForm.Settings.Settings[i];
				if ((filter != null) && (se.Key.IndexOf(filter) != 0)) continue;
				ListViewItem item = new ListViewItem(se.Key);
				item.SubItems.Add(se.Value);
				this.settingView.Items.Add(item);
			}
		}
		
		/**
		* Applies all settings
		*/
		public void ApplyButtonClick(object sender, System.EventArgs e)
		{
			for (int i = 0; i<this.settingView.Items.Count; i++)
			{
				string settingsKey = this.settingView.Items[i].SubItems[0].Text;
				string settingsValue = this.settingView.Items[i].SubItems[1].Text;
				this.mainForm.Settings.ChangeValue(settingsKey, settingsValue);
			}
			this.mainForm.ApplySciSettingsToAllDocuments();
			this.mainForm.MainSettings.SortByKey();
			this.mainForm.MainSettings.Save();
			//
			NotifyEvent se = new NotifyEvent(EventType.SettingUpdate);
			Global.Plugins.NotifyPlugins(this, se);
			this.Close();
		}
		
		/**
		* Manages the value changing
		*/
		public void SettingViewDoubleClick(object sender, System.EventArgs e)
		{
			ListView listView = (ListView)sender;
			ListViewItem selectedItem  = listView.SelectedItems[0];
			if (selectedItem.SubItems[1].Text == "true") selectedItem.SubItems[1].Text = "false";
			else if (selectedItem.SubItems[1].Text == "false") selectedItem.SubItems[1].Text = "true";
			else
			{
				ValueChanger valueChanger = new ValueChanger(this, selectedItem);
				valueChanger.ShowDialog();
			}
		}
		
		/**
		* Selected item changed event handling
		*/
		public void SettingViewSelectedIndexChanged(object sender, System.EventArgs e)
		{
			if (this.settingView.SelectedItems.Count > 0)
			{
				this.deleteButton.Enabled = true;
			} 
			else 
			{
				this.deleteButton.Enabled = false;
			}
		}
		
		/**
		* Opens the setting adder dialog
		*/
		public void NewButtonClick(object sender, System.EventArgs e)
		{
			SettingAdder settingAdder = new SettingAdder(this);
			settingAdder.ShowDialog();
		}
		
		/**
		* Removes the selected item
		*/
		public void DeleteButtonClick(object sender, System.EventArgs e)
		{
			try 
			{
				ListViewItem selectedItem = this.settingView.SelectedItems[0];
				this.settingView.Items.Remove(selectedItem);
			} 
			catch 
			{
				this.deleteButton.Enabled = false;
			}
		}
		
		/**
		* Closes the settings dialog
		*/
		public void CancelButtonClick(object sender, System.EventArgs e)
		{
			this.Close();
		}
		
		#endregion

		#region FilterBoxMethods 
		
		/**
		* Build filter list from settings names
		*/
		public void InitFilterBox()
		{
			this.filterBox.Items.Clear();
			this.filterBox.Items.Add(this.noFilter);
			this.filterBox.SelectedIndex = 0;
			this.filterBox.SelectedValueChanged += new System.EventHandler(this.FilterBoxSelectedValueChanged);
			int count = this.mainForm.Settings.Settings.Count;
			Hashtable filters = new Hashtable();
			for (int i = 0; i<count; i++)
			{
				SettingEntry se = (SettingEntry)this.mainForm.Settings.Settings[i];
				string[] splitKey = se.Key.Split('.');
				if ((splitKey.Length > 1) && !filters.ContainsKey(splitKey[0]))
				{
					filters.Add(splitKey[0], null);
					this.filterBox.Items.Add(splitKey[0]);
				}
			}
		}

		/**
		* User selection in filter list, update settings table
		*/
		public void FilterBoxSelectedValueChanged(object sender, System.EventArgs e)
		{
			string filter = this.filterBox.Items[this.filterBox.SelectedIndex].ToString();
			if (filter == this.noFilter) this.PopulateSettingsView(null);
			else this.PopulateSettingsView(filter+".");
		}
		
		#endregion
		
	}
	
}
