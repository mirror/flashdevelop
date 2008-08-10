using System;
using System.Collections;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;
using ScintillaNet.Configuration;
using System.Drawing.Printing;
using System.Drawing;
using System.Text;

namespace ScintillaNet
{
	public class ScintillaControl : Control
	{
		private Encoding encoding;
		private int directPointer;
		private IntPtr hwndScintilla;
		private bool isActive = true;
		private bool ignoreAllKeys = false;
		private bool isBraceMatching = true;
		private string configLanguage = "";
		private static Scintilla sciConfiguration = null;
		private Enums.SmartIndent smartIndent = Enums.SmartIndent.CPP;
		private Hashtable ignoredKeys = new Hashtable();
		
		#region "Scintilla Main"
		
		public ScintillaControl() : this("SciLexer.dll")
		{
			DragAcceptFiles(this.Handle, 1);
		}

		public ScintillaControl(string fullpath)
		{
			try
			{
				IntPtr lib = WinAPI.LoadLibrary(fullpath);
				hwndScintilla = WinAPI.CreateWindowEx(0, "Scintilla", "", WS_CHILD_VISIBLE_TABSTOP, 0, 0, this.Width, this.Height, this.Handle, 0, new IntPtr(0), null);
				directPointer = (int)SlowPerform(2185, 0, 0);
				UpdateUI += new UpdateUIHandler(OnBraceMatch); // for automation
				Resize += new EventHandler(OnResize);
				CharAdded += new CharAddedHandler(OnSmartIndent);
				directPointer = DirectPointer;
			}
			catch (Exception x)
			{
				throw x;
			}
		}

		protected override void OnGotFocus(System.EventArgs e)
		{
			IsFocus = WinAPI.SetFocus(hwndScintilla) != IntPtr.Zero;
 		}
		
		protected override void OnLostFocus(System.EventArgs e)
		{
			IsFocus = false;
		}

		public new bool Focus()
		{
			OnGotFocus(new EventArgs());
			return IsFocus;
		}

		public override bool Focused
		{
			get { return IsFocus; }
		}

		public void OnResize(object sender, EventArgs e)
		{
			SetWindowPos(this.hwndScintilla, 0, base.Location.X, base.Location.Y, base.Width, base.Height, 0);
		}

		[System.ComponentModel.Browsable(false)]
		public override string Text
		{
			get { return GetText(Length); }
			set { SetText(value); }
		}

		/// <summary>
		/// The file name is stored in the Tag property
		/// </summary>
		public string FileName
		{
			get { return Tag as string; }
			set { Tag = value; }
		}
		
		public bool IsActive
		{
			get { return isActive; }
			set { isActive = value; }
		}
		
		public bool IgnoreAllKeys
		{
			get { return ignoreAllKeys; }
			set { ignoreAllKeys = value; }
		}
		
		public virtual void AddIgnoredKey(Shortcut shortcutkey)
		{
			int key = (int)shortcutkey;
			ignoredKeys.Add(key, key);
		}

		public virtual void AddIgnoredKey(System.Windows.Forms.Keys key, System.Windows.Forms.Keys modifier)
		{
			ignoredKeys.Add((int)key+(int)modifier, (int)key+(int)modifier);
		}

		public virtual void RemoveIgnoredKey(Shortcut shortcutkey)
		{
			int key = (int)shortcutkey;
			ignoredKeys.Remove((int)key);
		}

		public virtual void RemoveIgnoredKey(System.Windows.Forms.Keys key, System.Windows.Forms.Keys modifier)
		{
			ignoredKeys.Remove((int)key+(int)modifier);
		}
		
		public virtual bool ContainsIgnoredKey(Shortcut shortcutkey)
		{
			int key = (int)shortcutkey;
			return ignoredKeys.ContainsKey((int)key);
		}

		public override bool PreProcessMessage(ref Message m)
		{
			switch (m.Msg)
			{
				case WM_KEYDOWN:
				{
					if (!isActive || ignoreAllKeys || ignoredKeys.ContainsKey((int)Control.ModifierKeys+(int)m.WParam))
					{
						if (base.PreProcessMessage(ref m)) return true;
					}
					if (((Control.ModifierKeys & Keys.Control) != 0) && ((Control.ModifierKeys & Keys.Alt) == 0))
					{
						int code = (int)m.WParam;
						// don't process Ctrl+<?> keys (non-writable characters)
						if ((code >= 65) && (code <= 90)) return true;
						// transmit Ctrl with Tab, PageUp/PageDown
						else if ((code == 9) || (code == 33) || (code == 34)) return base.PreProcessMessage(ref m);
					}
					break;
				}
				case WM_SYSKEYDOWN:
				{
					return base.PreProcessMessage(ref m);
				}
			}
			return false;
		}

		static public ScintillaNet.Configuration.Scintilla Configuration
		{
			get { return sciConfiguration; }
			set { sciConfiguration = value; }
		}

		public string ConfigurationLanguage
		{	
			get { return this.configLanguage; }
			set
			{
				if (value == null || value.Equals("")) return;
				Language lang = sciConfiguration.GetLanguage(value);
				if (lang == null) return;
				StyleClearAll();
				try 
				{
					lang.lexer.key = (int)Enum.Parse(typeof(Enums.Lexer), lang.lexer.name, true); 
				}
				catch 
				{
					// If not found, uses the lang.lexer.key directly.
				}
				this.configLanguage = value;
				Lexer = lang.lexer.key;
				if (lang.lexer.stylebits > 0) StyleBits = lang.lexer.stylebits;
				if (lang.editorstyle != null)
				{
					CaretFore = lang.editorstyle.CaretForegroundColor;
					CaretLineBack = lang.editorstyle.CaretLineBackgroundColor;
					SetSelBack(true, lang.editorstyle.SelectionBackgroundColor);
					SetSelFore(true, lang.editorstyle.SelectionForegroundColor);
					EdgeColour = lang.editorstyle.EdgeBackgroundColor;
				}
				if (lang.characterclass != null)
				{
					WordChars(lang.characterclass.Characters);
				}
				for (int j = 0; j<lang.usestyles.Length; j++)
				{
					UseStyle usestyle = lang.usestyles[j];
					if (usestyle.key == 0)
					{
						System.Type theType = null;
						switch ((Enums.Lexer)lang.lexer.key)
						{
							case Enums.Lexer.ADA:
								 theType = typeof(Lexers.ADA);
								 break;
							case Enums.Lexer.APDL:
								 theType = typeof(Lexers.APDL);
								 break;
							case Enums.Lexer.ASM:
								 theType = typeof(Lexers.ASM);
								 break;
							case Enums.Lexer.ASN1:
								 theType = typeof(Lexers.ASN1);
								 break;
							case Enums.Lexer.AU3:
								 theType = typeof(Lexers.AU3);
								 break;
							case Enums.Lexer.AVE:
								 theType = typeof(Lexers.AVENUE);
								 break;
							case Enums.Lexer.BAAN:
								 theType = typeof(Lexers.BAAN);
								 break;
							case Enums.Lexer.BASH:
								 theType = typeof(Lexers.BASH);
								 break;
							case Enums.Lexer.BATCH:
								 theType = typeof(Lexers.BATCH);
								 break;
							case Enums.Lexer.BULLANT:
								 theType = typeof(Lexers.BULLANT);
								 break;
							case Enums.Lexer.CAML:
								 theType = typeof(Lexers.CAML);
								 break;
							case Enums.Lexer.CLW:
								 theType = typeof(Lexers.CLARION);
								 break;
							case Enums.Lexer.CONF:
								 theType = typeof(Lexers.CONF);
								 break;
							case Enums.Lexer.CPP:
								 theType = typeof(Lexers.CPP);
								 break;
							case Enums.Lexer.CSOUND:
								 theType = typeof(Lexers.CSOUND);
								 break;
							case Enums.Lexer.CSS:
								 theType = typeof(Lexers.CSS);
								 break;
							case Enums.Lexer.DIFF:
								 theType = typeof(Lexers.DIFF);
								 break;
							case Enums.Lexer.EIFFEL:
								 theType = typeof(Lexers.EIFFEL);
								 break;
							case Enums.Lexer.EIFFELKW:
								 theType = typeof(Lexers.EIFFELKW);
								 break;
							case Enums.Lexer.ERLANG:
								 theType = typeof(Lexers.ERLANG);
								 break;
							case Enums.Lexer.ERRORLIST:
								 theType = typeof(Lexers.ERRORLIST);
								 break;
							case Enums.Lexer.ESCRIPT:
								 theType = typeof(Lexers.ESCRIPT);
								 break;
							case Enums.Lexer.F77:
								 theType = typeof(Lexers.F77);
								 break;
							case Enums.Lexer.FLAGSHIP:
								 theType = typeof(Lexers.FLAGSHIP);
								 break;
							case Enums.Lexer.FORTH:
								 theType = typeof(Lexers.FORTH);
								 break;
							case Enums.Lexer.FORTRAN:
								 theType = typeof(Lexers.FORTRAN);
								 break;
							case Enums.Lexer.GUI4CLI:
								 theType = typeof(Lexers.GUI4CLI);
								 break;
							case Enums.Lexer.HASKELL:
								 theType = typeof(Lexers.HASKELL);
								 break;
							case Enums.Lexer.HTML:
								 theType = typeof(Lexers.HTML);
								 break;
							case Enums.Lexer.KIX:
								 theType = typeof(Lexers.KIX);
								 break;
							case Enums.Lexer.LATEX:
								 theType = typeof(Lexers.LATEX);
								 break;
							case Enums.Lexer.LISP:
								 theType = typeof(Lexers.LISP);
								 break;
							case Enums.Lexer.LOT:
								 theType = typeof(Lexers.LOT);
								 break;
							case Enums.Lexer.LOUT:
								 theType = typeof(Lexers.LOUT);
								 break;
							case Enums.Lexer.LUA:
								 theType = typeof(Lexers.LUA);
								 break;
							case Enums.Lexer.MAKEFILE:
								 theType = typeof(Lexers.MAKEFILE);
								 break;
							case Enums.Lexer.MATLAB:
								 theType = typeof(Lexers.MATLAB);
								 break;
							case Enums.Lexer.METAPOST:
								 theType = typeof(Lexers.METAPOST);
								 break;
							case Enums.Lexer.MMIXAL:
								 theType = typeof(Lexers.MMIXAL);
								 break;
							case Enums.Lexer.MSSQL:
								 theType = typeof(Lexers.MSSQL);
								 break;
							case Enums.Lexer.NNCRONTAB:
								 theType = typeof(Lexers.NNCRONTAB);
								 break;
							case Enums.Lexer.NSIS:
								 theType = typeof(Lexers.NSIS);
								 break;
							case Enums.Lexer.OCTAVE:
								 theType = typeof(Lexers.OCTAVE);
								 break;
							case Enums.Lexer.PASCAL:
								 theType = typeof(Lexers.PASCAL);
								 break;
							case Enums.Lexer.PERL:
								 theType = typeof(Lexers.PERL);
								 break;
							case Enums.Lexer.PHPSCRIPT:
								 theType = typeof(Lexers.PHP);
								 break;
							case Enums.Lexer.PROPERTIES:
								 theType = typeof(Lexers.PROPERTIES);
								 break;
							case Enums.Lexer.VB:
								 theType = typeof(Lexers.VB);
								 break;
							case Enums.Lexer.VBSCRIPT:
								 theType = typeof(Lexers.VBSCRIPT);
								 break;
							case Enums.Lexer.VERILOG:
								 theType = typeof(Lexers.VERILOG);
								 break;
							case Enums.Lexer.VHDL:
								 theType = typeof(Lexers.VHDL);
								 break;
							case Enums.Lexer.XML:
								 theType = typeof(Lexers.XML);
								 break;
							case Enums.Lexer.YAML:
								 theType = typeof(Lexers.YAML);
								 break;
						}
						usestyle.key = (int)Enum.Parse(theType, usestyle.name, true);
					}
					if (usestyle.HasForegroundColor) StyleSetFore(usestyle.key, usestyle.ForegroundColor);
					if (usestyle.HasBackgroundColor) StyleSetBack(usestyle.key, usestyle.BackgroundColor);
					if (usestyle.HasFontName) StyleSetFont(usestyle.key, usestyle.FontName);
					if (usestyle.HasFontSize) StyleSetSize(usestyle.key, usestyle.FontSize);
					if (usestyle.HasBold) StyleSetBold(usestyle.key, usestyle.IsBold);
					if (usestyle.HasItalics) StyleSetItalic(usestyle.key, usestyle.IsItalics);
					if (usestyle.HasEolFilled) StyleSetEOLFilled(usestyle.key, usestyle.IsEolFilled);
				}
				// Clear the keywords lists	
				for (int j = 0; j<9; j++) KeyWords(j, "");
				for (int j = 0; j<lang.usekeywords.Length; j++)
				{
					UseKeyword usekeyword = lang.usekeywords[j];
					KeywordClass kc = sciConfiguration.GetKeywordClass(usekeyword.cls);
					if (kc != null) KeyWords(usekeyword.key, kc.val);
				}
			}
		}

		#endregion

		#region "Scintilla Event Members"
		
		public event KeyHandler Key;
		public event ZoomHandler Zoom;
		public event StyleNeededHandler StyleNeeded;
        public event CharAddedHandler CharAdded;
        public event SavePointReachedHandler SavePointReached;
        public event SavePointLeftHandler SavePointLeft;
        public event ModifyAttemptROHandler ModifyAttemptRO;
        public event UpdateUIHandler UpdateUI;
        public event ModifiedHandler Modified;
        public event MacroRecordHandler MacroRecord;
        public event MarginClickHandler MarginClick;
        public event NeedShownHandler NeedShown;
        public event PaintedHandler Painted;
        public event UserListSelectionHandler UserListSelection;
        public event URIDroppedHandler URIDropped;
        public event DwellStartHandler DwellStart;
        public event DwellEndHandler DwellEnd;
        public event HotSpotClickHandler HotSpotClick;
        public event HotSpotDoubleClickHandler HotSpotDoubleClick;
        public event CallTipClickHandler CallTipClick;
        public event AutoCSelectionHandler AutoCSelection;
		public event TextInsertedHandler TextInserted;
		public event TextDeletedHandler TextDeleted;
		public event FoldChangedHandler FoldChanged;
		public event UserPerformedHandler UserPerformed;
		public event UndoPerformedHandler UndoPerformed;
		public event RedoPerformedHandler RedoPerformed;
		public event LastStepInUndoRedoHandler LastStepInUndoRedo;
		public event MarkerChangedHandler MarkerChanged;
		public event BeforeInsertHandler BeforeInsert;
		public event BeforeDeleteHandler BeforeDelete;
		public event SmartIndentHandler SmartIndent;
		public new event StyleChangedHandler StyleChanged;
		public new event DoubleClickHandler DoubleClick;
		
		#endregion

		#region "Scintilla Properties"
		
