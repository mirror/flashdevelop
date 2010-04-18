////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2003-2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
using System;
using System.IO;
using Flash.Tools.Debugger;
using Flash.Tools.Debugger.Events;
using Flash.Tools.Debugger.Expression;
using Flash.Util;
using JavaCompatibleClasses;
using LocalizationManager = Flash.Localization.LocalizationManager;

namespace Flex.Tools.Debugger.CLI
{
	
	/// <summary> This is a front end command line interface to the Flash Debugger
	/// Player.
	/// <p />
	/// This tool utilizes the Debugger Java API (DJAPI) for Flash 
	/// Player that exists in Flash.Tools.debuggger.
	/// <p /> 
	/// This tool is not completely compliant with the API, since
	/// some commands expose implementation specific information for
	/// debugging purposes.  Instances where this occurs are kept to a
	/// minimum and are isolated in a special class called Extensions.  
	/// If you wish to build a version that is completely API 
	/// compatible.  Replace Extensions with ExtensionsDisabled in 
	/// the static method calls at the end of this file. 
	/// </summary>
	public class DebugCLI : SourceLocator
	{
		public static LocalizationManager LocalizationManager
		{
			get
			{
				return s_localizationManager;
			}
			
		}
		virtual public Session Session
		{
			get
			{
				return m_session;
			}
			
		}
		virtual public FileInfoCache FileCache
		{
			get
			{
				return m_fileInfo;
			}
			
		}
		virtual internal String CurrentLine
		{
			set
			{
				m_currentLine = value;
				if (m_currentLine == null)
					m_currentTokenizer = null;
				/* eof */
				else
				{
					m_currentLine = m_currentLine.Trim();
					
					/* if nothing provided on this command then pull our 'repeat' command  */
					if (m_repeatLine != null && !haveStreams() && m_currentLine.Length == 0)
						m_currentLine = m_repeatLine;
					
					m_currentTokenizer = new SupportClass.Tokenizer(m_currentLine, " \n\r\t"); //$NON-NLS-1$
				}
			}
			
		}
		virtual public StreamWriter Out
		{
			get
			{
				return m_out;
			}
			
		}
		virtual internal bool ConnectionLost
		{
			// check if we have lost the connect without our help...
			
			get
			{
				bool lost = false;
				
				if (m_session != null && !m_session.Connected)
					lost = true;
				
				return lost;
			}
			
		}
		/// <summary> Ask each swf if metadata processing is complete</summary>
		virtual public bool MetaDataAvailable
		{
			get
			{
				bool allLoaded = true;
				try
				{
					// we need to ask the session since our fileinfocache will hide the exception
					SwfInfo[] swfs = m_session.Swfs;
					for (int i = 0; i < swfs.Length; i++)
					{
						// check if our processing is finished.
						SwfInfo swf = swfs[i];
						if (swf != null && !swf.ProcessingComplete)
						{
							allLoaded = false;
							break;
						}
					}
				}
				catch (NoResponseException)
				{
					// ok we still need to wait for player to read the swd in
					allLoaded = false;
				}
				
				// count the number of times we checked and it wasn't there
				if (!allLoaded)
				{
					int count = propertyGet(METADATA_NOT_AVAILABLE);
					count++;
					propertyPut(METADATA_NOT_AVAILABLE, count);
				}
				else
				{
					// success so we reset our attempt counter
					propertyPut(METADATA_ATTEMPTS, METADATA_RETRIES);
				}
				return allLoaded;
			}
			
		}
		virtual internal int ListingToFrame
		{
			// set the listing command to point to the file/line of the given frame
			
			set
			{
				// set the module and line
				Frame[] frames = m_session.Frames;
				Frame ctx = frames[value];
				
				Location l = ctx.Location;
				SourceFile f = l.File;
                int id = 0;
                int line = l.Line;

                if (f != null)
                {
                    id = f.Id;
                }
                setListingPosition(id, line);
            }
			
		}
		virtual public int ChangeCount
		{
			/* (non-Javadoc)
			* @see Flash.Tools.Debugger.SourceLocator#getChangeCount()
			*/
			
			get
			{
				return m_sourceDirectoriesChangeCount;
			}
			
		}
		/// <summary> Returns the Flex home directory.  This is based on the <code>application.home</code>
		/// Java system property if present, or the current directory otherwise.
		/// This directory is one up from the "bin" and "lib" directories.  For example,
		/// <code>&lt;flexhome&gt;/lib/fdb.jar</code> can be used to refer to the fdb jar.
		/// </summary>
		virtual protected internal FileInfo FlexHomeDirectory
		{
			get
			{
				if (!m_initializedFlexHomeDirectory)
				{
					m_initializedFlexHomeDirectory = true;
					m_flexHomeDirectory = new FileInfo("."); // default in case the following logic fails //$NON-NLS-1$
					String flexHome = SystemProperties.getProperty("application.home"); //$NON-NLS-1$
					if (flexHome != null && flexHome.Length > 0)
					{
						try
						{
							m_flexHomeDirectory = new FileInfo(new FileInfo(flexHome).FullName);
						}
						catch (IOException)
						{
							// ignore
						}
					}
				}
				
				return m_flexHomeDirectory;
			}
			
		}
		public const String VERSION = "82"; //$NON-NLS-1$
		
		public const int CMD_UNKNOWN = 0;
		public const int CMD_QUIT = 1;
		public const int CMD_CONTINUE = 2;
		public const int CMD_STEP = 3;
		public const int CMD_NEXT = 4;
		public const int CMD_FINISH = 5;
		public const int CMD_BREAK = 6;
		public const int CMD_SET = 7;
		public const int CMD_LIST = 8;
		public const int CMD_PRINT = 9;
		public const int CMD_TUTORIAL = 10;
		public const int CMD_INFO = 11;
		public const int CMD_HOME = 12;
		public const int CMD_RUN = 13;
		public const int CMD_FILE = 14;
		public const int CMD_DELETE = 15;
		public const int CMD_SOURCE = 16;
		public const int CMD_COMMENT = 17;
		public const int CMD_CLEAR = 18;
		public const int CMD_HELP = 19;
		public const int CMD_SHOW = 20;
		public const int CMD_KILL = 21;
		public const int CMD_HANDLE = 22;
		public const int CMD_ENABLE = 23;
		public const int CMD_DISABLE = 24;
		public const int CMD_DISPLAY = 25;
		public const int CMD_UNDISPLAY = 26;
		public const int CMD_COMMANDS = 27;
		public const int CMD_PWD = 28;
		public const int CMD_CF = 29;
		public const int CMD_CONDITION = 30;
		public const int CMD_AWATCH = 31;
		public const int CMD_WATCH = 32;
		public const int CMD_RWATCH = 33;
		public const int CMD_WHAT = 34;
		public const int CMD_DISASSEMBLE = 35;
		public const int CMD_HALT = 36;
		public const int CMD_MCTREE = 37;
		public const int CMD_VIEW_SWF = 38;
		public const int CMD_DOWN = 39;
		public const int CMD_UP = 40;
		public const int CMD_FRAME = 41;
		public const int CMD_DIRECTORY = 42;
		
		/* info sub commands */
		public const int INFO_UNKNOWN_CMD = 100;
		public const int INFO_ARGS_CMD = 101;
		public const int INFO_BREAK_CMD = 102;
		public const int INFO_FILES_CMD = 103;
		public const int INFO_HANDLE_CMD = 104;
		public const int INFO_FUNCTIONS_CMD = 105;
		public const int INFO_LOCALS_CMD = 106;
		public const int INFO_SCOPECHAIN_CMD = 107;
		public const int INFO_SOURCES_CMD = 108;
		public const int INFO_STACK_CMD = 109;
		public const int INFO_VARIABLES_CMD = 110;
		public const int INFO_DISPLAY_CMD = 111;
		public const int INFO_TARGETS_CMD = 112;
		public const int INFO_SWFS_CMD = 113;
		
		/* show subcommands */
		public const int SHOW_UNKNOWN_CMD = 200;
		public const int SHOW_NET_CMD = 201;
		public const int SHOW_FUNC_CMD = 202;
		public const int SHOW_URI_CMD = 203;
		public const int SHOW_PROPERTIES_CMD = 204;
		public const int SHOW_FILES_CMD = 205;
		public const int SHOW_BREAK_CMD = 206;
		public const int SHOW_VAR_CMD = 207;
		public const int SHOW_MEM_CMD = 208;
		public const int SHOW_LOC_CMD = 209;
		public const int SHOW_DIRS_CMD = 210;
		
		/* misc subcommands */
		public const int ENABLE_ONCE_CMD = 301;
		
		// default metadata retry count 8 attempts per waitForMetadata() call * 5 calls
		public const int METADATA_RETRIES = 8 * 5;
		
		internal System.Collections.Stack m_readerStack = new System.Collections.Stack();
		internal StreamWriter m_err;
		internal StreamWriter m_out;
		internal Session m_session;
		internal String m_launchURI;
		internal bool m_fullnameOption; // emacs mode
		internal String m_cdPath;
		internal String m_mruURI;
        public readonly String m_newline = Environment.NewLine; //$NON-NLS-1$
		
		private static readonly LocalizationManager s_localizationManager = new LocalizationManager();
		
		internal System.Collections.IList m_sourceDirectories; // List of String
		internal int m_sourceDirectoriesChangeCount;
		private FileInfo m_flexHomeDirectory; // <application.home>/frameworks/projects/*/src always goes in m_sourceDirectories
		private bool m_initializedFlexHomeDirectory;
		
		// context information for our current session
		internal FileInfoCache m_fileInfo;
		internal ExpressionCache m_exprCache;
		internal FaultActions m_faultTable;
		internal System.Collections.ArrayList m_breakpoints;
		internal System.Collections.ArrayList m_watchpoints;
		internal System.Collections.ArrayList m_displays;
		internal bool m_requestResume;
		internal bool m_requestHalt;
		internal bool m_stepResume;
		
		/* our current input processing context */
        internal LineNumberReader m_in;
		internal LineNumberReader m_keyboardStream;
		internal System.Collections.ArrayList m_keyboardInput;
		internal bool m_keyboardReadRequest;
		internal SupportClass.Tokenizer m_currentTokenizer;
		internal String m_currentToken;
		internal String m_currentLine;
		public String m_repeatLine;
		
		/// <summary> The module that the next "list" command should display if no
		/// module is explicitly specified.
		/// </summary>
		public const String LIST_MODULE = "$listmodule"; //$NON-NLS-1$
		
		/// <summary> The line number at which the next "list" command should begin if no
		/// line number is explicitly specified.
		/// </summary>
		public const String LIST_LINE = "$listline"; //$NON-NLS-1$
		
		/// <summary> The number of lines displayed by the "list" command.</summary>
		private const String LIST_SIZE = "$listsize"; //$NON-NLS-1$
		
		private const String COLUMN_WIDTH = "$columnwidth"; //$NON-NLS-1$
		
		private const String UPDATE_DELAY = "$updatedelay"; //$NON-NLS-1$
		
		private const String HALT_TIMEOUT = "$halttimeout"; //$NON-NLS-1$
		
		/// <summary> Current breakpoint number.</summary>
		private const String BPNUM = "$bpnum"; //$NON-NLS-1$
		
		/// <summary> Used to determine how much context information should be displayed.</summary>
		private const String LAST_FRAME_DEPTH = "$lastframedepth"; //$NON-NLS-1$
		
		/// <summary> Used to determine how much context information should be displayed.</summary>
		private const String CURRENT_FRAME_DEPTH = "$currentframedepth"; //$NON-NLS-1$
		
		/// <summary> The current frame we are viewing -- controlled by the "up", "down", and "frame" commands.</summary>
		public const String DISPLAY_FRAME_NUMBER = "$displayframenumber"; //$NON-NLS-1$
		
		private const String FILE_LIST_WRAP = "$filelistwrap"; //$NON-NLS-1$
		
		private const String NO_WAITING = "$nowaiting"; //$NON-NLS-1$
		
		/// <summary> Show this pointer for info stack.</summary>
		private const String INFO_STACK_SHOW_THIS = "$infostackshowthis"; //$NON-NLS-1$
		
		/// <summary> Number of milliseconds to wait for metadata.</summary>
		private const String METADATA_ATTEMPTS_PERIOD = "$metadataattemptsperiod"; //$NON-NLS-1$
		
		private const String METADATA_NOT_AVAILABLE = "$metadatanotavailable"; //$NON-NLS-1$
		
		/// <summary> How many times we should try to get metadata.</summary>
		private const String METADATA_ATTEMPTS = "$metadataattempts"; //$NON-NLS-1$
		
		private const String PLAYER_FULL_SUPPORT = "$playerfullsupport"; //$NON-NLS-1$
		
		/// <summary> Whether the "print" command will display attributes of members.</summary>
		public const String DISPLAY_ATTRIBUTES = "$displayattributes"; //$NON-NLS-1$
		
		[STAThread]
		public static void  Main(String[] args)
		{
			DebugCLI cli = new DebugCLI();
			
			/* attach our 'main' input method and out/err*/
			StreamWriter temp_writer;
			temp_writer = new StreamWriter(System.Console.OpenStandardError(), System.Console.Error.Encoding);
			temp_writer.AutoFlush = true;
			cli.m_err = temp_writer;
			StreamWriter temp_writer2;
			temp_writer2 = new StreamWriter(System.Console.OpenStandardOutput(), System.Console.Out.Encoding);
			temp_writer2.AutoFlush = true;
			cli.m_out = temp_writer2;

            /* iterate through the args list */
            cli.processArgs(args);

            // get the default <application.home>/projects/frameworks/*/src entries into the source path
			cli.initSourceDirectoriesList();
			
			// a big of wrangling for our keyboard input stream since its special
            StreamReader stdin = new StreamReader(System.Console.OpenStandardInput(), System.Text.Encoding.Default);

			cli.m_keyboardStream = new LineNumberReader(new StreamReader(stdin.BaseStream, stdin.CurrentEncoding));
			cli.pushStream(cli.m_keyboardStream);
			
			/* figure out $HOME and the current directory */
			String userHome = System.Environment.GetEnvironmentVariable("userprofile"); //$NON-NLS-1$
			String userDir = System.Environment.CurrentDirectory; //$NON-NLS-1$
			
			/*
			* If the current directory is not $HOME, and a .fdbinit file exists in the current directory,
			* then push it onto the stack of files to read.
			* 
			* Note, we want ./.fdbinit to be read AFTER $HOME/.fdbinit, but we push them in reverse
			* order, because they're going onto a stack.  If we push them in reverse order, then they
			* will be read in the correct order (last one pushed is the first one read).
			*/
			if (userDir != null && !userDir.Equals(userHome))
			{
				try
				{
					StreamReader sr = new StreamReader(new FileInfo(userDir + "\\" + ".fdbinit").FullName, System.Text.Encoding.Default); //$NON-NLS-1$
					cli.pushStream(new LineNumberReader(sr));
				}
				catch (FileNotFoundException)
				{
				}
			}
			
			/*
			* If a .fdbinit file exists in the $HOME directory, then push it onto the stack of files
			* to read.
			* 
			* Note, we want ./.fdbinit to be read AFTER $HOME/.fdbinit, but we push them in reverse
			* order, because they're going onto a stack.  If we push them in reverse order, then they
			* will be read in the correct order (last one pushed is the first one read).
			*/
			if (userHome != null)
			{
				try
				{
					StreamReader sr = new StreamReader(new FileInfo(userHome + "\\" + ".fdbinit").FullName, System.Text.Encoding.Default); //$NON-NLS-1$
					cli.pushStream(new LineNumberReader(sr));
				}
				catch (FileNotFoundException)
				{
				}
			}
			
			cli.execute();
		}
		
		public DebugCLI()
		{
			m_fullnameOption = false;
			m_exprCache = new ExpressionCache(this);
			m_faultTable = new FaultActions();
			m_breakpoints = System.Collections.ArrayList.Synchronized(new System.Collections.ArrayList(10));
			m_watchpoints = System.Collections.ArrayList.Synchronized(new System.Collections.ArrayList(10));
			m_displays = new System.Collections.ArrayList();
			m_keyboardInput = System.Collections.ArrayList.Synchronized(new System.Collections.ArrayList(10));
			m_mruURI = null;
			m_sourceDirectories = new System.Collections.ArrayList();
			
			initProperties();
			populateFaultTable();
		}
		
		/// <summary> Convert a module to class name.  This is used
		/// by the ExpressionCache to find variables
		/// that live at royale package scope.   That
		/// is variables such as mx.core.Component.
		/// </summary>
		public virtual String module2ClassName(int moduleId)
		{
			String pkg = null;
			try
			{
				SourceFile file = m_fileInfo.getFile(moduleId);
				pkg = file.getPackageName();
			}
			catch (System.Exception)
			{
				// didn't work ignore it.
			}
			return pkg;
		}

        internal virtual LineNumberReader popStream()
		{
            return (LineNumberReader)m_readerStack.Pop();
		}
		internal virtual void  pushStream(LineNumberReader r)
		{
			m_readerStack.Push(r);
		}
		internal virtual bool haveStreams()
		{
			return !(m_readerStack.Count == 0);
		}
		
		internal virtual void  processArgs(String[] args)
		{
			for (int i = 0; i < args.Length; i++)
			{
				String arg = args[i];
				//			System.out.println("arg["+i+"]= '"+arg+"'");
				if (arg[0] == '-')
				{
					// its an option
                    if (arg.StartsWith("-D"))
                    {
                        String[] propNameValue = arg.Substring(2).Split(new char[] { '=' }, 2);

                        if (propNameValue.Length > 0)
                        {
                            SystemProperties.setProperty(propNameValue[0], propNameValue.Length > 1 ? propNameValue[1] : "1");
                        }
                    }
                    else if (arg.Equals("-unit"))
					// unit-testing mode //$NON-NLS-1$
					{
						SystemProperties.setProperty("fdbunit", ""); //$NON-NLS-1$ //$NON-NLS-2$
					}
					else if (arg.Equals("-fullname") || arg.Equals("-f"))
					//$NON-NLS-1$ //$NON-NLS-2$
					{
						m_fullnameOption = true; // emacs mode
					}
					else if (arg.Equals("-cd"))
					//$NON-NLS-1$
					{
						// consume the path
						if (i + 1 < args.Length)
							m_cdPath = args[i++];
					}
					else
					{
						err("Unknown command-line argument: " + arg);
					}
				}
				else
				{
					// its a URI to run
					StringReader sr = new StringReader("run " + arg + m_newline); //$NON-NLS-1$
					pushStream(new LineNumberReader(sr));
				}
			}
		}
		
		/// <summary> Dispose of the current line and read the next from the current stream, if its an empty
		/// line and we are console then repeat last line.
		/// </summary>
		internal virtual String readLine()
		{
			String line = null;
			if (haveStreams())
			{
				line = m_in.ReadLine();
			}
			else
				line = keyboardReadLine();
			
			CurrentLine = line;
			return line;
		}
		
		/// <summary> The reader portion of our keyboard input routine
		/// Block until input arrives.
		/// </summary>
		internal virtual String keyboardReadLine()
		{
			lock (this)
			{
				// enable a request then block on the queue
				m_keyboardReadRequest = true;
				try
				{
					System.Threading.Monitor.Wait(this);
				}
				catch (System.Threading.ThreadInterruptedException)
				{
				}
				
				// pull from the front of the queue
				System.Object tempObject;
				tempObject = m_keyboardInput[0];
				m_keyboardInput.RemoveAt(0);
				return (String) tempObject;
			}
		}
		
		/// <summary> A seperate thread collects our input so that we can
		/// block in the doContinue on the main thread and then
		/// allow the user to interrupt us via keyboard input
		/// on this thread.
		/// 
		/// We built the stupid thing in this manner, since readLine()
		/// will block no matter what and if we 'quit' we can't
		/// seem to kill this thread.  .close() doesn't work
		/// and Thread.stop(), etc. all fail to do the job.
		/// 
		/// Thus we needed to take a request response approach
		/// so that we only block when requested to do so.
		/// </summary>
		public virtual void  Run()
		{
			// while we have this stream
			while (m_keyboardStream != null)
			{
				try
				{
					// only if someone is requesting us to read do we do so...
					if (m_keyboardReadRequest)
					{
						// block on keyboard input and put it onto the end of the queue
						String s = m_keyboardStream.ReadLine();
						m_keyboardInput.Add(s);
						
						// fullfilled request, now notify blocking thread.
						m_keyboardReadRequest = false;
						lock (this)
						{
							System.Threading.Monitor.PulseAll(this);
						}
					}
					else
						try
						{
							System.Threading.Thread.Sleep(new System.TimeSpan((System.Int64) 10000 * 50));
						}
						catch (System.Threading.ThreadInterruptedException)
						{
						}
				}
				catch (IOException)
				{
					//				io.printStackTrace();
				}
			}
		}
		
		/* Helpers for extracting tokens from the current line */
		public virtual bool hasMoreTokens()
		{
			return m_currentTokenizer.HasMoreTokens();
		}
		public virtual String nextToken()
		{
			m_currentToken = m_currentTokenizer.NextToken(); return m_currentToken;
		}
		public virtual int nextIntToken()
		{
			nextToken(); return System.Int32.Parse(m_currentToken);
		}
		public virtual String restOfLine()
		{
			return m_currentTokenizer.NextToken("").Trim();
		} //$NON-NLS-1$
		
		public virtual void  execute()
		{
			/* dump console message */
			displayStartMessage();
			
			/* now fire our keyboard input thread */
			System.Threading.Thread t = new System.Threading.Thread(Run);
			t.Name = "Keyboard input"; //$NON-NLS-1$
			t.Start();
			
			/* keep processing streams until we have no more to do */
			while (haveStreams())
			{
				try
				{
					m_in = popStream();
					process();
				}
				catch (EndOfStreamException)
				{
					; /* quite allright */
				}
				catch (IOException io)
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["exceptionMessage"] = io; //$NON-NLS-1$
					err(LocalizationManager.getLocalizedTextString("errorWhileProcessingFile", args)); //$NON-NLS-1$
				}
			}
			
			/* we done kill everything */
			exitSession();
			
			// clear this thing, which also halts our other thread.
			m_keyboardStream = null;
		}
		
		private void  displayStartMessage()
		{
			String build = LocalizationManager.getLocalizedTextString("defaultBuildName"); //$NON-NLS-1$
			
			try
			{
                String buildString = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();
				if ((buildString != null) && (!buildString.Equals("")))
				//$NON-NLS-1$
				{
					build = buildString;
				}
			}
			catch (System.Exception)
			{
				// ignore
			}
			
			System.Collections.IDictionary aboutMap = new System.Collections.Hashtable();
			aboutMap["build"] = build; //$NON-NLS-1$
			output(LocalizationManager.getLocalizedTextString("about", aboutMap)); //$NON-NLS-1$
			output(LocalizationManager.getLocalizedTextString("copyright")); //$NON-NLS-1$
		}
		
		internal virtual void  displayPrompt()
		{
			m_out.Write("(fdb) "); //$NON-NLS-1$
		}
		
		internal virtual void  displayCommandPrompt()
		{
			m_out.Write(">"); //$NON-NLS-1$
		}
		
		// add the given character n times to sb
		internal virtual void  repeat(System.Text.StringBuilder sb, char c, int n)
		{
			while (n-- > 0)
				sb.Append(c);
		}
		
		// Prompt the user to respond to a yes or no type question
		internal virtual bool yesNoQuery(String prompt)
		{
			bool result = false;
			m_out.Write(prompt);
			m_out.Write(LocalizationManager.getLocalizedTextString("yesOrNoAppendedToAllQuestions")); //$NON-NLS-1$
			
			String in_Renamed = readLine();
			if (in_Renamed != null && in_Renamed.Equals(LocalizationManager.getLocalizedTextString("singleCharacterUserTypesForYes")))
			//$NON-NLS-1$
				result = true;
			else if (in_Renamed != null && in_Renamed.Equals("escape"))
			//$NON-NLS-1$
				throw new System.ArgumentException("escape");
			//$NON-NLS-1$
			else
				output(LocalizationManager.getLocalizedTextString("yesNoQueryNotConfirmed")); //$NON-NLS-1$
			return result;
		}
		
		public virtual void  err(String s)
		{
			// Doesn't make sense to send messages to stderr, because this is
			// an interactive application; and besides that, sending a combination
			// of interwoven but related messages to both stdout and stderr causes
			// the output to be in the wrong order sometimes.
			output(s);
		}
		
		public virtual void output(String s)
		{
			if (s.Length > 0 && (s[s.Length - 1] == '\n'))
				m_out.Write(s);
			else
				m_out.WriteLine(s);
		}

#if false
		internal static String uft()
		{
			System.Diagnostics.Process rt = System.Diagnostics.Process.GetCurrentProcess();
			//UPGRADE_ISSUE: Method 'java.lang.Runtime.freeMemory' was not converted. "ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?index='!DefaultContextWindowIndex'&keyword='jlca1000_javalangRuntimefreeMemory'"
			//UPGRADE_ISSUE: Method 'java.lang.Runtime.totalMemory' was not converted. "ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?index='!DefaultContextWindowIndex'&keyword='jlca1000_javalangRuntimetotalMemory'"
			long free = rt.freeMemory(), total = rt.totalMemory(), used = total - free;
			//		long max = rt.maxMemory();
			SupportClass.TextNumberFormat nf = SupportClass.TextNumberFormat.getTextNumberInstance();
			//        System.out.println("used: "+nf.format(used)+" free: "+nf.format(free)+" total: "+nf.format(total)+" max: "+nf.format(max));
			return "Used " + nf.FormatLong(used) + " - free " + nf.FormatLong(free) + " - total " + nf.FormatLong(total); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
		}
#endif

