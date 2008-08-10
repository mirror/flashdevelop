using System;
using System.Drawing;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using System.Collections;
using PluginCore;
using WeifenLuo.WinFormsUI;
using ScintillaNet;

namespace PluginCore.Controls
{
	public class UITools : IMessageFilter
	{
		
		#region Events
		
		public delegate void CharAddedHandler(ScintillaControl sender, int value);
		public delegate void TextChangedHandler(ScintillaControl sender, int position, int length, int linesAdded);
		static public event CharAddedHandler OnCharAdded;
		static public event TextChangedHandler OnTextChanged;
		static private EventType eventMask = EventType.Shortcut | EventType.FileSave | EventType.SettingUpdate | EventType.Command | EventType.FileSwitch;
		static private bool ignoreKeys;
		
		#endregion
		
		#region Settings management
		
		static readonly private string SETTING_DELAY_HOVER = "FlashDevelop.CompletionList.HoverTipDelay";
		static readonly private string SETTING_FILTER = "FlashDevelop.CompletionList.AutoFilter";
		static readonly private string SETTING_DELAY = "FlashDevelop.CompletionList.DisplayDelay";
		static readonly private string SETTING_HIDE = "FlashDevelop.CompletionList.AutoHide";
		static readonly private string SETTING_DETAILS = "FlashDevelop.CompletionList.ShowDetailsDefault";
		static readonly private string SETTING_INSERTIONKEYS = "FlashDevelop.CompletionList.InsertionKeys";
		static readonly private string SETTING_WRAP = "FlashDevelop.CompletionList.Wrap";
		
		static private int hoverDelay = -1;
		
		static private void ReadSettings()
		{
			CompletionList.DisplayDelay = mainForm.MainSettings.GetInt(SETTING_DELAY);
			CompletionList.AutoFilterList = mainForm.MainSettings.GetBool(SETTING_FILTER);
			CompletionList.EnableAutoHide = mainForm.MainSettings.GetBool(SETTING_HIDE);
			CompletionList.WrapList = mainForm.MainSettings.GetBool(SETTING_WRAP);
			CompletionList.InsertionKeys = mainForm.MainSettings.GetValue(SETTING_INSERTIONKEYS);
			showDetails = showDetailsDefault = mainForm.MainSettings.GetBool(SETTING_DETAILS);
			int prevDelay = hoverDelay;
			hoverDelay = mainForm.MainSettings.GetInt(SETTING_DELAY_HOVER);
			if (prevDelay != hoverDelay)
			{
				ScintillaControl sci;
				foreach(DockContent doc in mainForm.GetDocuments())
				{
					sci = mainForm.GetSciControl(doc);
					if (sci != null) sci.MouseDwellTime = hoverDelay;
				}
			}
		}
		
		#endregion

		static private WeakReference lockedSciControl;
		static private IMainForm mainForm;
		static private bool showDetails;
		static private bool showDetailsDefault;
		
		static public bool ShowDetails {
			get { return showDetails; }
			set { showDetails = value; }
		}
		
		
		#region Singleton Instance
		
		static private UITools instance;
		
		static public void Init(IMainForm mainForm)
		{
			/**
			* CONTROLS
			*/
			instance = new UITools();
			UITools.mainForm = mainForm;
			try
			{
				CompletionList.CreateControl(mainForm);
				InfoTip.CreateControl(mainForm);
			}
			catch(Exception ex)
			{
				ErrorHandler.ShowError("Error while creating editor controls.", ex);
			}
			/**
			* SETTINGS
			*/
			if (!MainForm.MainSettings.HasKey(SETTING_DELAY_HOVER))
			{
				MainForm.MainSettings.AddValue(SETTING_DELAY_HOVER, "1000");
			}
			if (!MainForm.MainSettings.HasKey(SETTING_FILTER))
			{
				MainForm.MainSettings.AddValue(SETTING_FILTER, "true");
			}
			if (!MainForm.MainSettings.HasKey(SETTING_DELAY))
			{
				MainForm.MainSettings.AddValue(SETTING_DELAY, "100");
			}
			if (!MainForm.MainSettings.HasKey(SETTING_HIDE))
			{
				MainForm.MainSettings.AddValue(SETTING_HIDE, "false");
			}
			if (!MainForm.MainSettings.HasKey(SETTING_DETAILS))
			{
				MainForm.MainSettings.AddValue(SETTING_DETAILS, "false");
			}
			if (!MainForm.MainSettings.HasKey(SETTING_WRAP))
			{
				MainForm.MainSettings.AddValue(SETTING_WRAP, "false");
			}
			if (!MainForm.MainSettings.HasKey(SETTING_INSERTIONKEYS))
			{
				MainForm.MainSettings.AddValue(SETTING_INSERTIONKEYS, ".()[],;!+*/%=-><");
			}
			ReadSettings();
			// always ignore these keys
			MainForm.IgnoredKeys.Add(Keys.Space | Keys.Control); // complete member
			MainForm.IgnoredKeys.Add(Keys.Space | Keys.Control|Keys.Shift); // complete method
		}
		
