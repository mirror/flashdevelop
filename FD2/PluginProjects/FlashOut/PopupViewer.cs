using System;
using System.Drawing;
using System.Diagnostics;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using AxShockwaveFlashObjects;

namespace FlashOut
{
	public class PopupViewer : System.Windows.Forms.Form
	{
		#region Windows Form Designer

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			// 
			// PopupViewer
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(292, 266);
			this.Name = "PopupViewer";
			this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
			this.Text = "Player";

		}
		#endregion

		public PopupViewer()
		{
			InitializeComponent();
		}
	}
}