		/// <summary> Add all properties that we know about</summary>
		internal virtual void  initProperties()
		{
			propertyPut(LIST_SIZE, 10);
			propertyPut(LIST_LINE, 1);
			propertyPut(LIST_MODULE, 1); // default to module #1
			propertyPut(COLUMN_WIDTH, 70);
			propertyPut(UPDATE_DELAY, 25);
			propertyPut(HALT_TIMEOUT, 7000);
			propertyPut(BPNUM, 0); // set current breakpoint number as something bad
			propertyPut(LAST_FRAME_DEPTH, 0); // used to determine how much context information should be displayed
			propertyPut(CURRENT_FRAME_DEPTH, 0); // used to determine how much context information should be displayed
			propertyPut(DISPLAY_FRAME_NUMBER, 0); // houses the current frame we are viewing
			propertyPut(FILE_LIST_WRAP, 999999); // default 1 file name per line
			propertyPut(NO_WAITING, 0);
			propertyPut(INFO_STACK_SHOW_THIS, 1); // show this pointer for info stack
		}
		
		// getter/setter for properties; in the expression cache, so that they can be used in expressions!
		public virtual void  propertyPut(String k, int v)
		{
			m_exprCache.put(k, v);
		}
		public virtual int propertyGet(String k)
		{
			return ((System.Int32) m_exprCache.get_Renamed(k));
		}
		public virtual SupportClass.SetSupport propertyKeys()
		{
			return m_exprCache.keySet();
		}
		
		/// <summary> Process this reader until its done</summary>
		internal virtual void  process()
		{
			bool done = false;
			while (!done)
			{
				try
				{
					/*
					* Now if we are in a session and that session is suspended then we go
					* into a state where we wait for some user interaction to get us out
					*/
					runningLoop();
					
					/* if we are in the stdin then put out a prompt */
					if (!haveStreams())
						displayPrompt();
					
					/* now read in the next line */
					readLine();
					if (m_currentLine == null)
						break;
					
					done = processLine();
				}
				catch (NoResponseException)
				{
					err(LocalizationManager.getLocalizedTextString("noResponseException")); //$NON-NLS-1$
				}
				catch (NotSuspendedException)
				{
					err(LocalizationManager.getLocalizedTextString("notSuspendedException")); //$NON-NLS-1$
				}
				catch (AmbiguousException)
				{
					// we already put up a warning for the user
				}
				catch (InvalidOperationException)
				{
					err(LocalizationManager.getLocalizedTextString("illegalStateException")); //$NON-NLS-1$
				}
				catch (System.Threading.SynchronizationLockException)
				{
					err(LocalizationManager.getLocalizedTextString("illegalMonitorStateException")); //$NON-NLS-1$
				}
				catch (ArgumentOutOfRangeException)
				{
					err(LocalizationManager.getLocalizedTextString("noSuchElementException")); //$NON-NLS-1$
				}
				catch (FormatException)
				{
					err(LocalizationManager.getLocalizedTextString("numberFormatException")); //$NON-NLS-1$
				}
				catch (System.Net.Sockets.SocketException se)
				{
					System.Collections.IDictionary socketArgs = new System.Collections.Hashtable();
					socketArgs["message"] = se.Message; //$NON-NLS-1$
					err(LocalizationManager.getLocalizedTextString("socketException", socketArgs)); //$NON-NLS-1$
				}
				catch (VersionException)
				{
					err(LocalizationManager.getLocalizedTextString("versionException")); //$NON-NLS-1$
				}
				catch (NotConnectedException)
				{
					// handled by isConnectionLost()
				}
				catch (Exception e)
				{
					err(LocalizationManager.getLocalizedTextString("unexpectedError")); //$NON-NLS-1$
					err(LocalizationManager.getLocalizedTextString("stackTraceFollows")); //$NON-NLS-1$
					Console.Error.Write(e.StackTrace);
                    Console.Error.Flush();
                }
				
				// check for a lost connection and if it is clean-up!
				if (ConnectionLost)
				{
					try
					{
						dumpHaltState(false);
					}
					catch (PlayerDebugException)
					{
						err(LocalizationManager.getLocalizedTextString("sessionEndedAbruptly")); //$NON-NLS-1$
					}
				}
			}
		}
		
		internal virtual bool haveConnection()
		{
			bool have = false;
			
			if (m_session != null && m_session.Connected)
				have = true;
			
			return have;
		}
		
		internal virtual void  doShow()
		{
			/* show without any args brings up help */
			if (!hasMoreTokens())
				output(getHelpTopic("show"));
			//$NON-NLS-1$
			else
			{
				/* otherwise we have a boatload of options */
				String subCmdString = nextToken();
				int subCmd = showCommandFor(subCmdString);
				switch (subCmd)
				{
					case SHOW_NET_CMD: 
						doShowStats();
						break;
					
					
					case SHOW_FUNC_CMD: 
						doShowFuncs();
						break;
					
					case SHOW_URI_CMD: 
						doShowUri();
						break;
					
					case SHOW_PROPERTIES_CMD: 
						doShowProperties();
						break;
					
					case SHOW_FILES_CMD: 
						doShowFiles();
						break;
					
					case SHOW_BREAK_CMD: 
						doShowBreak();
						break;
					
					case SHOW_VAR_CMD: 
						doShowVariable();
						break;
					
#if false					
					case SHOW_MEM_CMD: 
						doShowMemory();
						break;
#endif			
					
					case SHOW_LOC_CMD: 
						doShowLocations();
						break;
					
					case SHOW_DIRS_CMD: 
						doShowDirectories();
						break;
					
					default: 
						doUnknown("show", subCmdString); //$NON-NLS-1$
						break;
				}
			}
		}
		
		internal virtual void  doShowUri()
		{
			// dump the URI that the player has sent us
			try
			{
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				sb.Append("URI = "); //$NON-NLS-1$
				sb.Append(m_session.URI);
				output(sb.ToString());
			}
			catch (System.Exception)
			{
				err(LocalizationManager.getLocalizedTextString("noUriReceived")); //$NON-NLS-1$
			}
		}
		
		/// <summary> Dump the content of files in a raw format</summary>
		internal virtual void  doShowFiles()
		{
			try
			{
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				System.Collections.IEnumerator itr = m_fileInfo.AllFiles;
				
				while (itr.MoveNext())
				{
					SourceFile m = (SourceFile) ((IntMap.IntMapEntry)itr.Current).Value;
					
					String name = m.Name;
					int id = m.Id;
					String path = m.FullPath;
					
					sb.Append(id);
					sb.Append(' ');
					sb.Append(path);
					sb.Append(", "); //$NON-NLS-1$
					sb.Append(name);
					sb.Append(m_newline);
				}
				output(sb.ToString());
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("noSourceFilesFound")); //$NON-NLS-1$
			}
		}

#if false
		internal virtual void  doShowMemory()
		{
			output(uft());
		}