		static public IMainForm MainForm
		{
			get { return mainForm; }
		}
		
		static public EventType EventMask
		{
			get { return eventMask; }
		}
		
		#endregion
		
		#region SciControls & MainForm Events
		
		static public void HandleEvent(object sender, NotifyEvent e)
		{
			switch (e.Type)
			{
				case EventType.Shortcut:
					e.Handled = HandleKeys(((KeyEvent)e).Value);
					return;
					
				case EventType.FileSave:
					MessageBar.HideWarning();
					return;
				
				case EventType.SettingUpdate:
					ReadSettings();
					DockContent[] docs = MainForm.GetDocuments();
					ScintillaControl sci;
					foreach (DockContent content in docs)
					{
						sci = MainForm.GetSciControl(content);
						if (sci != null) sci.MouseDwellTime = hoverDelay;
					}
					break;
			}
			// most of the time, and event should hide the list
			OnUIRefresh(null);
		}
		
		static public void ListenTo(ScintillaControl sci)
		{
			// hook scintilla events
			sci.MouseDwellTime = hoverDelay;
			sci.DwellStart += new DwellStartHandler(InfoTip.HandleDwellStart);
			sci.DwellEnd += new DwellEndHandler(InfoTip.HandleDwellEnd);
			sci.CharAdded += new ScintillaNet.CharAddedHandler(OnChar);
			sci.UpdateUI += new UpdateUIHandler(OnUIRefresh);
			sci.TextInserted += new TextInsertedHandler(OnTextInserted);
			sci.TextDeleted += new TextDeletedHandler(OnTextDeleted);
		}
		
		#endregion
		
		#region Scintilla Hook
		
		private const int WM_MOUSEWHEEL = 0x20A;
		[DllImport("User32.dll")]
        static extern Int32 SendMessage(int hWnd, int Msg, int wParam, int lParam);
        
		public bool PreFilterMessage(ref Message m)
		{
			if (m.Msg == WM_MOUSEWHEEL)
			{
				// capture all MouseWheel events and transmit to completionList
				SendMessage(CompletionList.GetHandle(), m.Msg, (Int32)m.WParam, (Int32)m.LParam);
				return true;
			}
			return false;
		}
		
		static public void LockControl(ScintillaControl sci)
		{
			UnlockControl();
			sci.IgnoreAllKeys = true;
			lockedSciControl = new WeakReference(sci);
			Application.AddMessageFilter(instance);
		}
		
		static public void UnlockControl()
		{
			Application.RemoveMessageFilter(instance);
			if ((lockedSciControl != null) && lockedSciControl.IsAlive)
			{
				ScintillaControl sci = (ScintillaControl)lockedSciControl.Target;
				sci.IgnoreAllKeys = false;
			}
			lockedSciControl = null;
			showDetails = showDetailsDefault;
		}

		static public void OnUIRefresh(ScintillaControl sci)
		{
			if (sci != null && sci.IsActive)
			{
				int position = sci.CurrentPos;
				if (CompletionList.Active && CompletionList.CheckPosition(position)) return;
				if (InfoTip.CallTipActive && InfoTip.CheckPosition(position)) return;
			}
			CompletionList.Hide();
			InfoTip.Hide();
		}
		
