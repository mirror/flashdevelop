using System;
using System.Drawing;
using System.Windows.Forms;
using System.Collections;
using System.Text.RegularExpressions;
using ScintillaNet;

namespace PluginCore.Controls
{
	#region ICompletionListItem interface
		
	public interface ICompletionListItem
	{
		string Label { get; }
		string Value { get; }
		string Description { get; }
		Bitmap Icon { get; }
	}
	
	#endregion

	/// <summary>
	/// Editor completion list 
	/// </summary>
	public class CompletionList
	{
		#region Settings
		
		static private bool autoFilterList;
		static private bool enableAutoHide;
		static private int displayDelay;
		static private bool wrapList;
		
		static public bool AutoFilterList
		{
			get { return autoFilterList; }
			set { autoFilterList = value; }
		}
		static public bool EnableAutoHide
		{
			get { return enableAutoHide; }
			set { enableAutoHide = value; }
		}
		static public int DisplayDelay
		{
			get { return displayDelay; }
			set { displayDelay = value; }
		}
		static public bool WrapList
		{
			get { return wrapList; }
			set { wrapList = value; }
		}
		static public string InsertionKeys
		{
			get { return insertionKeys; }
			set {
				if (value != insertionKeys)
				{
					insertionKeys = value;
					re_separator = new Regex("[ "+Regex.Escape(insertionKeys).Replace("]","\\]").Replace("-","\\-")+"]");
				}
			}
		}
		
		#endregion
		
		// controls
		static private System.Timers.Timer tempo;
		static private ListBox completionList;
		
		#region State
		static private ArrayList allItems;
		static private bool listUp;
		static private bool autoHideList;
		static private bool fullList;
		static private string insertionKeys;
		static private string word;
		static private string currentWord;
		static private int startPos;
		static private int currentPos;
		static private int lastIndex;
		static private bool isActive;
		static private bool exactMatchInList;
		static private ICompletionListItem currentItem;
		#endregion
		
		#region Control creation
		
		static public void CreateControl(IMainForm mainForm)
		{
			/**
			* DELAY
			*/
			tempo = new System.Timers.Timer();
			tempo.SynchronizingObject = (Form)mainForm;
			tempo.Elapsed += new System.Timers.ElapsedEventHandler(DisplayList);
			tempo.AutoReset = false;
			/**
			* LIST
			*/
			completionList = new ListBox();
			completionList.Visible = false;
			completionList.Location = new Point(400,200);
			completionList.ItemHeight = 16;
			completionList.Size = new Size(150, 100);
			completionList.DrawMode = DrawMode.OwnerDrawFixed;
			completionList.DrawItem += new DrawItemEventHandler(CLDrawListItem);
			completionList.Click += new EventHandler(CLClick);
			completionList.DoubleClick += new EventHandler(CLDoubleClick);
			(mainForm as Form).Controls.Add(completionList);
		}
		
		#endregion
		
		#region Public List Properties
		
		static public bool Active
		{
			get { return isActive; }
		}
		
		#endregion
		
		#region CompletionList Methods
		
		static public bool CheckPosition(int position)
		{
			return position == currentPos;
		}

		static public void Show(ArrayList itemList, bool autoHide, string select)
		{
			if (select.Length > 0)
			{
				ScintillaControl sci = UITools.MainForm.CurSciControl;
				if (sci == null) return;
				currentWord = select;
			}
			Show(itemList, autoHide);
		}

