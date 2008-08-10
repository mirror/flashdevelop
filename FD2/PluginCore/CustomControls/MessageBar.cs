using System;
using System.ComponentModel;
using System.Drawing;
using System.Windows.Forms;
using WeifenLuo.WinFormsUI;

namespace PluginCore.Controls
{
	public class MessageBar : System.Windows.Forms.UserControl
	{
		private System.Windows.Forms.Label label;
		private WeifenLuo.WinFormsUI.InertButton buttonClose;
		private ToolTip tip;
		private string currentMessage;
		
		public MessageBar()
		{
			InitializeComponent();
			//
			System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
			label.Image = new System.Drawing.Bitmap(assembly.GetManifestResourceStream("Warning.png"));
			buttonClose.ImageEnabled = new System.Drawing.Bitmap(assembly.GetManifestResourceStream("WeifenLuo.WinFormsUI.Resources.DockPaneCaption.CloseEnabled.bmp"));
		}
		
		static public void ShowWarning(string message)
		{
			CreateBar(UITools.MainForm.CurDocument, message);
		}
		static public void HideWarning()
		{
			HideBar(UITools.MainForm.CurDocument);
		}
		
		static private MessageBar CreateBar(DockContent target, string message)
		{
			MessageBar bar;
			foreach(Control ctrl in target.Controls)
			{
				if (ctrl is MessageBar)
				{
					bar = (ctrl as MessageBar);
					bar.Update(message);
					bar.Visible = true;
					return bar;
				}
			}
			bar = new MessageBar();
			bar.Visible = false;
			target.Controls.Add(bar);
			bar.Update(message);
			bar.BringToFront();
			bar.Dock = DockStyle.Top;
			bar.Visible = true;
			return bar;
		}
		
		static public void HideBar(DockContent target)
		{
			foreach(Control ctrl in target.Controls)
			{
				if (ctrl is MessageBar)
				{
					(ctrl as MessageBar).MessageBarClick(null, null);
					return;
				}
			}
		}
		
		#region InitializeComponent
		
		public void InitializeComponent() 
		{
			this.buttonClose = new WeifenLuo.WinFormsUI.InertButton();
			this.label = new System.Windows.Forms.Label();
			this.SuspendLayout();
			// 
			// buttonClose
			// 
			this.buttonClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.buttonClose.Location = new System.Drawing.Point(476, 5);
			this.buttonClose.Name = "buttonClose";
			this.buttonClose.Size = new System.Drawing.Size(16, 14);
			this.buttonClose.TabIndex = 2;
			this.buttonClose.Click += new System.EventHandler(this.MessageBarClick);
			// 
			// label
			// 
			this.label.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
						| System.Windows.Forms.AnchorStyles.Right)));
			this.label.ForeColor = System.Drawing.SystemColors.InfoText;
			this.label.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
			this.label.Location = new System.Drawing.Point(2, 4);
			this.label.Name = "label";
			this.label.Size = new System.Drawing.Size(494, 16);
			this.label.TabIndex = 0;
			this.label.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			this.label.Click += new System.EventHandler(this.MessageBarClick);
			this.label.MouseEnter += new System.EventHandler(this.LabelMouseEnter);
			this.label.MouseLeave += new System.EventHandler(this.LabelMouseLeave);
			// 
			// MessageBar
			// 
			this.BackColor = System.Drawing.SystemColors.Info;
			this.Controls.Add(this.buttonClose);
			this.Controls.Add(this.label);
			this.Name = "MessageBar";
			this.Size = new System.Drawing.Size(496, 24);
			this.Click += new System.EventHandler(this.MessageBarClick);
			this.ResumeLayout(false);
		}
		
		#endregion
		
		#region MethodsAndEventHandlers
		
		public void Update(string message)
		{
			currentMessage = message;
			int p = message.IndexOf('\r');
			if (p < 0) p = message.IndexOf('\n');
			if (p >= 0) message = message.Substring(0,p)+" ...";
			label.Text = "      "+message;
		}
		
		void ButtonCloseClick(object sender, System.EventArgs e)
		{
			MessageBarClick(null, null);
		}
		
		public void MessageBarClick(object sender, System.EventArgs e)
		{
			currentMessage = "";
			Hide();
		}
		
		public void LabelMouseEnter(object sender, System.EventArgs e)
		{
			if (tip == null)
			{
				tip = new ToolTip();
				tip.ShowAlways = true;
				tip.AutoPopDelay = 10000;
			}
			tip.SetToolTip(label, currentMessage);
		}
		
		public void LabelMouseLeave(object sender, System.EventArgs e)
		{
			if (tip != null) tip.SetToolTip(label, "");
		}
		
		protected override void OnPaint(PaintEventArgs e)
		{
			base.OnPaint(e);
			Graphics g = CreateGraphics();
			g.DrawLine(new System.Drawing.Pen(System.Drawing.Color.Gray,1),0,23,Width,23);
		}
		
		#endregion
		
	}
	
	
}