		static public void OnTextInserted(ScintillaControl sci, int position, int length, int linesAdded)
		{
			if (OnTextChanged != null) OnTextChanged(sci, position, length, linesAdded);
		}
		static public void OnTextDeleted(ScintillaControl sci, int position, int length, int linesAdded)
		{
			if (OnTextChanged != null) OnTextChanged(sci, position, -length, linesAdded);
		}
		
		static private void OnChar(ScintillaControl sci, int value)
		{
			if (sci == null) return;
			if (!CompletionList.Active && !InfoTip.CallTipActive)
			{
				if (OnCharAdded != null) OnCharAdded(sci, value);
				return;
			}
			if (lockedSciControl.IsAlive) sci = (ScintillaControl)lockedSciControl.Target;
			else
			{
				CompletionList.Hide();
				if (OnCharAdded != null) OnCharAdded(sci, value);
				return;
			}
			if (InfoTip.CallTipActive) 
			{
				InfoTip.OnChar(sci, value);
				return;
			}
			else CompletionList.OnChar(sci, value);
			return;
		}
		
		static public void SendChar(ScintillaControl sci, int value)
		{
			if (OnCharAdded != null) OnCharAdded(sci, value);	
		}
		
		static public bool HandleKeys(Keys key)
		{
			// UITools is currently broadcasting a shortcut, ignore!
			if (ignoreKeys) return false;
			
			// list/tip shortcut dispatching
			if ((key == (Keys.Control | Keys.Space)) || (key == (Keys.Shift | Keys.Control | Keys.Space)))
			{
				if (CompletionList.Active || InfoTip.CallTipActive)
				{
					UnlockControl();
					CompletionList.Hide();
					InfoTip.Hide();
				}
				// offer to handle the shortcut
				ignoreKeys = true;
				KeyEvent ke = new KeyEvent(EventType.Shortcut, key);
				MainForm.DispatchEvent(ke);
				ignoreKeys = false;
				// if not handled:
				if (!ke.Handled) MainForm.CallCommand("InsertSnippet", "null");
				return true;
			}
			// are we currently displaying something?
			if (!CompletionList.Active && !InfoTip.CallTipActive) return false;
			
			// hide if pressing Esc or Ctrl+Key combination
			if (!lockedSciControl.IsAlive || (key == Keys.Escape) 
			    || ((Control.ModifierKeys & Keys.Control) != 0 && Control.ModifierKeys != (Keys.Control|Keys.Alt)) )
			{
				UnlockControl();
				CompletionList.Hide();
				InfoTip.Hide();
				return false;
			}
			ScintillaControl sci = (ScintillaControl)lockedSciControl.Target;
			// chars
			string ks = key.ToString();
			if ((ks.Length == 1) || ks.EndsWith(", Shift") || ks.StartsWith("NumPad"))
			{
				return false;
			}
			
			// toggle "long-description"
			if (key == Keys.F1)
			{
				showDetails = !showDetails;
				if (InfoTip.CallTipActive) InfoTip.UpdateTip(sci);
				else CompletionList.UpdateTip();
				return true;
			}
			
			// switches
			else if (((key & Keys.ShiftKey) == Keys.ShiftKey) || ((key & Keys.ControlKey) == Keys.ControlKey) || ((key & Keys.Menu) == Keys.Menu))
			{
				return false;
			}
			
			// calltip keys handler
			if (InfoTip.CallTipActive) return InfoTip.HandleKeys(sci, key);
			
			// completion keys handler
			return CompletionList.HandleKeys(sci, key);
		}
		
		
		/**
		* Compute current editor line height
		*/
		static public int LineHeight(ScintillaControl sci)
		{
			if (sci == null) return 0;
			// evaluate the font size
			Font tempFont = new Font(sci.Font.Name, sci.Font.Size+sci.ZoomLevel);
			Graphics g = ((Control)sci).CreateGraphics();
			SizeF textSize = g.MeasureString("S", tempFont);
			return (int)(textSize.Height*0.9);
		}

		#endregion
		
	}
}