		static public void Show(ArrayList itemList, bool autoHide)
		{
			// check controls
			ScintillaControl sci = UITools.MainForm.CurSciControl;
			ListBox cl = completionList;
			try
			{
				if ((itemList == null) || (itemList.Count == 0))
				{
					if (isActive) Hide();
					return;
				}
				if (sci == null) 
				{
					if (isActive) Hide();
					return;
				}
				if (InfoTip.CallTipActive) InfoTip.Hide();
			}
			catch (Exception ex)
			{
				ErrorHandler.ShowError("Completion list Control exception.", ex);
			}
			// state
			allItems = itemList;
			autoHideList = autoHide;
			word = "";
			if (currentWord != null)
			{
				word = currentWord;
				currentWord = null;
			}
			fullList = (word.Length == 0) || !autoHide || !autoFilterList;
			lastIndex = 0;
			exactMatchInList = false;
			startPos = sci.CurrentPos-word.Length;
			currentPos = sci.CurrentPos;
			// lock keys
			isActive = true;
			UITools.LockControl(sci);
			// populate list
			tempo.Enabled = autoHide && (displayDelay > 0);
			if (tempo.Enabled) tempo.Interval = displayDelay;
			FindWordStartingWith(word);
		}
		
		static private void DisplayList(object sender, System.Timers.ElapsedEventArgs e)
		{
			ScintillaControl sci = UITools.MainForm.CurSciControl;
			ListBox cl = completionList;
			if (cl.Items.Count == 0) return;
			// evaluate position
			cl.Height = Math.Min(cl.Items.Count, 10)*cl.ItemHeight+4;
			Point coord = new Point(sci.PointXFromPosition(startPos), sci.PointYFromPosition(startPos));
			listUp = (coord.Y+cl.Height > (sci as Control).Height);
			coord = sci.PointToScreen(coord);
			coord = ((Form)UITools.MainForm).PointToClient(coord);
			cl.Left = coord.X-20 + sci.Left;
			if (listUp) cl.Top = coord.Y-cl.Height + sci.Top;
			else cl.Top = coord.Y+UITools.LineHeight(sci) + sci.Top;
			//
			if (!cl.Visible)
			{
				cl.Show();
				cl.BringToFront();
			}
		}
				
		static public void Hide()
		{
			if ((completionList != null) && isActive) 
			{
				// list
				tempo.Enabled = false;
				isActive = false;
				fullList = false;
				completionList.Visible = false;
				if (completionList.Items.Count > 0) completionList.Items.Clear();
				currentItem = null;
				allItems = null;
				InfoTip.Hide(); // InfoTip
				UITools.UnlockControl(); // unlock keys
			}
		}
		
		static public void SelectWordInList(string tail)
		{
			ScintillaControl sci = UITools.MainForm.CurSciControl;
			if (sci == null) 
			{
				Hide();
				return;
			}
			currentWord = tail;
			currentPos += tail.Length;
			sci.SetSel(currentPos, currentPos);
		}
		
		static private void CLDrawListItem(object sender, System.Windows.Forms.DrawItemEventArgs e)
		{
			ICompletionListItem item = completionList.Items[e.Index] as ICompletionListItem;
			e.DrawBackground(); // empty background
			// draw text
			Brush myBrush = ((e.State & DrawItemState.Selected) > 0) ? Brushes.White : Brushes.Black;
			Rectangle tbounds = new Rectangle(18, e.Bounds.Top+1, e.Bounds.Width, e.Bounds.Height);
			if (item != null)
			{
				e.Graphics.DrawImage(item.Icon, 1,e.Bounds.Top);
				e.Graphics.DrawString(item.Label, e.Font, myBrush, tbounds, StringFormat.GenericDefault);
			}
			// focus rect
			e.DrawFocusRectangle();
			// InfoTip
			if ((item != null) && ((e.State & DrawItemState.Selected) > 0))
			{
				currentItem = item;
				UpdateTip();
			}
		}

		static public void UpdateTip()
		{
			if (currentItem == null) return;
			InfoTip.Text = currentItem.Description;
			// update & show InfoTip
			InfoTip.Location = new Point(completionList.Left+completionList.Width, completionList.Top);
			InfoTip.AutoSize();
			InfoTip.Show();
		}

