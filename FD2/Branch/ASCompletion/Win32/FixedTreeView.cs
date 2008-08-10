/*
 * Custom Treeview
 * - custom tooltip (that don't appear behind the window!)
 * - flicker free
 * - extends StateSavingTreeView
 */

using System;
using System.Drawing;
using System.Windows.Forms;

namespace ASCompletion
{
	public class FixedTreeView : StateSavingTreeView
	{
		public delegate void NodeClickedHandler(object sender, TreeNode node);
		public event NodeClickedHandler NodeClicked;
		
		private const int TVS_NOTOOLTIPS = 0x80;
		private ToolTip tip;
		private int px;
		private int py;
		private TreeNode clickedNode;
		
		// disable the automatic tooltips
		protected override System.Windows.Forms.CreateParams CreateParams
		{
			get {
				CreateParams p = base.CreateParams;
				p.Style = p.Style | TVS_NOTOOLTIPS;
				return p;
			}
		}
		
		// prevents some flicker
		protected override void WndProc(ref Message m)
		{
			// Stop erase background message
			if (m.Msg == (int)0x0014 )
				m.Msg = (int) 0x0000; // Set to null
			
			base.WndProc(ref m);
		}
		
		// find clicked node on mousedown
		protected override void OnMouseDown(MouseEventArgs e)
		{
			clickedNode = this.GetNodeAt(e.X, e.Y);
			if (clickedNode != null)
			{
				TreeNode currentNode = clickedNode;
				int offset = 25 - Win32.Scrolling.GetScrollPos(this.Handle, Win32.Scrolling.SB_HORZ);
				while (currentNode.Parent != null)
				{
					offset += 20;
					currentNode = currentNode.Parent;
				}
				if (e.X > offset-5) {
					base.SelectedNode = clickedNode;
				}
				else clickedNode = null;
			}
			base.OnMouseDown(e);
		}
		
		// on mouseup init delayed NodeClicked event
		protected override void OnMouseUp(MouseEventArgs e)
		{
			base.OnMouseUp(e);
			if (clickedNode != null && NodeClicked != null) 
				NodeClicked(this, clickedNode);
		}
		
		// custom tooltip
		protected override void OnMouseMove(MouseEventArgs e)
		{
			// create tooltip
			if (tip == null) {
				tip = new ToolTip();
				tip.ShowAlways = true;
				tip.AutoPopDelay = 10000;
			}
			// get node under mouse
			TreeNode currentNode = this.GetNodeAt(this.PointToClient(Cursor.Position));
			string prev = tip.GetToolTip(this);
			if (currentNode != null)
			{
				string text = currentNode.Text;
				if ((prev == text) && (px == e.X) && (py == e.Y))
					return;
				
				// text dimensions
				int offset = 25 - Win32.Scrolling.GetScrollPos(this.Handle, Win32.Scrolling.SB_HORZ);
				while (currentNode.Parent != null)
				{
					offset += 20;
					currentNode = currentNode.Parent;
				}
				if (e.X < offset-5) {
					if (prev != "") tip.SetToolTip(this, "");
					return;
				}
				Graphics g = ((Control)this).CreateGraphics();
				SizeF textSize = g.MeasureString(text, this.Font);
				int w = (int)textSize.Width;
				if (w+offset+10 > this.Width)
				{
					px = e.X;
					py = e.Y;
					tip.SetToolTip(this, text);
				}
				else if (prev != "") tip.SetToolTip(this, "");
			}
			else if (prev != "") tip.SetToolTip(this, "");
		}
	}
}