		/**
		* Enables the brace matching from current position.
		*/
		public bool IsBraceMatching
		{
			get { return isBraceMatching; }
			set { isBraceMatching = value; }
		}
		
		/**
		* Enables the Smart Indenter so that On enter, it indents the next line.
		*/
		public Enums.SmartIndent SmartIndentType
		{
			get { return smartIndent; }
			set { smartIndent = value; }
		}
		
		/**
		* Are white space characters currently visible?
		* Returns one of SCWS_* constants.
		*/
		public Enums.WhiteSpace ViewWhitespace
		{
			get { return (Enums.WhiteSpace)ViewWS; }
			set { ViewWS = (int)value; }
		}

		/**
		* Retrieve the current end of line mode - one of CRLF, CR, or LF.
		*/
		public Enums.EndOfLine EndOfLineMode
		{
			get { return (Enums.EndOfLine)EOLMode; }
			set { EOLMode = (int)value; }
		}
		
		/**
		* Length Method for : Retrieve the text of the line containing the caret.
		* Returns the index of the caret on the line.
		*/
		public int CurLineSize
		{	
			get
			{
				return (int)SPerform(2027, 0 , 0);
			}
		}
		
		/**
		* Length Method for : Retrieve the contents of a line.
		* Returns the length of the line.
		*/
		public int LineSize
		{	
			get
			{
				return (int)SPerform(2153, 0, 0);
			}
		}
		
		/**
		* Length Method for : Retrieve the selected text.
		* Return the length of the text.
		*/
		public int SelTextSize
		{	
			get
			{
				return (int)SPerform(2161, 0, 0);
			}
		}
		
		/**
		* Length Method for : Retrieve all the text in the document.
		* Returns number of characters retrieved.
		*/
		public int TextSize
		{	
			get
			{
				return (int)SPerform(2182, 0, 0);
			}
		}
		
		/**
		* Are there any redoable actions in the undo history?
		*/
		public bool CanRedo
		{
			get 
			{
				return SPerform(2016, 0, 0) != 0;
			}
		}
		
		/**
		* Is there an auto-completion list visible?
		*/
		public bool IsAutoCActive
		{
			get 
			{
				return SPerform(2102, 0, 0) != 0;
			}
		}	

		/**
		* Retrieve the position of the caret when the auto-completion list was displayed.
		*/
		public int AutoCPosStart
		{
			get 
			{
				return (int)SPerform(2103, 0, 0);
			}
		}	

		/**
		* Will a paste succeed?
		*/
		public bool CanPaste
		{
			get 
			{
				return SPerform(2173, 0, 0) != 0;
			}
		}	

		/**
		* Are there any undoable actions in the undo history?
		*/
		public bool CanUndo
		{
			get 
			{
				return SPerform(2174, 0, 0) != 0;
			}
		}	

		/**
		* Is there an active call tip?
		*/
		public bool IsCallTipActive
		{
			get 
			{
				return SPerform(2202, 0, 0) != 0;
			}
		}	

		/**
		* Retrieve the position where the caret was before displaying the call tip.
		*/
		public int CallTipPosStart
		{
			get 
			{
				return (int)SPerform(2203, 0, 0);
			}
		}	
		
		/**
		* Create a new document object.
		* Starts with reference count of 1 and not selected into editor.
		*/
		public int CreateDocument
		{
			get 
			{
				return (int)SPerform(2375, 0, 0);
			}
		}	

		/**
		* Get currently selected item position in the auto-completion list
		*/
		public int AutoCGetCurrent
		{
			get 
			{
				return (int)SPerform(2445, 0, 0);
			}
		}	

		/**
		* Returns the number of characters in the document.
		*/
		public int Length
		{
			get 
			{
				return (int)SPerform(2006, 0, 0); 
			}
		}
		
		/**
		* Enable/Disable convert-on-paste for line endings
		*/
		public bool PasteConvertEndings
		{
			get 
			{
				return SPerform(2468, 0, 0) != 0; 
			}
			set 
			{
				SPerform(2467, (uint)(value ? 1 : 0), 0);
			}
		}
		
		/**
		* Returns the position of the caret.
		*/
		public int CurrentPos
		{
			get 
			{
				return (int)SPerform(2008, 0, 0); 
			}
			set 
			{
				SPerform(2141, (uint)value , 0);
			}
		}
		
		/**
		* Returns the position of the opposite end of the selection to the caret.
		*/
		public int AnchorPosition
		{
			get 
			{
				return (int)SPerform(2009, 0, 0);
			}
			set
			{
				SPerform(2026, (uint)value , 0);
			}
		}