		static private void CLClick(object sender, System.EventArgs e)
		{
			ScintillaControl sci = UITools.MainForm.CurSciControl;
			if (sci == null) Hide();
			else (sci as Control).Focus();
		}
		
		static private void CLDoubleClick(object sender, System.EventArgs e)
		{
			ScintillaControl sci = UITools.MainForm.CurSciControl;
			if (sci == null) Hide();
			else 
			{
				(sci as Control).Focus();
				ReplaceText(sci);
			}
		}
		
		static private void FindWordStartingWith(string word)
		{
			int len = word.Length;
			/**
			* FILTER ITEMS
			*/
			if (autoFilterList || fullList)
			{
				ArrayList found;
				if (len == 0) 
				{
					found = allItems;
					lastIndex = 0;
					exactMatchInList = true;
				}
				else
				{
					found = new ArrayList();
					int n = allItems.Count;
					int i = lastIndex;
					ICompletionListItem item;
					exactMatchInList = false;
					while (i < n)
					{
						item = (ICompletionListItem)allItems[i];
						// compare item's label with the searched word
						if (String.Compare(item.Label,0, word,0, len, true) == 0)
						{
							// first match found
							if (!exactMatchInList)
							{
								lastIndex = found.Count;
								exactMatchInList = true;
							}
							// exact match
							/*if (autoHide && !fullList && (len == item.Label.Length))
							{
								Hide();
								return;
							}*/
							found.Add(item);
						}
						else if (fullList) found.Add(item);
						i++;
					}
				}
				// no match?
				if (!exactMatchInList)
				{
					if ((autoHideList && enableAutoHide) || (len == 0) || (len > 255)) Hide();
					else 
					{
						FindWordStartingWith(word.Substring(0, len-1));
						exactMatchInList = false;
					}
					return;
				}
				fullList = false;
				// reset timer
				if (tempo.Enabled)
				{
					tempo.Enabled = false;
					tempo.Enabled = true;
				}
				// populate list
				if ((completionList.Items.Count == found.Count) && completionList.Items[0] == found[0])
				{
					// no update needed
					return;
				}
				try
				{
					completionList.BeginUpdate();
					completionList.Items.Clear();
					foreach (ICompletionListItem item in found)
					{
						completionList.Items.Add(item);
					}
					// select first item
					completionList.SelectedIndex = lastIndex;
					completionList.TopIndex = lastIndex;
				}
				catch (Exception ex)
				{
					Hide();
					ErrorHandler.ShowError("Completion list populate error.", ex);
					return;
				}
				finally
				{
					completionList.EndUpdate();
				}
				// update list
				if (!tempo.Enabled) DisplayList(null, null);
			}
			/**
			* NO FILTER
			*/
			else
			{
				int n = completionList.Items.Count;
				ICompletionListItem item;
				while (lastIndex < n)
				{
					item = (ICompletionListItem)completionList.Items[lastIndex];
					if (String.Compare(item.Label, 0, word, 0, len, true) == 0)
					{
						completionList.SelectedIndex = lastIndex;
						completionList.TopIndex = lastIndex;
						exactMatchInList = true;
						return;
					}
					lastIndex++;
				}
				// no match
				if (autoHideList && enableAutoHide) Hide();
				else exactMatchInList = false;
			}
		}
		
		static public void ReplaceText(ScintillaControl sci)
		{
			ReplaceText(sci, "");
		}
		
		static public void ReplaceText(ScintillaControl sci, string tail)
		{
			if (InfoTip.CallTipActive)
			{
				InfoTip.Hide();
				return;
			}
			if (completionList.SelectedIndex >= 0)
			{
				ICompletionListItem item = (ICompletionListItem)completionList.Items[completionList.SelectedIndex];
				sci.SetSel(startPos, sci.CurrentPos);
				string replace = item.Value;
				if (replace != null) sci.ReplaceSel(replace+tail);
			}
			Hide();
		}
		
		#endregion
		
		#region Events handling
		