#endif
		
		internal virtual void  doShowLocations()
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			sb.Append("Num Type           Disp Enb Address    What" + m_newline);
			
			// our list of breakpoints
			int count = breakpointCount();
			for (int i = 0; i < count; i++)
			{
				BreakAction b = breakpointAt(i);
				int num = b.Id;
				
				FieldFormat.formatLong(sb, num, 3);
				sb.Append(" breakpoint     ");
				
				if (b.AutoDisable)
					sb.Append("dis  ");
				else if (b.AutoDelete)
					sb.Append("del  ");
				else
					sb.Append("keep ");
				
				if (b.Enabled)
					sb.Append("y   ");
				else
					sb.Append("n   ");

                for (int index = 0; index < b.Locations.Count; index++)
                {
                    Location l = b.Locations[index];
                    SourceFile file = l.File;
                    String funcName = (file == null) ? LocalizationManager.getLocalizedTextString("unknownBreakpointLocation") : file.getFunctionNameForLine(m_session, l.Line);
                    int offset = adjustOffsetForUnitTests((file == null) ? 0 : file.getOffsetForLine(l.Line));

                    if (index > 0)
                        sb.Append("                            "); //$NON-NLS-1$

                    sb.Append("0x"); //$NON-NLS-1$
                    FieldFormat.formatLongToHex(sb, offset, 8);
                    sb.Append(' ');

                    if (funcName != null)
                    {
                        System.Collections.IDictionary funcArgs = new System.Collections.Hashtable();
                        funcArgs["functionName"] = funcName; //$NON-NLS-1$
                        sb.Append(LocalizationManager.getLocalizedTextString("inFunctionAt", funcArgs)); //$NON-NLS-1$
                    }

                    sb.Append(file.Name);
                    if (file != null)
                    {
                        sb.Append("#"); //$NON-NLS-1$
                        sb.Append(file.Id);
                    }
                    sb.Append(':');
                    sb.Append(l.Line);

                    try
                    {
                        SwfInfo info = m_fileInfo.swfForFile(file);
                        System.Collections.IDictionary swfArgs = new System.Collections.Hashtable();
                        swfArgs["swf"] = FileInfoCache.shortNameOfSwf(info); //$NON-NLS-1$
                        sb.Append(LocalizationManager.getLocalizedTextString("inSwf", swfArgs)); //$NON-NLS-1$
                    }
                    catch (System.NullReferenceException)
                    {
                        // can't find the swf
                        sb.Append(LocalizationManager.getLocalizedTextString("nonRestorable")); //$NON-NLS-1$
                    }
                    sb.Append(m_newline);
                }
			}
			output(sb.ToString());
		}
		
		/// <summary> When running unit tests, we want byte offsets into the file to
		/// always be displayed as zero, so that the unit test expected
		/// results will match up with the actual results.  This is just a
		/// simple helper function that deals with that.
		/// </summary>
		private int adjustOffsetForUnitTests(int offset)
		{
			if (SystemProperties.getProperty("fdbunit") == null)
			//$NON-NLS-1$
				return offset;
			else
				return 0;
		}
		
		internal virtual void  doShowDirectories()
		{
			output(LocalizationManager.getLocalizedTextString("sourceDirectoriesSearched")); //$NON-NLS-1$

            foreach (String dir in m_sourceDirectories)
            {
				output("  " + dir); //$NON-NLS-1$
			}
		}
		
		internal virtual void  doHalt()
		{
			output(LocalizationManager.getLocalizedTextString("attemptingToSuspend")); //$NON-NLS-1$
			m_session.suspend();
			if (m_session.Suspended)
				output(LocalizationManager.getLocalizedTextString("playerStopped"));
			//$NON-NLS-1$
			else
				output(LocalizationManager.getLocalizedTextString("playerRunning")); //$NON-NLS-1$
		}
		
		public virtual void  appendReason(System.Text.StringBuilder sb, int reason)
		{
			switch (reason)
			{
				
				case SuspendReason.Unknown: 
					sb.Append(LocalizationManager.getLocalizedTextString("suspendReason_Unknown")); //$NON-NLS-1$
					break;
				
				
				case SuspendReason.Breakpoint: 
					sb.Append(LocalizationManager.getLocalizedTextString("suspendReason_HitBreakpoint")); //$NON-NLS-1$
					break;
				
				
				case SuspendReason.Watch: 
					sb.Append(LocalizationManager.getLocalizedTextString("suspendReason_HitWatchpoint")); //$NON-NLS-1$
					break;
				
				
				case SuspendReason.Fault: 
					sb.Append(LocalizationManager.getLocalizedTextString("suspendReason_ProgramThrewException")); //$NON-NLS-1$
					break;
				
				
				case SuspendReason.StopRequest: 
					sb.Append(LocalizationManager.getLocalizedTextString("suspendReason_StopRequest")); //$NON-NLS-1$
					break;
				
				
				case SuspendReason.Step: 
					sb.Append(LocalizationManager.getLocalizedTextString("suspendReason_ProgramFinishedStepping")); //$NON-NLS-1$
					break;
				
				
				case SuspendReason.HaltOpcode: 
					sb.Append(LocalizationManager.getLocalizedTextString("suspendReason_HaltOpcode")); //$NON-NLS-1$
					break;
				
				
				case SuspendReason.ScriptLoaded: 
					sb.Append(LocalizationManager.getLocalizedTextString("suspendReason_ScriptHasLoadedIntoFlashPlayer")); //$NON-NLS-1$
					break;
			}
		}
		
		/// <summary> The big ticket item, where all your questions are answered.
		/// 
		/// </summary>
		internal virtual void  doInfo()
		{
			/* info without any args brings up help */
			if (!hasMoreTokens())
				output(getHelpTopic("info"));
			//$NON-NLS-1$
			else
			{
				/* otherwise we have a boatload of options */
				String subCmdString = nextToken();
				int subCmd = infoCommandFor(subCmdString);
				switch (subCmd)
				{
					case INFO_ARGS_CMD: 
						doInfoArgs();
						break;
					
					case INFO_BREAK_CMD: 
						doInfoBreak();
						break;
					
					case INFO_FILES_CMD: 
						doInfoFiles();
						break;
					
					case INFO_FUNCTIONS_CMD: 
						doInfoFuncs();
						break;
					
					case INFO_HANDLE_CMD: 
						doInfoHandle();
						break;
					
					case INFO_LOCALS_CMD: 
						doInfoLocals();
						break;
					
					case INFO_SCOPECHAIN_CMD: 
						doInfoScopeChain();
						break;
					
					case INFO_SOURCES_CMD: 
						doInfoSources();
						break;
					
					case INFO_STACK_CMD: 
						doInfoStack();
						break;
					
					case INFO_VARIABLES_CMD: 
						doInfoVariables();
						break;
					
					case INFO_DISPLAY_CMD: 
						doInfoDisplay();
						break;
					
					case INFO_TARGETS_CMD: 
						doInfoTargets();
						break;
					
					case INFO_SWFS_CMD: 
						doInfoSwfs();
						break;
					
					default: 
						doUnknown("info", subCmdString); //$NON-NLS-1$
						break;
				}
			}
		}
		
		internal virtual void  doInfoStack()
		{
			waitTilHalted();
			
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			Frame[] stack = m_session.Frames;
			if (stack == null || stack.Length == 0)
				sb.Append(LocalizationManager.getLocalizedTextString("noStackAvailable"));
			//$NON-NLS-1$
			else
			{
				bool showThis = propertyGet(INFO_STACK_SHOW_THIS) == 1;
				for (int i = 0; i < stack.Length; i++)
				{
					// keep spitting out frames until we can't
					Frame frame = stack[i];
					bool valid = appendFrameInfo(sb, frame, i, showThis, false);
					sb.Append(m_newline);
					if (!valid)
						break;
				}
			}
			
			/* dump it out */
			output(sb.ToString());
		}
		
		/// <summary> Spit out frame information for a given frame number </summary>
		internal virtual bool appendFrameInfo(System.Text.StringBuilder sb, Frame ctx, int frameNumber, bool showThis, bool showFileId)
		{
			bool validFrame = true;
			
			// some formatting properties
			int i = frameNumber;
			
			Location loc = ctx.Location;
			SourceFile file = loc.File;
			int line = loc.Line;
			String name = (file == null)?"<null>":file.Name; //$NON-NLS-1$
			String sig = ctx.CallSignature;
			String func = extractFunctionName(sig);
			
			// file == null or line < 0 appears to be a terminator for stack info
			if (file == null && line < 0)
			{
				validFrame = false;
			}
			else
			{
				Variable[] var = ctx.getArguments(m_session);
				Variable dis = ctx.getThis(m_session);
				bool displayArgs = (func != null) || (var != null);
				
				sb.Append('#');
				FieldFormat.formatLong(sb, i, 3);
				sb.Append(' ');
				
				if (showThis && dis != null)
				{
					ExpressionCache.appendVariable(sb, dis);
					sb.Append("."); //$NON-NLS-1$
				}
				
				if (func != null)
					sb.Append(func);
				
				if (displayArgs)
				{
					sb.Append('(');
					for (int j = 0; j < var.Length; j++)
					{
						Variable v = var[j];
						sb.Append(v.getName());
						sb.Append('=');
						ExpressionCache.appendVariableValue(sb, v.getValue());
						if ((j + 1) < var.Length)
							sb.Append(", "); //$NON-NLS-1$
					}
					sb.Append(")"); //$NON-NLS-1$
					sb.Append(LocalizationManager.getLocalizedTextString("atFilename")); //$NON-NLS-1$
				}
				
				sb.Append(name);
				
				// if this file is currently being filtered put the source file id after it
				if (file != null && (showFileId || !m_fileInfo.inFileList(file)))
				{
					sb.Append('#');
					sb.Append(file.Id);
				}
				sb.Append(':');
				sb.Append(line);
			}
			return validFrame;
		}
		
		/// <summary>extract the function name from a signature </summary>
		public static String extractFunctionName(String sig)
		{
			// strip everything after the leading ( 
			int at = sig.IndexOf('(');
			if (at > - 1)
				sig = sig.Substring(0, (at) - (0));
			
			// trim the leading [object_name::] since it doesn't seem to add much
			if (sig != null && (at = sig.IndexOf("::")) > - 1)
			//$NON-NLS-1$
				sig = sig.Substring(at + 2);
			
			return sig;
		}
		
		internal virtual void  doInfoVariables()
		{
			waitTilHalted();
			
			// dump a set of locals
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			
			// use our expression cache formatting routine
			try
			{
				Variable[] vars = m_session.VariableList;
				for (int i = 0; i < vars.Length; i++)
				{
					Variable v = vars[i];
					
					// all non-local and non-arg variables
					if (!v.isAttributeSet(VariableAttribute.IS_LOCAL) && !v.isAttributeSet(VariableAttribute.IS_ARGUMENT))
					{
						ExpressionCache.appendVariable(sb, vars[i]);
						sb.Append(m_newline);
					}
				}
			}
			catch (System.NullReferenceException)
			{
				sb.Append(LocalizationManager.getLocalizedTextString("noVariables")); //$NON-NLS-1$
			}
			
			output(sb.ToString());
		}
		
		internal virtual void  doInfoDisplay()
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			sb.Append("Num Enb Expression" + m_newline); //$NON-NLS-1$
			
			// our list of displays
			int count = displayCount();
			for (int i = 0; i < count; i++)
			{
				DisplayAction b = displayAt(i);
				int num = b.Id;
				String exp = b.Content;
				
				sb.Append(':');
				FieldFormat.formatLong(sb, num, 3);
				
				if (b.Enabled)
					sb.Append(" y  ");
				//$NON-NLS-1$
				else
					sb.Append(" n  "); //$NON-NLS-1$
				
				sb.Append(exp);
				sb.Append(m_newline);
			}
			
			output(sb.ToString());
		}
		
		internal virtual void  doInfoArgs()
		{
			waitTilHalted();
			
			// dump a set of locals
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			
			// use our expression cache formatting routine
			try
			{
				int num = propertyGet(DISPLAY_FRAME_NUMBER);
				Frame[] frames = m_session.Frames;
				Variable[] vars = frames[num].getArguments(m_session);
				for (int i = 0; i < vars.Length; i++)
				{
					ExpressionCache.appendVariable(sb, vars[i]);
					sb.Append(m_newline);
				}
			}
			catch (System.NullReferenceException)
			{
				sb.Append(LocalizationManager.getLocalizedTextString("noArguments")); //$NON-NLS-1$
			}
			catch (System.IndexOutOfRangeException)
			{
				sb.Append(LocalizationManager.getLocalizedTextString("notInValidFrame")); //$NON-NLS-1$
			}
			
			output(sb.ToString());
		}
		
		internal virtual void  doInfoLocals()
		{
			waitTilHalted();
			
			// dump a set of locals
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			
			// use our expression cache formatting routine
			try
			{
				// get the variables from the requested frame
				int num = propertyGet(DISPLAY_FRAME_NUMBER);
				Frame[] ar = m_session.Frames;
				Frame ctx = ar[num];
				Variable[] vars = ctx.getLocals(m_session);
				
				for (int i = 0; i < vars.Length; i++)
				{
					Variable v = vars[i];
					
					// see if variable is local
					if (v.isAttributeSet(VariableAttribute.IS_LOCAL))
					{
						ExpressionCache.appendVariable(sb, v);
						sb.Append(m_newline);
					}
				}
			}
			catch (System.NullReferenceException)
			{
				sb.Append(LocalizationManager.getLocalizedTextString("noLocals")); //$NON-NLS-1$
			}
			catch (System.IndexOutOfRangeException)
			{
				sb.Append(LocalizationManager.getLocalizedTextString("notInValidFrame")); //$NON-NLS-1$
			}
			
			output(sb.ToString());
		}
		
		internal virtual void  doInfoScopeChain()
		{
			waitTilHalted();
			
			// dump the scope chain
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			
			// use our expression cache formatting routine
			try
			{
				// get the scope chainfrom the requested frame
				int num = propertyGet(DISPLAY_FRAME_NUMBER);
				Frame[] ar = m_session.Frames;
				Frame ctx = ar[num];
				Variable[] scopes = ctx.getScopeChain(m_session);
				
				for (int i = 0; i < scopes.Length; i++)
				{
					Variable scope = scopes[i];
					ExpressionCache.appendVariable(sb, scope);
					sb.Append(m_newline);
				}
			}
			catch (System.NullReferenceException)
			{
				sb.Append(LocalizationManager.getLocalizedTextString("noScopeChain")); //$NON-NLS-1$
			}
			catch (System.IndexOutOfRangeException)
			{
				sb.Append(LocalizationManager.getLocalizedTextString("notInValidFrame")); //$NON-NLS-1$
			}
			
			output(sb.ToString());
		}
		
		internal virtual void  doInfoTargets()
		{
			if (!haveConnection())
			{
				output(LocalizationManager.getLocalizedTextString("noActiveSession")); //$NON-NLS-1$
				if (m_launchURI != null)
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["uri"] = m_launchURI; //$NON-NLS-1$
					output(LocalizationManager.getLocalizedTextString("runWillLaunchUri", args)); //$NON-NLS-1$
				}
			}
			else
			{
				String uri = m_session.URI;
				if (uri == null || uri.Length < 1)
					err(LocalizationManager.getLocalizedTextString("targetUnknown"));
				//$NON-NLS-1$
				else
					output(uri);
			}
		}
		
		/// <summary> Dump some stats about our currently loaded swfs.</summary>
		internal virtual void  doInfoSwfs()
		{
			try
			{
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				SwfInfo[] swfs = m_fileInfo.Swfs;
				for (int i = 0; i < swfs.Length; i++)
				{
					SwfInfo e = swfs[i];
					if (e == null || e.isUnloaded())
						continue;
					
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["swfName"] = FileInfoCache.nameOfSwf(e); //$NON-NLS-1$
					args["size"] = e.SwfSize.ToString("N0"); //$NON-NLS-1$
					
					try
					{
						int size = e.getSwdSize(m_session);
						
						// our swd is loaded so let's comb through our
						// list of scripts and locate the range of ids.
						SourceFile[] files = e.getSourceList(m_session);
						int max = System.Int32.MinValue;
						int min = System.Int32.MaxValue;
						for (int j = 0; j < files.Length; j++)
						{
							SourceFile f = files[j];
							int id = f.Id;
							max = (id > max)?id:max;
							min = (id < min)?id:min;
						}
						
						args["scriptCount"] = System.Convert.ToString(e.getSourceCount(m_session)); //$NON-NLS-1$
						args["min"] = System.Convert.ToString(min); //$NON-NLS-1$
						args["max"] = System.Convert.ToString(max); //$NON-NLS-1$
						args["plus"] = (e.ProcessingComplete)?"+":""; //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
						args["moreInfo"] = (size == 0)?LocalizationManager.getLocalizedTextString("remainingSourceBeingLoaded"):""; //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
					}
					catch (InProgressException)
					{
						sb.Append(LocalizationManager.getLocalizedTextString("debugInfoBeingLoaded")); //$NON-NLS-1$
					}
					args["url"] = e.Url; //$NON-NLS-1$
					sb.Append(LocalizationManager.getLocalizedTextString("swfInfo", args)); //$NON-NLS-1$
					sb.Append(m_newline);
				}
				output(sb.ToString());
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("noSWFs")); //$NON-NLS-1$
			}
		}
		
		private const int AUTHORED_FILE = 1; // a file that was created by the end user, e.g. MyApp.mxml
		private const int FRAMEWORK_FILE = 2; // a file from the Flex framework, e.g. mx.controls.Button.as
		private const int SYNTHETIC_FILE = 3; // e.g. "<set up XML utilities.1>"
		private const int ACTIONS_FILE = 4; // e.g. "Actions for UIComponent: Frame 1 of Layer Name Layer 1"
		
		/// <summary> Given a file, guesses what type it is -- e.g. a file created by the end user,
		/// or a file from the Flex framework, etc.
		/// </summary>
		private int getFileType(SourceFile sourceFile)
		{
			String name = sourceFile.Name;
			String path = sourceFile.FullPath;
			
			if (name.StartsWith("<") && name.EndsWith(">") || name.Equals("GeneratedLocale"))
			//$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
				return SYNTHETIC_FILE;
			else if ((path.IndexOf("\\mx\\") > - 1) || (path.IndexOf("/mx/") > - 1) || name.Equals("frameworks.as"))
			//$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
				return FRAMEWORK_FILE;
			else if (name.StartsWith("Actions for"))
			//$NON-NLS-1$
				return ACTIONS_FILE;
			else
				return AUTHORED_FILE;
		}
		
		internal virtual void  buildFileList(System.Text.StringBuilder sb, bool authoredFilesOnly)
		{
			SourceFile[] ar = m_fileInfo.FileList;
			if (ar == null)
			{
				err(LocalizationManager.getLocalizedTextString("noSourceFilesFound")); //$NON-NLS-1$
				return ;
			}
			
			System.Collections.ArrayList authoredFiles = System.Collections.ArrayList.Synchronized(new System.Collections.ArrayList(10));
			System.Collections.ArrayList frameworkFiles = System.Collections.ArrayList.Synchronized(new System.Collections.ArrayList(10));
			System.Collections.ArrayList syntheticFiles = System.Collections.ArrayList.Synchronized(new System.Collections.ArrayList(10));
			System.Collections.ArrayList actionsFiles = System.Collections.ArrayList.Synchronized(new System.Collections.ArrayList(10));
			
			for (int i = 0; i < ar.Length; i++)
			{
				SourceFile m = ar[i];
				int fileType = getFileType(m);
				int id = m.Id;
				String entry = m.Name + "#" + id; //$NON-NLS-1$
				
				switch (fileType)
				{
					
					case SYNTHETIC_FILE: 
						syntheticFiles.Add(entry);
						break;
					
					case FRAMEWORK_FILE: 
						frameworkFiles.Add(entry);
						break;
					
					case ACTIONS_FILE: 
						actionsFiles.Add(entry);
						break;
					
					case AUTHORED_FILE: 
						authoredFiles.Add(entry);
						break;
					}
			}
			
			int wrapAt = propertyGet(FILE_LIST_WRAP);
			
			if (!authoredFilesOnly)
			{
				if (actionsFiles.Count > 0)
				{
					appendStrings(sb, actionsFiles, (actionsFiles.Count > wrapAt));
				}
				
				if (frameworkFiles.Count > 0)
				{
					sb.Append("---" + m_newline); //$NON-NLS-1$
					appendStrings(sb, frameworkFiles, (frameworkFiles.Count > wrapAt));
				}
				
				if (syntheticFiles.Count > 0)
				{
					sb.Append("---" + m_newline); //$NON-NLS-1$
					appendStrings(sb, syntheticFiles, (syntheticFiles.Count > wrapAt));
				}
				
				sb.Append("---" + m_newline); //$NON-NLS-1$
			}
			
			appendStrings(sb, authoredFiles, (authoredFiles.Count > wrapAt));
		}
		
		/// <summary> Dump a list of strings contained a vector
		/// If flow is set then the strings are placed
		/// on a single line and wrapped at $columnwidth
		/// </summary>
		internal virtual void  appendStrings(System.Text.StringBuilder sb, System.Collections.ArrayList v, bool flow)
		{
			int count = v.Count;
			int width = 0;
			int maxCol = propertyGet(COLUMN_WIDTH);
			
			for (int i = 0; i < count; i++)
			{
				String s = (String) v[i];
				sb.Append(s);
				
				// too many of them, then wrap according to columnwidth
				if (flow)
				{
					width += (s.Length + 2);
					if (width >= maxCol)
					{
						sb.Append(m_newline);
						width = 0;
					}
					else
						sb.Append(", "); //$NON-NLS-1$
				}
				else
					sb.Append(m_newline);
			}
			
			// add a line feed for flow based
			if (flow && width > 0)
				sb.Append(m_newline);
		}
		
		internal virtual void  doInfoFiles()
		{
			try
			{
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				if (hasMoreTokens())
				{
					String arg = nextToken();
					listFilesMatching(sb, arg);
				}
				else
				{
					buildFileList(sb, false);
				}
				output(sb.ToString());
			}
			catch (System.NullReferenceException)
			{
				throw new System.InvalidOperationException();
			}
		}
		
		public virtual void  waitForMetaData()
		{
			// perform a query to see if our metadata has loaded
			int metadatatries = propertyGet(METADATA_ATTEMPTS);
			int maxPerCall = 8; // cap on how many attempt we make per call
			
			int tries = System.Math.Min(maxPerCall, metadatatries);
			if (tries > 0)
			{
				int remain = metadatatries - tries; // assume all get used up
				
				// perform the call and then update our remaining number of attempts
				try
				{
					tries = waitForMetaData(tries);
					remain = metadatatries - tries; // update our used count
				}
				catch (InProgressException ipe)
				{
					propertyPut(METADATA_ATTEMPTS, remain);
					throw ipe;
				}
			}
		}
		
		/// <summary> Wait for the API to load function names, which
		/// exist in the form of external meta-data.
		/// 
		/// Only do this tries times, then give up
		/// 
		/// We wait period * attempts
		/// </summary>
		public virtual int waitForMetaData(int attempts)
		{
			int start = attempts;
			int period = propertyGet(METADATA_ATTEMPTS_PERIOD);
			while (attempts > 0)
			{
				// are we done yet?
				if (MetaDataAvailable)
					break;
				else
					try
					{
						attempts--;
						System.Threading.Thread.Sleep(period);
					}
					catch (System.Threading.ThreadInterruptedException)
					{
					}
			}
			
			// throw exception if still not ready
			if (!MetaDataAvailable)
				throw new InProgressException();
			
			return start - attempts; // remaining number of tries
		}
		
		internal virtual void  doInfoHandle()
		{
			if (hasMoreTokens())
			{
				// user specified a fault
				String faultName = nextToken();
				
				// make sure we know about this one
				if (!m_faultTable.exists(faultName))
					err(LocalizationManager.getLocalizedTextString("unrecognizedFault"));
				//$NON-NLS-1$
				else
					listFault(faultName);
			}
			else
			{
				// dump them all
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				
				appendFaultTitles(sb);
				
				System.Object[] names = m_faultTable.names();
				ArrayUtil.sort(names);
				
				for (int i = 0; i < names.Length; i++)
					appendFault(sb, (String) names[i]);
				
				output(sb.ToString());
			}
		}
		
		internal virtual void  doInfoFuncs()
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			
			String arg = null;
			
			// we take an optional single arg which specifies a module
			try
			{
				// let's wait a bit for the background load to complete
				waitForMetaData();
				
				if (hasMoreTokens())
				{
					arg = nextToken();
					int id = arg.Equals(".")?propertyGet(LIST_MODULE):parseFileArg(- 1, arg); //$NON-NLS-1$
					
					SourceFile m = m_fileInfo.getFile(id);
					listFunctionsFor(sb, m);
				}
				else
				{
					SourceFile[] ar = m_fileInfo.FileList;
					if (ar == null)
						err(LocalizationManager.getLocalizedTextString("noSourceFilesFound"));
					//$NON-NLS-1$
					else
					{
						for (int i = 0; ar != null && i < ar.Length; i++)
						{
							SourceFile m = ar[i];
							listFunctionsFor(sb, m);
						}
					}
				}
				
				output(sb.ToString());
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("noFunctionsFound")); //$NON-NLS-1$
			}
			catch (System.FormatException pe)
			{
				err(pe.Message);
			}
			catch (NoMatchException nme)
			{
				err(nme.Message);
			}
			catch (AmbiguousException ae)
			{
				err(ae.Message);
			}
			catch (InProgressException)
			{
				err(LocalizationManager.getLocalizedTextString("functionListBeingPrepared")); //$NON-NLS-1$
			}
		}
		
		internal virtual void  listFunctionsFor(System.Text.StringBuilder sb, SourceFile m)
		{
			String[] names = m.getFunctionNames(m_session);
			if (names == null)
				return ;
			
			ArrayUtil.sort(names);
			
			System.Collections.IDictionary args = new System.Collections.Hashtable();
			args["sourceFile"] = m.Name + "#" + m.Id; //$NON-NLS-1$ //$NON-NLS-2$
			sb.Append(LocalizationManager.getLocalizedTextString("functionsInSourceFile", args)); //$NON-NLS-1$
			sb.Append(m_newline);
			
			for (int j = 0; j < names.Length; j++)
			{
				String fname = names[j];
				sb.Append(' ');
				sb.Append(fname);
				sb.Append(' ');
				sb.Append(m.getLineForFunctionName(m_session, fname));
				sb.Append(m_newline);
			}
		}
		
		internal virtual void  listFilesMatching(System.Text.StringBuilder sb, String match)
		{
			SourceFile[] sourceFiles = m_fileInfo.getFiles(match);
			
			for (int j = 0; j < sourceFiles.Length; j++)
			{
				SourceFile sourceFile = sourceFiles[j];
				sb.Append(sourceFile.Name);
				sb.Append('#');
				sb.Append(sourceFile.Id);
				sb.Append(m_newline);
			}
		}
		
		internal virtual void  doInfoSources()
		{
			try
			{
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				buildFileList(sb, true);
				output(sb.ToString());
			}
			catch (System.NullReferenceException)
			{
                throw new System.InvalidOperationException();
			}
		}
		
		internal virtual void  doInfoBreak()
		{
			//		waitTilHalted();
			
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			sb.Append("Num Type           Disp Enb Address    What" + m_newline);
			
			// our list of breakpoints
			int count = breakpointCount();
			for (int i = 0; i < count; i++)
			{
				BreakAction b = breakpointAt(i);
				int status = b.Status;
				bool isResolved = (status == BreakAction.RESOLVED);
				Location l = b.Location;
				SourceFile file = (l != null)?l.File:null;
				String funcName = (file == null)?null:file.getFunctionNameForLine(m_session, l.Line);
				bool singleSwf = b.SingleSwf;
				int cmdCount = b.CommandCount;
				int hits = b.Hits;
				String cond = b.ConditionString;
				bool silent = b.Silent;
				int offset = adjustOffsetForUnitTests((file == null)?0:file.getOffsetForLine(l.Line));
				
				int num = b.Id;
				FieldFormat.formatLong(sb, num, 3);
				sb.Append(" breakpoint     ");
				
				if (b.AutoDisable)
					sb.Append("dis  ");
				else if (b.AutoDelete)
					sb.Append("del  ");
				else
					sb.Append("keep ");
				
				if (b.Enabled)
					sb.Append("y   ");
				else
					sb.Append("n   ");
				
				sb.Append("0x"); //$NON-NLS-1$
				FieldFormat.formatLongToHex(sb, offset, 8);
				sb.Append(' ');
				
				if (funcName != null)
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["functionName"] = funcName; //$NON-NLS-1$
					sb.Append(LocalizationManager.getLocalizedTextString("inFunctionAt", args)); //$NON-NLS-1$
				}
				
				if (file != null)
				{
					sb.Append(file.Name);
					if (isResolved && singleSwf)
					{
						sb.Append("#"); //$NON-NLS-1$
						sb.Append(file.Id);
					}
					sb.Append(':');
					sb.Append(l.Line);
				}
				else
				{
					String expr = b.BreakpointExpression;
					if (expr != null)
						sb.Append(expr);
				}
				
				switch (status)
				{
					case BreakAction.UNRESOLVED: 
						sb.Append(LocalizationManager.getLocalizedTextString("breakpointNotYetResolved")); //$NON-NLS-1$
						break;
					
					case BreakAction.AMBIGUOUS: 
						sb.Append(LocalizationManager.getLocalizedTextString("breakpointAmbiguous")); //$NON-NLS-1$
						break;
					
					case BreakAction.NOCODE: 
						sb.Append(LocalizationManager.getLocalizedTextString("breakpointNoCode")); //$NON-NLS-1$
						break;
					}
				
				// if a single swf break action then append more info
				if (singleSwf && isResolved)
				{
					try
					{
						SwfInfo info = m_fileInfo.swfForFile(file);
						System.Collections.IDictionary swfArgs = new System.Collections.Hashtable();
						swfArgs["swf"] = FileInfoCache.nameOfSwf(info); //$NON-NLS-1$
						sb.Append(LocalizationManager.getLocalizedTextString("inSwf", swfArgs)); //$NON-NLS-1$
					}
					catch (System.NullReferenceException)
					{
						// can't find the swf
						sb.Append(LocalizationManager.getLocalizedTextString("nonRestorable")); //$NON-NLS-1$
					}
				}
				sb.Append(m_newline);
				
				const String INDENT = "        "; //$NON-NLS-1$
				
				// state our condition if we have one
				if (cond != null && cond.Length > 0)
				{
					sb.Append(INDENT);
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["breakpointCondition"] = cond; //$NON-NLS-1$
					sb.Append(LocalizationManager.getLocalizedTextString(LocalizationManager.getLocalizedTextString("stopOnlyIfConditionMet", args))); //$NON-NLS-1$
					sb.Append(m_newline);
				}
				
				// now if its been hit, lets state the fact
				if (hits > 0)
				{
					sb.Append(INDENT);
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["count"] = System.Convert.ToString(hits); //$NON-NLS-1$
					sb.Append(LocalizationManager.getLocalizedTextString("breakpointAlreadyHit", args)); //$NON-NLS-1$
					sb.Append(m_newline);
				}
				
				// silent?
				if (silent)
				{
					sb.Append(INDENT);
					sb.Append(LocalizationManager.getLocalizedTextString("silentBreakpoint") + m_newline); //$NON-NLS-1$
				}
				
				// now if any commands are trailing then we pump them out
				for (int j = 0; j < cmdCount; j++)
				{
					sb.Append(INDENT);
					sb.Append(b.commandAt(j));
					sb.Append(m_newline);
				}
			}
			
			int wcount = watchpointCount();
			for (int k = 0; k < wcount; k++)
			{
				WatchAction b = watchpointAt(k);
				int id = b.Id;
				FieldFormat.formatLong(sb, id, 4);
				
				int flags = b.Kind;
				switch (flags)
				{
					
					case WatchKind.READ: 
						sb.Append("rd watchpoint  ");
						break;
					
					case WatchKind.WRITE: 
						sb.Append("wr watchpoint  ");
						break;
					
					case WatchKind.READWRITE: 
					default: 
						sb.Append("watchpoint     ");
						break;
					}
				
				sb.Append("keep ");
				sb.Append("y   ");
				sb.Append("           "); //$NON-NLS-1$
				sb.Append(b.Expr);
				sb.Append(m_newline);
			}
			output(sb.ToString());
		}
		
		/// <summary> Dump out the state of the execution, either the fact we are running
		/// or the breakpoint we hit.
		/// </summary>
		internal virtual void  dumpHaltState(bool postStep)
		{
			// spit out any event output, if we are to resume after a fault and we're not stepping then we're done.
			processEvents();
			//		System.out.println("processEvents = "+m_requestResume);
			
			if (m_requestResume && !postStep)
				return ;
			
			if (!m_session.Connected)
			{
				// session is kaput
				output(LocalizationManager.getLocalizedTextString("sessionTerminated")); //$NON-NLS-1$
				exitSession();
			}
			else
			{
				if (m_session.Suspended)
				{
					// capture our break location / information
					System.Text.StringBuilder sbLine = new System.Text.StringBuilder();
					dumpBreakLine(postStep, sbLine);
					
					// Process our breakpoints.
					// Since we can have conditional breakpoints, which the
					// player always breaks for, but we may not want to, the variable
					// m_requestResume may be set after this call.  Additionally,
					// silent may be set for one of two reasons; 1) m_requestResume
					// was set to true in the call or one or more breakpoints that
					// hit contained the keyword silent in their command list.
					//
					System.Text.StringBuilder sbBreak = new System.Text.StringBuilder();
					bool silent = processBreak(postStep, sbBreak);
					
					System.Text.StringBuilder sb = new System.Text.StringBuilder();
					if (silent)
					{
						// silent means we only spit out our current location
						dumpBreakLine(postStep, sb);
					}
					else
					{
						// not silent means we append things like normal
						sb.Append(sbLine);
						if (sbLine.Length > 0 && sbLine[sbLine.Length - 1] != '\n')
							sb.Append(m_newline);
						sb.Append(sbBreak);
					}
					
					// output whatever was generated 
					if (sb.Length > 0)
						output(sb.ToString());
					
					//				System.out.println("processbreak = "+m_requestResume+",silent="+silent+",reason="+m_session.suspendReason());
				}
				else
				{
					// very bad, set stepping so that we don't trigger a continue on a breakpoint or fault
					output(LocalizationManager.getLocalizedTextString("playerDidNotStop")); //$NON-NLS-1$
				}
			}
		}
		
		internal virtual Location getCurrentLocation()
		{
			Location where = null;
			try
			{
				Frame[] ar = m_session.Frames;
				propertyPut(CURRENT_FRAME_DEPTH, (ar.Length > 0)?ar.Length:0);
				where = ((ar.Length > 0)?ar[0].Location:null);
			}
			catch (PlayerDebugException)
			{
				// where == null
			}
			return where;
		}
		
		internal virtual void  dumpBreakLine(bool postStep, System.Text.StringBuilder sb)
		{
			int bp = - 1;
			String name = LocalizationManager.getLocalizedTextString("unknownFilename"); //$NON-NLS-1$
			int line = - 1;
			
			// clear our current frame display
			propertyPut(DISPLAY_FRAME_NUMBER, 0);
			
			/* dump a context line to the console */
			Location l = getCurrentLocation();
			
			// figure out why we stopped
			int reason = SuspendReason.Unknown;
			try
			{
				reason = m_session.suspendReason();
			}
			catch (PlayerDebugException)
			{
			}
			
			// then see if it because of a swfloaded event
			if (reason == SuspendReason.ScriptLoaded)
			{
				// since the player takes a long time to provide swf/swd, try 80 * 250ms = ~20s
				if (propertyGet(METADATA_ATTEMPTS) > 0)
					try
					{
						waitForMetaData(80);
					}
					catch (InProgressException)
					{
					}
				
				m_fileInfo.setDirty();
				processEvents();
				propagateBreakpoints();
				
				sb.Append(LocalizationManager.getLocalizedTextString("additionalCodeLoaded")); //$NON-NLS-1$
				sb.Append(m_newline);
				
				if (resolveBreakpoints(sb))
					sb.Append(LocalizationManager.getLocalizedTextString("setAdditionalBreakpoints") + m_newline);
				//$NON-NLS-1$
				else
					sb.Append(LocalizationManager.getLocalizedTextString("fixBreakpoints") + m_newline); //$NON-NLS-1$
			}
			else if (l == null || l.File == null)
			{
				// no idea where we are ?!?
				propertyPut(LAST_FRAME_DEPTH, 0);
				sb.Append(LocalizationManager.getLocalizedTextString("executionHalted")); //$NON-NLS-1$
				sb.Append(' ');
				
				/* disable this line (and enable the one after) if implementation Extensions are not provided */
				appendBreakInfo(sb);
				//sb.append("unknown location");
			}
			else
			{
				SourceFile file = l.File;
				name = file.Name;
				line = l.Line;
				String funcName = file.getFunctionNameForLine(m_session, line);
				
				// where were we last time
				int lastModule = propertyGet(LIST_MODULE);
				int lastDepth = propertyGet(LAST_FRAME_DEPTH);
				
				int thisModule = file.Id;
				int thisDepth = propertyGet(CURRENT_FRAME_DEPTH); // triggered via getCurrentLocation()
				
				// mark where we stopped
				propertyPut(LAST_FRAME_DEPTH, thisDepth);
				
				// if we have changed our context or we are not spitting out source then dump our location
				if (!postStep || lastModule != thisModule || lastDepth != thisDepth)
				{
					// is it a fault?
					String reasonForHalting;
					if (reason == SuspendReason.Fault || reason == SuspendReason.StopRequest)
					{
						System.Text.StringBuilder s = new System.Text.StringBuilder();
						appendReason(s, reason);
						reasonForHalting = s.ToString();
					}
					// if its a breakpoint add that information
					else if ((bp = enabledBreakpointIndexOf(l)) > - 1)
					{
						System.Collections.IDictionary args = new System.Collections.Hashtable();
						args["breakpointNumber"] = System.Convert.ToString(breakpointAt(bp).Id); //$NON-NLS-1$
						reasonForHalting = LocalizationManager.getLocalizedTextString("hitBreakpoint", args); //$NON-NLS-1$
					}
					else
					{
						reasonForHalting = LocalizationManager.getLocalizedTextString("executionHalted"); //$NON-NLS-1$
					}
					
					System.Collections.IDictionary args2 = new System.Collections.Hashtable();
					args2["reasonForHalting"] = reasonForHalting; //$NON-NLS-1$
					args2["fileAndLine"] = name + ':' + line; //$NON-NLS-1$
					String formatString;
					if (funcName != null)
					{
						args2["functionName"] = funcName; //$NON-NLS-1$
						formatString = "haltedInFunction"; //$NON-NLS-1$
					}
					else
					{
						formatString = "haltedInFile"; //$NON-NLS-1$
					}
					sb.Append(LocalizationManager.getLocalizedTextString(formatString, args2));
					
					if (!m_fullnameOption)
						sb.Append(m_newline);
				}
				
				// set current listing poistion and emit emacs trigger
				setListingPosition(thisModule, line);
				
				// dump our source line if not in emacs mode
				if (!m_fullnameOption)
					appendSource(sb, file.Id, line, file.getLine(line), false);
			}
		}
		
		internal virtual void  appendFullnamePosition(System.Text.StringBuilder sb, SourceFile file, int lineNbr)
		{
			// fullname option means we dump 'path:line:col?:offset', which is used for emacs !
			String name = file.FullPath;
			if (name.StartsWith("file:/"))
			//$NON-NLS-1$
				name = name.Substring(6);
			
			// Ctrl-Z Ctrl-Z
			sb.Append('\u001a');
			sb.Append('\u001a');
			
			sb.Append(name);
			sb.Append(':');
			sb.Append(lineNbr);
			sb.Append(':');
			sb.Append('0');
			sb.Append(':');
			sb.Append("beg"); //$NON-NLS-1$
			sb.Append(':');
			sb.Append('0');
		}
		
		// pretty print a trace statement to the console
		internal virtual void  dumpTraceLine(String s)
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			sb.Append("[trace] "); //$NON-NLS-1$
			sb.Append(s);
			output(sb.ToString());
		}
		
		// pretty print a fault statement to the console
		internal virtual void  dumpFaultLine(FaultEvent e)
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			
			// use a slightly different format for ConsoleErrorFaults
			if (e is ConsoleErrorFault)
			{
				sb.Append(LocalizationManager.getLocalizedTextString("linePrefixWhenDisplayingConsoleError")); //$NON-NLS-1$
				sb.Append(' ');
				sb.Append(e.information);
			}
			else
			{
				String name = e.name();
				sb.Append(LocalizationManager.getLocalizedTextString("linePrefixWhenDisplayingFault")); //$NON-NLS-1$
				sb.Append(' ');
				sb.Append(name);
				if (e.information != null && e.information.Length > 0)
				{
					sb.Append(LocalizationManager.getLocalizedTextString("informationAboutFault")); //$NON-NLS-1$
					sb.Append(e.information);
				}
			}
			output(sb.ToString());
		}
		
		/// <summary> Called when a swf has been loaded by the player</summary>
		/// <param name="e">event documenting the load
		/// </param>
		internal virtual void  handleSwfLoadedEvent(SwfLoadedEvent e)
		{
			// first we dump out a message that displays we have loaded a swf
			dumpSwfLoadedLine(e);
		}
		
		// pretty print a SwfLoaded statement to the console
		internal virtual void  dumpSwfLoadedLine(SwfLoadedEvent e)
		{
			// now rip off any trailing ? options
			int at = e.path.LastIndexOf('?');
			String name = (at > - 1)?e.path.Substring(0, (at) - (0)):e.path;
			
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			sb.Append(LocalizationManager.getLocalizedTextString("linePrefixWhenSwfLoaded")); //$NON-NLS-1$
			sb.Append(' ');
			sb.Append(name);
			sb.Append(" - "); //$NON-NLS-1$
			
			System.Collections.IDictionary args = new System.Collections.Hashtable();
			args["size"] = e.swfSize.ToString("N0"); //$NON-NLS-1$
			sb.Append(LocalizationManager.getLocalizedTextString("sizeAfterDecompression", args)); //$NON-NLS-1$
			output(sb.ToString());
		}
		
		/// <summary> Propagate current breakpoints to the newly loaded swf.</summary>
		internal virtual void  propagateBreakpoints()
		{
			// get the newly added swf, which lands at the end list
			SwfInfo[] swfs = m_fileInfo.Swfs;
			SwfInfo swf = (swfs.Length > 1)?swfs[swfs.Length - 1]:null;
			
			// now walk through all breakpoints propagating the 
			// the break for each source and line number we
			// find in the new swf
			int size = m_breakpoints.Count;
			for (int i = 0; (swf != null) && i < size; i++)
			{
				// dont do this for single swf breakpoints
				BreakAction bp = breakpointAt(i);
				if (bp.SingleSwf)
					continue;
				if (bp.Status != BreakAction.RESOLVED)
					continue;
				
				try
				{
					Location l = bp.Location;
					int line = l.Line;
					SourceFile f = l.File;
					Location newLoc = findAndEnableBreak(swf, f, line);
					if (newLoc != null)
						bp.addLocation(newLoc);
				}
				catch (InProgressException)
				{
					if (breakpointCount() > 0)
					{
						System.Collections.IDictionary args = new System.Collections.Hashtable();
						args["breakpointNumber"] = System.Convert.ToString(bp.Id); //$NON-NLS-1$
						output(LocalizationManager.getLocalizedTextString("breakpointNotPropagated", args)); //$NON-NLS-1$
					}
				}
			}
		}
		
		/// <summary> Perform the tasks need for when a swf is unloaded
		/// the player
		/// </summary>
		internal virtual void  handleSwfUnloadedEvent(SwfUnloadedEvent e)
		{
			// print out the notification
			dumpSwfUnloadedLine(e);
		}
		
		// pretty print a SwfUnloaded statement to the console
		internal virtual void  dumpSwfUnloadedLine(SwfUnloadedEvent e)
		{
			// now rip off any trailing ? options
			int at = e.path.LastIndexOf('?');
			String name = (at > - 1)?e.path.Substring(0, (at) - (0)):e.path;
			
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			sb.Append(LocalizationManager.getLocalizedTextString("linePrefixWhenSwfUnloaded")); //$NON-NLS-1$
			sb.Append(' ');
			sb.Append(name);
			output(sb.ToString());
		}
		
		internal virtual void  doContinue()
		{
			waitTilHalted();
			
			// this will trigger a resume when we get back to the main loop
			m_requestResume = true;
			m_repeatLine = m_currentLine;
		}
		
		/// <summary> Our main loop when the player is off running</summary>
		internal virtual void  runningLoop()
		{
			int update = propertyGet(UPDATE_DELAY);
			bool nowait = (propertyGet(NO_WAITING) == 1)?true:false; // DEBUG ONLY; do not document
			bool stop = false;
			
			// not there, not connected or already halted and no pending resume requests => we are done
			if (!haveConnection() || (m_session.Suspended && !m_requestResume))
			{
				processEvents();
				stop = true;
			}
			
			while (!stop)
			{
				// allow keyboard input
				if (!nowait)
					m_keyboardReadRequest = true;
				
				if (m_requestResume)
				{
					// resume execution (request fulfilled) and look for keyboard input
					try
					{
						if (m_stepResume)
							m_session.stepContinue();
						else
							m_session.resume();
					}
					catch (NotSuspendedException)
					{
						err(LocalizationManager.getLocalizedTextString("playerAlreadyRunning")); //$NON-NLS-1$
					}
					
					m_requestResume = false;
					m_requestHalt = false;
					m_stepResume = false;
				}
				
				// sleep for a bit, then process our events.
				try
				{
					System.Threading.Thread.Sleep(update);
				}
				catch (System.Threading.ThreadInterruptedException)
				{
				}
				processEvents();
				
				// lost connection?
				if (!haveConnection())
				{
					stop = true;
					dumpHaltState(false);
				}
				else if (m_session.Suspended)
				{
					/*
					* We have stopped for some reason.  Now for all cases, but conditional
					* breakpoints, we should be done.  For conditional breakpoints it
					* may be that the condition has turned out to be false and thus
					* we need to continue
					*/
					
					/*
					* Now before we do this see, if we have a valid break reason, since
					* we could be still receiving incoming messages, even though we have halted.
					* This is definately the case with loading of multiple SWFs.  After the load
					* we get info on the swf.
					*/
					int tries = 3;
					while (tries-- > 0 && m_session.suspendReason() == SuspendReason.Unknown)
						try
						{
							System.Threading.Thread.Sleep(100);
							processEvents();
						}
						catch (System.Threading.ThreadInterruptedException)
						{
						}
					
					dumpHaltState(false);
					if (!m_requestResume)
						stop = true;
				}
				else if (nowait)
				{
					stop = true; // for DEBUG only
				}
				else
				{
					/*
					* We are still running which is fine.  But let's see if the user has
					* tried to enter something on the keyboard.  If so, then we need to
					* stop
					*/
					if (!(m_keyboardInput.Count == 0) && SystemProperties.getProperty("fdbunit") == null)
					//$NON-NLS-1$
					{
						// flush the queue and prompt the user if they want us to halt
						m_keyboardInput.Clear();
						try
						{
							if (yesNoQuery(LocalizationManager.getLocalizedTextString("doYouWantToHalt")))
							//$NON-NLS-1$
							{
								output(LocalizationManager.getLocalizedTextString("attemptingToHalt")); //$NON-NLS-1$
								m_session.suspend();
								m_requestHalt = true;
								
								// no connection => dump state and end
								if (!haveConnection())
								{
									dumpHaltState(false);
									stop = true;
								}
								else if (!m_session.Suspended)
									err(LocalizationManager.getLocalizedTextString("couldNotHalt")); //$NON-NLS-1$
							}
						}
						catch (ArgumentException)
						{
							output(LocalizationManager.getLocalizedTextString("escapingFromDebuggerPendingLoop")); //$NON-NLS-1$
							propertyPut(NO_WAITING, 1);
							stop = true;
						}
						catch (IOException io)
						{
							System.Collections.IDictionary args = new System.Collections.Hashtable();
							args["error"] = io.Message; //$NON-NLS-1$
							err(LocalizationManager.getLocalizedTextString("continuingDueToError", args)); //$NON-NLS-1$
						}
						catch (SuspendedException)
						{
							// lucky us, already stopped
						}
					}
				}
				//		System.out.println("doContinue resume="+m_requestResume+",isSuspended="+m_session.isSuspended());
			}
			
			// DEBUG ONLY: if we are not waiting then process some events
			if (nowait)
				processEvents();
		}
		
		/// <summary> Bring the listing location back to the current frame</summary>
		internal virtual void  doHome()
		{
			try
			{
				Location l = getCurrentLocation();
				SourceFile file = l.File;
				int module = file.Id;
				int line = l.Line;
				
				// now set it
				setListingPosition(module, line);
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("currentLocationUnknown")); //$NON-NLS-1$
			}
		}
		
		// Dump a source line of text to the display
		internal virtual void  dumpStep()
		{
			dumpHaltState(true);
		}
		
		/// <summary> Simple interface used with stepWithTimeout().  Implementors of this interface
		/// are expected to call one of these function: Session.stepInto(), Session.stepOver(),
		/// Session.stepOut(), or Session.stepContinue().
		/// </summary>
		private delegate void AnyKindOfStep();
		
		/// <summary> Helper function to do a stepInto, stepOver, stepOut, or stepContinue,
		/// and then to block (processing events) until either the step has completed
		/// or it has timed out.
		/// </summary>
		private void  stepWithTimeout(DebugCLI.AnyKindOfStep step)
		{
			int timeout = m_session.getPreference(SessionManager.PREF_RESPONSE_TIMEOUT);
			long timeoutTime = (System.DateTime.Now.Ticks - 621355968000000000) / 10000 + timeout;
			
			step();
			
			while ((System.DateTime.Now.Ticks - 621355968000000000) / 10000 < timeoutTime && !m_session.Suspended)
			{
				processEvents();
				if (!m_session.Suspended)
				{
					try
					{
						System.Threading.Thread.Sleep(1);
					}
					catch (System.Threading.ThreadInterruptedException)
					{
					}
				}
			}
			if ((System.DateTime.Now.Ticks - 621355968000000000) / 10000 >= timeoutTime && !m_session.Suspended)
				throw new NoResponseException(timeout);
		}
		
		private bool allowedToStep()
		{
			int suspendReason = m_session.suspendReason();
			if (suspendReason == SuspendReason.ScriptLoaded)
			{
				err(LocalizationManager.getLocalizedTextString("cannotStep")); //$NON-NLS-1$
				return false;
			}
			
			return true;
		}
		
		/// <summary> Perform step into, optional COUNT parameter</summary>
		internal virtual void  doStep()
		{
			waitTilHalted();
			
			if (!allowedToStep())
				return ;
			
			int count = 1;
			if (hasMoreTokens())
				count = nextIntToken();
			
			while (count-- > 0)
			{
				stepWithTimeout(m_session.stepInto);
				
				for ( ; ; )
				{
					dumpStep();
					
					if (m_requestResume)
					// perhaps we hit a conditional breakpoint
					{
						m_requestResume = false;
                        stepWithTimeout(m_session.stepContinue);
					}
					else
					{
						break;
					}
				}
			}
			
			m_repeatLine = m_currentLine;
		}
		
		/// <summary> Perform step over, optional COUNT parameter</summary>
		internal virtual void  doNext()
		{
			waitTilHalted();
			
			if (!allowedToStep())
				return ;
			
			int count = 1;
			if (hasMoreTokens())
				count = nextIntToken();
			
			try
			{
				while (count-- > 0)
				{
                    stepWithTimeout(m_session.stepOver);
					
					for (; ; )
					{
						dumpStep();
						
						if (m_requestResume)
						// perhaps we hit a conditional breakpoint
						{
							m_requestResume = false;
							stepWithTimeout(m_session.stepContinue);
						}
						else
						{
							break;
						}
					}
				}
			}
			catch (NoResponseException)
			{
				if (count > 0)
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["count"] = System.Convert.ToString(count); //$NON-NLS-1$
					err(LocalizationManager.getLocalizedTextString("abortingStep", args)); //$NON-NLS-1$
				}
			}
			
			m_repeatLine = m_currentLine;
		}
		
		/// <summary> Perform step out</summary>
		internal virtual void  doFinish()
		{
			waitTilHalted();
			
			if (!allowedToStep())
				return ;
			
			try
			{
				// make sure we have another frame?
				int depth = propertyGet(CURRENT_FRAME_DEPTH);
				if (depth < 2)
					err(LocalizationManager.getLocalizedTextString("finishCommandNotMeaningfulOnOutermostFrame"));
				//$NON-NLS-1$
				else
				{
                    stepWithTimeout(m_session.stepOut);
					
					for (; ; )
					{
						dumpStep();
						
						if (m_requestResume)
						// perhaps we hit a conditional breakpoint
						{
							m_requestResume = false;
                            stepWithTimeout(m_session.stepContinue);
						}
						else
						{
							break;
						}
					}
					
					m_repeatLine = m_currentLine;
				}
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("finishCommandNotMeaningfulWithoutStack")); //$NON-NLS-1$
			}
		}
		
		/// <summary> Delete a breakpoint, very similar logic to disable.</summary>
		internal virtual void  doDelete()
		{
			waitTilHalted();
			
			try
			{
				if (!hasMoreTokens())
				{
					// no args means delete all breakpoints, last chance...
					if (yesNoQuery(LocalizationManager.getLocalizedTextString("askDeleteAllBreakpoints")))
					//$NON-NLS-1$
					{
						int count = breakpointCount();
						for (int i = count - 1; i > - 1; i--)
							removeBreakpointAt(i);
						
						removeAllWatchpoints();
					}
				}
				else
				{
					// optionally specify  'display' or 'breakpoint'
					String arg = nextToken();
					int cmd = disableCommandFor(arg);
					int id = - 1;
					if (cmd == CMD_DISPLAY)
						doUnDisplay();
					else
					{
						if (cmd == CMD_BREAK)
							id = nextIntToken();
						// ignore and get next number token
						else
							id = System.Int32.Parse(arg);
						
						do 
						{
							try
							{
								int at = breakpointIndexOf(id);
								if (at > - 1)
								{
									removeBreakpointAt(at);
								}
								else
								{
									at = watchpointIndexOf(id);
									removeWatchpointAt(at);
								}
							}
							catch (System.IndexOutOfRangeException)
							{
								System.Collections.IDictionary args = new System.Collections.Hashtable();
								args["breakpointNumber"] = m_currentToken; //$NON-NLS-1$
								err(LocalizationManager.getLocalizedTextString("noBreakpointNumber", args)); //$NON-NLS-1$
							}
							
							if (hasMoreTokens())
								id = nextIntToken();
							else
								id = - 1;
							
							// keep going till we're blue in the face; also note that we cache'd a copy of locations
							// so that breakpoint numbers are consistent.
						}
						while (id > - 1);
					}
				}
			}
			catch (System.FormatException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["token"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("badBreakpointNumber", args)); //$NON-NLS-1$
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("commandFailed")); //$NON-NLS-1$
			}
		}
		
		/// <summary> Set a breakpoint</summary>
		internal virtual void  doBreak()
		{
			/* wait a bit if we are not halted */
			waitTilHalted();
			
			int module = propertyGet(LIST_MODULE);
			int line = propertyGet(LIST_LINE);
			String arg = null;
			
			/* currentXXX may NOT be invalid! */
			try
			{
				if (hasMoreTokens())
				{
					arg = nextToken();
					int[] result = parseLocationArg(module, line, arg);
					module = result[0];
					line = result[1];
				}
				else
				{
					// no parameter mean use current location;  null pointer if nothing works
					Location l = getCurrentLocation();
					SourceFile file = l.File;
					module = file.Id;
					line = l.Line;
				}
				
				//			// check to see if there are any existing breakpoints at this file/line
				//			LinkedList existingBreakpoints = new LinkedList();
				//			int start = 0;
				//			for (;;)
				//			{
				//				int bp = breakpointIndexOf(module, line, start, true);
				//				if (bp == -1)
				//					break; // no more matches
				//				boolean isEnabled = breakpointAt(bp).isEnabled();
				//				existingBreakpoints.add("" + bp + (isEnabled ? "" : " (disabled)"));
				//			}
				//			if (existingBreakpoints.size() > 0)
				//			{
				//				String
				//			}
				
				// go off; create it and set it
				BreakAction b = addBreakpoint(module, line); // throws npe if not able to set
				Location l2 = b.Location;
				
				int which = b.Id;
				String name = l2.File.Name;
				int offset = adjustOffsetForUnitTests(l2.File.getOffsetForLine(line));
				
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["breakpointNumber"] = System.Convert.ToString(which); //$NON-NLS-1$
				args["file"] = name; //$NON-NLS-1$
				args["line"] = System.Convert.ToString(line); //$NON-NLS-1$
				String formatString;
				if (offset != 0)
				{
					args["offset"] = "0x" + System.Convert.ToString(offset, 16); //$NON-NLS-1$ //$NON-NLS-2$
					formatString = "createdBreakpointWithOffset"; //$NON-NLS-1$
				}
				else
				{
					formatString = "createdBreakpoint"; //$NON-NLS-1$
				}
				output(LocalizationManager.getLocalizedTextString(formatString, args));
				
				// worked so add it to our tracking state
				propertyPut(BPNUM, which);
			}
			catch (System.FormatException pe)
			{
				err(pe.Message);
			}
			catch (AmbiguousException ae)
			{
				err(ae.Message);
			}
			catch (NoMatchException)
			{
				// We couldn't find a function name or filename which matched what
				// the user entered.  Do *not* fail; instead, just save this breakpoint
				// away, and later, as more ABCs get loaded from the SWF, we may be
				// able to resolve this breakpoint.
				BreakAction b = addUnresolvedBreakpoint(arg);
				
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["breakpointNumber"] = System.Convert.ToString(b.Id); //$NON-NLS-1$
				output(LocalizationManager.getLocalizedTextString("breakpointCreatedButNotYetResolved", args)); //$NON-NLS-1$
				
				// add it to our tracking state
				propertyPut(BPNUM, b.Id);
			}
			catch (System.NullReferenceException)
			{
				String filename;
				try
				{
					filename = m_fileInfo.getFile(module).Name + "#" + module; //$NON-NLS-1$
				}
				catch (System.Exception)
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["fileNumber"] = System.Convert.ToString(module); //$NON-NLS-1$
					filename = LocalizationManager.getLocalizedTextString("fileNumber", args); //$NON-NLS-1$
				}
				
				System.Collections.IDictionary args2 = new System.Collections.Hashtable();
				args2["filename"] = filename; //$NON-NLS-1$
				args2["line"] = System.Convert.ToString(line); //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("breakpointNotSetNoCode", args2)); //$NON-NLS-1$
			}
		}
		
		/// <summary> Clear a breakpoint</summary>
		internal virtual void  doClear()
		{
			int module = propertyGet(LIST_MODULE);
			int line = propertyGet(LIST_LINE);
			String arg = null;
			
			/* wait a bit if we are not halted */
			waitTilHalted();
			
			/* currentXXX may NOT be invalid! */
			try
			{
				if (hasMoreTokens())
				{
					arg = nextToken();
					int[] result = parseLocationArg(module, line, arg);
					module = result[0];
					line = result[1];
				}
				
				// map the breakpoint to location and then delete it
				removeBreakpoint(module, line);
			}
			catch (FormatException pe)
			{
				err(pe.Message);
			}
			catch (NoMatchException)
			{
				if (removeUnresolvedBreakpoint(arg) == null)
					err(LocalizationManager.getLocalizedTextString("breakpointLocationUnknown")); //$NON-NLS-1$
			}
			catch (AmbiguousException ae)
			{
				err(ae.Message);
			}
			catch (IndexOutOfRangeException)
			{
				// means no breakpoint at this location
				err(LocalizationManager.getLocalizedTextString("breakpointLocationUnknown")); //$NON-NLS-1$
			}
			catch (NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("breakpointNotCleared")); //$NON-NLS-1$
			}
		}
		
		/// <summary> Remove the breakpoint from our table and then determine</summary>
		internal virtual BreakAction removeBreakpoint(int fileId, int line)
		{
			int at = breakpointIndexOf(fileId, line);
			return removeBreakpointAt(at);
		}
		
		internal virtual BreakAction removeUnresolvedBreakpoint(String unresolvedLocation)
		{
			int size = breakpointCount();
			for (int i = 0; i < size; i++)
			{
				BreakAction b = breakpointAt(i);
				String s = b.BreakpointExpression;
				if (s != null && s.Equals(unresolvedLocation))
					return removeBreakpointAt(i);
			}
			return null;
		}
		
		internal virtual BreakAction removeBreakpointAt(int at)
		{
			BreakAction a = breakpointAt(at);
			m_breakpoints.RemoveAt(at);
			if (a.Status == BreakAction.RESOLVED)
				breakDisableRequest(a.Locations);
			return a;
		}
		
		/// <summary> Attempt to create new breakpoint at the given file and line. It will be set</summary>
		/// <param name="fileId">source file identifier
		/// </param>
		/// <param name="line">line number
		/// </param>
		/// <returns> object associated with breakpoint
		/// </returns>
		internal virtual BreakAction addBreakpoint(int fileId, int line)
		{
			// use fileId SourceFile to denote the name of file in which we wish to set a breakpoint
			SourceFile f = m_fileInfo.getFile(fileId);
			LocationCollection col = enableBreak(f, line);
			
			BreakAction b = new BreakAction(col); //  throws NullPointerException if collection is null
			b.Enabled = true;
			b.SingleSwf = m_fileInfo.SwfFilterOn;
			breakpointAdd(b);
			return b;
		}
		
		/// <summary> Create a new, *unresolved* breakpoint.  Unresolved means we weren't able to
		/// parse the location string, presumably because the filename to which it refers
		/// has not yet been loaded.
		/// </summary>
		/// <param name="unresolvedLocation">the breakpoint location, exactly as typed by the user
		/// </param>
		/// <returns> object associated with breakpoint
		/// </returns>
		private BreakAction addUnresolvedBreakpoint(String unresolvedLocation)
		{
			BreakAction b = new BreakAction(unresolvedLocation);
			b.Enabled = true;
			b.SingleSwf = m_fileInfo.SwfFilterOn;
			breakpointAdd(b);
			return b;
		}
		
		/// <summary> Try to resolve any breakpoints which have not yet been resolved.  We
		/// do this every time a new ABC or SWF is loaded.  NOTE: The return
		/// value does NOT indicate whether any breakpoints were resolved!  Rather,
		/// it indicates whether the operation was considered "successful."
		/// If a previously-unresolved breakpoint is now ambiguous, then that is
		/// an error, and the return value is 'false' (indicating that the
		/// debugger should halt).
		/// </summary>
		private bool resolveBreakpoints(System.Text.StringBuilder sb)
		{
			int count = breakpointCount();
			bool success = true;
			for (int i = 0; i < count; ++i)
			{
				BreakAction b = breakpointAt(i);
				try
				{
					tryResolveBreakpoint(b, sb);
				}
				catch (System.Exception e)
				// AmbiguousException or NullPointerException
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["breakpointNumber"] = System.Convert.ToString(b.Id); //$NON-NLS-1$
					args["expression"] = b.BreakpointExpression; //$NON-NLS-1$
					sb.Append(LocalizationManager.getLocalizedTextString("attemptingToResolve", args)); //$NON-NLS-1$
					sb.Append(m_newline);
					sb.Append(e.Message);
					sb.Append(m_newline);
					success = false;
				}
			}
			return success;
		}
		
		/// <summary> Try to resolve one breakpoint.  We do this every time a new ABC or
		/// SWF is loaded.
		/// </summary>
		/// <param name="b">the breakpoint to resolve (it's okay if it's already resolved)
		/// </param>
		/// <param name="sb">a StringBuffer to which any messages for are appended;
		/// to the user.
		/// </param>
		/// <returns> true if the breakpoint is resolved
		/// </returns>
		/// <throws>  AmbiguousException </throws>
		/// <throws>  NullPointerException  </throws>
		private bool tryResolveBreakpoint(BreakAction b, System.Text.StringBuilder sb)
		{
			int status = b.Status;
			bool resolved = (status == BreakAction.RESOLVED);
			if (status == BreakAction.UNRESOLVED)
			// we don't do anything for RESOLVED or AMBIGUOUS
			{
				/* wait a bit if we are not halted */
				try
				{
					waitTilHalted();
					
					// First we check for the case where this breakpoint already has a
					// filename and line number, because those were determined during a
					// previous session, but then the user did a "kill".
					//
					// If this fails, then the "else" clause deals with the case where
					// the user typed in an expression for which we have not yet found
					// a filename and line number.
					if (enableBreakpoint(b, b.AutoDisable, b.AutoDelete))
					{
						resolved = true;
					}
					else
					{
						int module = propertyGet(LIST_MODULE);
						int line = propertyGet(LIST_LINE);
						
						String arg = b.BreakpointExpression;
						
						if (arg != null)
						{
							int[] result = parseLocationArg(module, line, arg);
							
							// whoo-hoo, it resolved!
							module = result[0];
							line = result[1];
							
							// use module SourceFile to denote the name of file in which we wish to set a breakpoint
							SourceFile f = m_fileInfo.getFile(module);
							LocationCollection col = enableBreak(f, line);
							if (col.Empty)
								throw new NullReferenceException(LocalizationManager.getLocalizedTextString("noExecutableCode")); //$NON-NLS-1$
							b.Locations = col;
							
							Location l = col.first();
							SourceFile file = (l != null)?l.File:null;
							String funcName = (file == null)?null:file.getFunctionNameForLine(m_session, l.Line);
							
							System.Collections.IDictionary args = new System.Collections.Hashtable();
							String formatString;
							args["breakpointNumber"] = System.Convert.ToString(b.Id); //$NON-NLS-1$
							String filename = file.Name;
							if (b.SingleSwf && file != null)
							{
								filename = filename + "#" + file.Id; //$NON-NLS-1$
							}
							args["file"] = filename; //$NON-NLS-1$
							args["line"] = (System.Int32) l.Line; //$NON-NLS-1$
							
							if (funcName != null)
							{
								args["functionName"] = funcName; //$NON-NLS-1$
								formatString = "resolvedBreakpointToFunction"; //$NON-NLS-1$
							}
							else
							{
								formatString = "resolvedBreakpointToFile"; //$NON-NLS-1$
							}
							
							sb.Append(LocalizationManager.getLocalizedTextString(formatString, args));
							sb.Append(m_newline);
							sb.Append(m_newline);
							
							resolved = true;
						}
					}
				}
				catch (NotConnectedException)
				{
					// Ignore
				}
				catch (NoMatchException)
				{
					// Okay, it's still not resolved; do nothing
				}
				catch (System.FormatException e)
				{
					// this shouldn't happen
					if (Trace.error)
					{
						Trace.trace(e.ToString());
					}
				}
				catch (AmbiguousException e)
				{
					b.Status = BreakAction.AMBIGUOUS;
					throw e; // rethrow
				}
				catch (System.NullReferenceException e)
				{
					b.Status = BreakAction.NOCODE;
					throw e; // rethrow
				}
			}
			return resolved;
		}
		
		/// <summary> Enable a breakpoint using the SourceFile as a template
		/// for the source file in which the breakpoint should be 
		/// set.
		/// </summary>
		internal virtual LocationCollection enableBreak(SourceFile f, int line)
		{
			LocationCollection col = new LocationCollection();
			bool singleSwfBreakpoint = m_fileInfo.SwfFilterOn;
			SwfInfo swf = m_fileInfo.getSwfFilter();
			
			// If we have a swf filter enabled then we only want to
			// set a breakpoint in a specific swf not all of them
			try
			{
				if (singleSwfBreakpoint)
				{
					Location l = findAndEnableBreak(swf, f, line);
					col.add(l);
				}
				else
				{
					// walk all swfs looking to add this breakpoint
					SwfInfo[] swfs = m_fileInfo.Swfs;
					for (int i = 0; i < swfs.Length; i++)
					{
						swf = swfs[i];
						if (swf != null)
						{
							Location l = findAndEnableBreak(swf, f, line);
							if (l != null)
								col.add(l);
						}
					}
				}
			}
			catch (InProgressException)
			{
				if (Trace.error)
					Trace.trace(((swf == null)?"SWF ":swf.Url) + " still loading, breakpoint at " + f.Name + ":" + line + " not set"); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$
			}
			return col;
		}
		
		/// <summary> Enable a breakpoint for a particular swf if the sourceFile 
		/// is available in that swf.
		/// </summary>
		/// <param name="swf">if null, then set the breakpoint in the given source file
		/// otherwise try to locate a matching source file in given swf.
		/// </param>
		/// <param name="f">Source file.
		/// </param>
		/// <param name="line">Line number in file.
		/// </param>
		/// <returns> null if the swf does not contain this source file
		/// </returns>
		internal virtual Location findAndEnableBreak(SwfInfo swf, SourceFile f, int line)
		{
			int fileId = f.Id;
			if (swf != null)
			{
				SourceFile sameFile = m_fileInfo.similarFileInSwf(swf, f);
				if (sameFile != null)
					fileId = sameFile.Id;
				else
					fileId = - 1;
			}
			
			Location l = (fileId > - 1)?breakEnableRequest(fileId, line):null;
			return l;
		}
		
		/// <summary> Received when a breakpoint has been removed (or disabled)</summary>
		internal virtual Location breakEnableRequest(int fileId, int line)
		{
			Location l = null;
			try
			{
				l = m_session.setBreakpoint(fileId, line);
			}
			catch (NoResponseException)
			{
				/*
				* This could be that we have an old player which does not
				* respond to this request, or that we have a new player and
				* the location was not set.
				*/
			}
			return l;
		}
		
		/// <summary> Notification that a breakpoint has been removed (or disabled)
		/// at the CLI level and we may need to remove it at the session level
		/// </summary>
		internal virtual void  breakDisableRequest(LocationCollection col)
		{
			// now let's comb the table looking to see if this breakpoint should
			// be removed at the session level.  Use the first entry as a template
			// for which location we are talking about.
			int at = 0;
			bool hit = false;
			Location l = col.first();
			do 
			{
				at = breakpointIndexOf(l, at);
				if (at > - 1)
				{
					if (breakpointAt(at).Enabled)
						hit = true;
					else
						at++; // our location match is not enabled but let's continue after the hit
				}
			}
			while (at > - 1 && !hit);
			
			// no one matches, so let's remove it at the session level
			if (!hit)
			{
                foreach (Location loc in col)
                {
					try
					{
                        m_session.clearBreakpoint(loc);
					}
					catch (NoResponseException)
					{
					}
				}
			}
		}
		
		internal virtual BreakAction breakpointAt(int at)
		{
			return (BreakAction) m_breakpoints[at];
		}
		internal virtual bool breakpointAdd(BreakAction a)
		{
			return m_breakpoints.Add(a) >= 0;
		}
		internal virtual int breakpointCount()
		{
			return m_breakpoints.Count;
		}
		
		/// <summary> Probe the table looking for the first breakpoint that
		/// matches our criteria.  Various permutations of the call are supported.
		/// </summary>
		internal virtual int breakpointIndexOf(int fileId, int line)
		{
			return breakpointIndexOf(fileId, line, 0, true);
		}
		internal virtual int breakpointIndexOf(Location l, int start)
		{
			return breakpointIndexOf(l.File.Id, l.Line, start, true);
		}
		internal virtual int enabledBreakpointIndexOf(Location l)
		{
			return breakpointIndexOf(l.File.Id, l.Line, 0, false);
		}
		
		internal virtual int breakpointIndexOf(int fileId, int line, int start, bool includeDisabled)
		{
			int size = breakpointCount();
			int hit = - 1;
			for (int i = start; (hit < 0) && (i < size); i++)
			{
				BreakAction b = breakpointAt(i);
				if (b.locationMatches(fileId, line) && (includeDisabled || b.Enabled))
					hit = i;
			}
			return hit;
		}
		
		// probe by identifier
		internal virtual int breakpointIndexOf(int id)
		{
			int size = breakpointCount();
			int hit = - 1;
			
			for (int i = 0; (hit < 0) && (i < size); i++)
			{
				BreakAction b = breakpointAt(i);
				if (b.Id == id)
					hit = i;
			}
			return hit;
		}
		
		// access to display
		internal virtual DisplayAction displayAt(int at)
		{
			return (DisplayAction) m_displays[at];
		}
		internal virtual bool displayAdd(DisplayAction a)
		{
			return m_displays.Add(a) >= 0;
		}
		internal virtual void  displayRemoveAt(int at)
		{
			m_displays.RemoveAt(at);
		}
		internal virtual int displayCount()
		{
			return m_displays.Count;
		}
		
		// probe by id
		internal virtual int displayIndexOf(int id)
		{
			int size = displayCount();
			int hit = - 1;
			
			for (int i = 0; (hit < 0) && (i < size); i++)
			{
				DisplayAction b = displayAt(i);
				if (b.Id == id)
					hit = i;
			}
			return hit;
		}
		
		internal virtual void  doSet()
		{
			/* wait a bit if we are not halted */
			//		waitTilHalted();
			try
			{
				System.Object result = null;
				ValueExp exp = null;
				
				if (!hasMoreTokens())
					err(LocalizationManager.getLocalizedTextString("setCommand"));
				//$NON-NLS-1$
				else
				{
					// pull the expression
					String s = restOfLine();
					
					// parse and eval which causes the assignment to occur...
					if ((exp = parseExpression(s)) == null)
					{
					}
					// failed parse
					
					// make sure contains assignment
					else if (!exp.containsInstanceOf(typeof(AssignmentExp)))
						throw new System.UnauthorizedAccessException("=");
					//$NON-NLS-1$
					else if ((result = evalExpression(exp)) == null)
					{
					} // eval failed
				}
				
				// done so dump a result if we have a negative one
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				if (result == null)
				{
				}
				// error already issued
				else if (result is System.Boolean && !((System.Boolean) result))
					sb.Append(LocalizationManager.getLocalizedTextString("assignmentFailed")); //$NON-NLS-1$
				
				if (exp != null && sb.Length > 0)
					output(sb.ToString());
			}
			catch (System.UnauthorizedAccessException iae)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["operator"] = iae.Message; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("missingOperator", args)); //$NON-NLS-1$
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("couldNotEvaluate")); //$NON-NLS-1$
			}
		}
		
		internal virtual void  doPrint()
		{
			/* wait a bit if we are not halted */
			//		waitTilHalted();
			try
			{
				System.Object result = null;
				if (!hasMoreTokens())
				{
					try
					{
						// attempt to get the last result
						result = m_exprCache.get_Renamed("$"); //$NON-NLS-1$
					}
					catch (IndexOutOfRangeException)
					{
						err(LocalizationManager.getLocalizedTextString("commandHistoryIsEmpty")); //$NON-NLS-1$
						throw new NullReferenceException();
					}
				}
				else
				{
					// pull the rest of the line
					String s = restOfLine();
					
					// first parse it, then attempt to evaluate the expression
					ValueExp expr = parseExpression(s);
					
					// make sure no assignment
					if (expr.hasSideEffectsOtherThanGetters())
						throw new UnauthorizedAccessException();
					
					result = evalExpression(expr);
				}
				
				/* it worked, add it to the list */
				int which = m_exprCache.add(result);
				
				/* dump the output */
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				sb.Append('$');
				sb.Append(which);
				sb.Append(" = "); //$NON-NLS-1$
				
				if (result is Variable)
					ExpressionCache.appendVariableValue(sb, ((Variable) result).getValue());
				else if (result is Value)
					ExpressionCache.appendVariableValue(sb, (Value) result);
				else if (result is InternalProperty)
					sb.Append(((InternalProperty) result).valueOf());
				else
					sb.Append(result);
				
				output(sb.ToString());
				
				m_repeatLine = m_currentLine;
			}
			catch (IndexOutOfRangeException aio)
			{
				// $n not in range 0..size
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["number"] = aio.Message; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("historyHasNotReached", args)); //$NON-NLS-1$
			}
			catch (UnauthorizedAccessException)
			{
				err(LocalizationManager.getLocalizedTextString("noSideEffectsAllowed")); //$NON-NLS-1$
			}
			catch (NoSuchVariableException nsv)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["variable"] = nsv.Message; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("variableUnknown", args)); //$NON-NLS-1$
			}
			catch (NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("couldNotEvaluate")); //$NON-NLS-1$
			}
		}
		
		/* parse the given string and produce an error message as appropriate */
		internal virtual ValueExp parseExpression(String s)
		{
			ValueExp expr = null;
			try
			{
				expr = m_exprCache.parse(s);
			}
			catch (ArgumentOutOfRangeException)
			{
				// tried to pop but didn't
				err(LocalizationManager.getLocalizedTextString("expressionIsIncomplete") + " " + s); //$NON-NLS-1$ //$NON-NLS-2$
			}
			catch (UnknownOperationException uo)
			{
				// bad operation code
				err(LocalizationManager.getLocalizedTextString("unknownOperator") + " " + uo.Message); //$NON-NLS-1$ //$NON-NLS-2$
			}
			catch (IncompleteExpressionException)
			{
				// bad operation code
				err(LocalizationManager.getLocalizedTextString("expressionCouldNotBeResolved") + " " + s); //$NON-NLS-1$ //$NON-NLS-2$
			}
			catch (FormatException pe)
			{
				// bad operation code
				err(LocalizationManager.getLocalizedTextString("expressionCouldNotBeParsed") + " " + pe.Message); //$NON-NLS-1$ //$NON-NLS-2$
			}
			catch (IOException )
			{
				// thrown from parser
				err(LocalizationManager.getLocalizedTextString("expressionCouldNotBeParsed") + " " + s); //$NON-NLS-1$ //$NON-NLS-2$
			}
			return expr;
		}
		
		/*
		* Evaluate the given expression
		*/
		internal virtual Object evalExpression(ValueExp expr)
		{
			return evalExpression(expr, true);
		}
		
		internal virtual Object evalExpression(ValueExp expr, bool displayExceptions)
		{
			/* now we go off and evaluate the expression */
			Object result = null;
			try
			{
				result = m_exprCache.evaluate(expr);
			}
			catch (NoSuchVariableException nsv)
			{
				if (displayExceptions)
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["variable"] = nsv.Message; //$NON-NLS-1$
					err(LocalizationManager.getLocalizedTextString("variableUnknown", args)); //$NON-NLS-1$
				}
			}
			catch (FormatException nfe)
			{
				if (displayExceptions)
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["value"] = nfe.Message; //$NON-NLS-1$
					err(LocalizationManager.getLocalizedTextString("couldNotConvertToNumber", args)); //$NON-NLS-1$
				}
			}
			catch (PlayerFaultException pfe)
			{
				if (displayExceptions)
				{
					err(pfe.Message);
				}
			}
			
			// NullPointerException if parse failed and expr is null (we should really have some more info for the user!
			if (result == null)
				throw new NullReferenceException();
			
			return result;
		}
		
		/// <summary> Specialized dump of the contents of a movie clip tree, dumping
		/// all the _target properties of all MCs
		/// </summary>
		/// <throws>  NoResponseException  </throws>
		/// <throws>  NotSuspendedException  </throws>
		internal virtual void  doMcTree()
		{
			/* wait a bit if we are not halted */
			waitTilHalted();
			try
			{
				String var = nextToken(); // our variable reference
				String member = "_target"; //$NON-NLS-1$
				bool printPath = false;
				Object result = null;
				String name = null;
				
				// did the user specify a member name
				if (hasMoreTokens())
				{
					member = nextToken();
					
					// did they specify some other options
					while (hasMoreTokens())
					{
						String option = nextToken();
						if (option.ToUpper().Equals("fullpath".ToUpper()))
						//$NON-NLS-1$
							printPath = true;
					}
				}
				
				// first parse it, then attempt to evaluate the expression
				ValueExp expr = parseExpression(var);
				result = evalExpression(expr);
				
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				
				if (result is Variable)
				{
					name = ((Variable) result).getName();
					result = ((Variable) result).getValue();
				}
				
				// It worked an should now be a value that we can traverse looking for member properties
				
				if (result is Value)
				{
					System.Collections.ArrayList e = new System.Collections.ArrayList();
					dumpTree(new System.Collections.Hashtable(), e, name, (Value) result, member);
					
					// now sort according to our criteria
					treeResults(sb, e, member, printPath);
				}
				else
					throw new NoSuchVariableException(result);
				
				output(sb.ToString());
			}
			catch (NoSuchVariableException nsv)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["variable"] = nsv.Message; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("variableUnknown", args)); //$NON-NLS-1$
			}
			catch (NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("couldNotEvaluate")); //$NON-NLS-1$
			}
		}
		
		/// <summary> Set the context from which info files
		/// and all other file releated commands
		/// will operate from.
		/// 
		/// It no swf is given then we use the
		/// default mode which is to display all
		/// files from all swfs.  Files with identical
		/// names are only displayed once.
		/// </summary>
		internal virtual void  doViewSwf()
		{
			try
			{
				if (hasMoreTokens())
				{
					String swfName = nextToken();
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["swf"] = swfName; //$NON-NLS-1$
					if (m_fileInfo.setSwfFilter(swfName))
					{
						output(LocalizationManager.getLocalizedTextString("commandsLimitedToSpecifiedSwf", args)); //$NON-NLS-1$
					}
					else
					{
						err(LocalizationManager.getLocalizedTextString("notValidSwf", args)); //$NON-NLS-1$
					}
				}
				else
				{
					m_fileInfo.setSwfFilter(null);
					output(LocalizationManager.getLocalizedTextString("commandsApplyToAllSwfs")); //$NON-NLS-1$
				}
			}
			catch (NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("noActiveSession")); //$NON-NLS-1$
			}
		}
		
		/// <summary> Increment the frame context by 1 and display the new current frame.</summary>
		internal virtual void  doUp()
		{
			int num = propertyGet(DISPLAY_FRAME_NUMBER) + 1;
			try
			{
				propertyPut(DISPLAY_FRAME_NUMBER, num);
				
				dumpFrame(num);
				ListingToFrame = num;
			}
			catch (NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("noActiveSession")); //$NON-NLS-1$
			}
			catch (IndexOutOfRangeException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["frameNumber"] = System.Convert.ToString(num); //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("frameDoesNotExist", args)); //$NON-NLS-1$
			}
			m_repeatLine = m_currentLine;
		}
		
		/// <summary> Decrement the frame context by 1 and display the new current frame.</summary>
		internal virtual void  doDown()
		{
			int num = propertyGet(DISPLAY_FRAME_NUMBER) - 1;
			try
			{
				propertyPut(DISPLAY_FRAME_NUMBER, num);
				
				dumpFrame(num);
				ListingToFrame = num;
			}
			catch (NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("noActiveSession")); //$NON-NLS-1$
			}
			catch (IndexOutOfRangeException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["frameNumber"] = Convert.ToString(num); //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("frameDoesNotExist", args)); //$NON-NLS-1$
			}
			m_repeatLine = m_currentLine;
		}
		
		/// <summary> Set the frame context to the given number and display the new current frame.</summary>
		internal virtual void  doFrame()
		{
			int num = 0; // frame 0 by default 
			try
			{
				if (hasMoreTokens())
					num = nextIntToken();
				
				propertyPut(DISPLAY_FRAME_NUMBER, num);
				
				dumpFrame(num);
				ListingToFrame = num;
			}
			catch (FormatException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["token"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("notANumber", args)); //$NON-NLS-1$
			}
			catch (IndexOutOfRangeException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["frameNumber"] = System.Convert.ToString(num); //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("frameDoesNotExist", args)); //$NON-NLS-1$
			}
			catch (NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("noActiveSession")); //$NON-NLS-1$
			}
		}
		
		// Displays information on the current frame
		// @throws ArrayIndexOutOfBoundsException if frame 'frm' doesn't exist
		internal virtual void  dumpFrame(int frm)
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			Frame[] ar = m_session.Frames;
			appendFrameInfo(sb, ar[frm], frm, false, true);
			
			sb.Append(m_newline);
			output(sb.ToString());
		}
		
		// Set the listing position to change to the given module and line number
		// also triggers emacs to move to this position if enabled
		internal virtual void  setListingPosition(int module, int line)
		{
			propertyPut(LIST_MODULE, module);
			propertyPut(LIST_LINE, line);
			
			// if we are running under emacs then dump out our new location
			if (m_fullnameOption)
			{
				SourceFile f = m_fileInfo.getFile(module);
				if (f != null)
				{
					System.Text.StringBuilder sb = new System.Text.StringBuilder();
					appendFullnamePosition(sb, f, line);
					sb.Append('\n'); // not sure why this is needed but it seems to address some emacs bugs
					output(sb.ToString());
				}
			}
		}
		
		/// <summary> Traverse the given variables dumping any Movieclips we find that
		/// contain a member called 'member'
		/// </summary>
		/// <throws>  NotConnectedException  </throws>
		/// <throws>  NoResponseException  </throws>
		/// <throws>  NotSuspendedException  </throws>
		internal virtual void  dumpTree(System.Collections.IDictionary tree, System.Collections.IList e, String name, Value result, String member)
		{
			// name for this variable
			if (name == null)
				name = ""; //$NON-NLS-1$
			
			// have we seen it already
			if (tree.Contains(result))
				return ;
			
			tree[result] = name; // place it
			
			// first iterate over our members looking for 'member'
			Value proto = result;
			bool done = false;
			while (!done && proto != null)
			{
				Variable[] members = proto.getMembers(m_session);
				proto = null;
				
				// see if we find one called 'member'
				for (int i = 0; i < members.Length; i++)
				{
					Variable m = members[i];
					String memName = m.getName();
					if (memName.Equals(member) && !tree.Contains(m))
					{
						e.Add(name);
						e.Add(result);
						e.Add(m);
						tree[m] = name + "." + memName; //$NON-NLS-1$
						done = true;
					}
					else if (memName.Equals("__proto__"))
					//$NON-NLS-1$
						proto = members[i].getValue();
				}
			}
			
			// now traverse other mcs recursively
			done = false;
			proto = result;
			while (!done && proto != null)
			{
				Variable[] members = proto.getMembers(m_session);
				proto = null;
				
				// see if we find an mc
				for (int i = 0; i < members.Length; i++)
				{
					Variable m = members[i];
					String memName = m.getName();
					
					// if our type is NOT object or movieclip then we are done
					if (m.getValue().getType() != VariableType.OBJECT && m.getValue().getType() != VariableType.MOVIECLIP)
					{
					}
					else if (m.getValue().Id != Value.UNKNOWN_ID)
						dumpTree(tree, e, name, m.getValue(), member);
					else if (memName.Equals("__proto__"))
					//$NON-NLS-1$
					{
						proto = m.getValue();
						//					name = name + ".__proto__";
					}
				}
			}
		}
		
		internal virtual System.Text.StringBuilder treeResults(System.Text.StringBuilder sb, System.Collections.IList e, String memName, bool fullName)
		{
			// walk the list
            for (int index = 0; index < e.Count; index += 3)
            {
				String name = (String) e[index];
                Variable key = (Variable)e[index+1];
                Variable val = (Variable)e[index+2];
				
				//			sb.append(key);
				//			sb.append(".");
				//			sb.append(val.getName());
				if (fullName)
					sb.Append(name);
				ExpressionCache.appendVariableValue(sb, key.getValue(), key.getName());
				sb.Append("."); //$NON-NLS-1$
				sb.Append(memName);
				sb.Append(" = "); //$NON-NLS-1$
				ExpressionCache.appendVariableValue(sb, val.getValue(), val.getName());
				sb.Append(m_newline);
			}
			return sb;
		}
		
		/// <summary> Output a source line of code to the output channel formatting nicely</summary>
		public virtual void  outputSource(int module, int line, String s)
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			appendSource(sb, module, line, s, true);
			output(sb.ToString());
		}
		
		internal virtual void  appendSource(System.Text.StringBuilder sb, int module, int line, String s, bool markCurrent)
		{
			String lineS = System.Convert.ToString(line);
			int padding = 6 - lineS.Length;
			
			// if we are the current location then mark it
			if (markCurrent && isCurrentLocation(module, line))
				sb.Append('=');
			else
				sb.Append(' ');
			sb.Append(lineS);
			repeat(sb, ' ', padding);
			sb.Append(s);
		}
		
		// see if this module, line combo is the current location
		internal virtual bool isCurrentLocation(int module, int line)
		{
			bool yes = false;
			Location l = getCurrentLocation();
			if (l != null)
			{
				SourceFile file = l.File;
				if (file != null && file.Id == module && l.Line == line)
					yes = true;
			}
			return yes;
		}
		
		private int parseLineNumber(String lineNumber)
		{
			try
			{
				return System.Int32.Parse(lineNumber);
			}
			catch (System.FormatException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["token"] = lineNumber; //$NON-NLS-1$
				throw new FormatException(LocalizationManager.getLocalizedTextString("expectedLineNumber", args)); //$NON-NLS-1$
			}
		}
		
		private int parseFileNumber(String fileNumber)
		{
			try
			{
				return System.Int32.Parse(fileNumber);
			}
			catch (System.FormatException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["token"] = fileNumber; //$NON-NLS-1$
                throw new FormatException(LocalizationManager.getLocalizedTextString("expectedFileNumber", args)); //$NON-NLS-1$
			}
		}
		
		private int parseFileName(String partialFileName)
		{
			SourceFile[] sourceFiles = m_fileInfo.getFiles(partialFileName);
			int nSourceFiles = sourceFiles.Length;
			
			if (nSourceFiles == 0)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["name"] = partialFileName; //$NON-NLS-1$
				throw new NoMatchException(LocalizationManager.getLocalizedTextString("noSourceFileWithSpecifiedName", args)); //$NON-NLS-1$
			}
			else if (nSourceFiles > 1)
			{
				String s = LocalizationManager.getLocalizedTextString("ambiguousMatchingFilenames") + m_newline; //$NON-NLS-1$
				for (int i = 0; i < nSourceFiles; i++)
				{
					SourceFile sourceFile = sourceFiles[i];
					s += (" " + sourceFile.Name + "#" + sourceFile.Id); //$NON-NLS-1$ //$NON-NLS-2$
					if (i < nSourceFiles - 1)
						s += m_newline;
				}
				throw new AmbiguousException(s);
			}
			return sourceFiles[0].Id;
		}
		
		/* used by parseFunctionName */
		private class ModuleFunctionPair : System.IComparable
		{
			public ModuleFunctionPair(int moduleId, String functionName)
			{
				this.moduleId = moduleId;
				this.functionName = functionName;
			}
			public int moduleId;
			public String functionName;
			
			public virtual int CompareTo(System.Object arg0)
			{
				ModuleFunctionPair other = (ModuleFunctionPair) arg0;
				return String.CompareOrdinal(functionName, other.functionName);
			}
		}
		
		/// <summary> Parse a partial function name</summary>
		/// <param name="module">the FIRST module to search; but we also search all the others if 'onlyThisModule' is false
		/// </param>
		/// <returns> two ints: first is the module, and second is the line
		/// </returns>
		private int[] parseFunctionName(int module, String partialFunctionName, bool onlyThisModule)
		{
			try
			{
				waitForMetaData();
			}
			catch (InProgressException)
			{
			} // wait a bit before we try this to give the background thread time to complete
			
			SourceFile m = m_fileInfo.getFile(module);
			System.Collections.ArrayList functionNames = new System.Collections.ArrayList(); // each member is a ModuleFunctionPair
			
			appendFunctionNamesMatching(functionNames, m, partialFunctionName);
			
			if (functionNames.Count == 0)
			{
				if (!onlyThisModule)
				{
					// not found in the specified module; search all the other modules
					System.Collections.IEnumerator fileIter = m_fileInfo.AllFiles;
					while (fileIter.MoveNext())
					{
                        SourceFile nextFile = (SourceFile)((IntMap.IntMapEntry)fileIter.Current).Value;
						if (nextFile != m)
						// skip the one file we searched at the beginning
						{
							appendFunctionNamesMatching(functionNames, nextFile, partialFunctionName);
						}
					}
				}
				
				if (functionNames.Count == 0)
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["name"] = partialFunctionName; //$NON-NLS-1$
					throw new NoMatchException(LocalizationManager.getLocalizedTextString("noFunctionWithSpecifiedName", args)); //$NON-NLS-1$
				}
			}
			
			if (functionNames.Count > 1)
			{
				ModuleFunctionPair[] functionNameArray = (ModuleFunctionPair[]) SupportClass.ICollectionSupport.ToArray(functionNames, new ModuleFunctionPair[functionNames.Count]);
				ArrayUtil.sort(functionNameArray);
				
				String s = LocalizationManager.getLocalizedTextString("ambiguousMatchingFunctionNames") + m_newline; //$NON-NLS-1$
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				for (int i = 0; i < functionNameArray.Length; i++)
				{
					String moduleName = m_fileInfo.getFile(functionNameArray[i].moduleId).Name;
					String functionName = functionNameArray[i].functionName;
					args["functionName"] = functionName; //$NON-NLS-1$
					args["filename"] = moduleName + "#" + functionNameArray[i].moduleId; //$NON-NLS-1$ //$NON-NLS-2$
					s += (" " + LocalizationManager.getLocalizedTextString("functionInFile", args)); //$NON-NLS-1$ //$NON-NLS-2$
					if (i < functionNameArray.Length - 1)
						s += m_newline;
				}
				throw new AmbiguousException(s);
			}
			
			ModuleFunctionPair pair = (ModuleFunctionPair) functionNames[0];
			module = pair.moduleId;
			m = m_fileInfo.getFile(module);
			int line = m.getLineForFunctionName(m_session, pair.functionName);
			return new int[]{module, line};
		}
		
		/// <summary> Find function names in this module that start with
		/// the specified string, and append them to the specified List.
		/// 
		/// If partialName contains parenthesis then we look for an exact match
		/// </summary>
		private void  appendFunctionNamesMatching(System.Collections.IList functionNameList, SourceFile m, String partialName)
		{
			int exactHitAt = - 1;
			
			// trim off the trailing parenthesis, if any
			int parenAt = partialName.LastIndexOf('(');
			if (parenAt > - 1)
				partialName = partialName.Substring(0, (parenAt) - (0));
			
			String[] names = m.getFunctionNames(m_session);
			for (int i = 0; i < names.Length; i++)
			{
				String functionName = names[i];
				if (functionName.Equals(partialName))
				{
					exactHitAt = i;
					break;
				}
				else if (functionName.StartsWith(partialName))
					functionNameList.Add(new ModuleFunctionPair(m.Id, functionName));
			}
			
			// exact match?
			if (exactHitAt > - 1)
			{
				functionNameList.Clear();
				functionNameList.Add(new ModuleFunctionPair(m.Id, names[exactHitAt]));
			}
		}
		
		
		/// <summary> Parse arg to determine which file it specifies.
		/// Allowed formats: #29, MyApp.mxml, MyA
		/// A variety of exceptions are thrown for other formats.
		/// </summary>
		public virtual int parseFileArg(int module, String arg)
		{
			/* Special case: a location arg like :15 produces a file arg
			which is an empty string. */
			if (arg.Length == 0)
				return module;
			
			char firstChar = arg[0];
			
			/* The first character can't be 0-9 or '-'. */
			if (System.Char.IsDigit(firstChar) || firstChar == '-')
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["token"] = arg; //$NON-NLS-1$
                throw new FormatException(LocalizationManager.getLocalizedTextString("expectedFile", args)); //$NON-NLS-1$
			}
			/* If the first character is '#', the rest must be a file number. */
			else if (firstChar == '#')
			{
				return parseFileNumber(arg.Substring(1));
			}
			/* Otherwise, assume beforeColon is a full or partial file name. */
			else
			{
				return parseFileName(arg);
			}
		}
		
		/// <summary> Parse arg to determine which line it specifies.
		/// Allowed formats: 17, MyFunction, MyF
		/// A variety of exceptions are thrown for other formats.
		/// </summary>
		public virtual int parseLineArg(int module, String arg)
		{
			/* Special case: a location arg like #29: produces a line arg
			which is an empty string. */
			if (arg.Length == 0)
				return 1;
			
			char firstChar = arg[0];
			
			/* If the first character is 0-9 or '-', arg is assumed to be a line number. */
			if (System.Char.IsDigit(firstChar) || firstChar == '-')
			{
				return parseLineNumber(arg);
			}
			/* The first character can't be '#'. */
			else if (firstChar == '#')
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["token"] = arg; //$NON-NLS-1$
                throw new FormatException(LocalizationManager.getLocalizedTextString("expectedLineNumber", args)); //$NON-NLS-1$
			}
			/* Otherwise, assume arg is a full or partial function name. */
			else
			{
				int[] moduleAndLine = parseFunctionName(module, arg, true);
				return moduleAndLine[1];
			}
		}
		
		/// <summary> Parse arg to figure out what module and line it specifies.
		/// 
		/// Allowed formats (assuming Button.as is file #29
		/// and the first line of MyFunction is line 17):
		/// 
		/// arg                     module      line
		/// 17                      no change   17
		/// MyFunction              no change   17
		/// MyF                     no change   17
		/// #29                     29          1
		/// Button.as               29          1
		/// Bu                      29          1
		/// #29:17                  29          17
		/// #29:MyFunction          29          17
		/// #29:MyF                 29          17
		/// Button.as:17            29          17
		/// Button.as:MyFunction    29          17
		/// Button.as:MyF           29          17
		/// Bu:17                   29          17
		/// Bu:MyFunction           29          17
		/// Bu:MyF                  29          17
		/// 
		/// A variety of exceptions are thrown for other formats.
		/// </summary>
		public virtual int[] parseLocationArg(int module, int line, String arg)
		{
			int colonAt = arg.IndexOf(':');
			int wasFunc = 0; // set to 1 if a function was named
			
			/* First deal with the case where arg doesn't contain a ':'
			and therefore might be specifying either a file or a line. */
			if (colonAt < 0)
			{
				char firstChar = arg[0];
				
				/* If the first character is 0-9 or '-', arg is assumed to be a line number. */
				if (System.Char.IsDigit(firstChar) || firstChar == '-')
				{
					line = parseLineNumber(arg);
				}
				/* If the first character is a '#', what follows
				is assumed to be a file number. */
				else if (firstChar == '#')
				{
					module = parseFileNumber(arg.Substring(1));
					line = 1;
				}
				/* Otherwise, assume arg is a full or partial function name or file name. */
				else
				{
					/* Assume arg is a full or partial function in the specified module. */
					try
					{
						int[] moduleAndLine = parseFunctionName(module, arg, false);
						module = moduleAndLine[0];
						line = moduleAndLine[1];
						wasFunc = 1;
					}
					/* If it isn't, assume arg is a full or partial file name. */
					catch (NoMatchException)
					{
						try
						{
							module = parseFileName(arg);
							line = 1;
						}
						catch (NoMatchException)
						{
							// catch the 'file name' string
							System.Collections.IDictionary args = new System.Collections.Hashtable();
							args["token"] = arg; //$NON-NLS-1$
							throw new NoMatchException(LocalizationManager.getLocalizedTextString("noSuchFileOrFunction", args)); //$NON-NLS-1$
						}
					}
				}
			}
			/* Now deal with the case where arg contains a ':',
			and is therefore specifying both a file and a line. */
			else
			{
				module = parseFileArg(module, arg.Substring(0, (colonAt) - (0)));
				line = parseLineArg(module, arg.Substring(colonAt + 1));
				wasFunc = (arg.Substring(colonAt + 1).Length > 1 && System.Char.IsDigit(arg.Substring(colonAt + 1)[0]))?0:1;
			}
			
			return new int[]{module, line, wasFunc};
		}
		
		/// <summary> Print the context of a Variable</summary>
		internal virtual void  doWhat()
		{
			/* wait a bit if we are not halted */
			waitTilHalted();
			try
			{
				System.Object result = null;
				
				/* pull the rest of the line */
				String s = restOfLine();
				
				// first parse it, then attempt to evaluate the expression
				ValueExp expr = parseExpression(s);
				
				// make sure no assignment
				if (expr.hasSideEffectsOtherThanGetters())
					throw new System.UnauthorizedAccessException();
				
				result = evalExpression(expr);
				
				/* dump the output */
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				
				if (result is Variable)
				{
					Variable v = (Variable) result;
					
					// if it has a path then display it!
					if (v.isAttributeSet(VariableAttribute.IS_LOCAL))
						s = LocalizationManager.getLocalizedTextString("localVariable");
					//$NON-NLS-1$
					else if (v.isAttributeSet(VariableAttribute.IS_ARGUMENT))
						s = LocalizationManager.getLocalizedTextString("functionArgumentVariable");
					//$NON-NLS-1$
					else if ((v is VariableFacade) && (s = ((VariableFacade) v).Path) != null && s.Length > 0)
					{
					}
					else
						s = "_global"; //$NON-NLS-1$
					
					sb.Append(s);
				}
				else
					sb.Append(LocalizationManager.getLocalizedTextString("mustBeOnlyOneVariable")); //$NON-NLS-1$
				
				output(sb.ToString());
			}
			catch (System.UnauthorizedAccessException)
			{
				err(LocalizationManager.getLocalizedTextString("noSideEffectsAllowed")); //$NON-NLS-1$
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("couldNotEvaluate")); //$NON-NLS-1$
			}
		}
		
		/*
		* We accept zero, one or two args for this command. Zero args
		* means list the next 10 line around the previous listing.  One argument
		* specifies a line and 10 lines are listed around that line.  Two arguments
		* with a command between specifies starting and ending lines.
		*/
		internal virtual void  doList()
		{
			/* currentXXX may NOT be invalid! */
			
			int currentModule = propertyGet(LIST_MODULE);
			int currentLine = propertyGet(LIST_LINE);
			int listsize = propertyGet(LIST_SIZE);
			
			String arg1 = null;
			int module1 = currentModule;
			int line1 = currentLine;
			
			String arg2 = null;
			int line2 = currentLine;
			
			int numLines = 0;
			
			try
			{
				if (hasMoreTokens())
				{
					arg1 = nextToken();
					
					if (arg1.Equals("-"))
					//$NON-NLS-1$
					{
						// move back two times the listing size and if listsize is odd then move forward one
						line1 = line2 = line1 - (2 * listsize);
					}
					else
					{
						int[] result = parseLocationArg(currentModule, currentLine, arg1);
						module1 = result[0];
						line2 = line1 = result[1];
						
						if (hasMoreTokens())
						{
							arg2 = nextToken();
							line2 = parseLineArg(module1, arg2);
						}
					}
				}
				
				//			System.out.println("1="+module1+":"+line1+",2=:"+line2);
				
				/*
				* Check for a few error conditions, otherwise we'll write a listing!
				*/
				if (hasMoreTokens())
				{
					err(LocalizationManager.getLocalizedTextString("lineJunk")); //$NON-NLS-1$
				}
				else
				{
					int half = listsize / 2;
					SourceFile file = m_fileInfo.getFile(module1);
					numLines = file.LineCount;
					
					int newLine;
					if (numLines == 1 && file.getLine(1).Equals(""))
					//$NON-NLS-1$
					{
						// there's no source in the file at all!
						// this presumably means that the source file isn't in the current directory
						err(LocalizationManager.getLocalizedTextString("sourceFileNotFound")); //$NON-NLS-1$
						newLine = currentLine;
					}
					else
					{
						// pressing return is ok, otherwise throw the exception
						if (line1 > numLines && arg1 != null)
							throw new System.IndexOutOfRangeException();
						
						/* if no arg2 then user requested the next N lines around something */
						if (arg2 == null)
						{
							line2 = line1 + (half) - 1;
							line1 = line1 - (listsize - half);
						}
						
						/* adjust our range of lines to ensure we conform */
						if (line1 < 1)
						{
							/* shrink line 1, grow line2 */
							line2 += - (line1 - 1);
							line1 = 1;
						}
						
						if (line2 > numLines)
							line2 = numLines;
						
						//				    System.out.println("1="+module1+":"+line1+",2="+module2+":"+line2+",num="+numLines+",half="+half);
						
						/* nothing to display */
						if (line1 > line2)
							throw new System.IndexOutOfRangeException();
						
						/* now do it! */
						SourceFile source = m_fileInfo.getFile(module1);
						for (int i = line1; i <= line2; i++)
							outputSource(module1, i, source.getLine(i));
						
						newLine = line2 + half + (((listsize % 2) == 0)?1:2); // add one if even, 2 for odd;
					}
					
					/* save away valid context */
					propertyPut(LIST_MODULE, module1);
					propertyPut(LIST_LINE, newLine);
					m_repeatLine = "list"; /* allow repeated listing by typing CR */ //$NON-NLS-1$
				}
			}
			catch (System.IndexOutOfRangeException)
			{
				String name = "#" + module1; //$NON-NLS-1$
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["line"] = System.Convert.ToString(line1); //$NON-NLS-1$
				args["filename"] = name; //$NON-NLS-1$
				args["total"] = System.Convert.ToString(numLines); //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("lineNumberOutOfRange", args)); //$NON-NLS-1$
			}
			catch (AmbiguousException ae)
			{
				err(ae.Message);
			}
			catch (NoMatchException nme)
			{
				// TODO [mmorearty]: try to find a matching source file
				err(nme.Message);
			}
			catch (NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("noFilesFound")); //$NON-NLS-1$
			}
			catch (FormatException pe)
			{
				err(pe.Message);
			}
		}
		
		/// <summary> Fire up a session or await a connection from the socket if no
		/// URI was specified.
		/// </summary>
		internal virtual void  doRun()
		{
			if (m_session != null)
			{
				err(LocalizationManager.getLocalizedTextString("sessionInProgress")); //$NON-NLS-1$
				return ;
			}
			
			SessionManager mgr = Bootstrap.sessionManager();
			
			if (hasMoreTokens())
			{
				if (!setLaunchURI(restOfLine()))
					return ;
			}
			
			mgr.startListening();
			
			try
			{
				if (m_launchURI == null)
				{
					output(LocalizationManager.getLocalizedTextString("waitingForPlayerToConnect")); //$NON-NLS-1$
					m_session = mgr.accept(null);
				}
				else
				{
					output(LocalizationManager.getLocalizedTextString("launchingWithUrl") + m_newline + m_launchURI); //$NON-NLS-1$
					m_session = mgr.launch(m_launchURI, null, true, null);
				}
				
				// now see what happened
				if (m_session == null)
				{
					// shouldn't have gotten here
					throw new System.Net.Sockets.SocketException();
				}
				else
				{
					output(LocalizationManager.getLocalizedTextString("playerConnectedSessionStarting")); //$NON-NLS-1$
					initSession(m_session);
					
					// pause for a while during startup, don't let exceptions ripple outwards
					try
					{
						waitTilHalted();
					}
					catch (System.Exception)
					{
					}
					
					// pause for a while during startup, don't let exceptions ripple outwards
					try
					{
						waitForMetaData();
					}
					catch (System.Exception)
					{
					}
					
					setInitialSourceFile();
					
					output(LocalizationManager.getLocalizedTextString("setBreakpointsThenResume")); //$NON-NLS-1$
					
					// now poke to see if the player is good enough
					try
					{
						if (m_session.getPreference(SessionManager.PLAYER_SUPPORTS_GET) == 0)
							err(m_newline + LocalizationManager.getLocalizedTextString("warningNotAllCommandsSupported")); //$NON-NLS-1$
					}
					catch (System.Exception)
					{
					}
				}
			}
			catch (FileNotFoundException fnf)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["uri"] = fnf.Message; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("fileDoesNotExist", args)); //$NON-NLS-1$
			}
            catch (System.Net.Sockets.SocketException)
			{
				err(LocalizationManager.getLocalizedTextString("failedToConnect")); //$NON-NLS-1$
			}
			catch (IOException io)
			{
				err(io.Message);
			}
			finally
			{
				// turn off listening, to allow other session to connect
				mgr.stopListening();
			}
		}
		
		/// <summary> When we begin a debugging session, it would be nice if the default file
		/// for the "list" command etc. was the user's main MXML application file.
		/// There is no good way to really figure out what that file is, but we can
		/// certainly take a guess.
		/// </summary>
		private void  setInitialSourceFile()
		{
			int largestAuthoredId = - 1;
			SourceFile[] files = m_fileInfo.FileList;
			for (int i = 0; i < files.Length; ++i)
			{
				SourceFile sf = files[i];
				if (sf.Id > largestAuthoredId && getFileType(sf) == AUTHORED_FILE)
					largestAuthoredId = sf.Id;
			}
			if (largestAuthoredId != - 1)
				setListingPosition(largestAuthoredId, 1);
		}
		
		private bool setLaunchURI(String launchURI)
		{
			if (launchURI != null)
			{
				SessionManager mgr = Bootstrap.sessionManager();
				
				// If doing fdbunit, we always try to do launch(), even on platforms
				// that say they don't support it
				if (!mgr.supportsLaunch() && SystemProperties.getProperty("fdbunit") == null)
				//$NON-NLS-1$
				{
					err(LocalizationManager.getLocalizedTextString("manuallyLaunchPlayer")); //$NON-NLS-1$
					return false;
				}
				
				// check for special form of URI when in fullname mode, since we can't pass http: in this mode?!?
				if (m_fullnameOption)
				{
					if (launchURI.StartsWith("//"))
					//$NON-NLS-1$
						launchURI = "http:" + launchURI; //$NON-NLS-1$
				}
			}
			
			m_launchURI = launchURI;
			return true;
		}
		
		// set the URI
		internal virtual void  doFile()
		{
			if (!hasMoreTokens())
				setLaunchURI(null);
			else
				setLaunchURI(restOfLine());
		}
		
		internal virtual void  doSource()
		{
			String name = ""; //$NON-NLS-1$
			try
			{
				name = nextToken();
				StreamReader f = new StreamReader(name, System.Text.Encoding.Default);
				
				// push our current source onto the stack and open the new one
				pushStream(m_in);
				m_in = new LineNumberReader(f);
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("sourceCommandRequiresPath")); //$NON-NLS-1$
			}
			catch (System.ArgumentOutOfRangeException)
			{
				err(LocalizationManager.getLocalizedTextString("sourceCommandRequiresPath")); //$NON-NLS-1$
			}
			catch (FileNotFoundException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["filename"] = name; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("fileNotFound", args)); //$NON-NLS-1$
			}
		}
		
		internal virtual void  listFault(String f)
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			appendFaultTitles(sb);
			appendFault(sb, f);
			
			output(sb.ToString());
		}
		
		internal virtual void  appendFault(System.Text.StringBuilder sb, String f)
		{
			sb.Append(f);
			
			int space = 30 - f.Length;
			repeat(sb, ' ', space);
			
			bool stop = m_faultTable.isSet(f, "stop"); //$NON-NLS-1$
			bool print = m_faultTable.isSet(f, "print"); //$NON-NLS-1$
			
			sb.Append(stop?"Yes":"No");
			repeat(sb, ' ', stop?0:1);
			
			repeat(sb, ' ', 5);
			
			sb.Append(print?"Yes":"No");
			repeat(sb, ' ', print?0:1);
			
			// description
			repeat(sb, ' ', 7);
			
			String desc = m_faultTable.getDescription(f);
			sb.Append(desc);
			sb.Append(m_newline);
		}
		
		internal virtual void  appendFaultTitles(System.Text.StringBuilder sb)
		{
			sb.Append("Fault                         Stop    Print     Description" + m_newline);
			sb.Append("-----                         ----    -----     -----------" + m_newline);
		}
		
		/// <summary> Controls the configuration of what occurs when a
		/// fault is encountered
		/// </summary>
		internal virtual void  doHandle()
		{
			// should be at least on arg
			if (!hasMoreTokens())
				err(LocalizationManager.getLocalizedTextString("argumentRequired"));
			//$NON-NLS-1$
			else
			{
				// poor man's fix for supporting 'all' option
				String faultName = nextToken();
				System.Object[] names = new System.Object[]{faultName};
				
				// replace the single name with all of them
				if (faultName.ToUpper().Equals("all".ToUpper()))
				//$NON-NLS-1$
					names = m_faultTable.names();
				
				// make sure we know about at least one
				if (!m_faultTable.exists((String) names[0]))
					err(LocalizationManager.getLocalizedTextString("unrecognizedFault"));
				//$NON-NLS-1$
				else
				{
					if (!hasMoreTokens())
						listFault((String) names[0]);
					else
					{
						String action = null;
						try
						{
							while (hasMoreTokens())
							{
								action = nextToken();
								for (int i = 0; i < names.Length; i++)
									m_faultTable.action((String) names[i], action);
							}
						}
						catch (System.ArgumentException)
						{
							System.Collections.IDictionary args = new System.Collections.Hashtable();
							args["action"] = action; //$NON-NLS-1$
							err(LocalizationManager.getLocalizedTextString("unrecognizedAction", args)); //$NON-NLS-1$
						}
					}
				}
			}
		}
		
		/// <summary> Do the commands command!  This attaches a series of lines of text input by the user
		/// to a particular breakpoint, with the intention of exeuting these lines when the
		/// breakpoint is hit.
		/// </summary>
		internal virtual void  doCommands()
		{
			try
			{
				int id = - 1;
				if (hasMoreTokens())
					id = nextIntToken();
				else
					id = propertyGet(BPNUM);
				
				// get the breakpoint
				int at = breakpointIndexOf(id);
				BreakAction a = breakpointAt(at);
				
				// ready it
				a.clearCommands();
				a.Silent = false;
				
				// now just pull the commands as they come while not end
				String line = null;
				bool first = true;
				bool isEnd = false;
				
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["breakpointNumber"] = System.Convert.ToString(id); //$NON-NLS-1$
				output(LocalizationManager.getLocalizedTextString("typeCommandsForBreakpoint", args)); //$NON-NLS-1$
				
				do 
				{
					displayCommandPrompt();
					line = readLine().Trim();
					isEnd = line.ToUpper().Equals("end".ToUpper()); //$NON-NLS-1$
					
					if (!isEnd)
					{
						if (first && line.ToUpper().Equals("silent".ToUpper()))
						//$NON-NLS-1$
							a.Silent = true;
						else
							a.addCommand(line);
					}
					first = false;
				}
				while (!isEnd);
			}
			catch (System.IndexOutOfRangeException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["breakpointNumber"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("noBreakpointNumber", args)); //$NON-NLS-1$
			}
			catch (System.FormatException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["token"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("badBreakpointNumber", args)); //$NON-NLS-1$
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("commandFailed")); //$NON-NLS-1$
			}
		}
		
		/// <summary> Apply or remove conditions to a breakpoint.</summary>
		internal virtual void  doCondition()
		{
			try
			{
				// must have a breakpoint number
				int id = nextIntToken();
				
				// get the breakpoint
				int at = breakpointIndexOf(id);
				BreakAction a = breakpointAt(at);
				
				// no more parms means to clear it
				if (hasMoreTokens())
				{
					// now just pull the commands as they come while not end
					String line = restOfLine();
					
					// build an expression and attach it to the breakpoint
					ValueExp exp = parseExpression(line);
					
					// warn about the assignment!
					if (exp.containsInstanceOf(typeof(AssignmentExp)) && !yesNoQuery(LocalizationManager.getLocalizedTextString("askExpressionContainsAssignment")))
					//$NON-NLS-1$
						throw new System.UnauthorizedAccessException("="); //$NON-NLS-1$
					
					a.setCondition(exp, line);
				}
				else
				{
					a.clearCondition(); // clear it
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["breakpointNumber"] = System.Convert.ToString(id); //$NON-NLS-1$
					output(LocalizationManager.getLocalizedTextString("breakpointNowUnconditional", args)); //$NON-NLS-1$
				}
			}
			catch (System.UnauthorizedAccessException)
			{
				err(LocalizationManager.getLocalizedTextString("breakpointNotChanged")); //$NON-NLS-1$
			}
			catch (System.IndexOutOfRangeException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["breakpointNumber"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("noBreakpointNumber", args)); //$NON-NLS-1$
			}
			catch (System.FormatException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["token"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("badBreakpointNumber", args)); //$NON-NLS-1$
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("commandFailed")); //$NON-NLS-1$
			}
		}
		
		/// <summary> Request to add a new watchpoint
		/// This may result in one of two things happening
		/// (1) a new watchpoint could be added or
		/// (2) an existing watchpoint may be modified.
		/// 
		/// The watch, awatch, and rwatch commands will set a watchpoint on the
		/// given expression. The different commands control the read/write aspect
		/// of the watchpoint.
		/// 
		/// awatch will trigger a break if the expression is read or written.
		/// rwatch will trigger a break if the expression is read.
		/// watch will trigger a break if the expression is written.
		/// </summary>
		internal virtual void  doWatch(bool read, bool write)
		{
			try
			{
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				
				/* pull the rest of the line */
				String s = restOfLine();
				
				int flags = 3;
				if (read && write)
					flags = WatchKind.READWRITE;
				else if (read)
					flags = WatchKind.READ;
				else if (write)
					flags = WatchKind.WRITE;
				
				// snapshot of our existing list
				Watch[] list = m_session.WatchList;
				
				// We need to separate the front part the 'a.b' in 'a.b.c' 
				// of the expression to resolve it into a variable 
				// We usually get back a VariableFacade which contains
				// the context id (i.e the variable id) and the member name.
				ValueExp expr = parseExpression(s);
				VariableFacade result = (VariableFacade) evalExpression(expr);
				
				// extract the 2 pieces and get the raw variable.
				int varId = result.Context; // TODO fix this???  -mike
				String memberName = result.getName();
				Value v = m_session.getValue(varId);
				
				// attempt to set.
				Watch w = m_session.setWatch(v, memberName, flags);
				if (w == null)
				{
					// failed
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["expression"] = s; //$NON-NLS-1$
					err(LocalizationManager.getLocalizedTextString("watchpointCouldNotBeSet", args)); //$NON-NLS-1$
				}
				else
				{
					// if modified then lists are same length
					// otherwise 1 will be added
					Watch[] newList = m_session.WatchList;
					if (newList.Length == list.Length)
					{
						// modified, lets locate the one that changed
						// and reset it
						int at = missingWatchpointIndexOf(newList);
						WatchAction a = null;
						try
						{
							a = watchpointAt(at);
						}
						catch (System.IndexOutOfRangeException)
						{
							// this is pretty bad it means the player thinks we have a watchpoint
							// but we don't have a record of it.  So let's create a new one
							// and hope that we are now in sync with the player.
							a = new WatchAction(w);
						}
						
						// modify our view of the watchpoint
						int id = a.Id;
						a.resetWatch(w);
						
						System.Collections.IDictionary args = new System.Collections.Hashtable();
						args["watchpointNumber"] = System.Convert.ToString(id); //$NON-NLS-1$
						args["expression"] = s; //$NON-NLS-1$
						args["watchpointMode"] = getWatchpointModeString(a.Kind); //$NON-NLS-1$
						sb.Append(LocalizationManager.getLocalizedTextString("changedWatchpointMode", args)); //$NON-NLS-1$
					}
					else
					{
						// newly added
						WatchAction a = new WatchAction(w);
						watchpointAdd(a);
						
						int which = a.Id;
						System.Collections.IDictionary args = new System.Collections.Hashtable();
						args["watchpointNumber"] = System.Convert.ToString(which); //$NON-NLS-1$
						args["expression"] = s; //$NON-NLS-1$
						sb.Append(LocalizationManager.getLocalizedTextString("createdWatchpoint", args)); //$NON-NLS-1$
					}
					output(sb.ToString());
				}
			}
			catch (System.IndexOutOfRangeException)
			{
				// We should really do some cleanup after this exception
				// since it most likely means we can't find the watchpoint
				// that was just modified, therefore our watchlists are
				// out of sync with those of the API.
				err(LocalizationManager.getLocalizedTextString("badWatchpointNumber")); //$NON-NLS-1$
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("couldNotEvaluate")); //$NON-NLS-1$
			}
			catch (System.InvalidCastException)
			{
				err(LocalizationManager.getLocalizedTextString("couldNotResolveExpression")); //$NON-NLS-1$
			}
		}
		
		internal virtual WatchAction watchpointAt(int at)
		{
			return (WatchAction) m_watchpoints[at];
		}
		internal virtual bool watchpointAdd(WatchAction a)
		{
			return m_watchpoints.Add(a) >= 0;
		}
		internal virtual int watchpointCount()
		{
			return m_watchpoints.Count;
		}
		
		internal virtual int watchpointIndexOf(int id)
		{
			int size = watchpointCount();
			for (int i = 0; i < size; i++)
			{
				WatchAction b = watchpointAt(i);
				if (b.Id == id)
					return i;
			}
			
			return - 1;
		}
		
		internal virtual void  removeAllWatchpoints()
		{
			while (watchpointCount() > 0)
				removeWatchpointAt(0);
		}
		
		internal virtual void  removeWatchpointAt(int at)
		{
			WatchAction b = watchpointAt(at);
			bool worked = false;
			
			try
			{
				worked = (m_session.clearWatch(b.Watch) == null)?false:true;
			}
			catch (NoResponseException)
			{
			}
			
			if (!worked)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["variable"] = b.Expr; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("couldNotFindWatchpoint", args)); //$NON-NLS-1$
			}
			
			// remove in any event
			m_watchpoints.RemoveAt(at);
		}
		
		internal virtual String getWatchpointModeString(int flags)
		{
			switch (flags)
			{
				
				case 1: 
					return LocalizationManager.getLocalizedTextString("watchpointMode_read"); //$NON-NLS-1$
				
				case 2: 
					return LocalizationManager.getLocalizedTextString("watchpointMode_write"); //$NON-NLS-1$
				
				case 3: 
					return LocalizationManager.getLocalizedTextString("watchpointMode_readWrite"); //$NON-NLS-1$
				}
			return ""; //$NON-NLS-1$
		}
		
		/// <summary> Locate the index of a WatchAction that does not
		/// have a corresponding Watch in the given list. 
		/// 
		/// WARNING: this call can be very expensive but
		/// it is assumed that a.list and watchpointCount()
		/// are both small. 
		/// </summary>
		internal virtual int missingWatchpointIndexOf(Watch[] a)
		{
			int size = watchpointCount();
			int at = - 1;
			for (int i = 0; i < size && at < 0; i++)
			{
				WatchAction action = watchpointAt(i);
				Watch w = action.Watch;
				
				// now scan the list of watches looking for a hit
				int hit = - 1;
				for (int j = 0; j < a.Length && hit < 0; j++)
				{
					if (w == a[j])
						hit = j;
				}
				
				// can't find the watch object corresponding to our
				// watchpoint in list of session watches.
				if (hit < 0)
					at = i;
			}
			
			return at;
		}
		
		/// <summary> Display command</summary>
		internal virtual void  doDisplay()
		{
			try
			{
				if (!hasMoreTokens())
					doInfoDisplay();
				else
				{
					// followed by an expression (i.e. a line we just pull in)
					String s = restOfLine();
					
					// first parse it, then attempt to evaluate the expression
					ValueExp expr = parseExpression(s);
					
					// make sure no assignment
					if (expr.hasSideEffectsOtherThanGetters())
						throw new System.UnauthorizedAccessException();
					
					// it worked so create a new DisplayAction and then add it in
					
					DisplayAction b = new DisplayAction(expr, s);
					b.Enabled = true;
					displayAdd(b);
				}
			}
			catch (System.UnauthorizedAccessException)
			{
				err(LocalizationManager.getLocalizedTextString("noSideEffectsAllowed")); //$NON-NLS-1$
			}
			catch (System.NullReferenceException)
			{
				// already handled by parseExpression
			}
		}
		
		/// <summary> Remove auto-display expressions</summary>
		internal virtual void  doUnDisplay()
		{
			try
			{
				if (!hasMoreTokens())
				{
					// no args means delete all displays, last chance...
					if (yesNoQuery(LocalizationManager.getLocalizedTextString("askDeleteAllAutoDisplay")))
					//$NON-NLS-1$
					{
						int count = displayCount();
						for (int i = count - 1; i > - 1; i--)
						{
							displayRemoveAt(i);
						}
					}
				}
				else
				{
					while (hasMoreTokens())
					{
						int id = nextIntToken();
						int at = displayIndexOf(id);
						displayRemoveAt(at);
					}
				}
			}
			catch (System.IndexOutOfRangeException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["displayNumber"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("noDisplayNumber", args)); //$NON-NLS-1$
			}
			catch (System.FormatException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["token"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("badDisplayNumber", args)); //$NON-NLS-1$
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("commandFailed")); //$NON-NLS-1$
			}
		}
		
		/// <summary> Enabled breakpoints and disaplays</summary>
		internal virtual void  doDisable()
		{
			waitTilHalted();
			
			try
			{
				if (!hasMoreTokens())
				{
					// disables all breakpoints,
					int count = breakpointCount();
					for (int i = 0; i < count; i++)
						disableBreakpointAt(i);
				}
				else
				{
					// optionally specify  'display' or 'breakpoint'
					String arg = nextToken();
					int cmd = disableCommandFor(arg);
					int id = - 1;
					if (cmd == CMD_DISPLAY)
						doDisableDisplay();
					else
					{
						if (cmd == CMD_BREAK)
							id = nextIntToken();
						// ignore and get next number token
						else
							id = System.Int32.Parse(arg);
						
						do 
						{
							int at = breakpointIndexOf(id);
							disableBreakpointAt(at);
							
							if (hasMoreTokens())
								id = nextIntToken();
							else
								id = - 1;
							
							// keep going till we're blue in the face; also note that we cache'd a copy of locations
							// so that breakpoint numbers are consistent.
						}
						while (id > - 1);
					}
				}
			}
			catch (System.IndexOutOfRangeException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["breakpointNumber"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("noBreakpointNumber", args)); //$NON-NLS-1$
			}
			catch (System.FormatException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["token"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("badBreakpointNumber", args)); //$NON-NLS-1$
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("commandFailed")); //$NON-NLS-1$
			}
		}
		
		// disable a breakpoint
		internal virtual void  disableBreakpointAt(int at)
		{
			BreakAction a = breakpointAt(at);
			a.Enabled = false;
			breakDisableRequest(a.Locations);
		}
		
		internal virtual void  doDisableDisplay()
		{
			doEnableDisableDisplay(false);
		}
		
		internal virtual void  doEnableDisableDisplay(bool enable)
		{
			try
			{
				if (!hasMoreTokens())
				{
					// means do all!
					int size = displayCount();
					for (int i = 0; i < size; i++)
						displayAt(i).Enabled = enable;
				}
				else
				{
					// read ids until no more
					while ((hasMoreTokens()))
					{
						int id = nextIntToken();
						int at = displayIndexOf(id);
						DisplayAction a = displayAt(at);
						a.Enabled = enable;
					}
				}
			}
			catch (System.IndexOutOfRangeException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["displayNumber"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("noDisplayNumber", args)); //$NON-NLS-1$
			}
			catch (System.FormatException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["token"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("badDisplayNumber", args)); //$NON-NLS-1$
			}
		}
		
		/// <summary> Enables breakpoints (forever, one-shot hit or auto delete) and displays</summary>
		internal virtual void  doEnable()
		{
			waitTilHalted();
			
			try
			{
				if (!hasMoreTokens())
				{
					// enables all breakpoints
					int count = breakpointCount();
					int tally = 0;
					for (int i = 0; i < count; i++)
						tally += (enableBreakpointAt(i)?1:0);
					
					// mention that not all was good
					if (tally != count)
						err(LocalizationManager.getLocalizedTextString("notAllBreakpointsEnabled")); //$NON-NLS-1$
				}
				else
				{
					// optionally specify  'display' or 'breakpoint'
					String arg = nextToken();
					int cmd = enableCommandFor(arg);
					int id = - 1;
					bool autoDelete = false;
					bool autoDisable = false;
					if (cmd == CMD_DISPLAY)
						doEnableDisplay();
					else
					{
						if (cmd == CMD_BREAK)
							id = nextIntToken();
						// ignore and get next number token
						else if (cmd == CMD_DELETE)
						{
							autoDelete = true;
							id = nextIntToken(); // set and get next number token
						}
						else if (cmd == ENABLE_ONCE_CMD)
						{
							autoDisable = true;
							id = nextIntToken(); // set and get next number token
						}
						else
							id = System.Int32.Parse(arg);
						
						bool worked = true;
						do 
						{
							int at = breakpointIndexOf(id);
							worked = enableBreakpointAt(at, autoDisable, autoDelete);
							
							if (hasMoreTokens())
								id = nextIntToken();
							else
								id = - 1;
							
							// keep going till we're blue in the face; also note that we cache'd a copy of locations
							// so that breakpoint numbers are consistent.
						}
						while (worked && id > - 1);
						
						if (!worked)
						{
							System.Collections.IDictionary args = new System.Collections.Hashtable();
							args["breakpointNumber"] = System.Convert.ToString(id); //$NON-NLS-1$
							err(LocalizationManager.getLocalizedTextString("breakpointLocationNoLongerExists", args)); //$NON-NLS-1$
						}
					}
				}
			}
			catch (System.IndexOutOfRangeException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["breakpointNumber"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("noBreakpointNumber", args)); //$NON-NLS-1$
			}
			catch (System.FormatException)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["token"] = m_currentToken; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("badBreakpointNumber", args)); //$NON-NLS-1$
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("commandFailed")); //$NON-NLS-1$
			}
		}
		
		// request to enable a breakpoint
		// @return false if we couldn't enable it.
		internal virtual bool enableBreakpointAt(int at)
		{
			return enableBreakpointAt(at, false, false);
		}
		
		internal virtual bool enableBreakpointAt(int at, bool autoDisable, bool autoDelete)
		{
			return enableBreakpoint(breakpointAt(at), autoDisable, autoDelete);
		}
		
		internal virtual bool enableBreakpoint(BreakAction a, bool autoDisable, bool autoDelete)
		{
			bool retval = false;
			Location l = a.Location; // use the first location as a source file / line number template 
			if (l != null)
			{
				LocationCollection col = enableBreak(l.File, l.Line);
				if (!col.Empty)
				{
					a.Enabled = true;
					a.Locations = col;
					a.AutoDisable = autoDisable;
					a.AutoDelete = autoDelete;
					a.SingleSwf = false;
					a.Status = BreakAction.RESOLVED;
					retval = true;
				}
			}
			return retval;
		}
		
		internal virtual void  doEnableDisplay()
		{
			doEnableDisableDisplay(true);
		}
		
		/* Print working directory */
		internal virtual void  doPWD()
		{
			output(System.Environment.CurrentDirectory); //$NON-NLS-1$
		}
		
		/* Display or change current file */
		internal virtual void  doCF()
		{
			try
			{
				int module = propertyGet(LIST_MODULE);
				int currentLine = propertyGet(LIST_LINE);
				
				if (hasMoreTokens())
				{
					String arg = nextToken();
					module = parseFileArg(module, arg);
					currentLine = 1;
					setListingPosition(module, currentLine);
				}
				
				SourceFile sourceFile = m_fileInfo.getFile(module);
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				sb.Append(sourceFile.Name);
				sb.Append('#');
				sb.Append(sourceFile.Id);
				sb.Append(':');
				sb.Append(currentLine);
				output(sb.ToString());
			}
			catch (System.NullReferenceException)
			{
				err(LocalizationManager.getLocalizedTextString("noFilesFound")); //$NON-NLS-1$
			}
			catch (System.FormatException pe)
			{
				err(pe.Message);
			}
			catch (AmbiguousException ae)
			{
				err(ae.Message);
			}
			catch (NoMatchException nme)
			{
				err(nme.Message);
			}
		}
		
		/* Terminates current debugging sesssion */
		internal virtual void  doKill()
		{
			if (m_session == null)
				err(LocalizationManager.getLocalizedTextString("programNotBeingRun"));
			//$NON-NLS-1$
			else
			{
				if (yesNoQuery(LocalizationManager.getLocalizedTextString("askKillProgram")))
				//$NON-NLS-1$
					exitSession();
			}
		}
		
		/* Terminates fdb */
		internal virtual bool doQuit()
		{
			bool quit = false;
			
			// no session, no questions
			if (m_session == null)
				quit = true;
			else
			{
				quit = yesNoQuery(LocalizationManager.getLocalizedTextString("askProgramIsRunningExitAnyway")); //$NON-NLS-1$
				if (quit)
					exitSession();
			}
			return quit;
		}
		
		/* (non-Javadoc)
		* @see Flash.Tools.Debugger.SourceLocator#locateSource(java.lang.String, java.lang.String, java.lang.String)
		*/
		public virtual Stream locateSource(String path, String pkg, String name)
		{
			FileInfo f = null;
			bool exists = false;
			String pkgPlusName;
			
			if ((pkg != null && pkg.Length > 0))
				pkgPlusName = pkg + Path.DirectorySeparatorChar.ToString() + name;
			else
				pkgPlusName = null;
			
            foreach (String dir in m_sourceDirectories)
            {
                String dirName = dir;

				// new File("", filename) searches the root dir -- that's not what we want!
				if (dirName.Equals(""))
				//$NON-NLS-1$
					dirName = "."; //$NON-NLS-1$
				
				// look for sourcedir\package\filename
				if (pkgPlusName != null)
				{
                    f = new FileInfo(dirName + Path.DirectorySeparatorChar + pkgPlusName);
					exists = File.Exists(f.FullName) || Directory.Exists(f.FullName);
				}
				
				// look for sourcedir\filename
				if (!exists)
				{
                    f = new FileInfo(dir + Path.DirectorySeparatorChar + name);
					exists = File.Exists(f.FullName) || Directory.Exists(f.FullName);
				}
				
				if (exists)
				{
					try
					{
						return new FileStream(f.FullName, FileMode.Open, FileAccess.Read);
					}
					catch (FileNotFoundException e)
					{
                        Console.Error.Write(e.StackTrace);
                        Console.Error.Flush();

					}
				}
			}
			
			return null;
		}
		
		private void  doDirectory()
		{
			if (hasMoreTokens())
			{
				// File.separator is ";" on Windows or ":" on Mac
				SupportClass.Tokenizer dirs = new SupportClass.Tokenizer(restOfLine(), Path.PathSeparator.ToString());
				int insertPos = 0;
				
				while (dirs.HasMoreTokens())
				{
					String dir = dirs.NextToken();
					if (dir.Length > 2 && dir[0] == '"' && dir[dir.Length - 1] == '"')
						dir = dir.Substring(1, (dir.Length - 1) - (1));
					dir = dir.Trim();
					if (dir.Length > 0)
					{
#if false
						// For Unix and Mac, we want to escape "~" and "$HOME"
                        if (System.Environment.OSVersion.Platform == PlatformID.Unix)
						{
							// If the string starts with "~", or contains any environment variables
							// such as "$HOME", we need to escape those
							if (new System.Text.RegularExpressions.Regex(@"^.*[~$].*$").Match(dir).Success)
							//$NON-NLS-1$
							{
								try
								{
									System.Diagnostics.Process p = SupportClass.ExecSupport(new String[]{"/bin/sh", "-c", "echo " + dir}); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
                                    StreamReader r = new StreamReader(p.StandardInput.BaseStream, System.Text.Encoding.Default);
									String line = r.ReadLine();
									if (line != null)
									{
										line = line.Trim();
										if (line.Length > 0)
											dir = line;
									}
								}
								catch (IOException)
								{
									// ignore
								}
							}
						}
#endif

						try
						{
							dir = new FileInfo(dir).FullName;
							m_sourceDirectories.Insert(insertPos++, dir);
						}
						catch (IOException e)
						{
							err(e.Message);
						}
					}
				}
				++m_sourceDirectoriesChangeCount;
			}
			else
			{
				if (yesNoQuery(LocalizationManager.getLocalizedTextString("askReinitSourcePath")))
				//$NON-NLS-1$
				{
					initSourceDirectoriesList();
				}
			}
			
			doShowDirectories();
		}
		
		protected internal virtual void  initSourceDirectoriesList()
		{
			m_sourceDirectories.Clear();
			FileInfo flexHome = FlexHomeDirectory;
			if (flexHome != null)
			{
				try
				{
					FileInfo projectsDir = new FileInfo(flexHome.FullName + @"\frameworks\projects"); //$NON-NLS-1$

					if ((projectsDir.Attributes & FileAttributes.Directory) != 0)
					{
						String[] fullpathnames = Directory.GetFileSystemEntries(projectsDir.FullName);

						for (int i = 0; i < fullpathnames.Length; i++)
						{
							FileInfo file = new FileInfo(fullpathnames[i]);

							if (Directory.Exists(file.FullName))
							{
								FileInfo srcDir = new FileInfo(fullpathnames[i] + "\\" + "src"); //$NON-NLS-1$

								if (Directory.Exists(srcDir.FullName))
								{
									m_sourceDirectories.Add(srcDir.FullName);
								}
							}
						}
					}
				}
				catch (IOException)
				{
					// ignore
				}
			}
			++m_sourceDirectoriesChangeCount;
		}
		
		protected internal virtual String getenv(String var)
		{
            return System.Environment.GetEnvironmentVariable(var);
		}
		
		internal virtual void  doUnknown(String s)
		{
			doUnknown("", s);
		} //$NON-NLS-1$
		
		internal virtual void  doUnknown(String what, String s)
		{
			System.Collections.IDictionary args = new System.Collections.Hashtable();
			String formatString;
			args["command"] = s; //$NON-NLS-1$
			if (what == null || what.Equals(""))
			//$NON-NLS-1$
			{
				formatString = "unknownCommand"; //$NON-NLS-1$
				args["commandCategory"] = what; //$NON-NLS-1$
			}
			else
			{
				formatString = "unknownSubcommand"; //$NON-NLS-1$
			}
			err(LocalizationManager.getLocalizedTextString(formatString, args));
		}
		
		/// <summary> Process the incoming debug event queue</summary>
		internal virtual void  processEvents()
		{
			bool requestResume = false;
			bool requestHalt = m_requestHalt;
			
			while (m_session != null && m_session.EventCount > 0)
			{
				DebugEvent e = m_session.nextEvent();
				
				if (e is TraceEvent)
				{
					dumpTraceLine(e.information);
				}
				else if (e is SwfLoadedEvent)
				{
					handleSwfLoadedEvent((SwfLoadedEvent) e);
				}
				else if (e is SwfUnloadedEvent)
				{
					handleSwfUnloadedEvent((SwfUnloadedEvent) e);
				}
				else if (e is BreakEvent)
				{
					// we ignore these for now
				}
				else if (e is FileListModifiedEvent)
				{
					// we ignore this
				}
				else if (e is FunctionMetaDataAvailableEvent)
				{
					// we ignore this
				}
				else if (e is FaultEvent)
				{
					if (handleFault((FaultEvent) e))
						requestResume = true;
					else
						requestHalt = true;
				}
				else
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["type"] = e; //$NON-NLS-1$
					args["info"] = e.information; //$NON-NLS-1$
					err(LocalizationManager.getLocalizedTextString("unknownEvent", args)); //$NON-NLS-1$
				}
			}
			
			// only if we have processed a fault which requested a resume and no other fault asked for a break
			// and we are suspended and it was due to us that the stop occurred!
			if (requestResume && !requestHalt && m_session.Suspended && m_session.suspendReason() == SuspendReason.Fault)
				m_requestResume = true;
		}
		
		/// <summary> Our logic for handling a break condition.
		/// 
		/// </summary>
		/// <returns> some hit breakpoint requested silence, shhhh!
		/// </returns>
		internal virtual bool processBreak(bool postStep, System.Text.StringBuilder sb)
		{
			Location l = getCurrentLocation();
			if (l == null || l.File == null)
				return false;
			
			int fileId = l.File.Id;
			int line = l.Line;
			bool isSilent = false;
			bool bpHit = false;
			bool stoppedDueToBp = false;
			
			int count = breakpointCount();
			bool[] markedForRemoval = new bool[count];
			bool previousResume = m_requestResume;
			for (int i = 0; i < count; i++)
			{
				BreakAction a = breakpointAt(i);
				if (a.locationMatches(fileId, line))
				{
					/*
					* Note that it appears that we stopped due to hitting a hard breakpoint
					* Now if the breakpoint is conditional it may eval to false, meaning we
					* won't stop here, otherwise we will process the breakpoint.
					*/
					stoppedDueToBp = (m_session.suspendReason() == SuspendReason.Breakpoint);
					if (shouldBreak(a, fileId, line))
					{
						// its a hit
						bpHit = true;
						a.hit();
						isSilent = (isSilent)?true:a.Silent;
						
						// autodelete, autodisable
						if (a.AutoDisable)
							disableBreakpointAt(i);
						
						if (a.AutoDelete)
							markedForRemoval[i] = true;
						
						// now issue any commands that are attached to the breakpoint
						int n = a.CommandCount;
						for (int j = 0; j < n; j++)
							issueCommand(a.commandAt(j), sb);
					}
				}
			}
			
			// kill them backwards so our i is acurate
			for (int i = markedForRemoval.Length - 1; i > - 1; i--)
				if (markedForRemoval[i])
					removeBreakpointAt(i);
			
			/*
			* Now we should request to resume only if it was due to
			* breakpoints that were hit.
			*
			* For the first case, we hit a conditional breakpoint that
			* eval'd to false, resulting in bpHit == false.  Thus we
			* want to resume and additionally if we were stepping, we'd
			* like to do so 'softly' that is without loosing the stepping
			* information on the Player.
			*
			* For the 2nd case, we hit a breakpoint and we executed
			* commands that resulted in a m_requestResume.
			*/
			if (stoppedDueToBp && !bpHit)
			{
				m_requestResume = true;
				m_stepResume = postStep; // resume without losing our stepping
				isSilent = true; // do so quietly
			}
			else if (stoppedDueToBp && bpHit && m_requestResume && !previousResume)
			{
				m_requestResume = true;
				m_stepResume = postStep; // resume as we would
				processDisplay(sb);
			}
			
			// If we aren't continuing, then show display variables
			if (!m_requestResume)
				processDisplay(sb);
			
			//		System.out.println("processBreak stopDueToBp="+stoppedDueToBp+",bpHit="+bpHit+",postStep="+postStep+",reason="+suspendReason());
			
			return isSilent;
		}
		
		// iterate through our display list entries
		internal virtual void  processDisplay(System.Text.StringBuilder sb)
		{
			int count = displayCount();
			for (int i = 0; i < count; i++)
			{
				DisplayAction a = displayAt(i);
				if (a.Enabled)
				{
					try
					{
						sb.Append(a.Id);
						sb.Append(": "); //$NON-NLS-1$
						sb.Append(a.Content);
						sb.Append(" = "); //$NON-NLS-1$
						
						// command[0] contains our expression, so first we parse it, evalulate it then print it
						System.Object result = m_exprCache.evaluate(a.Expression);
						
						if (result is Variable)
							ExpressionCache.appendVariableValue(sb, ((Variable) result).getValue());
						else if (result is Value)
							ExpressionCache.appendVariableValue(sb, (Value) result);
						else if (result is InternalProperty)
							sb.Append(((InternalProperty) result).valueOf());
						else
							sb.Append(result);
						
						sb.Append(m_newline);
					}
					catch (NoSuchVariableException nsv)
					{
						System.Collections.IDictionary args = new System.Collections.Hashtable();
						args["variable"] = nsv.Message; //$NON-NLS-1$
						sb.Append(LocalizationManager.getLocalizedTextString("variableUnknown", args)); //$NON-NLS-1$
						sb.Append(m_newline);
					}
					catch (System.FormatException nfe)
					{
						System.Collections.IDictionary args = new System.Collections.Hashtable();
						args["value"] = nfe.Message; //$NON-NLS-1$
						sb.Append(LocalizationManager.getLocalizedTextString("couldNotConvertToNumber", args)); //$NON-NLS-1$
						sb.Append(m_newline);
					}
					catch (PlayerFaultException pfe)
					{
						sb.Append(pfe.Message + m_newline);
					}
					catch (System.NullReferenceException)
					{
						sb.Append(LocalizationManager.getLocalizedTextString("couldNotEvaluate")); //$NON-NLS-1$
					}
				}
			}
		}
		
		/// <summary> Determines if the given BreakAction requests a halt given the file
		/// line and optionally a conditional to evaluate.'
		/// </summary>
		internal virtual bool shouldBreak(BreakAction a, int fileId, int line)
		{
			bool should = a.Enabled;
			ValueExp exp = a.getCondition();
			if (should && exp != null && !m_requestHalt)
			// halt request fires true
			{
				// evaluate it then update our boolean
				try
				{
					System.Object result = evalExpression(exp, false);
					should = BooleanExp.toBoolean(result);
				}
				catch (System.NullReferenceException)
				{
				}
				catch (System.FormatException)
				{
				}
			}
			return should;
		}
		
		/// <summary> Sets the command interpreter up to execute the
		/// given string a  command
		/// 
		/// This io redirection crap is really UGLY!!!
		/// </summary>
		internal virtual void  issueCommand(String cmd, System.Text.StringBuilder output)
		{
			MemoryStream ba = new MemoryStream();
			StreamWriter ps = new StreamWriter(ba);
			
			// temporarily re-wire i/o to catch all output
			StreamWriter oldOut = m_out;
			StreamWriter oldErr = m_err;
			
			m_out = ps;
			m_err = ps;
			try
			{
				CurrentLine = cmd;
				processLine();
			}
			catch (AmbiguousException)
			{
				// we already put up a warning for the user
			}
			catch (System.InvalidOperationException)
			{
				err(LocalizationManager.getLocalizedTextString("illegalStateException")); //$NON-NLS-1$
			}
			catch (System.Threading.SynchronizationLockException)
			{
				err(LocalizationManager.getLocalizedTextString("commandNotValidUntilPlayerSuspended")); //$NON-NLS-1$
			}
			catch (System.ArgumentOutOfRangeException)
			{
				err(LocalizationManager.getLocalizedTextString("noSuchElementException")); //$NON-NLS-1$
			}
			catch (System.Net.Sockets.SocketException se)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["socketErrorMessage"] = se.Message; //$NON-NLS-1$
				err(LocalizationManager.getLocalizedTextString("problemWithConnection", args)); //$NON-NLS-1$
			}
			catch (System.Exception e)
			{
				err(LocalizationManager.getLocalizedTextString("unexpectedErrorWithStackTrace")); //$NON-NLS-1$
                if (Trace.error)
                {
                    Console.Error.Write(e.StackTrace);
                    Console.Error.Flush();
                }
			}
			
			// flush the stream and then send its contents to our string buffer
			ps.Flush();
			char[] tmpChar;
			byte[] tmpByte;
			tmpByte = ba.GetBuffer();
			tmpChar = new char[ba.Length];
			System.Array.Copy(tmpByte, 0, tmpChar, 0, tmpChar.Length);
			output.Append(new String(tmpChar));
			
			m_err = oldErr;
			m_out = oldOut;
		}
		
		/// <summary> We have received a fault and are possibly suspended at this point.
		/// We need to look at our fault table and determine what do.
		/// </summary>
		/// <returns> true if we resumed execution
		/// </returns>
		internal virtual bool handleFault(FaultEvent e)
		{
			// lookup what we need to do
			bool requestResume = false;
			String name = e.name();
			bool stop = true;
			bool print = true;
			try
			{
				print = m_faultTable.isSet(name, "print"); //$NON-NLS-1$
				stop = m_faultTable.isSet(name, "stop"); //$NON-NLS-1$
			}
			catch (System.NullReferenceException npe)
			{
				if (Trace.error)
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["faultName"] = name; //$NON-NLS-1$
					Trace.trace(LocalizationManager.getLocalizedTextString("faultHasNoTableEntry", args)); //$NON-NLS-1$
                    Console.Error.Write(npe.StackTrace);
                    Console.Error.Flush();
                }
			}
			
			// should we stop?
			if (!stop)
				requestResume = true;
			
			if (print)
				dumpFaultLine(e);
			
			return requestResume;
		}
		
		// wait a little bit of time until the player halts, if not throw an exception!
		internal virtual void  waitTilHalted()
		{
			if (!haveConnection())
                throw new System.InvalidOperationException();
			
			int timeout = propertyGet(HALT_TIMEOUT);
			int update = propertyGet(UPDATE_DELAY);
			bool wait = (propertyGet(NO_WAITING) == 1)?false:true;
			
			if (wait)
			{
				// spin for a while waiting for a halt; updating trace messages as we get them
				waitForSuspend(timeout, update);
				
				if (!m_session.Suspended)
				{
					throw new System.Threading.SynchronizationLockException();
				}
			}
		}
		
		/// <summary> We spin in this spot until the player reaches the
		/// requested suspend state, either true or false.
		/// 
		/// During this time we wake up every period milliseconds
		/// and update the display and our state with information
		/// received from the debug event queue.
		/// </summary>
		internal virtual void  waitForSuspend(int timeout, int period)
		{
			while (timeout > 0)
			{
				// dump our events to the console while we are waiting.
				processEvents();
				if (m_session.Suspended)
					break;
				
				try
				{
					System.Threading.Thread.Sleep(period);
				}
				catch (System.Threading.ThreadInterruptedException)
				{
				}
				timeout -= period;
			}
		}
		
		/// <summary> If we still have a socket try to send an exit message
		/// Doesn't seem to work ?!?
		/// </summary>
		internal virtual void  exitSession()
		{
			// clear out our watchpoint list and displays
			// keep breakpoints around so that we can try to reapply them if we reconnect
			m_displays.Clear();
			m_watchpoints.Clear();
			
			if (m_fileInfo != null)
				m_fileInfo.unbind();
			
			if (m_session != null)
				m_session.terminate();
			
			m_session = null;
			m_fileInfo = null;
		}
		
		internal virtual void  initSession(Session s)
		{
			s.SourceLocator = this;
			
			m_fileInfo = new FileInfoCache();
			m_exprCache.clear();
			
			m_fileInfo.bind(s);
			m_exprCache.bind(s);
			
			// bind catching a version problem
			bool correctVersion = true;
			try
			{
				s.bind();
			}
			catch (VersionException)
			{
				correctVersion = false;
			}
			
			// reset session properties
			propertyPut(LIST_LINE, 1);
			propertyPut(LIST_MODULE, 1); // default to module #1
			propertyPut(BPNUM, 0); // set current breakpoint number as something bad
			propertyPut(LAST_FRAME_DEPTH, 0);
			propertyPut(CURRENT_FRAME_DEPTH, 0);
			propertyPut(DISPLAY_FRAME_NUMBER, 0);
			propertyPut(METADATA_ATTEMPTS_PERIOD, 250); // 1/4s per attempt
			propertyPut(METADATA_NOT_AVAILABLE, 0); // counter for failures
			propertyPut(METADATA_ATTEMPTS, METADATA_RETRIES);
			propertyPut(PLAYER_FULL_SUPPORT, correctVersion?1:0);
			
			String previousURI = m_mruURI;
			m_mruURI = m_session.URI;
			
			// try to reapply the breakpoint's
			if (previousURI != null && m_mruURI != null && previousURI.ToUpper().Equals(m_mruURI.ToUpper()))
				reapplyBreakpoints();
			else
			{
				while (m_breakpoints.Count > 0)
					m_breakpoints.RemoveAt(0);
			}
			
			m_requestResume = false;
			m_stepResume = false;
		}
		
		/// <summary> Walk through the list of breakpoints and try to apply them to our session
		/// We aren't that smart in that we ignore the singleSwf property of the breakpoint
		/// meaning that if you have a breakpoint set on a single swf, it will be restored
		/// across all swfs.
		/// </summary>
		internal virtual void  reapplyBreakpoints()
		{
			// give us a bit of time to process the newly loaded swf
			if (propertyGet(METADATA_ATTEMPTS) > 0)
				try
				{
					waitForMetaData(80);
				}
				catch (InProgressException)
				{
				}
			
			int count = breakpointCount();
			for (int i = 0; i < count; i++)
			{
				BreakAction a = breakpointAt(i);
				a.clearHits();
				a.Status = BreakAction.UNRESOLVED;
			}
			
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			resolveBreakpoints(sb);
			output(sb.ToString());
		}
		
		/// <summary> Process a single line of input and return true if the quit command was encountered</summary>
		internal virtual bool processLine()
		{
			if (!hasMoreTokens())
				return false;
			
			String command = nextToken();
			bool quit = false;
			int cmdID = commandFor(command);
			
			/* assume line will not be repeated. (i.e. user hits CR nothing happens) */
			m_repeatLine = null;
			
			switch (cmdID)
			{
				
				case CMD_QUIT: 
					quit = doQuit();
					break;
				
				
				case CMD_CONTINUE: 
					doContinue();
					break;
				
				
				case CMD_HOME: 
					doHome();
					break;
				
				
				case CMD_HELP: 
					doHelp();
					break;
				
				
				case CMD_SHOW: 
					doShow();
					break;
				
				
				case CMD_STEP: 
					doStep();
					break;
				
				
				case CMD_NEXT: 
					doNext();
					break;
				
				
				case CMD_FINISH: 
					doFinish();
					break;
				
				
				case CMD_BREAK: 
					doBreak();
					break;
				
				
				case CMD_CLEAR: 
					doClear();
					break;
				
				
				case CMD_SET: 
					doSet();
					break;
				
				
				case CMD_LIST: 
					doList();
					break;
				
				
				case CMD_PRINT: 
					doPrint();
					break;
				
				
				case CMD_TUTORIAL: 
					doTutorial();
					break;
				
				
				case CMD_INFO: 
					doInfo();
					break;
				
				
				case CMD_FILE: 
					doFile();
					break;
				
				
				case CMD_DELETE: 
					doDelete();
					break;
				
				
				case CMD_RUN: 
					doRun();
					break;
				
				
				case CMD_SOURCE: 
					doSource();
					break;
				
				
				case CMD_KILL: 
					doKill();
					break;
				
				
				case CMD_HANDLE: 
					doHandle();
					break;
				
				
				case CMD_ENABLE: 
					doEnable();
					break;
				
				
				case CMD_DISABLE: 
					doDisable();
					break;
				
				
				case CMD_DISPLAY: 
					doDisplay();
					break;
				
				
				case CMD_UNDISPLAY: 
					doUnDisplay();
					break;
				
				
				case CMD_COMMANDS: 
					doCommands();
					break;
				
				
				case CMD_PWD: 
					doPWD();
					break;
				
				
				case CMD_CF: 
					doCF();
					break;
				
				
				case CMD_AWATCH: 
					doWatch(true, true);
					break;
				
				
				case CMD_WATCH: 
					// Disable the "watch" command for now
					//				doWatch(false, true);
					break;
				
				
				case CMD_RWATCH: 
					doWatch(true, false);
					break;
				
				
				case CMD_CONDITION: 
					doCondition();
					break;
				
				
				case CMD_WHAT: 
					doWhat();
					break;
				
				
				case CMD_DISASSEMBLE: 
					doDisassemble();
					break;
				
				
				case CMD_HALT: 
					doHalt();
					break;
				
				
				case CMD_MCTREE: 
					doMcTree();
					break;
				
				
				case CMD_VIEW_SWF: 
					doViewSwf();
					break;
				
				
				case CMD_DOWN: 
					doDown();
					break;
				
				
				case CMD_UP: 
					doUp();
					break;
				
				
				case CMD_FRAME: 
					doFrame();
					break;
				
				
				case CMD_COMMENT: 
					; // nop
					break;
				
				
				case INFO_STACK_CMD: 
					; // from bt
					doInfoStack();
					break;
				
				
				case CMD_DIRECTORY: 
					doDirectory();
					break;
				
				
				default: 
					doUnknown(command);
					break;
				
			}
			return quit;
		}
		
		/// <summary> Read help text from fdbhelp*.txt.</summary>
		internal virtual String getHelpTopic(String topic)
		{
			// Open the file fdbhelp*.txt that is a sibling of this class file.
			// (Note: build.xml copies it into the classes directory.)
			Stream helpStream = Help.ResourceAsStream;
			if (helpStream == null)
				return LocalizationManager.getLocalizedTextString("noHelpFileFound"); //$NON-NLS-1$
			
			// Read the help file line-by-line, looking for topic lines like [Break].
			// Build an array of the lines within the section for the specified topic.
			topic = "[" + topic + "]"; //$NON-NLS-1$ //$NON-NLS-2$
			System.Collections.ArrayList lines = System.Collections.ArrayList.Synchronized(new System.Collections.ArrayList(10));
			StreamReader r = null;
			try
			{
				r = new StreamReader(helpStream, System.Text.Encoding.GetEncoding("UTF-8")); //$NON-NLS-1$
				String line;
				// Read lines until we find the specified topic line.
				while ((line = r.ReadLine()) != null)
				{
					if (line.StartsWith(topic))
						break;
				}
				// Read lines until we find the next topic line.
				while ((line = r.ReadLine()) != null)
				{
					if (line.StartsWith("["))
					//$NON-NLS-1$
						break;
					lines.Add(line);
				}
			}
			catch (FileNotFoundException fnf)
			{
				err(fnf.Message);
			}
			catch (IOException e)
			{
				err(e.Message);
			}
			finally
			{
				if (r != null)
					try
					{
						r.Close();
					}
					catch (IOException e)
					{
                        Console.Error.Write(e.StackTrace);
                        Console.Error.Flush();
                    }
			}
			
			// Concatenate the lines, leaving out the first and last ones
			// which are supposed to be blank. They're only there to make
			// fdbhelp*.txt more readable.
			System.Text.StringBuilder helpText = new System.Text.StringBuilder();
			int n = lines.Count;
			for (int i = 1; i < n - 1; i++)
			{
				String line = (String) lines[i];
				helpText.Append(line);
				if (i != n - 2)
					helpText.Append(m_newline);
			}
			
			return helpText.ToString();
		}
		
		/// <summary> Provide context sensitive help</summary>
		internal virtual void  doHelp()
		{
			// someone entered a help command so let's help them!
			String topic = "help"; //$NON-NLS-1$
			
			int cmd;
			String commandName;
			
			// they might have entered something like "help br"
			if (hasMoreTokens())
			{
				// map "br" to CMD_BREAK
				cmd = commandFor(nextToken());
				// and then back to "break"
				commandName = commandNumberToCommandName(g_commandArray, cmd);
				// so we'll look up the topic named "break" in fdbhelp*.txt
				topic = commandName;
				
				// they might have entered something like "help inf fil"
				if (cmd == CMD_INFO && hasMoreTokens())
				{
					// map "fil" to CMD_INFO_FILE
					cmd = infoCommandFor(nextToken());
					// and then back to "file"
					commandName = commandNumberToCommandName(g_infoCommandArray, cmd);
					// so we'll look up the topic named "info file" in fdbhelp*.txt
					topic += (" " + commandName); //$NON-NLS-1$
				}
				// or like "help sho n"
				else if (cmd == CMD_SHOW && hasMoreTokens())
				{
					// map "n" to CMD_SHOW_NET
					cmd = showCommandFor(nextToken());
					// and then back to "net"
					commandName = commandNumberToCommandName(g_showCommandArray, cmd);
					// so we'll look up the topic named "show net" in fdbhelp*.txt
					topic += (" " + commandName); //$NON-NLS-1$
				}
			}
			
			output(getHelpTopic(topic));
		}
		
		internal virtual void  doTutorial()
		{
			output(getHelpTopic("Tutorial")); //$NON-NLS-1$
		}
		
		// process strings to command ids
		internal virtual int commandFor(String s)
		{
			return determineCommand(g_commandArray, s, CMD_UNKNOWN);
		}
		internal virtual int showCommandFor(String s)
		{
			return determineCommand(g_showCommandArray, s, SHOW_UNKNOWN_CMD);
		}
		internal virtual int infoCommandFor(String s)
		{
			return determineCommand(g_infoCommandArray, s, INFO_UNKNOWN_CMD);
		}
		internal virtual int enableCommandFor(String s)
		{
			return determineCommand(g_enableCommandArray, s, CMD_UNKNOWN);
		}
		internal virtual int disableCommandFor(String s)
		{
			return determineCommand(g_disableCommandArray, s, CMD_UNKNOWN);
		}
		
		/// <summary> Attempt to match given the given string against our set of commands</summary>
		/// <returns> the command code that was hit.
		/// </returns>
		internal virtual int determineCommand(StringIntArray cmdList, String input, int defCmd)
		{
			int cmd = defCmd;
			
			// first check for a comment
			if (input[0] == '#')
				cmd = CMD_COMMENT;
			else
			{
				//			long start = System.currentTimeMillis();
				System.Collections.ArrayList ar = cmdList.elementsStartingWith(input);
				//			long end = System.currentTimeMillis();
				
				int size = ar.Count;
				
				/*
				* 3 cases:
				*  - No hits, return unknown and let our caller
				*    dump the error.
				*  - We match unambiguously or we have 1 or more matches
				*    and the input is a single character. We then take the
				*    first hit as our command.
				*  - If we have multiple hits then we dump a 'ambiguous' message
				*    and puke quietly.
				*/
				if (size == 0)
				{
				}
				// no command match return unknown
				
				// only 1 match or our input is 1 character or first match is exact
				else if (size == 1 || input.Length == 1 || String.CompareOrdinal(cmdList.getString(((System.Int32) ar[0])), input) == 0)
				{
					cmd = (cmdList.getInteger(((System.Int32) ar[0])));
				}
				else
				{
					// matches more than one command dump message and go
					System.Text.StringBuilder sb = new System.Text.StringBuilder();
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["input"] = input; //$NON-NLS-1$
					sb.Append(LocalizationManager.getLocalizedTextString("ambiguousCommand", args)); //$NON-NLS-1$
					sb.Append(' ');
					for (int i = 0; i < size; i++)
					{
						String s = cmdList.getString(((System.Int32) ar[i]));
						sb.Append(s);
						if (i + 1 < size)
							sb.Append(", "); //$NON-NLS-1$
					}
					sb.Append('.');
					err(sb.ToString());
					throw new AmbiguousException();
				}
			}
			return cmd;
		}
		
		internal virtual String commandNumberToCommandName(StringIntArray cmdList, int cmdNumber)
		{
			for (int i = 0; i < cmdList.Count; i++)
			{
				if (cmdList.getInt(i) == cmdNumber)
					return cmdList.getString(i);
			}
			
			return "?"; //$NON-NLS-1$
		}
		
		/// <summary> The array of top level commands that we support.
		/// They are placed into a Nx2 array, whereby the first component
		/// is a String which is the command and the 2nd component is the
		/// integer identifier for the command.
		/// 
		/// The StringIntArray object provides a convenient wrapper class
		/// that implements the List interface.
		/// 
		/// NOTE: order matters!  For the case of a single character
		/// match, we let the first hit act like an unambiguous match.
		/// </summary>
		internal static StringIntArray g_commandArray = new StringIntArray(new System.Object[][]{new System.Object[]{"awatch", (System.Int32) CMD_AWATCH}, new System.Object[]{"break", (System.Int32) CMD_BREAK}, new System.Object[]{"bt", (System.Int32) INFO_STACK_CMD}, new System.Object[]{"continue", (System.Int32) CMD_CONTINUE}, new System.Object[]{"cf", (System.Int32) CMD_CF}, new System.Object[]{"clear", (System.Int32) CMD_CLEAR}, new System.Object[]{"commands", (System.Int32) CMD_COMMANDS}, new System.Object[]{"condition", (System.Int32) CMD_CONDITION}, new System.Object[]{"delete", (System.Int32) CMD_DELETE}, new System.Object[]{"disable", (System.Int32) CMD_DISABLE}, new System.Object[]{"disassemble", (System.Int32) CMD_DISASSEMBLE}, new System.Object[]{"display", (System.Int32) CMD_DISPLAY}, new System.Object[]{"directory", (System.Int32) CMD_DIRECTORY}, new System.Object[]{"down", (System.Int32) CMD_DOWN}, new System.Object[]{"enable", (System.Int32) CMD_ENABLE}, new System.Object[]{"finish", (System.Int32) CMD_FINISH}, new System.Object[]{"file", (System.Int32) CMD_FILE}, new System.Object[]{"frame", (System.Int32) CMD_FRAME}, new System.Object[]{"help", (System.Int32) CMD_HELP}, new System.Object[]{"halt", (System.Int32) CMD_HALT}, new System.Object[]{"handle", (System.Int32) CMD_HANDLE}, new System.Object[]{"home", (System.Int32) CMD_HOME}, new System.Object[]{"info", (System.Int32) CMD_INFO}, new System.Object[]{"kill", (System.Int32) CMD_KILL}, new System.Object[]{"list", (System.Int32) CMD_LIST}, new System.Object[]{"next", (System.Int32) CMD_NEXT}, new System.Object[]{"nexti", (System.Int32) CMD_NEXT}, new System.Object[]{"mctree", (System.Int32) CMD_MCTREE}, new System.Object[]{"print", (System.Int32) CMD_PRINT}, new System.Object[]{"pwd", (System.Int32) CMD_PWD}, new System.Object[]{"quit", (System.Int32) CMD_QUIT}, new System.Object[]{"run", (System.Int32) CMD_RUN}, new System.Object[]{"rwatch", (System.Int32) CMD_RWATCH}, new System.Object[]{"step", (System.Int32) CMD_STEP}, new 
			System.Object[]{"stepi", (System.Int32) CMD_STEP}, new System.Object[]{"set", (System.Int32) CMD_SET}, new System.Object[]{"show", (System.Int32) CMD_SHOW}, new System.Object[]{"source", (System.Int32) CMD_SOURCE}, new System.Object[]{"tutorial", (System.Int32) CMD_TUTORIAL}, new System.Object[]{"undisplay", (System.Int32) CMD_UNDISPLAY}, new System.Object[]{"up", (System.Int32) CMD_UP}, new System.Object[]{"where", (System.Int32) INFO_STACK_CMD}, new System.Object[]{"watch", (System.Int32) CMD_WATCH}, new System.Object[]{"what", (System.Int32) CMD_WHAT}, new System.Object[]{"viewswf", (System.Int32) CMD_VIEW_SWF}});
		
		/// <summary> Info sub-commands</summary>
		internal static StringIntArray g_infoCommandArray = new StringIntArray(new System.Object[][]{new System.Object[]{"arguments", (System.Int32) INFO_ARGS_CMD}, new System.Object[]{"breakpoints", (System.Int32) INFO_BREAK_CMD}, new System.Object[]{"display", (System.Int32) INFO_DISPLAY_CMD}, new System.Object[]{"files", (System.Int32) INFO_FILES_CMD}, new System.Object[]{"functions", (System.Int32) INFO_FUNCTIONS_CMD}, new System.Object[]{"handle", (System.Int32) INFO_HANDLE_CMD}, new System.Object[]{"locals", (System.Int32) INFO_LOCALS_CMD}, new System.Object[]{"stack", (System.Int32) INFO_STACK_CMD}, new System.Object[]{"scopechain", (System.Int32) INFO_SCOPECHAIN_CMD}, new System.Object[]{"sources", (System.Int32) INFO_SOURCES_CMD}, new System.Object[]{"swfs", (System.Int32) INFO_SWFS_CMD}, new System.Object[]{"targets", (System.Int32) INFO_TARGETS_CMD}, new System.Object[]{"variables", (System.Int32) INFO_VARIABLES_CMD}});
		
		/// <summary> Show sub-commands</summary>
		internal static StringIntArray g_showCommandArray = new StringIntArray(new System.Object[][]{new System.Object[]{"break", (System.Int32) SHOW_BREAK_CMD}, new System.Object[]{"directories", (System.Int32) SHOW_DIRS_CMD}, new System.Object[]{"files", (System.Int32) SHOW_FILES_CMD}, new System.Object[]{"functions", (System.Int32) SHOW_FUNC_CMD}, new System.Object[]{"locations", (System.Int32) SHOW_LOC_CMD}, new System.Object[]{"memory", (System.Int32) SHOW_MEM_CMD}, new System.Object[]{"net", (System.Int32) SHOW_NET_CMD}, new System.Object[]{"properties", (System.Int32) SHOW_PROPERTIES_CMD}, new System.Object[]{"uri", (System.Int32) SHOW_URI_CMD}, new System.Object[]{"variable", (System.Int32) SHOW_VAR_CMD}});
		
		/// <summary> enable sub-commands</summary>
		internal static StringIntArray g_enableCommandArray = new StringIntArray(new System.Object[][]{new System.Object[]{"breakpoints", (System.Int32) CMD_BREAK}, new System.Object[]{"display", (System.Int32) CMD_DISPLAY}, new System.Object[]{"delete", (System.Int32) CMD_DELETE}, new System.Object[]{"once", (System.Int32) ENABLE_ONCE_CMD}});
		
		/// <summary> disable sub-commands</summary>
		internal static StringIntArray g_disableCommandArray = new StringIntArray(new System.Object[][]{new System.Object[]{"display", (System.Int32) CMD_DISPLAY}, new System.Object[]{"breakpoints", (System.Int32) CMD_BREAK}});
		
		internal virtual void  populateFaultTable()
		{
			// possible actions for our fault table
			m_faultTable.addAction("stop"); //$NON-NLS-1$
			m_faultTable.addAction("print"); //$NON-NLS-1$
			
			// the faults we support
			m_faultTable.add(InvalidTargetFault.s_name);
            m_faultTable.add(RecursionLimitFault.s_name);
            m_faultTable.add(InvalidWithFault.s_name);
            m_faultTable.add(ProtoLimitFault.s_name);
            m_faultTable.add(InvalidURLFault.s_name);
            m_faultTable.add(ExceptionFault.s_name);
            m_faultTable.add(StackUnderFlowFault.s_name);
            m_faultTable.add(DivideByZeroFault.s_name);
            m_faultTable.add(ScriptTimeoutFault.s_name);
			//		m_faultTable.add(ConsoleErrorFault.name);
			
			// nice description of the faults
            m_faultTable.putDescription(InvalidTargetFault.s_name, LocalizationManager.getLocalizedTextString("invalidTargetFault")); //$NON-NLS-1$
            m_faultTable.putDescription(RecursionLimitFault.s_name, LocalizationManager.getLocalizedTextString("recursionLimitFault")); //$NON-NLS-1$
            m_faultTable.putDescription(InvalidWithFault.s_name, LocalizationManager.getLocalizedTextString("invalidWithFault")); //$NON-NLS-1$
            m_faultTable.putDescription(ProtoLimitFault.s_name, LocalizationManager.getLocalizedTextString("protoLimitFault")); //$NON-NLS-1$
            m_faultTable.putDescription(InvalidURLFault.s_name, LocalizationManager.getLocalizedTextString("invalidUrlFault")); //$NON-NLS-1$
            m_faultTable.putDescription(ExceptionFault.s_name, LocalizationManager.getLocalizedTextString("exceptionFault")); //$NON-NLS-1$
            m_faultTable.putDescription(StackUnderFlowFault.s_name, LocalizationManager.getLocalizedTextString("stackUnderflowFault")); //$NON-NLS-1$
            m_faultTable.putDescription(DivideByZeroFault.s_name, LocalizationManager.getLocalizedTextString("divideByZeroFault")); //$NON-NLS-1$
            m_faultTable.putDescription(ScriptTimeoutFault.s_name, LocalizationManager.getLocalizedTextString("scriptTimeoutFault")); //$NON-NLS-1$
			//		m_faultTable.putDescription(ConsoleErrorFault.name, "ActionScript recoverable error");
			
			// default values for the faults
            m_faultTable.action(InvalidTargetFault.s_name, "stop"); //$NON-NLS-1$
            m_faultTable.action(InvalidTargetFault.s_name, "print"); //$NON-NLS-1$
            m_faultTable.action(RecursionLimitFault.s_name, "stop"); //$NON-NLS-1$
            m_faultTable.action(RecursionLimitFault.s_name, "print"); //$NON-NLS-1$
            m_faultTable.action(InvalidWithFault.s_name, "stop"); //$NON-NLS-1$
            m_faultTable.action(InvalidWithFault.s_name, "print"); //$NON-NLS-1$
            m_faultTable.action(ProtoLimitFault.s_name, "stop"); //$NON-NLS-1$
            m_faultTable.action(ProtoLimitFault.s_name, "print"); //$NON-NLS-1$
            m_faultTable.action(InvalidURLFault.s_name, "stop"); //$NON-NLS-1$
            m_faultTable.action(InvalidURLFault.s_name, "print"); //$NON-NLS-1$
            m_faultTable.action(ExceptionFault.s_name, "stop"); //$NON-NLS-1$
            m_faultTable.action(ExceptionFault.s_name, "print"); //$NON-NLS-1$
            m_faultTable.action(StackUnderFlowFault.s_name, "stop"); //$NON-NLS-1$
            m_faultTable.action(StackUnderFlowFault.s_name, "print"); //$NON-NLS-1$
            m_faultTable.action(DivideByZeroFault.s_name, "stop"); //$NON-NLS-1$
            m_faultTable.action(DivideByZeroFault.s_name, "print"); //$NON-NLS-1$
            m_faultTable.action(ScriptTimeoutFault.s_name, "stop"); //$NON-NLS-1$
            m_faultTable.action(ScriptTimeoutFault.s_name, "print"); //$NON-NLS-1$
			//		m_faultTable.action(ConsoleErrorFault.name, "print"); //$NON-NLS-1$
			//		m_faultTable.action(ConsoleErrorFault.name, "stop"); //$NON-NLS-1$
		}
		
		/// <summary> -------------------------------------------------------------------------
		/// Any code that accesses the implementation of the API is wrapped 
		/// in Extensions.  This way one can easily factor this stuff out
		/// and build an fdb that is completely compliant to the API.
		/// 
		/// I'm pretty sure there's a better way of doing this like
		/// making Extensions a final static variable and then 
		/// toggling it between two classes Extensions and something
		/// like ExtensionsDisabled (methods with only out("not supported")
		/// in them).
		/// -------------------------------------------------------------------------
		/// </summary>
		internal virtual void  appendBreakInfo(System.Text.StringBuilder sb)
		{
			Extensions.appendBreakInfo(this, sb, false);
		}
		internal virtual void  doShowStats()
		{
			Extensions.doShowStats(this);
		}
		internal virtual void  doShowFuncs()
		{
			Extensions.doShowFuncs(this);
		}
		internal virtual void  doShowProperties()
		{
			Extensions.doShowProperties(this);
		}
		internal virtual void  doShowVariable()
		{
			Extensions.doShowVariable(this);
		}
		internal virtual void  doShowBreak()
		{
			Extensions.doShowBreak(this);
		}
		internal virtual void  doDisassemble()
		{
			Extensions.doDisassemble(this);
		}
		static DebugCLI()
		{
			/* class's static init */
			{
				// set up for localizing messages
				s_localizationManager.addLocalizer(new DebuggerLocalizer("Flex.Tools.Debugger.CLI.fdb.")); //$NON-NLS-1$
			}
		}
	}
}