		/**
		* Is undo history being collected?
		*/
		public bool IsUndoCollection
		{
			get 
			{
				return SPerform(2019, 0, 0)!=0;
			}
			set
			{
				SPerform(2012 , (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Are white space characters currently visible?
		* Returns one of SCWS_* constants.
		*/
		public int ViewWS
		{
			get 
			{
				return (int)SPerform(2020, 0, 0);
			}
			set
			{
				SPerform(2021, (uint)value , 0);
			}
		}	

		/**
		* Retrieve the position of the last correctly styled character.
		*/
		public int EndStyled
		{
			get 
			{
				return (int)SPerform(2028, 0, 0);
			}
		}	

		/**
		* Retrieve the current end of line mode - one of CRLF, CR, or LF.
		*/
		public int EOLMode
		{
			get 
			{
				return (int)SPerform(2030, 0, 0);
			}
			set
			{
				SPerform(2031, (uint)value , 0);
			}
		}	

		/**
		* Is drawing done first into a buffer or direct to the screen?
		*/
		public bool IsBufferedDraw
		{
			get 
			{
				return SPerform(2034, 0, 0)!=0;
			}
			set
			{
				SPerform(2035 , (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Retrieve the visible size of a tab.
		*/
		public int TabWidth
		{
			get 
			{
				return (int)SPerform(2121, 0, 0);
			}
			set
			{
				SPerform(2036, (uint)value, 0);
			}
		}	

		/**
		* Get the time in milliseconds that the caret is on and off.
		*/
		public int CaretPeriod
		{
			get 
			{
				return (int)SPerform(2075, 0, 0);
			}
			set
			{
				SPerform(2076, (uint)value, 0);
			}
		}
		
		/**
		* Retrieve number of bits in style bytes used to hold the lexical state.
		*/
		public int StyleBits
		{
			get 
			{
				return (int)SPerform(2091, 0, 0);
			}
			set
			{
				SPerform(2090, (uint)value, 0);
			}
		}	

		/**
		* Retrieve the last line number that has line state.
		*/
		public int MaxLineState
		{
			get 
			{
				return (int)SPerform(2094, 0, 0);
			}
		}	

		/**
		* Is the background of the line containing the caret in a different colour?
		*/
		public bool IsCaretLineVisible
		{
			get 
			{
				return SPerform(2095, 0, 0) != 0;
			}
			set
			{
				SPerform(2096, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Get the colour of the background of the line containing the caret.
		*/
		public int CaretLineBack
		{
			get 
			{
				return (int)SPerform(2097, 0, 0);
			}
			set
			{
				SPerform(2098, (uint)value, 0);
			}
		}	

		/**
		* Retrieve the auto-completion list separator character.
		*/
		public int AutoCSeparator
		{
			get 
			{
				return (int)SPerform(2107, 0, 0);
			}
			set
			{
				SPerform(2106, (uint)value, 0);
			}
		}	

		/**
		* Retrieve whether auto-completion cancelled by backspacing before start.
		*/
		public bool IsAutoCGetCancelAtStart
		{
			get 
			{
				return SPerform(2111, 0, 0) != 0;
			}
			set
			{
				SPerform(2110 , (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Retrieve whether a single item auto-completion list automatically choose the item.
		*/
		public bool IsAutoCGetChooseSingle
		{
			get 
			{
				return SPerform(2114, 0, 0) != 0;
			}
			set
			{
				SPerform(2113, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Retrieve state of ignore case flag.
		*/
		public bool IsAutoCGetIgnoreCase
		{
			get 
			{
				return SPerform(2116, 0, 0) != 0;
			}
			set
			{
				SPerform(2115, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Retrieve whether or not autocompletion is hidden automatically when nothing matches.
		*/
		public bool IsAutoCGetAutoHide
		{
			get 
			{
				return SPerform(2119, 0, 0) != 0;
			}
			set
			{
				SPerform(2118, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Retrieve whether or not autocompletion deletes any word characters
		* after the inserted text upon completion.
		*/
		public bool IsAutoCGetDropRestOfWord
		{
			get 
			{
				return SPerform(2271, 0, 0) != 0;
			}
			set
			{
				SPerform(2270, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Retrieve the auto-completion list type-separator character.
		*/
		public int AutoCTypeSeparator
		{
			get 
			{
				return (int)SPerform(2285, 0, 0);
			}
			set
			{
				SPerform(2286, (uint)value, 0);
			}
		}	

		/**
		* Retrieve indentation size.
		*/
		public int Indent
		{
			get 
			{
				return (int)SPerform(2123, 0, 0);
			}
			set
			{
				SPerform(2122, (uint)value, 0);
			}
		}	

		/**
		* Retrieve whether tabs will be used in indentation.
		*/
		public bool IsUseTabs
		{
			get 
			{
				return SPerform(2125, 0, 0) != 0;
			}
			set
			{
				SPerform(2124 , (uint)(value ? 1 : 0), 0);
			}
		}

		/**
		* Is the horizontal scroll bar visible? 
		*/
		public bool IsHScrollBar
		{
			get 
			{
				return SPerform(2131, 0, 0) != 0;
			}
			set
			{
				SPerform(2130, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Are the indentation guides visible?
		*/
		public bool IsIndentationGuides
		{
			get 
			{
				return SPerform(2133, 0, 0) != 0;
			}
			set
			{
				SPerform(2132, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Get the highlighted indentation guide column.
		*/
		public int HighlightGuide
		{
			get 
			{
				return (int)SPerform(2135, 0, 0);
			}
			set
			{
				SPerform(2134, (uint)value, 0);
			}
		}	

		/**
		* Get the code page used to interpret the bytes of the document as characters.
		*/
		public int CodePage
		{
			get 
			{
				return (int)SPerform(2137, 0, 0);
			}
			set
			{
				SPerform(2037, (uint)value, 0);
			}
		}	

		/**
		* Get the foreground colour of the caret.
		*/
		public int CaretFore
		{
			get 
			{
				return (int)SPerform(2138, 0, 0);
			}
			set
			{
				SPerform(2069, (uint)value, 0);
			}
		}	

		/**
		* In palette mode?
		*/
		public bool IsUsePalette
		{
			get 
			{
				return SPerform(2139, 0, 0) != 0;
			}
			set
			{
				SPerform(2039, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* In read-only mode?
		*/
		public bool IsReadOnly
		{
			get 
			{
				return SPerform(2140, 0, 0) != 0;
			}
			set
			{
				SPerform(2171, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Returns the position at the start of the selection.
		*/
		public int SelectionStart
		{
			get 
			{
				return (int)SPerform(2143, 0, 0);
			}
			set
			{
				SPerform(2142, (uint)value, 0);
			}
		}	

		/**
		* Returns the position at the end of the selection.
		*/
		public int SelectionEnd
		{
			get 
			{
				return (int)SPerform(2145, 0, 0);
			}
			set
			{
				SPerform(2144, (uint)value, 0);
			}
		}	

		/**
		* Returns the print magnification.
		*/
		public int PrintMagnification
		{
			get 
			{
				return (int)SPerform(2147, 0, 0);
			}
			set
			{
				SPerform(2146, (uint)value, 0);
			}
		}	

		/**
		* Returns the print colour mode.
		*/
		public int PrintColourMode
		{
			get 
			{
				return (int)SPerform(2149, 0, 0);
			}
			set
			{
				SPerform(2148, (uint)value, 0);
			}
		}	

		/**
		* Retrieve the display line at the top of the display.
		*/
		public int FirstVisibleLine
		{
			get 
			{
				return (int)SPerform(2152, 0, 0);
			}
		}	

		/**
		* Returns the number of lines in the document. There is always at least one.
		*/
		public int LineCount
		{
			get 
			{
				return (int)SPerform(2154, 0, 0);
			}
		}	

		/**
		* Returns the size in pixels of the left margin.
		*/
		public int MarginLeft
		{
			get 
			{
				return (int)SPerform(2156, 0, 0);
			}
			set
			{
				SPerform(2155, 0, (uint)value);
			}
		}	

		/**
		* Returns the size in pixels of the right margin.
		*/
		public int MarginRight
		{
			get 
			{
				return (int)SPerform(2158, 0, 0);
			}
			set
			{
				SPerform(2157, 0, (uint)value);
			}
		}	

		/**
		* Is the document different from when it was last saved?
		*/	
		public bool IsModify
		{
			get 
			{
				return SPerform(2159, 0, 0) != 0;
			}
		}	

		/**
		* Retrieve the number of characters in the document.
		*/
		public int TextLength
		{
			get 
			{
				return (int)SPerform(2183, 0, 0);
			}
		}	

		/**
		* Retrieve a pointer to a function that processes messages for this Scintilla.
		*/
		public int DirectFunction
		{
			get 
			{
				return (int)SPerform(2184, 0, 0);
			}
		}	

		/**
		* Retrieve a pointer value to use as the first argument when calling
		* the function returned by GetDirectFunction.
		*/
		public int DirectPointer
		{
			get 
			{
				return (int)SPerform(2185, 0, 0);
			}
		}	

		/**
		* Returns true if overtype mode is active otherwise false is returned.
		*/
		public bool IsOvertype
		{
			get 
			{
				return SPerform(2187, 0, 0) != 0;
			}
			set
			{
				SPerform(2186 , (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Returns the width of the insert mode caret.
		*/
		public int CaretWidth
		{
			get 
			{
				return (int)SPerform(2189, 0, 0);
			}
			set
			{
				SPerform(2188, (uint)value, 0);
			}
		}	

		/**
		* Get the position that starts the target. 
		*/
		public int TargetStart
		{
			get 
			{
				return (int)SPerform(2191, 0, 0);
			}
			set
			{
				SPerform(2190, (uint)value , 0);
			}
		}	

		/**
		* Get the position that ends the target.
		*/
		public int TargetEnd
		{
			get 
			{
				return (int)SPerform(2193, 0, 0);
			}
			set
			{
				SPerform(2192, (uint)value , 0);
			}
		}	

		/**
		* Get the search flags used by SearchInTarget.
		*/
		public int SearchFlags
		{
			get 
			{
				return (int)SPerform(2199, 0, 0);
			}
			set
			{
				SPerform(2198, (uint)value, 0);
			}
		}
		
		/**
		* Is a line visible?
		*/	
		public bool IsLineVisible
		{
			get 
			{
				return SPerform(2228, 0, 0) != 0;
			}
		}

		/**
		* Does a tab pressed when caret is within indentation indent?
		*/
		public bool IsTabIndents
		{
			get 
			{
				return SPerform(2261, 0, 0) != 0;
			}
			set
			{
				SPerform(2260, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Does a backspace pressed when caret is within indentation unindent?
		*/
		public bool IsBackSpaceUnIndents
		{
			get 
			{
				return SPerform(2263, 0, 0) != 0;
			}
			set
			{
				SPerform(2262, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Retrieve the time the mouse must sit still to generate a mouse dwell event.
		*/
		public int MouseDwellTime
		{
			get 
			{
				return (int)SPerform(2265, 0, 0);
			}
			set
			{
				SPerform(2264, (uint)value, 0);
			}
		}	

		/**
		* Retrieve whether text is word wrapped.
		*/
		public int WrapMode
		{
			get 
			{
				return (int)SPerform(2269, 0, 0);
			}
			set
			{
				SPerform(2268, (uint)value, 0);
			}
		}	

		/**
		* Retrive the display mode of visual flags for wrapped lines.
		*/
		public int WrapVisualFlags
		{
			get 
			{
				return (int)SPerform(2461, 0, 0);
			}
			set
			{
				SPerform(2460, (uint)value , 0);
			}
		}	

		/**
		* Retrive the location of visual flags for wrapped lines.
		*/
		public int WrapVisualFlagsLocation
		{
			get 
			{
				return (int)SPerform(2463, 0, 0);
			}
			set
			{
				SPerform(2462, (uint)value, 0);
			}
		}	

		/**
		* Retrive the start indent for wrapped lines.
		*/
		public int WrapStartIndent
		{
			get 
			{
				return (int)SPerform(2465, 0, 0);
			}
			set
			{
				SPerform(2464, (uint)value, 0);
			}
		}	

		/**
		* Retrieve the degree of caching of layout information.
		*/
		public int LayoutCache
		{
			get 
			{
				return (int)SPerform(2273, 0, 0);
			}
			set
			{
				SPerform(2272, (uint)value, 0);
			}
		}	

		/**
		* Retrieve the document width assumed for scrolling.
		*/
		public int ScrollWidth
		{
			get 
			{
				return (int)SPerform(2275, 0, 0);
			}
			set
			{
				SPerform(2274, (uint)value, 0);
			}
		}	

		/**
		* Retrieve whether the maximum scroll position has the last
		* line at the bottom of the view.
		*/
		public int EndAtLastLine
		{
			get 
			{
				return (int)SPerform(2278, 0, 0);
			}
			set
			{
				SPerform(2277, (uint)value , 0);
			}
		}	

		/**
		* Is the vertical scroll bar visible?
		*/
		public bool IsVScrollBar
		{
			get 
			{
				return SPerform(2281, 0, 0) != 0;
			}
			set
			{
				SPerform(2280, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Is drawing done in two phases with backgrounds drawn before faoregrounds?
		*/
		public bool IsTwoPhaseDraw
		{
			get 
			{
				return SPerform(2283, 0, 0)!=0;
			}
			set
			{
				SPerform(2284, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Are the end of line characters visible?
		*/
		public bool IsViewEOL
		{
			get 
			{
				return SPerform(2355, 0, 0) != 0;
			}
			set
			{
				SPerform(2356, (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Retrieve a pointer to the document object.
		*/
		public int DocPointer
		{
			get 
			{
				return (int)SPerform(2357, 0, 0);
			}
			set
			{
				SPerform(2358, (uint)value, 0);
			}
		}	

		/**
		* Retrieve the column number which text should be kept within.
		*/
		public int EdgeColumn
		{
			get 
			{
				return (int)SPerform(2360, 0, 0);
			}
			set
			{
				SPerform(2361, (uint)value, 0);
			}
		}	

		/**
		* Retrieve the edge highlight mode.
		*/
		public int EdgeMode
		{
			get 
			{
				return (int)SPerform(2362, 0, 0);
			}
			set
			{
				SPerform(2363, (uint)value, 0);
			}
		}	

		/**
		* Retrieve the colour used in edge indication.
		*/
		public int EdgeColour
		{
			get 
			{
				return (int)SPerform(2364, 0, 0);
			}
			set
			{
				SPerform(2365, (uint)value, 0);
			}
		}	

		/**
		* Retrieves the number of lines completely visible.
		*/
		public int LinesOnScreen
		{
			get 
			{
				return (int)SPerform(2370, 0, 0);
			}
		}	

		/**
		* Is the selection rectangular? The alternative is the more common stream selection. 
		*/	
		public bool IsSelectionRectangle
		{
			get 
			{
				return SPerform(2372, 0, 0) != 0;
			}
		}	

		/**
		* Set the zoom level. This number of points is added to the size of all fonts.
		* It may be positive to magnify or negative to reduce. Retrieve the zoom level.
		*/
		public int ZoomLevel
		{
			get 
			{
				return (int)SPerform(2374, 0, 0);
			}
			set
			{
				SPerform(2373, (uint)value, 0);
			}
		}	

		/**
		* Get which document modification events are sent to the container.
		*/
		public int ModEventMask
		{
			get 
			{
				return (int)SPerform(2378, 0, 0);
			}
			set
			{
				SPerform(2359, (uint)value, 0);
			}
		}	

		/**
		* Change internal focus flag. Get internal focus flag.
		*/
		public bool IsFocus
		{
			get 
			{
				return SPerform(2381, 0, 0) != 0;
			}
			set
			{
				SPerform(2380 , (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Change error status - 0 = OK. Get error status.
		*/
		public int Status
		{
			get 
			{
				return (int)SPerform(2383, 0, 0);
			}
			set
			{
				SPerform(2382, (uint)value, 0);
			}
		}	

		/**
		* Set whether the mouse is captured when its button is pressed. Get whether mouse gets captured.
		*/
		public bool IsMouseDownCaptures
		{
			get 
			{
				return SPerform(2385, 0, 0) != 0;
			}
			set
			{
				SPerform(2384 , (uint)(value ? 1 : 0), 0);
			}
		}	

		/**
		* Sets the cursor to one of the SC_CURSOR* values. Get cursor type.
		*/
		public int CursorType
		{
			get 
			{
				return (int)SPerform(2387, 0, 0);
			}
			set
			{
				SPerform(2386, (uint)value, 0);
			}
		}	

		/**
		* Change the way control characters are displayed:
		* If symbol is < 32, keep the drawn way, else, use the given character.
		* Get the way control characters are displayed.
		*/
		public int ControlCharSymbol
		{
			get 
			{
				return (int)SPerform(2389, 0, 0);
			}
			set
			{
				SPerform(2388, (uint)value, 0);
			}
		}	

		/**
		* Get and Set the xOffset (ie, horizonal scroll position).
		*/
		public int XOffset
		{
			get 
			{
				return (int)SPerform(2398, 0, 0);
			}
			set
			{
				SPerform(2397, (uint)value, 0);
			}
		}	

		/**
		* Is printing line wrapped?
		*/
		public int PrintWrapMode
		{
			get 
			{
				return (int)SPerform(2407, 0, 0);
			}
			set
			{
				SPerform(2406, (uint)value, 0);
			}
		}	

		/**
		* Get the mode of the current selection.
		*/
		public int SelectionMode
		{
			get 
			{
				return (int)SPerform(2423, 0, 0);
			}
			set
			{
				SPerform(2422, (uint)value, 0);
			}
		}	

		/**
		* Retrieve the lexing language of the document.
		*/
		public int Lexer
		{
			get 
			{
				return (int)SPerform(4002, 0, 0);
			}
			set
			{
				SPerform(4001, (uint)value, 0);
			}
		}		
						
		#endregion

		#region "Scintilla Methods"
		
		/**
		* Duplicate the selection. 
		* If selection empty duplicate the line containing the caret.
		*/
		public void SelectionDuplicate()
		{
			SPerform(2469, 0, 0);
		}
		
		/**
		* Can the caret preferred x position only be changed by explicit movement commands?
		*/
		public bool GetCaretSticky()
		{
			return SPerform(2457, 0, 0) != 0;
		}
		
		/**
		* Stop the caret preferred x position changing when the user types.
		*/
		public void SetCaretSticky(bool useSetting)
		{
			SPerform(2458, (uint)(useSetting ? 1 : 0), 0);
		}
		
		/**
		* Switch between sticky and non-sticky: meant to be bound to a key.
		*/
		public void ToggleCaretSticky()
		{
			SPerform(2459, 0, 0);
		}
		
		/**
		* Retrieve the fold level of a line.
		*/
		public int GetFoldLevel(int line)
		{
			return (int)SPerform(2223, (uint)line, 0);
		}

		/**
		* Set the fold level of a line.
		* This encodes an integer level along with flags indicating whether the
		* line is a header and whether it is effectively white space.
		*/
		public void SetFoldLevel(int line, int level)
		{
			SPerform(2222, (uint)line, (uint)level);
		}	

		/**
		* Find the last child line of a header line.
		*/
		public int LastChild(int line, int level)
		{
				return (int)SPerform(2224, (uint)line, (uint)level);
		}	

		/**
		* Find the last child line of a header line. 
		*/
		public int LastChild(int line)
		{
			return (int)SPerform(2224, (uint)line, 0);
		}	

		/**
		* Find the parent line of a child line.
		*/
		public int FoldParent(int line)
		{
			return (int)SPerform(2225, (uint)line, 0);
		}	
		
		/**
		* Is a header line expanded?
		*/
		public bool FoldExpanded(int line)
		{
			return SPerform(2230, (uint)line, 0) != 0;
		}

		/**
		* Show the children of a header line.
		*/
		public void FoldExpanded(int line, bool expanded)
		{
			SPerform(2229, (uint)line, (uint)(expanded ? 1 : 0));
		}	
		
		/**
		* Clear all the styles and make equivalent to the global default style.
		*/
		public void StyleClearAll()
		{
			SPerform(2050, 0, 0);
		}	

		/**
		* Set the foreground colour of a style.
		*/
		public void StyleSetFore(int style, int fore)
		{
			SPerform(2051, (uint)style, (uint)fore);
		}	

		/**
		* Set the background colour of a style.
		*/
		public void StyleSetBack(int style, int back)
		{
			SPerform(2052, (uint)style, (uint)back);
		}	

		/**
		* Set a style to be bold or not.
		*/
		public void StyleSetBold(int style, bool bold)
		{
			SPerform(2053, (uint)style, (uint)(bold ? 1 : 0));
		}	

		/**
		* Set a style to be italic or not.
		*/
		public void StyleSetItalic(int style, bool italic)
		{
			SPerform(2054, (uint)style, (uint)(italic ? 1 : 0));
		}	

		/**
		* Set the size of characters of a style.
		*/
		public void StyleSetSize(int style, int sizePoints)
		{
			SPerform(2055, (uint)style, (uint)sizePoints);
		}	

		/**
		* Set the font of a style.
		*/
		unsafe public void StyleSetFont(int style, string fontName)
		{
			if (fontName == null || fontName.Equals("")) fontName = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(fontName)) 
			{
				SPerform(2056,(uint)style, (uint)b );
			}
		}	
						
		/**
		* Set a style to have its end of line filled or not.
		*/
		public void StyleSetEOLFilled(int style, bool filled)
		{
			SPerform(2057, (uint)style, (uint)(filled ? 1 : 0));
		}	

		/**
		* Set a style to be underlined or not.
		*/
		public void StyleSetUnderline(int style, bool underline )
		{
			SPerform(2059, (uint)style, (uint)(underline?1:0) );
		}	

		/**
		* Set a style to be mixed case, or to force upper or lower case.
		*/
		public void StyleSetCase(int style, int caseForce)
		{
			SPerform(2060, (uint)style, (uint)caseForce);
		}	

		/**
		* Set the character set of the font in a style.
		*/
		public void StyleSetCharacterSet(int style, int characterSet )
		{
			SPerform(2066, (uint)style, (uint)characterSet);
		}	

		/**
		* Set a style to be a hotspot or not.
		*/
		public void StyleSetHotSpot(int style, bool hotspot)
		{
			SPerform(2409, (uint)style, (uint)(hotspot ? 1 : 0));
		}	

		/**
		* Set a style to be visible or not.
		*/
		public void StyleSetVisible(int style, bool visible)
		{
			SPerform(2074, (uint)style, (uint)(visible ? 1 : 0));
		}	

		/**
		* Set the set of characters making up words for when moving or selecting by word.
		* First sets deaults like SetCharsDefault.
		*/
		unsafe public void WordChars(string characters )
		{
			if (characters == null || characters.Equals("")) characters = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(characters))
			{
				SPerform(2077, 0, (uint)b);
			}
		}					

		/**
		* Set a style to be changeable or not (read only).
		* Experimental feature, currently buggy.
		*/
		public void StyleSetChangeable(int style, bool changeable )
		{
			SPerform(2099, (uint)style, (uint)(changeable?1:0) );
		}	

		/**
		* Define a set of characters that when typed will cause the autocompletion to
		* choose the selected item.
		*/
		unsafe public void AutoCSetFillUps(string characterSet )
		{
			if (characterSet == null || characterSet.Equals("")) characterSet = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(characterSet))
			{
				SPerform(2112, 0, (uint)b);
			}
		}	
		
		/**
		* Enable / Disable underlining active hotspots.
		*/
		public void HotspotActiveUnderline(bool useSetting)
		{
			SPerform(2412, (uint)(useSetting ? 1 : 0), 0);
		}
		
		/**
		* Limit hotspots to single line so hotspots on two lines don't merge.
		*/
		public void HotspotSingleLine(bool useSetting)
		{
			SPerform(2421, (uint)(useSetting ? 1 : 0), 0);
		}	
		
		/**
		* Set a fore colour for active hotspots.
		*/
		public void HotspotActiveFore(bool useSetting, int fore)
		{
			SPerform(2410, (uint)(useSetting ? 1 : 0), (uint)fore);
		}	

		/**
		* Set a back colour for active hotspots.
		*/
		public void HotspotActiveBack(bool useSetting, int back)
		{
			SPerform(2411, (uint)(useSetting ? 1 : 0), (uint)back);
		}
		
		/**
		* Retrieve the number of bits the current lexer needs for styling.
		*/
		public int GetStyleBitsNeeded()
		{
			return (int)SPerform(4011, 0, 0);
		}
		
		/**
		* Set the set of characters making up whitespace for when moving or selecting by word.
		* Should be called after SetWordChars.
		*/
		unsafe public void WhitespaceChars(string characters)
		{
			if (characters == null || characters.Equals("")) characters = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(characters)) 
			{
				SPerform(2443, 0, (uint)b);
			}
		}	
						
		/**
		* Set up a value that may be used by a lexer for some optional feature.
		*/
		unsafe public void SetProperty(string key, string val)
		{
			if (key == null || key.Equals("")) key = "\0\0";
			if (val == null || val.Equals("")) val = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(val))
			{
				fixed (byte* b2 = Encoding.GetEncoding(this.CodePage).GetBytes(key))
				{
					SPerform(4004, (uint)b2, (uint)b);
				}
			}
		}
		
		/**
		* Retrieve a "property" value previously set with SetProperty,
		* interpreted as an int AFTER any "$()" variable replacement.
		*/
		unsafe public int GetPropertyInt(string key)
		{
			if (key == null || key.Equals("")) key = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(key))
			{
				return (int)SPerform(4010, (uint)b, 0);
			}
		}
		
		/**
		* Set up the key words used by the lexer.
		*/
		unsafe public void KeyWords(int keywordSet, string keyWords)
		{
			if (keyWords == null || keyWords.Equals("")) keyWords = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(keyWords))
			{
				SPerform(4005, (uint)keywordSet, (uint)b);
			}
		}	
						
		/**
		* Set the lexing language of the document based on string name.
		*/
		unsafe public void LexerLanguage(string language)
		{
			if (language == null || language.Equals("")) language = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(language))
			{
				SPerform(4006, 0, (uint)b);
			}
		}
		
		/**
		* Retrieve the extra styling information for a line.
		*/
		public int GetLineState(int line)
		{
			return (int)SPerform(2093,(uint)line, 0);
		}

		/**
		* Used to hold extra styling information for each line.
		*/
		public void SetLineState(int line, int state)
		{
			SPerform(2092, (uint)line, (uint)state);
		}
		
		/**
		* Retrieve the number of columns that a line is indented.
		*/
		public int GetLineIndentation(int line)
		{
			return (int)SPerform(2127, (uint)line, 0);
		}

		/**
		* Change the indentation of a line to a number of columns.
		*/
		public void SetLineIndentation(int line, int indentSize)
		{
			SPerform(2126, (uint)line, (uint)indentSize);
		}	

		/**
		* Retrieve the position before the first non indentation character on a line.
		*/
		public int LineIndentPosition(int line)
		{
			return (int)SPerform(2128, (uint)line, 0);
		}	

		/**
		* Retrieve the column number of a position, taking tab width into account.
		*/
		public int Column(int pos)
		{
			return (int)SPerform(2129, (uint)pos, 0);
		}
		
		/**
		* Get the position after the last visible characters on a line.
		*/
		public int LineEndPosition(int line)
		{
			return (int)SPerform(2136, (uint)line, 0);
		}
		
		/**
		* Returns the character byte at the position.
		*/
		public int CharAt(int pos)
		{
			return (int)SPerform(2007, (uint)pos, 0);
		}	
		
		/**
		* Returns the style byte at the position.
		*/
		public int StyleAt(int pos)
		{
			return (int)SPerform(2010, (uint)pos, 0);
		}	
		
		/**
		* Retrieve the type of a margin.
		*/
		public int GetMarginTypeN(int margin)
		{
			return (int)SPerform(2241, (uint)margin, 0);
		}

		/**
		* Set a margin to be either numeric or symbolic.
		*/
		public void SetMarginTypeN(int margin, int marginType)
		{
			SPerform(2240, (uint)margin, (uint)marginType);
		}	

		/**
		* Retrieve the width of a margin in pixels.
		*/
		public int GetMarginWidthN(int margin)
		{
			return (int)SPerform(2243,(uint)margin, 0);
		}

		/**
		* Set the width of a margin to a width expressed in pixels.
		*/
		public void SetMarginWidthN(int margin, int pixelWidth)
		{
			SPerform(2242, (uint)margin, (uint)pixelWidth);
		}	

		/**
		* Retrieve the marker mask of a margin.
		*/
		public int GetMarginMaskN(int margin)
		{
			return (int)SPerform(2245, (uint)margin, 0);
		}

		/**
		* Set a mask that determines which markers are displayed in a margin.
		*/
		public void SetMarginMaskN(int margin, int mask)
		{
			SPerform(2244, (uint)margin, (uint)mask);
		}	

		/**
		* Retrieve the mouse click sensitivity of a margin.
		*/
		public bool MarginSensitiveN(int margin)
		{
			return SPerform(2247, (uint)margin, 0) != 0;
		}

		/**
		* Make a margin sensitive or insensitive to mouse clicks.
		*/
		public void MarginSensitiveN(int margin, bool sensitive)
		{
			SPerform(2246, (uint)margin, (uint)(sensitive ? 1 : 0));
		}
		
		/**
		* Retrieve the style of an indicator.
		*/
		public int GetIndicStyle(int indic)
		{
			return (int)SPerform(2081, (uint)indic, 0);
		}

		/**
		* Set an indicator to plain, squiggle or TT.
		*/
		public void SetIndicStyle(int indic, int style)
		{
			SPerform(2080, (uint)indic , (uint)style);
		}	

		/**
		* Retrieve the foreground colour of an indicator.
		*/
		public int GetIndicFore(int indic)
		{
			return (int)SPerform(2083,(uint)indic, 0);
		}

		/**
		* Set the foreground colour of an indicator.
		*/
		public void SetIndicFore(int indic, int fore)
		{
			SPerform(2082, (uint)indic, (uint)fore);
		}
		
		/**
		* Add text to the document at current position.
		*/
		unsafe public void AddText(int length, string text )
		{
			if (text == null || text.Equals("")) text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text)) 
			{
				 SPerform(2001,(uint)length, (uint)b);
			}
		}			

		/**
		* Insert string at a position. 
		*/
		unsafe public void InsertText(int pos, string text )
		{
			if (text == null || text.Equals("")) text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text)) 
			{
				SPerform(2003, (uint)pos, (uint)b);
			}
		}	
						
		/**
		* Convert all line endings in the document to one mode.
		*/
		public void ConvertEOLs(Enums.EndOfLine eolMode)
		{
			ConvertEOLs((int)eolMode);
		}	

		/**
		* Set the symbol used for a particular marker number.
		*/
		public void MarkerDefine(int markerNumber, Enums.MarkerSymbol markerSymbol)
		{
			MarkerDefine(markerNumber, (int)markerSymbol);
		}

		/**
		* Set the character set of the font in a style.
		*/
		public void StyleSetCharacterSet(int style, Enums.CharacterSet characterSet)
		{
			StyleSetCharacterSet(style, (int)characterSet);
		}	

		/**
		* Set a style to be mixed case, or to force upper or lower case.
		*/
		public void StyleSetCase(int style, Enums.CaseVisible caseForce)
		{
			StyleSetCase(style, (int)caseForce);
		}	
		
		/**
		* Delete all text in the document.
		*/
		public void ClearAll()
		{
			SPerform(2004, 0, 0);
		}	
						

		/**
		* Set all style bytes to 0, remove all folding information.
		*/
		public void ClearDocumentStyle()
		{
			SPerform(2005, 0, 0);
		}	
						
		/**
		* Redoes the next action on the undo history.
		*/
		public void Redo()
		{
			SPerform(2011, 0, 0);
		}	
						
		/**
		* Select all the text in the document.
		*/
		public void SelectAll()
		{
			SPerform(2013, 0, 0);
		}	
						
		/**
		* Remember the current position in the undo history as the position
		* at which the document was saved. 
		*/
		public void SetSavePoint()
		{
			SPerform(2014, 0, 0);
		}	
					
		/**
		* Retrieve the line number at which a particular marker is located.
		*/
		public int MarkerLineFromHandle(int handle)
		{
			return (int)SPerform(2017, (uint)handle, 0);
		}	
						
		/**
		* Delete a marker.
		*/
		public void MarkerDeleteHandle(int handle)
		{
			 SPerform(2018, (uint)handle, 0);
		}	
						
		/**
		* Find the position from a point within the window.
		*/
		public int PositionFromPoint(int x, int y)
		{
			return (int)SPerform(2022, (uint)x, (uint)y);
		}	
						
		/**
		* Find the position from a point within the window but return
		* INVALID_POSITION if not close to text.
		*/
		public int PositionFromPointClose(int x, int y)
		{
			return (int)SPerform(2023, (uint)x, (uint)y);
		}	
						
		/**
		* Set caret to start of a line and ensure it is visible.
		*/
		public void GotoLine(int line)
		{
			 SPerform(2024, (uint)line, 0);
		}	
						
		/**
		* Set caret to a position and ensure it is visible.
		*/
		public void GotoPos(int pos)
		{
			 SPerform(2025, (uint)pos, 0);
		}	
						
		/**
		* Retrieve the text of the line containing the caret.
		* Returns the index of the caret on the line.
		*/
		unsafe public string GetCurLine(int length)
		{
				int sz = (int)SPerform(2027, (uint)length, 0);
				byte[] buffer = new byte[sz+1];
				fixed (byte* b = buffer) 
				{
					SPerform(2027, (uint)length+1, (uint)b);
				}
				return Encoding.GetEncoding(this.CodePage).GetString(buffer, 0, sz-1);
		}

		/**
		* Convert all line endings in the document to one mode.
		*/
		public void ConvertEOLs(int eolMode)
		{
			 SPerform(2029, (uint)eolMode, 0);
		}	
					
		/**
		* Set the current styling position to pos and the styling mask to mask.
		* The styling mask can be used to protect some bits in each styling byte from modification.
		*/
		public void StartStyling(int pos, int mask)
		{
			 SPerform(2032, (uint)pos, (uint)mask);
		}	
						
		/**
		* Change style from current styling position for length characters to a style
		* and move the current styling position to after this newly styled segment.
		*/
		public void SetStyling(int length, int style)
		{
			 SPerform(2033, (uint)length, (uint)style);
		}	
						
		/**
		* Set the symbol used for a particular marker number.
		*/
		public void MarkerDefine(int markerNumber, int markerSymbol)
		{
			 SPerform(2040, (uint)markerNumber, (uint)markerSymbol);
		}	
						
		/**
		* Set the foreground colour used for a particular marker number.
		*/
		public void MarkerSetFore(int markerNumber, int fore)
		{
			 SPerform(2041, (uint)markerNumber, (uint)fore);
		}	
						
		/**
		* Set the background colour used for a particular marker number.
		*/
		public void MarkerSetBack(int markerNumber, int back)
		{
			 SPerform(2042, (uint)markerNumber, (uint)back);
		}	
						
		/**
		* Add a marker to a line, returning an ID which can be used to find or delete the marker.
		*/
		public int MarkerAdd(int line, int markerNumber)
		{
			return (int)SPerform(2043, (uint)line, (uint)markerNumber);
		}	
						
		/**
		* Delete a marker from a line.
		*/
		public void MarkerDelete(int line, int markerNumber)
		{
			 SPerform(2044, (uint)line, (uint)markerNumber);
		}	
						
		/**
		* Delete all markers with a particular number from all lines.
		*/
		public void MarkerDeleteAll(int markerNumber)
		{
			 SPerform(2045, (uint)markerNumber, 0);
		}	
						
		/**
		* Get a bit mask of all the markers set on a line.
		*/
		public int MarkerGet(int line)
		{
			return (int)SPerform(2046, (uint)line, 0);
		}	
						
		/**
		* Find the next line after lineStart that includes a marker in mask.
		*/
		public int MarkerNext(int lineStart, int markerMask)
		{
			return (int)SPerform(2047, (uint)lineStart, (uint)markerMask);
		}	
						
		/**
		* Find the previous line before lineStart that includes a marker in mask.
		*/
		public int MarkerPrevious(int lineStart, int markerMask)
		{
			return (int)SPerform(2048, (uint)lineStart, (uint)markerMask);
		}	
						
		/**
		* Define a marker from a pixmap.
		*/
		unsafe public void MarkerDefinePixmap(int markerNumber, string pixmap )
		{
			if (pixmap == null || pixmap.Equals("")) pixmap = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(pixmap))
			{
				 SPerform(2049, (uint)markerNumber, (uint)b);
			}	
		}			

		/**
		* Reset the default style to its state at startup
		*/
		public void StyleResetDefault()
		{
			SPerform(2058, 0, 0);
		}	
						
		/**
		* Set the foreground colour of the selection and whether to use this setting.
		*/
		public void SetSelFore(bool useSetting, int fore)
		{
			 SPerform(2067,(uint)(useSetting ? 1 : 0), (uint)fore);
		}	
						
		/**
		* Set the background colour of the selection and whether to use this setting.
		*/
		public void SetSelBack(bool useSetting, int back)
		{
			 SPerform(2068, (uint)(useSetting ? 1 : 0), (uint)back);
		}	
						
		/**
		* When key+modifier combination km is pressed perform msg.
		*/
		public void AssignCmdKey(int km, int msg)
		{
			 SPerform(2070, (uint)km, (uint)msg);
		}	
						
		/**
		* When key+modifier combination km is pressed do nothing.
		*/
		public void ClearCmdKey(int km)
		{
			 SPerform(2071, (uint)km, 0);
		}	
						
		/**
		* Drop all key mappings.
		*/
		public void ClearAllCmdKeys()
		{
			SPerform(2072, 0, 0);
		}	
						
		/**
		* Set the styles for a segment of the document.
		*/
		unsafe public void SetStylingEx(int length, string styles)
		{
			if (styles == null || styles.Equals("")) styles = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(styles))
			{
				 SPerform(2073,(uint)length, (uint)b );
			}
		}	
						
		/**
		* Start a sequence of actions that is undone and redone as a unit.
		* May be nested.
		*/
		public void BeginUndoAction()
		{
			SPerform(2078, 0, 0);
		}	
						
		/**
		* End a sequence of actions that is undone and redone as a unit.
		*/
		public void EndUndoAction()
		{
			SPerform(2079, 0, 0);
		}	
						
		/**
		* Set the foreground colour of all whitespace and whether to use this setting.
		*/
		public void SetWhitespaceFore(bool useSetting, int fore)
		{
			 SPerform(2084, (uint)(useSetting ? 1 : 0), (uint)fore);
		}	
						
		/**
		* Set the background colour of all whitespace and whether to use this setting.
		*/
		public void SetWhitespaceBack(bool useSetting, int back)
		{
			 SPerform(2085, (uint)(useSetting ? 1 : 0), (uint)back);
		}	
						
		/**
		* Display a auto-completion list.
		* The lenEntered parameter indicates how many characters before
		* the caret should be used to provide context.
		*/
		unsafe public void AutoCShow(int lenEntered, string itemList)
		{
			if (itemList == null || itemList.Equals("")) itemList = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(itemList))
			{
				SPerform(2100, (uint)lenEntered, (uint)b);
			}
		}	
						
		/**
		* Remove the auto-completion list from the screen.
		*/
		public void AutoCCancel()
		{
			SPerform(2101, 0, 0);
		}	
						
		/**
		* User has selected an item so remove the list and insert the selection.
		*/
		public void AutoCComplete()
		{
			SPerform(2104, 0, 0);
		}	
						
		/**
		* Define a set of character that when typed cancel the auto-completion list.
		*/
		unsafe public void AutoCStops(string characterSet)
		{
			if (characterSet == null || characterSet.Equals("")) characterSet = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(characterSet))
			{
				 SPerform(2105, 0, (uint)b);
			}
		}	
						
		/**
		* Select the item in the auto-completion list that starts with a string.
		*/
		unsafe public void AutoCSelect(string text)
		{
			if (text == null || text.Equals("")) text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text))
			{
				 SPerform(2108, 0, (uint)b);
			}
		}	
						
		/**
		* Display a list of strings and send notification when user chooses one.
		*/
		unsafe public void UserListShow(int listType, string itemList)
		{
			if (itemList == null || itemList.Equals("")) itemList = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(itemList))
			{
				 SPerform(2117, (uint)listType, (uint)b);
			}
		}	
						
		/**
		* Register an XPM image for use in autocompletion lists.
		*/
		unsafe public void RegisterImage(int type, string xpmData)
		{
			if (xpmData == null || xpmData.Equals("")) xpmData = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(xpmData)) 
			{
				 SPerform(2405,(uint)type, (uint)b );
			}
		}	
						
		/**
		* Clear all the registered XPM images.
		*/
		public void ClearRegisteredImages()
		{
			SPerform(2408, 0, 0);
		}	
						
		/**
		* Retrieve the contents of a line.
		*/
		unsafe public string GetLine(int line)
		{
			try 
			{
				int sz = (int)SPerform(2153, (uint)line, 0);
				byte[] buffer = new byte[sz+1];
				fixed (byte* b = buffer) SPerform(2153, (uint)line, (uint)b);
				return Encoding.GetEncoding(this.CodePage).GetString(buffer, 0, sz-1);
			} 
			catch 
			{
				return "";
			}
		}

		/**
		* Select a range of text.
		*/
		public void SetSel(int start, int end)
		{ 
			SPerform(2160, (uint)start, (uint)end);
		}					

		/**
		* Retrieve the selected text.
		* Return the length of the text.
		*/
		unsafe public string SelText
		{
			get
			{
				int sz = (int)SPerform(2161,0 ,0);
				byte[] buffer = new byte[sz+1];
				fixed (byte* b = buffer)
				{
					SPerform(2161, (UInt32)sz+1, (uint)b);
				}
				return Encoding.GetEncoding(this.CodePage).GetString(buffer, 0, sz-1);
			}
		}

		/**
		* Draw the selection in normal style or with selection highlighted.
		*/
		public void HideSelection(bool normal)
		{
			 SPerform(2163, (uint)(normal ? 1 : 0), 0);
		}	
						
		/**
		* Retrieve the x value of the point in the window where a position is displayed.
		*/
		public int PointXFromPosition(int pos)
		{
			return (int) SPerform(2164, 0, (uint)pos);
		}	
						
		/**
		* Retrieve the y value of the point in the window where a position is displayed.
		*/
		public int PointYFromPosition(int pos)
		{
			return (int) SPerform(2165, 0, (uint)pos);
		}	
						
		/**
		* Retrieve the line containing a position.
		*/
		public int LineFromPosition(int pos)
		{
			return (int) SPerform(2166, (uint)pos, 0);
		}	
						
		/**
		* Retrieve the position at the start of a line.
		*/
		public int PositionFromLine(int line)
		{
			return (int) SPerform(2167, (uint)line, 0);
		}	
						
		/**
		* Scroll horizontally and vertically.
		*/
		public void LineScroll(int columns, int lines)
		{
			 SPerform(2168, (uint)columns, (uint)lines);
		}	
						
		/**
		* Ensure the caret is visible.
		*/
		public void ScrollCaret()
		{
			SPerform(2169, 0, 0);
		}	
					
		/**
		* Replace the selected text with the argument text.
		*/
		unsafe public void ReplaceSel(string text)
		{
			if (text == null || text.Equals("")) text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text)) 
			{
				SPerform(2170,0 ,  (uint)b);
			}
		}	
						
		/**
		* Null operation.
		*/
		public void Null()
		{
			SPerform(2172, 0, 0);
		}	
						
		/**
		* Delete the undo history.
		*/
		public void EmptyUndoBuffer()
		{
			SPerform(2175, 0, 0);
		}	
						
		/**
		* Undo one action in the undo history.
		*/
		public void Undo()
		{
			SPerform(2176, 0, 0);
		}	
						
		/**
		* Cut the selection to the clipboard.
		*/
		public void Cut()
		{
			SPerform(2177, 0, 0);
		}	
						
		/**
		* Copy the selection to the clipboard.
		*/
		public void Copy()
		{
			SPerform(2178, 0, 0);
		}	
						
		/**
		* Paste the contents of the clipboard into the document replacing the selection.
		*/
		public void Paste()
		{
			SPerform(2179, 0, 0);
		}	
						
		/**
		* Clear the selection.
		*/
		public void Clear()
		{
			SPerform(2180, 0, 0);
		}	
						
		/**
		* Replace the contents of the document with the argument text.
		*/
		unsafe public void SetText(string text)
		{
			if (text == null || text.Equals("")) text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text))
			{
				SPerform(2181, 0, (uint)b);
			}
		}	
						
		/**
		* Retrieve all the text in the document.
		* Returns number of characters retrieved.
		*/
		unsafe public string GetText(int length)
		{
			int sz = (int)SPerform(2182, (uint)length, 0);
			byte[] buffer = new byte[sz+1];
			fixed (byte* b = buffer)SPerform(2182, (uint)length+1, (uint)b);
			return Encoding.GetEncoding(this.CodePage).GetString(buffer, 0, sz-1);
		}

		/**
		* Replace the target text with the argument text.
		* Text is counted so it can contain NULs.
		* Returns the length of the replacement text.
		*/
		unsafe public int ReplaceTarget(int length, string text)
		{
			if (text == null || text.Equals("")) text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text))
			{
				return (int)SPerform(2194, (uint)length, (uint)b);
			}
		}	
						
		/**
		* Replace the target text with the argument text after \d processing.
		* Text is counted so it can contain NULs.
		* Looks for \d where d is between 1 and 9 and replaces these with the strings
		* matched in the last search operation which were surrounded by \( and \).
		* Returns the length of the replacement text including any change
		* caused by processing the \d patterns.
		*/
		unsafe public int ReplaceTargetRE(int length, string text )
		{
			if (text == null || text.Equals("")) text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text))
			{
				return (int) SPerform(2195, (uint)length, (uint)b);
			}
		}	
						
		/**
		* Search for a counted string in the target and set the target to the found
		* range. Text is counted so it can contain NULs.
		* Returns length of range or -1 for failure in which case target is not moved.
		*/
		unsafe public int SearchInTarget(int length, string text)
		{
			if (text == null || text.Equals("")) text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text)) 
			{
				return (int) SPerform(2197, (uint)length, (uint)b);
			}
		}				

		/**
		* Show a call tip containing a definition near position pos.
		*/
		unsafe public void CallTipShow(int pos, string definition)
		{
			if (definition == null || definition.Equals("")) definition = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(definition)) 
			{
				SPerform(2200, (uint)pos, (uint)b);
			}
		}				

		/**
		* Remove the call tip from the screen.
		*/
		public void CallTipCancel()
		{
			SPerform(2201, 0, 0);
		}	
		
		/**
		* Highlight a segment of the definition.
		*/
		public void CallTipSetHlt(int start, int end)
		{
			 SPerform(2204, (uint)start, (uint)end);
		}	
		
		/**
		* Set the background colour for the call tip.
		*/
		public void CallTipSetBack(int color)
		{
			SPerform(2205, (uint)color, 0); 
		}
		
		/**
		* Set the foreground colour for the call tip.
		*/
		public void CallTipSetFore(int color)
		{
			SPerform(2206, (uint)color, 0);
		}
		
		/**
		* Set the foreground colour for the highlighted part of the call tip.
		*/
		public void CallTipSetForeHlt(int color)
		{
			SPerform(2207, (uint)color, 0); 
		}
		
		/**
		* Find the display line of a document line taking hidden lines into account.
		*/
		public int VisibleFromDocLine(int line)
		{
			return (int) SPerform(2220, (uint)line, 0);
		}	

		/**
		* Find the document line of a display line taking hidden lines into account.
		*/
		public int DocLineFromVisible(int lineDisplay)
		{
			return (int) SPerform(2221, (uint)lineDisplay, 0);
		}			

		/**
		* Make a range of lines visible.
		*/
		public void ShowLines(int lineStart, int lineEnd)
		{
			 SPerform(2226, (uint)lineStart, (uint)lineEnd);
		}	
		
		/**
		* Make a range of lines invisible.
		*/
		public void HideLines(int lineStart, int lineEnd)
		{
			 SPerform(2227, (uint)lineStart, (uint)lineEnd);
		}			

		/**
		* Switch a header line between expanded and contracted.
		*/
		public void ToggleFold(int line)
		{
			 SPerform(2231, (uint)line, 0);
		}			

		/**
		* Ensure a particular line is visible by expanding any header line hiding it.
		*/
		public void EnsureVisible(int line)
		{
			 SPerform(2232, (uint)line, 0);
		}				

		/**
		* Set some style options for folding.
		*/
		public void SetFoldFlags(int flags)
		{
			 SPerform(2233, (uint)flags, 0);
		}			

		/**
		* Ensure a particular line is visible by expanding any header line hiding it.
		* Use the currently set visibility policy to determine which range to display.
		*/
		public void EnsureVisibleEnforcePolicy(int line)
		{
			 SPerform(2234, (uint)line, 0);
		}			

		/**
		* Get position of start of word.
		*/
		public int WordStartPosition(int pos, bool onlyWordCharacters)
		{
			return (int) SPerform(2266, (uint)pos, (uint)(onlyWordCharacters ? 1 : 0));
		}				

		/**
		* Get position of end of word.
		*/
		public int WordEndPosition(int pos, bool onlyWordCharacters)
		{
			return (int) SPerform(2267, (uint)pos, (uint)(onlyWordCharacters ? 1 : 0));
		}			

		/**
		* Measure the pixel width of some text in a particular style.
		* NUL terminated text argument.
		* Does not handle tab or control characters.
		*/
		unsafe public int TextWidth(int style, string text)
		{
			if (text == null || text.Equals("")) text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text)) 
			{
				return (int) SPerform(2276, (uint)style, (uint)b);
			}
		}				

		/**
		* Retrieve the height of a particular line of text in pixels.
		*/
		public int TextHeight(int line)
		{
			return (int) SPerform(2279, (uint)line, 0);
		}	
						
		/**
		* Append a string to the end of the document without changing the selection.
		*/
		unsafe public void AppendText(int length, string text)
		{
			if (text == null || text.Equals("")) text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text))
			{
				SPerform(2282, (uint)length, (uint)b);
			}
		}	
						
		/**
		* Make the target range start and end be the same as the selection range start and end.
		*/
		public void TargetFromSelection()
		{
			SPerform(2287, 0, 0);
		}	
						
		/**
		* Join the lines in the target.
		*/
		public void LinesJoin()
		{
			SPerform(2288, 0, 0);
		}	
						
		/**
		* Split the lines in the target into lines that are less wide than pixelWidth
		* where possible.
		*/
		public void LinesSplit(int pixelWidth)
		{
			 SPerform(2289, (uint)pixelWidth, 0);
		}	
						
		/**
		* Set the colours used as a chequerboard pattern in the fold margin
		*/
		public void SetFoldMarginColour(bool useSetting, int back)
		{
			 SPerform(2290,(uint)(useSetting ? 1 : 0), (uint)back);
		}	
						
		/**
		* Set the colours used as a chequerboard pattern in the fold margin
		*/
		public void SetFoldMarginHiColour(bool useSetting, int fore)
		{
			 SPerform(2291,(uint)(useSetting ? 1 : 0), (uint)fore);
		}	
						
		/**
		* Move caret down one line.
		*/
		public void LineDown()
		{
			SPerform(2300, 0, 0);
		}	
						
		/**
		* Move caret down one line extending selection to new caret position.
		*/
		public void LineDownExtend()
		{
			SPerform(2301, 0, 0);
		}	
						
		/**
		* Move caret up one line.
		*/
		public void LineUp()
		{
			SPerform(2302, 0, 0);
		}	
						
		/**
		* Move caret up one line extending selection to new caret position.
		*/
		public void LineUpExtend()
		{
			SPerform(2303, 0, 0);
		}	
						
		/**
		* Move caret left one character.
		*/
		public void CharLeft()
		{
			SPerform(2304, 0, 0);
		}	
						
		/**
		* Move caret left one character extending selection to new caret position.
		*/
		public void CharLeftExtend()
		{
			SPerform(2305, 0, 0);
		}	
						
		/**
		* Move caret right one character.
		*/
		public void CharRight()
		{
			SPerform(2306, 0, 0);
		}	
						
		/**
		* Move caret right one character extending selection to new caret position.
		*/
		public void CharRightExtend()
		{
			SPerform(2307, 0, 0);
		}	
						
		/**
		* Move caret left one word.
		*/
		public void WordLeft()
		{
			SPerform(2308, 0, 0);
		}	
						
		/**
		* Move caret left one word extending selection to new caret position.
		*/
		public void WordLeftExtend()
		{
			SPerform(2309, 0, 0);
		}	
						
		/**
		* Move caret right one word.
		*/
		public void WordRight()
		{
			SPerform(2310, 0, 0);
		}	
						
		/**
		* Move caret right one word extending selection to new caret position.
		*/
		public void WordRightExtend()
		{
			SPerform(2311, 0, 0);
		}	
						
		/**
		* Move caret to first position on line.
		*/
		public void Home()
		{
			SPerform(2312, 0, 0);
		}	
						
		/**
		* Move caret to first position on line extending selection to new caret position.
		*/
		public void HomeExtend()
		{
			SPerform(2313, 0, 0);
		}	
						
		/**
		* Move caret to last position on line.
		*/
		public void LineEnd()
		{
			SPerform(2314, 0, 0);
		}	
						
		/**
		* Move caret to last position on line extending selection to new caret position.
		*/
		public void LineEndExtend()
		{
			SPerform(2315, 0, 0);
		}	
						
		/**
		* Move caret to first position in document.
		*/
		public void DocumentStart()
		{
			SPerform(2316, 0, 0);
		}	
						
		/**
		* Move caret to first position in document extending selection to new caret position.
		*/
		public void DocumentStartExtend()
		{
			SPerform(2317, 0, 0);
		}	
						
		/**
		* Move caret to last position in document.
		*/
		public void DocumentEnd()
		{
			SPerform(2318, 0, 0);
		}	
						
		/**
		* Move caret to last position in document extending selection to new caret position.
		*/
		public void DocumentEndExtend()
		{
			SPerform(2319, 0, 0);
		}	
						
		/**
		* Move caret one page up.
		*/
		public void PageUp()
		{
			SPerform(2320, 0, 0);
		}	
						
		/**
		* Move caret one page up extending selection to new caret position.
		*/
		public void PageUpExtend()
		{
			SPerform(2321, 0, 0);
		}	
						
		/**
		* Move caret one page down.
		*/
		public void PageDown()
		{
			SPerform(2322, 0, 0);
		}	
						
		/**
		* Move caret one page down extending selection to new caret position.
		*/
		public void PageDownExtend()
		{
			SPerform(2323, 0, 0);
		}	
						
		/**
		* Switch from insert to overtype mode or the reverse.
		*/
		public void EditToggleOvertype()
		{
			SPerform(2324, 0, 0);
		}	
						
		/**
		* Cancel any modes such as call tip or auto-completion list display.
		*/
		public void Cancel()
		{
			SPerform(2325, 0, 0);
		}	
						
		/**
		* Delete the selection or if no selection, the character before the caret.
		*/
		public void DeleteBack()
		{
			SPerform(2326, 0, 0);
		}	
						
		/**
		* If selection is empty or all on one line replace the selection with a tab character.
		* If more than one line selected, indent the lines.
		*/
		public void Tab()
		{
			SPerform(2327, 0, 0);
		}	
						
		/**
		* Dedent the selected lines.
		*/
		public void BackTab()
		{
			SPerform(2328, 0, 0);
		}	
						
		/**
		* Insert a new line, may use a CRLF, CR or LF depending on EOL mode.
		*/
		public void NewLine()
		{
			SPerform(2329, 0, 0);
		}	
						
		/**
		* Insert a Form Feed character.
		*/
		public void FormFeed()
		{
			SPerform(2330, 0, 0);
		}	
						
		/**
		* Move caret to before first visible character on line.
		* If already there move to first character on line.
		*/
		public void VCHome()
		{
			SPerform(2331, 0, 0);
		}	
						
		/**
		* Like VCHome but extending selection to new caret position.
		*/
		public void VCHomeExtend()
		{
			SPerform(2332, 0, 0);
		}	
						
		/**
		* Magnify the displayed text by increasing the sizes by 1 point.
		*/
		public void ZoomIn()
		{
			SPerform(2333, 0, 0);
		}	
						
		/**
		* Make the displayed text smaller by decreasing the sizes by 1 point.
		*/
		public void ZoomOut()
		{
			SPerform(2334, 0, 0);
		}	
						
		/**
		* Delete the word to the left of the caret.
		*/
		public void DelWordLeft()
		{
			SPerform(2335, 0, 0);
		}	
						
		/**
		* Delete the word to the right of the caret.
		*/
		public void DelWordRight()
		{
			SPerform(2336, 0, 0);
		}	
						
		/**
		* Cut the line containing the caret.
		*/
		public void LineCut()
		{
			SPerform(2337, 0, 0);
		}	
						
		/**
		* Delete the line containing the caret.
		*/
		public void LineDelete()
		{
			SPerform(2338, 0, 0);
		}	
						
		/**
		* Switch the current line with the previous.
		*/
		public void LineTranspose()
		{
			SPerform(2339, 0, 0);
		}	
						
		/**
		* Duplicate the current line.
		*/
		public void LineDuplicate()
		{
			SPerform(2404, 0, 0);
		}	
						
		/**
		* Transform the selection to lower case.
		*/
		public void LowerCase()
		{
			SPerform(2340, 0, 0);
		}	
						
		/**
		* Transform the selection to upper case.
		*/
		public void UpperCase()
		{
			SPerform(2341, 0, 0);
		}	
						
		/**
		* Scroll the document down, keeping the caret visible.
		*/
		public void LineScrollDown()
		{
			SPerform(2342, 0, 0);
		}	
						
		/**
		* Scroll the document up, keeping the caret visible.
		*/
		public void LineScrollUp()
		{
			SPerform(2343, 0, 0);
		}	
						
		/**
		* Delete the selection or if no selection, the character before the caret.
		* Will not delete the character before at the start of a line.
		*/
		public void DeleteBackNotLine()
		{
			SPerform(2344, 0, 0);
		}	
					
		/**
		* Move caret to first position on display line.
		*/
		public void HomeDisplay()
		{
			SPerform(2345, 0, 0);
		}	
						
		/**
		* Move caret to first position on display line extending selection to
		* new caret position.
		*/
		public void HomeDisplayExtend()
		{
			SPerform(2346, 0, 0);
		}	
						
		/**
		* Move caret to last position on display line.
		*/
		public void LineEndDisplay()
		{
			SPerform(2347, 0, 0);
		}	
						
		/**
		* Move caret to last position on display line extending selection to new
		* caret position.
		*/
		public void LineEndDisplayExtend()
		{
			SPerform(2348, 0, 0);
		}	
						
		/**
		*/
		public void HomeWrap()
		{
			SPerform(2349, 0, 0);
		}	
						
		/**
		*/
		public void HomeWrapExtend()
		{
			SPerform(2450, 0, 0);
		}	
						
		/**
		*/
		public void LineEndWrap()
		{
			SPerform(2451, 0, 0);
		}	
						
		/**
		*/
		public void LineEndWrapExtend()
		{
			SPerform(2452, 0, 0);
		}	
						
		/**
		*/
		public void VCHomeWrap()
		{
			SPerform(2453, 0, 0);
		}	
						
		/**
		*/
		public void VCHomeWrapExtend()
		{
			SPerform(2454, 0, 0);
		}	
						
		/**
		* Copy the line containing the caret.
		*/
		public void LineCopy()
		{
			SPerform(2455, 0, 0);
		}	
						
		/**
		* Move the caret inside current view if it's not there already.
		*/
		public void MoveCaretInsideView()
		{
			SPerform(2401, 0, 0);
		}	
						
		/**
		* How many characters are on a line, not including end of line characters?
		*/
		public int LineLength(int line)
		{
			return (int) SPerform(2350, (uint)line, 0);
		}	
						
		/**
		* Highlight the characters at two positions.
		*/
		public void BraceHighlight(int pos1, int pos2 )
		{
			 SPerform(2351, (uint)pos1, (uint)pos2 );
		}	
						
		/**
		* Highlight the character at a position indicating there is no matching brace.
		*/
		public void BraceBadLight(int pos)
		{
			 SPerform(2352, (uint)pos, 0);
		}	
						
		/**
		* Find the position of a matching brace or INVALID_POSITION if no match.
		*/
		public int BraceMatch(int pos)
		{
			return (int) SPerform(2353, (uint)pos, 0);
		}	
						
		/**
		* Sets the current caret position to be the search anchor.
		*/
		public void SearchAnchor()
		{
			SPerform(2366, 0, 0);
		}	
						
		/**
		* Find some text starting at the search anchor.
		* Does not ensure the selection is visible.
		*/
		unsafe public int SearchNext(int flags, string text)
		{
			if (text == null || text.Equals("")) text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text)) 
			{
				return (int)SPerform(2367, (uint)flags, (uint)b);
			}
		}	
						
		/**
		* Find some text starting at the search anchor and moving backwards.
		* Does not ensure the selection is visible.
		*/
		unsafe public int SearchPrev(int flags, string text )
		{
			if (text == null || text.Equals("")) text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text)) 
			{
				return (int)SPerform(2368,(uint)flags, (uint)b);
			}
		}	
						
		/**
		* Set whether a pop up menu is displayed automatically when the user presses
		* the wrong mouse button.
		*/
		public void UsePopUp(bool allowPopUp)
		{
			 SPerform(2371, (uint)(allowPopUp ? 1 : 0), 0);
		}	
						
		/**
		* Create a new document object.
		* Starts with reference count of 1 and not selected into editor.
		* Extend life of document.
		*/
		public void AddRefDocument(int doc)
		{
			 SPerform(2376, 0, (uint)doc );
		}	
						
		/**
		* Create a new document object.
		* Starts with reference count of 1 and not selected into editor.
		* Extend life of document.
		* Release a reference to the document, deleting document if it fades to black.
		*/
		public void ReleaseDocument(int doc)
		{
			 SPerform(2377, 0, (uint)doc );
		}	
					
		/**
		* Move to the previous change in capitalisation.
		*/
		public void WordPartLeft()
		{
			SPerform(2390, 0, 0);
		}	
						
		/**
		* Move to the previous change in capitalisation.
		* Move to the previous change in capitalisation extending selection
		* to new caret position.
		*/
		public void WordPartLeftExtend()
		{
			SPerform(2391, 0, 0);
		}	
						
		/**
		* Move to the previous change in capitalisation.
		* Move to the previous change in capitalisation extending selection
		* to new caret position.
		* Move to the change next in capitalisation.
		*/
		public void WordPartRight()
		{
			SPerform(2392, 0, 0);
		}	
						
		/**
		* Move to the previous change in capitalisation.
		* Move to the previous change in capitalisation extending selection
		* to new caret position.
		* Move to the change next in capitalisation.
		* Move to the next change in capitalisation extending selection
		* to new caret position.
		*/
		public void WordPartRightExtend()
		{
			SPerform(2393, 0, 0);
		}	
					
		/**
		* Constants for use with SetVisiblePolicy, similar to SetCaretPolicy.
		* Set the way the display area is determined when a particular line
		* is to be moved to by Find, FindNext, GotoLine, etc.
		*/
		public void SetVisiblePolicy(int visiblePolicy, int visibleSlop)
		{
			 SPerform(2394, (uint)visiblePolicy, (uint)visibleSlop);
		}	
						
		/**
		* Delete back from the current position to the start of the line.
		*/
		public void DelLineLeft()
		{
			SPerform(2395, 0, 0);
		}	
						
		/**
		* Delete forwards from the current position to the end of the line.
		*/
		public void DelLineRight()
		{
			SPerform(2396, 0, 0);
		}	
						
		/**
		* Set the last x chosen value to be the caret x position.
		*/
		public void ChooseCaretX()
		{
			SPerform(2399, 0, 0);
		}	
						
		/**
		* Set the focus to this Scintilla widget.
		* GTK+ Specific.
		*/
		public void GrabFocus()
		{
			SPerform(2400, 0, 0);
		}	
						
		/**
		* Set the way the caret is kept visible when going sideway.
		* The exclusion zone is given in pixels.
		*/
		public void SetXCaretPolicy(int caretPolicy, int caretSlop)
		{
			 SPerform(2402, (uint)caretPolicy, (uint)caretSlop);
		}	
						
		/**
		* Set the way the line the caret is on is kept visible.
		* The exclusion zone is given in lines.
		*/
		public void SetYCaretPolicy(int caretPolicy, int caretSlop)
		{
			 SPerform(2403, (uint)caretPolicy, (uint)caretSlop);
		}	
						
		/**
		* Move caret between paragraphs (delimited by empty lines).
		*/
		public void ParaDown()
		{
			SPerform(2413, 0, 0);
		}	
						
		/**
		* Move caret between paragraphs (delimited by empty lines).
		*/
		public void ParaDownExtend()
		{
			SPerform(2414, 0, 0);
		}	
						
		/**
		* Move caret between paragraphs (delimited by empty lines).
		*/
		public void ParaUp()
		{
			SPerform(2415, 0, 0);
		}	
						
		/**
		* Move caret between paragraphs (delimited by empty lines).
		*/
		public void ParaUpExtend()
		{
			SPerform(2416, 0, 0);
		}	
						
		/**
		* Given a valid document position, return the previous position taking code
		* page into account. Returns 0 if passed 0.
		*/
		public int PositionBefore(int pos)
		{
			return (int) SPerform(2417, (uint)pos, 0);
		}	
						
		/**
		* Given a valid document position, return the next position taking code
		* page into account. Maximum value returned is the last position in the document.
		*/
		public int PositionAfter(int pos)
		{
			return (int) SPerform(2418, (uint)pos, 0);
		}	
						
		/**
		* Copy a range of text to the clipboard. Positions are clipped into the document.
		*/
		public void CopyRange(int start, int end)
		{
			 SPerform(2419, (uint)start, (uint)end);
		}	
						
		/**
		* Copy argument text to the clipboard.
		*/
		unsafe public void CopyText(int length, string text)
		{
			if (text == null || text.Equals(""))text = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(text))
			{
				SPerform(2420,(uint)length, (uint)b );
			}
		}	
						
		/**
		* Retrieve the position of the start of the selection at the given line (INVALID_POSITION if no selection on this line).
		*/
		public int GetLineSelStartPosition(int line)
		{
			return (int) SPerform(2424, (uint)line, 0);
		}	
						
		/**
		* Retrieve the position of the end of the selection at the given line (INVALID_POSITION if no selection on this line).
		*/
		public int GetLineSelEndPosition(int line)
		{
			return (int)SPerform(2425, (uint)line, 0);
		}	
						
		/**
		* Move caret down one line, extending rectangular selection to new caret position.
		*/
		public void LineDownRectExtend()
		{
			SPerform(2426, 0, 0);
		}	
						
		/**
		* Move caret up one line, extending rectangular selection to new caret position. 
		*/
		public void LineUpRectExtend()
		{
			SPerform(2427, 0, 0);
		}	
						
		/**
		* Move caret left one character, extending rectangular selection to new caret position.
		*/
		public void CharLeftRectExtend()
		{
			SPerform(2428, 0, 0);
		}	
						
		/**
		* Move caret right one character, extending rectangular selection to new caret position.
		*/
		public void CharRightRectExtend()
		{
			SPerform(2429, 0, 0);
		}	
						
		/**
		* Move caret to first position on line, extending rectangular selection to new caret position.
		*/
		public void HomeRectExtend()
		{
			SPerform(2430, 0, 0);
		}	
						
		/**
		* Move caret to before first visible character on line.
		* If already there move to first character on line.
		* In either case, extend rectangular selection to new caret position.
		*/
		public void VCHomeRectExtend()
		{
			SPerform(2431, 0, 0);
		}	
						
		/**
		* Move caret to last position on line, extending rectangular selection to new caret position.
		*/
		public void LineEndRectExtend()
		{
			SPerform(2432, 0, 0);
		}	
						
		/**
		* Move caret one page up, extending rectangular selection to new caret position.
		*/
		public void PageUpRectExtend()
		{
			SPerform(2433, 0, 0);
		}	
						
		/**
		* Move caret one page down, extending rectangular selection to new caret position.
		*/
		public void PageDownRectExtend()
		{
			SPerform(2434, 0, 0);
		}	
						
		/**
		* Move caret to top of page, or one page up if already at top of page.
		*/
		public void StutteredPageUp()
		{
			SPerform(2435, 0, 0);
		}	
						
		/**
		* Move caret to top of page, or one page up if already at top of page, extending selection to new caret position.
		*/
		public void StutteredPageUpExtend()
		{
			SPerform(2436, 0, 0);
		}	
						
		/**
		* Move caret to bottom of page, or one page down if already at bottom of page.
		*/
		public void StutteredPageDown()
		{
			SPerform(2437, 0, 0);
		}	
						
		/**
		* Move caret to bottom of page, or one page down if already at bottom of page, extending selection to new caret position.
		*/
		public void StutteredPageDownExtend()
		{
			SPerform(2438, 0, 0);
		}	
						
		/**
		* Move caret left one word, position cursor at end of word.
		*/
		public void WordLeftEnd()
		{
			SPerform(2439, 0, 0);
		}	
						
		/**
		* Move caret left one word, position cursor at end of word, extending selection to new caret position.
		*/
		public void WordLeftEndExtend()
		{
			SPerform(2440, 0, 0);
		}	
						
		/**
		* Move caret right one word, position cursor at end of word.
		*/
		public void WordRightEnd()
		{
			SPerform(2441, 0, 0);
		}	
						
		/**
		* Move caret right one word, position cursor at end of word, extending selection to new caret position.
		*/
		public void WordRightEndExtend()
		{
			SPerform(2442, 0, 0);
		}	
						
		/**
		* Reset the set of characters for whitespace and word characters to the defaults.
		*/
		public void SetCharsDefault()
		{
			SPerform(2444, 0, 0);
		}
		
		/**
		* Enlarge the document to a particular size of text bytes.
		*/
		public void Allocate(int bytes)
		{
			 SPerform(2446, (uint)bytes, 0);
		}	
						
		/**
		* Start notifying the container of all key presses and commands.
		*/
		public void StartRecord()
		{
			SPerform(3001, 0, 0);
		}	
						
		/**
		* Stop notifying the container of all key presses and commands.
		*/
		public void StopRecord()
		{
			SPerform(3002, 0, 0);
		}	
						
		/**
		* Colourise a segment of the document using the current lexing language.
		*/
		public void Colourise(int start, int end)
		{
			 SPerform(4003, (uint)start, (uint)end);
		}	
						
		/**
		* Load a lexer library (dll / so).
		*/
		unsafe public void LoadLexerLibrary(string path)
		{
			if (path == null || path.Equals("")) path = "\0\0";
			fixed (byte* b = Encoding.GetEncoding(this.CodePage).GetBytes(path))
			{
				 SPerform(4007, 0, (uint)b);
			}
		}	
						
		#endregion
		
		#region Scintilla Constants
		
		public const int MAXDWELLTIME = 10000000;
		private const uint WS_CHILD = (uint)0x40000000L;
		private const uint WS_VISIBLE = (uint)0x10000000L;
		private const uint WS_TABSTOP = (uint)0x00010000L;
		private const uint WS_CHILD_VISIBLE_TABSTOP = WS_CHILD|WS_VISIBLE|WS_TABSTOP;
		private const int WM_NOTIFY = 0x004e;
		private const int WM_KEYDOWN = 0x0100;
		private const int WM_SYSKEYDOWN = 0x0104;
		private const int WM_DROPFILES = 0x0233;
		private const int PATH_LEN = 1024;
	
		#endregion
		
		#region "Scintilla External"
		
		[DllImport("gdi32.dll")] 
		public static extern int GetDeviceCaps(IntPtr hdc, Int32 capindex);
		
		[DllImport("user32.dll")]
		public static extern int SendMessage(int hWnd, uint Msg, int wParam, int lParam);

		[DllImport("user32.dll")]
		public static extern int SetWindowPos(IntPtr hWnd, int hWndInsertAfter, int X, int Y, int cx, int cy, int uFlags);
		
		[DllImport("shell32.dll")]
        public static extern int DragQueryFileA(IntPtr hDrop, uint idx, IntPtr buff, int sz);
                
        [DllImport("shell32.dll")]
        public static extern int DragFinish(IntPtr hDrop);
                
        [DllImport("shell32.dll")]
        public static extern void DragAcceptFiles(IntPtr hwnd, int accept);
        
		[DllImport("scilexer.dll",EntryPoint="Scintilla_DirectFunction")]
		public static extern int Perform(int directPointer, UInt32 message, UInt32 wParam, UInt32 lParam);

		public UInt32 SlowPerform(UInt32 message, UInt32 wParam, UInt32 lParam)
		{
			return (UInt32)SendMessage((int)hwndScintilla, message, (int)wParam, (int)lParam);
		}

		public UInt32 FastPerform(UInt32 message, UInt32 wParam, UInt32 lParam)
		{
			return (UInt32)Perform(directPointer, message, wParam, lParam);
		}

		public UInt32 SPerform(UInt32 message, UInt32 wParam, UInt32 lParam)
		{
			return (UInt32)Perform(directPointer, message, wParam, lParam);
		}
		
		protected override void WndProc(ref System.Windows.Forms.Message m )
		{
			if (m.Msg == WM_NOTIFY)
			{
				SCNotification scn = (SCNotification)Marshal.PtrToStructure(m.LParam, typeof(SCNotification));
				if (scn.nmhdr.hwndFrom == hwndScintilla) 
				{
					switch (scn.nmhdr.code)
					{
						case (uint)Enums.ScintillaEvents.StyleNeeded:
							if (StyleNeeded != null) StyleNeeded(this, scn.position);
							break;
							
						case (uint)Enums.ScintillaEvents.CharAdded:
							if (CharAdded != null) CharAdded(this, scn.ch);
							break;
							
						case (uint)Enums.ScintillaEvents.SavePointReached:
							if (SavePointReached != null) SavePointReached(this);
							break;
							
						case (uint)Enums.ScintillaEvents.SavePointLeft:
							if (SavePointLeft != null) SavePointLeft(this);
							break;
							
						case (uint)Enums.ScintillaEvents.ModifyAttemptRO:
							if (ModifyAttemptRO != null) ModifyAttemptRO(this);
							break;

						case (uint)Enums.ScintillaEvents.Key:
							if (Key != null) Key(this, scn.ch, scn.modifiers);
							break;

						case (uint)Enums.ScintillaEvents.DoubleClick:
							if (DoubleClick != null) DoubleClick(this);
							break;

						case (uint)Enums.ScintillaEvents.UpdateUI:
							if (UpdateUI != null) UpdateUI(this);
							break;

						case (uint)Enums.ScintillaEvents.MacroRecord:
							if (MacroRecord != null) MacroRecord(this, scn.message, scn.wParam, scn.lParam);
							break;

						case (uint)Enums.ScintillaEvents.MarginClick:
							if (MarginClick != null) MarginClick(this, scn.modifiers, scn.position, scn.margin);
							break;

						case (uint)Enums.ScintillaEvents.NeedShown:
							if (NeedShown != null) NeedShown(this, scn.position, scn.length);
							break;

						case (uint)Enums.ScintillaEvents.Painted:
							if (Painted != null) Painted(this);
							break;

						case (uint)Enums.ScintillaEvents.UserListSelection:
							if (UserListSelection != null) UserListSelection(this, scn.listType, MarshalStr(scn.text));
							break;

						case (uint)Enums.ScintillaEvents.URIDropped:
							if (URIDropped != null) URIDropped(this, MarshalStr(scn.text));
							break;

						case (uint)Enums.ScintillaEvents.DwellStart:
							if (DwellStart != null) DwellStart(this, scn.position);
							break;

						case (uint)Enums.ScintillaEvents.DwellEnd:
							if (DwellEnd != null) DwellEnd(this, scn.position);
							break;

						case (uint)Enums.ScintillaEvents.Zoom:
							if (Zoom != null) Zoom(this);
							break;

						case (uint)Enums.ScintillaEvents.HotspotClick:
							if (HotSpotClick != null) HotSpotClick(this, scn.modifiers, scn.position);
							break;

						case (uint)Enums.ScintillaEvents.HotspotDoubleClick:
							if (HotSpotDoubleClick != null) HotSpotDoubleClick(this, scn.modifiers, scn.position);
							break;

						case (uint)Enums.ScintillaEvents.CalltipClick:
							if (CallTipClick != null) CallTipClick(this, scn.position);
							break;

						case (uint)Enums.ScintillaEvents.AutoCSelection:
							if (AutoCSelection != null) AutoCSelection(this, MarshalStr(scn.text));
							break;
							
						case (uint)Enums.ScintillaEvents.Modified:
							if ((scn.modificationType & (uint)Enums.ModificationFlags.InsertText)>0)
							{	
								if (TextInserted != null) TextInserted(this, scn.position, scn.length, scn.linesAdded);
							}
							if ((scn.modificationType & (uint)Enums.ModificationFlags.DeleteText)>0) 
							{
								if (TextDeleted != null) TextDeleted(this, scn.position, scn.length, scn.linesAdded);
							}
							if ((scn.modificationType & (uint)Enums.ModificationFlags.ChangeStyle)>0) 
							{
								if (StyleChanged != null) StyleChanged(this, scn.position, scn.length);
							}
							if ((scn.modificationType & (uint)Enums.ModificationFlags.ChangeFold)>0)
							{
								if (FoldChanged != null ) FoldChanged(this, scn.line, scn.foldLevelNow, scn.foldLevelPrev);
							}
							if ((scn.modificationType & (uint)Enums.ModificationFlags.UserPerformed)>0) 
							{
								if (UserPerformed != null ) UserPerformed(this);
							}
							if ((scn.modificationType & (uint)Enums.ModificationFlags.UndoPerformed)>0)
							{
								if (UndoPerformed != null ) UndoPerformed(this);
							}
							if ((scn.modificationType & (uint)Enums.ModificationFlags.RedoPerformed)>0)
							{
								if (RedoPerformed != null )RedoPerformed(this);
							}
							if ((scn.modificationType & (uint)Enums.ModificationFlags.LastStepInUndoRedo)>0)
							{
								if (LastStepInUndoRedo != null ) LastStepInUndoRedo(this);
							}
							if ((scn.modificationType & (uint)Enums.ModificationFlags.ChangeMarker)>0)
							{
								if (MarkerChanged != null ) MarkerChanged(this, scn.line);
							}
							if ((scn.modificationType & (uint)Enums.ModificationFlags.BeforeInsert)>0)
							{
								if (BeforeInsert != null ) BeforeInsert(this, scn.position, scn.length);
							}
							if ((scn.modificationType & (uint)Enums.ModificationFlags.BeforeDelete)>0)
							{
								if (BeforeDelete != null ) BeforeDelete(this, scn.position, scn.length);
							}
							if (Modified != null)
							{
								if ((scn.modificationType & (uint)Enums.ModificationFlags.BeforeInsert)>0) Modified( this, scn.position, scn.modificationType, MarshalStr(scn.text, scn.length), scn.length, scn.linesAdded, scn.line, scn.foldLevelNow,scn.foldLevelPrev);
								else Modified( this, scn.position, scn.modificationType, null, scn.length, scn.linesAdded, scn.line, scn.foldLevelNow, scn.foldLevelPrev);
							}
							break;
					}
				}
			}
			else if (m.Msg == WM_DROPFILES)
			{
				HandleFileDrop(m.WParam);
			}
			else
			{
				base.WndProc(ref m);
			}
		}
		
		unsafe string MarshalStr(IntPtr p) 
		{
		   sbyte* b = (sbyte*)p;
		   int len = 0;
		   while (b[len] != 0) ++len;
		   return new string(b,0,len);
		}
		
		unsafe string MarshalStr(IntPtr p, int len) 
		{
		   sbyte* b = (sbyte*)p;
		   return new string(b,0,len);
		}
		
		#endregion
		
		#region "Automated Features"
		
		/**
		* Provides the support for brace matching.
		*/
		private void OnBraceMatch(ScintillaControl sci)
		{
			if (isBraceMatching && sci.SelText.Length == 0)
			{
				int position = CurrentPos-1;
				char character = (char)CharAt(position);
				if (character != '{' && character != '}' && character != '(' && character != ')' && character != '[' && character != ']')
				{
					position = CurrentPos;
					character = (char)CharAt(position);
				}
				if (character == '{' || character == '}' || character == '(' || character == ')' || character == '[' || character == ']')
				{
					if (!this.PositionIsOnComment(position))
					{
						int bracePosStart = position;
						int bracePosEnd = BraceMatch(position);
						BraceHighlight(bracePosStart, bracePosEnd);
					} 
					else 
					{
						BraceHighlight(-1, -1);
					}
				}
				else
				{
					BraceHighlight(-1, -1);
				}
			}
		}
		
		/**
		* Provides support for smart indenting
		*/
		private void OnSmartIndent(ScintillaControl ctrl, int ch)
		{
			char newline = (EOLMode == 1) ? '\r' : '\n';
			switch (SmartIndentType)
			{
				case Enums.SmartIndent.None:
					return;
				case Enums.SmartIndent.Simple:
					if (ch == newline)
					{
						int curLine = LineFromPosition(CurrentPos);
						int previousIndent = GetLineIndentation(curLine-1);
						IndentLine(curLine, previousIndent);
						int position = LineIndentPosition(curLine);
						SetSel(position, position);
					}
					break;
				case Enums.SmartIndent.CPP:
					if (ch == newline)
					{
						int curLine = LineFromPosition(CurrentPos);
						int tempLine = curLine;
						int previousIndent;
						string tempText;
						do 
						{
							previousIndent = GetLineIndentation(tempLine - 1);
							tempText = GetLine(tempLine-1).Trim();
							if (tempText.Length == 0) previousIndent = -1;
							tempLine--;
						}
						while ((tempLine > 1) && (previousIndent < 0));
						if (tempText.EndsWith("{")) 
						{
							int bracePos = CurrentPos-1;
							while (bracePos > 0 && CharAt(bracePos) != '{') bracePos--;
							if (bracePos > 0 && BaseStyleAt(bracePos) == 10)
								previousIndent += TabWidth;
						}
						IndentLine(curLine, previousIndent);
						int position = LineIndentPosition(curLine);
						SetSel(position, position);
					}
					else if (ch == '}')
					{
						int position = CurrentPos;
						int curLine = LineFromPosition(position);
						int previousIndent = GetLineIndentation(curLine-1);
						int match = SafeBraceMatch(position-1);
						if (match != -1)
						{
							previousIndent = GetLineIndentation(LineFromPosition(match));
							IndentLine(curLine, previousIndent);
						}
					}
					break;
				case Enums.SmartIndent.Custom:
					if (ch == newline)
					{
						if (SmartIndent != null) SmartIndent(this);
					}
					break;
			}
		}
		
		#endregion

		#region "Misc Custom Stuff"

		/**
		* Render the contents for printing
		*/
		public int FormatRange(bool measureOnly, PrintPageEventArgs e, int charFrom, int charTo)
		{
			IntPtr hdc = e.Graphics.GetHdc();
			int wParam = (measureOnly ? 0 : 1);
			RangeToFormat frPrint = this.GetRangeToFormat(hdc, charFrom, charTo);
			IntPtr lParam = Marshal.AllocCoTaskMem(Marshal.SizeOf(frPrint));
			Marshal.StructureToPtr(frPrint, lParam, false);
			int res = (int)this.SPerform(2151, (uint)wParam, (uint)lParam);
			Marshal.FreeCoTaskMem(lParam);
			e.Graphics.ReleaseHdc(hdc);
			return res;
		}
		
		/**
		* Populates the RangeToFormat struct
		*/
		private RangeToFormat GetRangeToFormat(IntPtr hdc, int charFrom, int charTo)
		{
			RangeToFormat frPrint;
			int pageWidth = (int)GetDeviceCaps(hdc, 110);
			int pageHeight = (int)GetDeviceCaps(hdc, 111);
			frPrint.hdcTarget = hdc;
			frPrint.hdc = hdc;
			frPrint.rcPage.Left = 0;
			frPrint.rcPage.Top = 0;
			frPrint.rcPage.Right = pageWidth;
			frPrint.rcPage.Bottom = pageHeight;
			frPrint.rc.Left = Convert.ToInt32(pageWidth*0.02);
			frPrint.rc.Top = Convert.ToInt32(pageHeight*0.03);
			frPrint.rc.Right = Convert.ToInt32(pageWidth*0.975);
			frPrint.rc.Bottom = Convert.ToInt32(pageHeight*0.95);
			frPrint.chrg.cpMin = charFrom;
			frPrint.chrg.cpMax = charTo;
			return frPrint;
		}
		
		/**
		* Free cached data from the control after printing
		*/
		public void FormatRangeDone()
		{
		    this.SPerform(2151, 0, 0);
		}
		
		/**
		* This holds the actual encoding of the document
		*/
		public Encoding Encoding
		{
			set { this.encoding = value; }
			get { return this.encoding; }
		}
		
		/**
		* Adds a line end marker to the end of the document
		*/
		public void AddLastLineEnd()
		{
			string eolMarker = "\r\n";
			if (this.EOLMode == 1) eolMarker = "\r";
			else if (this.EOLMode == 2) eolMarker = "\n";
			if (!this.Text.EndsWith(eolMarker))
			{
				this.TargetStart = this.TargetEnd = this.TextLength;
				this.ReplaceTarget(eolMarker.Length, eolMarker);
			}
		}
		
		/**
		* Checks if line is just spaces
		*/
		public bool LineIsJustWhite(int line)
		{
			string lineText = this.GetLine(line);
			return (lineText.Trim() == "");
		}
		
		/**
		* Removes trailing spaces from each line
		*/
		public void StripTrailingSpaces()
		{
			this.BeginUndoAction();
			int maxLines = this.LineCount;
			for (int line = 0; line<maxLines; line++)
			{
				int lineStart = this.PositionFromLine(line);
				int lineEnd = this.LineEndPosition(line);
				int i = lineEnd-1;
				char ch = (char)this.CharAt(i);
				while ((i >= lineStart) && (ch == ' ' || ch == '\t'))
				{
					i--;
					ch = (char)this.CharAt(i);
				}
				if (i < (lineEnd-1))
				{
					this.TargetStart = i+1;
					this.TargetEnd = lineEnd;
					this.ReplaceTarget(0, "");
				}
			}
			this.EndUndoAction();
		}
		
		/**
		* Checks that if the specified position is on comment.
		*/
		public bool PositionIsOnComment(int position)
		{
			Colourise(0, -1);
			return PositionIsOnComment(position, Lexer);
		}
		public bool PositionIsOnComment(int position, int lexer)
		{
			int style = BaseStyleAt(position);
			if ((lexer == 2 || lexer == 21)
			    && style == 1
			    || style == 12)
			{
				return true; // python or lisp
			}
			else if ((Lexer == 3 || lexer == 18 || lexer == 25 || lexer == 27)
			    && style == 1
			    || style == 2 
			    || style == 3
			    || style == 15
				|| style == 17
				|| style == 18)
			{
				return true; // cpp, tcl, bullant or pascal
			} 
			else if ((lexer == 4 || lexer == 5)
		        && style == 9
		        || style == 20 
		        || style == 29 
		        || style == 30 
		        || style == 42 
		        || style == 43 
		        || style == 44 
		        || style == 57 
		        || style == 58 
		        || style == 59
		        || style == 72
		        || style == 82
		        || style == 92
		        || style == 107
		        || style == 124
		        || style == 125)
			{
				return true; // html or xml
			}
			else if ((lexer == 6 || lexer == 22 || lexer == 45 || lexer == 62)
			    && style == 2)
			{
				return true; // perl, bash, clarion/clw or ruby
			}
			else if ((Lexer == 7)
			    && style == 1
				|| style == 2 
				|| style == 3
				|| style == 13
				|| style == 15
				|| style == 17
				|| style == 18)
			{
				return true; // sql
			}
			else if ((lexer == 8 || lexer == 9 || lexer == 11 || lexer == 12 || lexer == 16 || lexer == 17 || lexer == 19 || lexer == 23 || lexer == 24 || lexer == 26 || lexer == 28 || lexer == 32 || lexer == 36 || lexer == 37 || lexer == 40 || lexer == 44 || lexer == 48 || lexer == 51 || lexer == 53 || lexer == 54 || lexer == 57 || lexer == 63)
			    && style == 1)
			{
				return true; // asn1, vb, diff, batch, makefile, avenue, eiffel, eiffelkw, vbscript, matlab, crontab, fortran, f77, lout, mmixal, yaml, powerbasic, erlang, octave, kix or properties
			}
			else if ((lexer == 14)
			    && style == 4)
			{
				return true; // latex
			}
			else if ((lexer == 15 || lexer == 41 || lexer == 56)
			    && style == 1
			   	|| style == 2
			  	|| style == 3)
			{
				return true; // lua, verilog or escript
			}
			else if ((lexer == 20)
			    && style == 10)
			{
				return true; // ada
			}
			else if ((lexer == 31 || lexer == 39 || lexer == 42 || lexer == 52 || lexer == 55 || lexer == 58 || lexer == 60 || lexer == 61 || lexer == 64 || lexer == 71)
			    && style == 1
				|| style == 2)
			{
				return true; // au3, apdl, baan, ps, mssql, rebol, forth, gui4cli, vhdl or pov
			}
			else if ((lexer == 34)
			    && style == 1
				|| style == 11)
			{
				return true; // asm
			}
			else if ((lexer == 43)
			    && style == 1
				|| style == 18)
			{
				return true; // nsis
			}
			else if ((lexer == 59)
			    && style == 2
				|| style == 3)
			{
				return true; // specman
			}
			else if ((lexer == 70)
			    && style == 3
				|| style == 4)
			{
				return true; // tads3
			}
			else if ((lexer == 74)
			    && style == 1
				|| style == 9)
			{
				return true; // csound
			}
			else if ((lexer == 65)
			    && style == 12
				|| style == 13
				|| style == 14
				|| style == 15)
			{
				return true; // caml
			}
			else if ((lexer == 68)
			    && style == 13
				|| style == 14
				|| style == 15
				|| style == 16)
			{
				return true; // haskell
			}
			else if ((lexer == 73)
			    && style == 1
				|| style == 2
				|| style == 3
				|| style == 4
				|| style == 5
				|| style == 6)
			{
				return true; // flagship
			}
			else if ((lexer == 72) 
			    && style == 3)
			{
				return true; // smalltalk
			}
			else if ((lexer == 38) 
			    && style == 9)
			{
				return true; // css
			}
			return false;
		}
		
		/**
		* Indents the specified line
		*/
		protected void IndentLine(int line, int indent)
		{
			if (indent < 0) return;
			int selStart = SelectionStart;
			int selEnd = SelectionEnd;
			int posBefore = LineIndentPosition(line);
			SetLineIndentation(line, indent);
			int posAfter = LineIndentPosition(line);
			int posDifference = posAfter - posBefore;
			if (posAfter > posBefore)
			{
				if (selStart >= posBefore) selStart += posDifference;
				if (selEnd >= posBefore) selEnd += posDifference;
			}
			else if (posAfter < posBefore)
			{
				if (selStart >= posAfter)
				{
					if (selStart >= posBefore) selStart += posDifference;
					else selStart = posAfter;
				}
				if (selEnd >= posAfter)
				{
					if (selEnd >= posBefore) selEnd += posDifference;
					else selEnd = posAfter;
				}
			}
			SetSel(selStart, selEnd);
		}
		
		/**
		* Expands all folds
		*/
		public void ExpandAllFolds()
		{
			for (int i = 0; i<LineCount; i++)
			{
				FoldExpanded(i, true);
				ShowLines(i+1, i+1);
			}
		}
		
		/**
		* Collapses all folds
		*/
		public void CollapseAllFolds()
		{
			for (int i = 0; i<LineCount; i++)
			{
				int maxSubOrd = LastChild(i, -1);
				FoldExpanded(i, false);
				HideLines(i+1, maxSubOrd);
			}
		}
		
		/**
		* Selects the specified text
		*/
		public void SelectText(string text)
		{
			Match match = Regex.Match(this.Text, text);
			if (match.Success)
			{
				this.MBSafeSetSel(match.Index, text);
			}
		}
		
		/**
		* Gets a word from the specified position
		*/
		public string GetWordFromPosition(int position)
		{
			try
			{
				int startPosition = this.MBSafeCharPosition(this.WordStartPosition(position-1, true));
				int endPosition = this.MBSafeCharPosition(this.WordEndPosition(position-1, true));
				string keyword = this.Text.Substring(startPosition, endPosition-startPosition);
				if (keyword == "" || keyword == " ") return null;
				return keyword.Trim();
			}
			catch
			{
				return null;
			}
		}
		
		/**
		* These are general multibyte safe methods for UTF mode
		*/
		public void MBSafeInsertText(int position, string text)
		{
			if (this.CodePage != 65001)
			{
				this.InsertText(position, text);
			}
			else
			{	
				int mbpos = this.MBSafePosition(position);
				this.InsertText(mbpos, text);
			}
		}
		public void MBSafeGotoPos(int position)
		{
			if (this.CodePage != 65001)
			{
				this.GotoPos(position);
			}
			else
			{
				int mbpos = this.MBSafePosition(position);
				this.GotoPos(mbpos);
			}
		}
		public void MBSafeSetSel(int start, int end)
		{
			if (this.CodePage != 65001)
			{
				this.SetSel(start, end);
			}
			else
			{
				string count = this.Text.Substring(start, end-start);
				start = this.MBSafePosition(start);
				end = start+this.MBSafeTextLength(count);
				this.SetSel(start, end);
			}
		}
		public void MBSafeSetSel(int start, string text)
		{
			if (this.CodePage != 65001)
			{
				this.SetSel(start, start+text.Length);
			}
			else
			{
				int mbpos = this.MBSafePosition(start);
				this.SetSel(mbpos, mbpos+this.MBSafeTextLength(text));
			}
		}
		public int MBSafePosition(int position)
		{
			if (this.CodePage != 65001)
			{
				return position;
			}
			else
			{
				string count = this.Text.Substring(0, position);
				int mbpos = Encoding.UTF8.GetByteCount(count);
				return mbpos;
			}
		}
		public int MBSafeCharPosition(int bytePosition)
		{
			if (this.CodePage != 65001)
			{
				return bytePosition;
			}
			else
			{
				byte[] bytes = Encoding.UTF8.GetBytes(this.Text);
				int chrpos = Encoding.UTF8.GetCharCount(bytes, 0, bytePosition);
				return chrpos;
			}
		}
		public int MBSafeTextLength(string text)
		{
			if (this.CodePage != 65001)
			{
				return text.Length;
			}
			else
			{
				int mblenght = Encoding.UTF8.GetByteCount(text);
				return mblenght;
			}
		}
		
		/**
		* Custom way to find the matching brace when BraceMatch() does not work
		*/
		public int SafeBraceMatch(int position)
		{
			int match = this.CharAt(position);
			int toMatch = 0;
			int length = TextLength;
			int ch;
			int sub = 0;
			int lexer = Lexer;
			Colourise(0, -1);
			bool comment = PositionIsOnComment(position, lexer);
			switch (match)
			{
				case '{':
					toMatch = '}';
					goto down;
				case '(':
					toMatch = ')';
					goto down;
				case '[':
					toMatch = ']';
					goto down;
				case '}':
					toMatch = '{';
					goto up;
				case ')':
					toMatch = '(';
					goto up;
				case ']':
					toMatch = '[';
					goto up;
			}
			return -1;
			// search up
			up:
			while (position >= 0)
			{
				position--;
				ch = CharAt(position);
				if (ch == match) 
				{
					if (comment == PositionIsOnComment(position, lexer)) sub++;
				}
				else if (ch == toMatch && comment == PositionIsOnComment(position, lexer))
				{
					sub--;
					if (sub < 0) return position;
				}
			}
			return -1;
			// search down
			down:
			while (position < length)
			{
				position++;
				ch = CharAt(position);
				if (ch == match) 
				{
					if (comment == PositionIsOnComment(position, lexer)) sub++;
				}
				else if (ch == toMatch && comment == PositionIsOnComment(position, lexer)) 
				{
					sub--;
					if (sub < 0) return position;
				}
			}
			return -1;
		}
		
		/**
		* File dropped on the control, fire URIDropped event
		*/
		unsafe void HandleFileDrop(IntPtr hDrop) 
		{
			int nfiles = DragQueryFileA(hDrop, 0xffffffff, (IntPtr)null, 0);
			string files = "";
			byte[] buffer = new byte[PATH_LEN];
			for (uint i = 0; i<nfiles; i++) 
			{
				fixed (byte* b = buffer) 
				{
					DragQueryFileA(hDrop, i, (IntPtr)b, PATH_LEN);
					if (files.Length > 0) files += ' ';
					files += '"'+MarshalStr((IntPtr)b) + '"';
				}
			}
			DragFinish(hDrop);
			if (URIDropped != null) URIDropped(this, files);                        
		}
		
		
		/**
		* Returns the base style (without indicators) byte at the position.
		*/
		public int BaseStyleAt(int pos)
		{
			return (int)(SPerform(2010, (uint)pos, 0) & ((1 << this.StyleBits) - 1));
		}	

		#endregion
		
		#region "Not yet ready"
		
		/**
		# Returns the target converted to UTF8.
		# Return the length in bytes.
		fun int TargetAsUTF8=2447(, stringresult s)
		
		# Set the length of the utf8 argument for calling EncodedFromUTF8.
		# Set to -1 and the string will be measured to the first nul.
		fun void SetLengthForEncode=2448(int bytes,)
		
		# Translates a UTF8 string into the document encoding.
		# Return the length of the result in bytes.
		# On error return 0.
		fun int EncodedFromUTF8=2449(string utf8, stringresult encoded)
		
		# Find the position of a column on a line taking into account tabs and
		# multi-byte characters. If beyond end of line, return line end position.
		fun int FindColumn=2456(int line, int column)
		
		# Retrieve a "property" value previously set with SetProperty.
		fun int GetProperty=4008(string key, stringresult buf)
		
		# Retrieve a "property" value previously set with SetProperty,
		# with "$()" variable replacement on returned buffer.
		fun int GetPropertyExpanded=4009(string key, stringresult buf)
		
		Not Emitted:
		Function : AddStyledText
		// Function with cells parameter skipped [AddStyledText]
		// There is no clear way to provide this functionaliy to a .NET app.
		Function : GetStyledText
		// Function with parameter 2 TEXTRANGE skipped [GetStyledText]
		// Not yet coded this :p.
		Function : FindText
		// Function with parameter 2 find text skipped [FindText]
		// Not yet coded this :p.
		Function : GetTextRange
		// Function with parameter 2 TEXTRANGE skipped [GetTextRange]
		// Not yet coded this :p.
		*/
		
		#endregion
		
	}
	
}