		static private readonly Regex re_word = new Regex(@"[\w$_]", RegexOptions.Compiled);
		static private Regex re_separator = new Regex(@"[ .]");

		static public int GetHandle()
		{
			return (int)completionList.Handle;
		}
		
		static public void OnChar(ScintillaControl sci, int value)
		{
			string c = Convert.ToString((char)value);
			
			if (re_word.IsMatch(c))
			{
				word += c;
				currentPos++;
				FindWordStartingWith(word);
				return;
			}
			else if (re_separator.IsMatch(c))
			{
				if (!exactMatchInList) CompletionList.Hide();
				else if (word.Length > 0 || c == "." || c == "(" || c == "[")
				{
					// TODO  maybe add an option to add spaces around operators
					/*if (c == "=") ReplaceText(sci, " "+c+" "); 
					else*/ ReplaceText(sci, c);
				}
				// handle this char
				UITools.SendChar(sci, value);
			}
			else
			{
				CompletionList.Hide();
			}			
		}
		
		static public bool HandleKeys(ScintillaControl sci, Keys key)
		{
			int index;
			switch (key)
			{
				case Keys.Back:
					sci.DeleteBack();
					if (word.Length > 0)
					{
						word = word.Substring(0, word.Length-1);
						currentPos = sci.CurrentPos;
						lastIndex = 0;
						FindWordStartingWith(word);
					}
					else CompletionList.Hide();
					return true;
					
				case Keys.Enter:
				case Keys.Tab:
					ReplaceText(sci);
					return true;
					
				case Keys.Space:
					return false;
					
				case Keys.Up:	
				case Keys.Left:
					// the list was hidden and it should not appear
					if (!completionList.Visible)
					{
						CompletionList.Hide();
						if (key == Keys.Up) sci.LineUp(); 
						else sci.CharLeft();
						return false;
					}
					// go up the list
					else if (completionList.SelectedIndex > 0)
					{
						index = completionList.SelectedIndex-1;
						completionList.SelectedIndex = index;
					}
					// wrap
					else if (wrapList)
					{
						index = completionList.Items.Count-1;
						completionList.SelectedIndex = index;
					}
					break;
					
				case Keys.Down:	
				case Keys.Right:
					// the list was hidden and it should not appear
					if (!completionList.Visible)
					{
						CompletionList.Hide();
						if (key == Keys.Down) sci.LineDown(); 
						else sci.CharRight();
						return false;
					}
					// go down the list
					else if (completionList.SelectedIndex < completionList.Items.Count-1)
					{
						index = completionList.SelectedIndex+1;
						completionList.SelectedIndex = index;
					}
					// wrap
					else if (wrapList)
					{
						index = 0;
						completionList.SelectedIndex = index;
					}
					break;
					
				case Keys.PageUp:
					// the list was hidden and it should not appear
					if (!completionList.Visible)
					{
						CompletionList.Hide();
						sci.PageUp();
						return false;
					}
					// go up the list
					else if (completionList.SelectedIndex > 0)
					{
						index = completionList.SelectedIndex-completionList.Height/completionList.ItemHeight;
						if (index < 0) index = 0;
						completionList.SelectedIndex = index;
					}
					break;
					
				case Keys.PageDown:
					// the list was hidden and it should not appear
					if (!completionList.Visible)
					{
						CompletionList.Hide();
						sci.PageDown();
						return false;
					}
					// go down the list
					else if (completionList.SelectedIndex < completionList.Items.Count-1)
					{
						index = completionList.SelectedIndex+completionList.Height/completionList.ItemHeight;
						if (index > completionList.Items.Count-1) index = completionList.Items.Count-1;
						completionList.SelectedIndex = index;
					}
					break;
				
				case (Keys.Control | Keys.Space):
					break;
					
				default:
					CompletionList.Hide();
					return false;
			}
			return true;
		}
		
		#endregion
	}
}
