using System;
using System.Windows.Forms;
using WeifenLuo.WinFormsUI;
using System.Drawing;
using ScintillaNet;
using PluginCore;
using System.IO;

namespace FlashDevelop
{
	public class TabbedDocument : DockContent, ITabbedDocument
	{
		private MainForm mainForm;
		private FileInfo fileInfo;
		readonly private string dlgMessage = "The file has been modified externally. Do you want to reload the file?";
		readonly public static EventType EventMask = EventType.FileSave | EventType.FileSaving;
		
		public TabbedDocument(MainForm mainForm, ScintillaControl sciControl)
		{
			string file = sciControl.Tag.ToString();
			if (!file.StartsWith("Untitled"))
			{
				this.fileInfo = new FileInfo(file);
			}
			this.mainForm = mainForm;
			this.BackColor = Color.White;
			this.Text = Path.GetFileName(file);
			this.DockPanel = this.mainForm.DockPanel;
			this.DockableAreas = DockAreas.Document;
			this.Controls.Add(sciControl);
			this.Show();
		}
		
		/**
		* Handles the incoming file save events
		*/
		public void HandleEvent(object sender, NotifyEvent e)
		{
			if (e.Type == EventType.FileSaving)
			{
				TextEvent te = (TextEvent)e;
				if (te.Text.ToLower() == this.FilePath.ToLower())
				{
					this.fileInfo = null;
				}
			} 
			else if (e.Type == EventType.FileSave)
			{
				TextEvent te = (TextEvent)e;
				if (te.Text.ToLower() == this.FilePath.ToLower())
				{
					this.fileInfo = new FileInfo(this.FilePath);
				}
			}
		}
		
		/**
		* Path of the current document
		*/
		public string FilePath
		{
			get 
			{
				return this.SciControl.Tag.ToString();
			}
		}
		
		/**
		* ScintillaControl of the current document
		*/
		public ScintillaControl SciControl 
		{
			get 
			{
				foreach (Control ctrl in this.Controls)
				{
					if (ctrl is ScintillaControl) return ctrl as ScintillaControl;
				}
				return null;
			}
		}
		
		/**
		* Shows message if this is the current document
		*/
		public void CheckFileChange()
		{
			if (!this.mainForm.IsClosing && File.Exists(this.FilePath) && this.mainForm.CurDocument == this && this.fileInfo != null)
			{
				FileInfo fi = new FileInfo(this.FilePath);
				if (this.fileInfo.LastWriteTime != fi.LastWriteTime)
				{
					this.fileInfo = fi;
					DialogResult dialogResult = MessageBox.Show(this.dlgMessage, " Information", MessageBoxButtons.YesNo, MessageBoxIcon.Information);
					if (dialogResult == DialogResult.Yes)
					{
						this.mainForm.ReloadDocument(this, false);
					} 
					else if (dialogResult == DialogResult.No)
					{
						this.mainForm.OnDocumentModify();
					}
				}
			}
		}
		
	}
	
	public class DockableWindow : DockContent
	{
		private MainForm mainForm;
		private string pluginGuid;

		public DockableWindow(MainForm mainForm, Control ctrl, string guid)
		{
			ctrl.Dock = DockStyle.Fill;
			this.Text = ctrl.Text;
			this.pluginGuid = guid;
			this.mainForm = mainForm;
			this.HideOnClose = true;
			this.TabText = ctrl.Tag.ToString();
			this.DockPanel = this.mainForm.DockPanel;
			this.DockableAreas = DockAreas.DockBottom|DockAreas.DockLeft|DockAreas.DockRight|DockAreas.DockTop|DockAreas.Float;
			this.Controls.Add(ctrl);
			this.Show();
		}
		
		/**
		* Retrieves the guid of the document
		*/
		public override string GetPersistString()
		{
			return this.pluginGuid;
		}
		
	}
	
}
