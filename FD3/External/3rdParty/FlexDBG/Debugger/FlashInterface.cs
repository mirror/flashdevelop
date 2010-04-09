/*
    Copyright (C) 2009  Robert Nelson

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/

using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using ASCompletion.Settings;
using Flash.Tools.Debugger;
using Flash.Tools.Debugger.Events;
using FlexDbg.Localization;
using PluginCore.Managers;


namespace FlexDbg
{
	public delegate void TraceEventHandler(object sender, string trace);

	public delegate void SwfLoadedEventHandler(object sender, SwfLoadedEvent e);
	public delegate void SwfUnloadedEventHandler(object sender, SwfUnloadedEvent e);

	public delegate void DebuggerEventHandler(object sender);
    public delegate void DebuggerProgressEventHandler(object sender, int current, int total);

	public class FlashInterface : IProgress
	{
		// default metadata retry count 8 attempts per waitForMetadata() call * 5 calls
		public const int METADATA_RETRIES = 8 * 5;

		public event TraceEventHandler	TraceEvent;

		//
		// Error Events
		//
		public event DebuggerEventHandler DisconnectedEvent;
		public event DebuggerEventHandler PauseFailedEvent;

		public event DebuggerEventHandler StartedEvent;

		//
		// Suspend Events
		//
		public event DebuggerEventHandler BreakpointEvent;
		public event DebuggerEventHandler FaultEvent;
		public event DebuggerEventHandler PauseEvent;
		public event DebuggerEventHandler StepEvent;
		public event DebuggerEventHandler ScriptLoadedEvent;
		public event DebuggerEventHandler WatchpointEvent;
		public event DebuggerEventHandler UnknownHaltEvent;

        public event DebuggerProgressEventHandler ProgressEvent;

		#region public properties

		public BreakPointManager m_BreakPointManager = null;

		public string outputFileFullPath
		{
			get
			{
				return m_OutputFileFullPath;
			}
			set
			{
				m_OutputFileFullPath = value;
			}
		}

		public ProjectManager.Projects.Project currentProject
		{
			get
			{
				return m_CurrentProject;
			}
			set
			{
				m_CurrentProject = value;

				if (m_CurrentProject == null)
					return;
			}
		}

		public bool isDebuggerStarted
		{
			get
			{
				return m_Session != null &&
					   m_CurrentState != DebuggerState.Initializing &&
					   m_CurrentState != DebuggerState.Stopped;
			}
		}

		public bool isDebuggerSuspended
		{
			get
			{
				return m_Session.Suspended;
			}
		}

		public int suspendReason
		{
			get
			{
				return m_Session.suspendReason();
			}
		}

		public Session Session
		{
			get
			{
				return m_Session;
			}
		}

		#endregion

		#region private properties

		private Session m_Session = null;
		private DebuggerState m_CurrentState = DebuggerState.Initializing;
		private Boolean m_RequestPause;
		private Boolean m_RequestResume;
		private Boolean m_RequestStop;
		private Boolean m_RequestDetach;

		private Boolean m_StepResume;
		private ProjectManager.Projects.Project m_CurrentProject;

		private EventWaitHandle m_SuspendWait = new EventWaitHandle(false, EventResetMode.ManualReset);

		// Global Properties
		private int m_HaltTimeout;
		private int m_UpdateDelay;

		// Session Properties
		private int m_MetadataAttemptsPeriod;	// 1/4s per attempt
		private int m_MetadataNotAvailable;		// counter for failures
		private int m_MetadataAttempts;
		private int m_PlayerFullSupport;
		private string m_OutputFileFullPath;

		#endregion

		public FlashInterface()
		{
			m_HaltTimeout = 7000;
			m_UpdateDelay = 25;
			m_CurrentState = DebuggerState.Stopped;
		}

		/// <summary>
		/// Main loop
		/// </summary>
		public void Start()
		{
			m_CurrentState = DebuggerState.Starting;

            SessionManager mgr = Bootstrap.sessionManager();

			mgr.setDebuggerCallbacks(new FlashDebuggerCallbacks());

			mgr.setPreference(SessionManager.PREF_GETVAR_RESPONSE_TIMEOUT, 5000);

			m_RequestDetach = false;

			mgr.startListening();
            FlexDbgTrace.TraceInfo("startListening");
            
            try
            {
                m_Session = mgr.accept(this);

                FlexDbgTrace.TraceInfo("FlexDbg.START");
                TraceManager.AddAsync("[Starting debug session with FDB]", -1);

                if (m_Session == null)
                {
                    m_CurrentState = DebuggerState.Stopped;

                    throw new Exception("Unable to start Flex SDK interactive debugger.");
                }

                initSession();

                m_CurrentState = DebuggerState.Running;

                if (StartedEvent != null)
                {
                    StartedEvent(this);
                }

                try
                {
                    waitTilHalted();
                }
                catch (System.Exception)
                {
                }

                try
                {
                    waitForMetaData();
                }
                catch (System.Exception)
                {
                }

                m_CurrentState = DebuggerState.Running;

                // now poke to see if the player is good enough
                try
                {
                    if (m_Session.getPreference(SessionManager.PLAYER_SUPPORTS_GET) == 0)
                    {
                        TraceManager.AddAsync(TextHelper.GetString("warningNotAllCommandsSupported"));
                    }
                }
                catch (System.Exception)
                {
                }

                bool stop = false;

                while (!stop)
                {
                    processEvents();

                    // not there, not connected
                    if (m_RequestStop || m_RequestDetach || !haveConnection())
                    {
                        FlexDbgTrace.TraceInfo("Stopping due to request or lost connection, m_RequestStop = " + m_RequestStop);
                        stop = true;
                        continue;
                    }

                    if (m_RequestResume)
                    {
                        // resume execution (request fulfilled)
                        try
                        {
                            if (m_StepResume)
                            {
                                m_Session.stepContinue();
                            }
                            else
                            {
                                m_Session.resume();
                            }
                        }
                        catch (NotSuspendedException)
                        {
                            TraceManager.AddAsync(TextHelper.GetString("playerAlreadyRunning"));
                        }

                        m_RequestResume = false;
                        m_RequestPause = false;
                        m_StepResume = false;
                        m_CurrentState = DebuggerState.Running;

                        continue;
                    }

                    if (m_Session.Suspended)
                    {
                        /*
                        * We have stopped for some reason. 
                        */

                        /*
                        * Now before we do this see, if we have a valid break reason, since
                        * we could be still receiving incoming messages, even though we have halted.
                        * This is definately the case with loading of multiple SWFs.  After the load
                        * we get info on the swf.
                        */
                        int tries = 3;
                        while (tries-- > 0 && m_Session.suspendReason() == SuspendReason.Unknown)
                        {
                            try
                            {
                                System.Threading.Thread.Sleep(100);
                                processEvents();
                            }
                            catch (System.Threading.ThreadInterruptedException)
                            {
                            }
                        }

                        m_SuspendWait.Reset();

                        switch (suspendReason)
                        {
                            case SuspendReason.Breakpoint:
                                m_CurrentState = DebuggerState.BreakHalt;
                                if (BreakpointEvent != null)
                                {
                                    BreakpointEvent(this);
                                }
                                else
                                {
                                    m_RequestResume = true;
                                }
                                break;

                            case SuspendReason.Fault:
                                m_CurrentState = DebuggerState.ExceptionHalt;
                                if (FaultEvent != null)
                                {
                                    FaultEvent(this);
                                }
                                else
                                {
                                    m_RequestResume = true;
                                }
                                break;

                            case SuspendReason.ScriptLoaded:
                                waitForMetaData();
                                m_CurrentState = DebuggerState.PauseHalt;
                                if (ScriptLoadedEvent != null)
                                {
                                    ScriptLoadedEvent(this);
                                }
                                else
                                {
                                    m_RequestResume = true;
                                }
                                break;

                            case SuspendReason.Step:
                                m_CurrentState = DebuggerState.BreakHalt;
                                if (StepEvent != null)
                                {
                                    StepEvent(this);
                                }
                                else
                                {
                                    m_RequestResume = true;
                                }
                                break;

                            case SuspendReason.StopRequest:
                                m_CurrentState = DebuggerState.PauseHalt;
                                if (PauseEvent != null)
                                {
                                    PauseEvent(this);
                                }
                                else
                                {
                                    m_RequestResume = true;
                                }
                                break;

                            case SuspendReason.Watch:
                                m_CurrentState = DebuggerState.BreakHalt;
                                if (WatchpointEvent != null)
                                {
                                    WatchpointEvent(this);
                                }
                                else
                                {
                                    m_RequestResume = true;
                                }
                                break;

                            default:
                                m_CurrentState = DebuggerState.BreakHalt;
                                if (UnknownHaltEvent != null)
                                {
                                    UnknownHaltEvent(this);
                                }
                                else
                                {
                                    m_RequestResume = true;
                                }
                                break;
                        }

                        if (!(m_RequestResume || m_RequestDetach))
                        {
                            m_SuspendWait.WaitOne();
                        }
                    }
                    else
                    {
                        if (m_RequestPause)
                        {
                            try
                            {
                                m_CurrentState = DebuggerState.Pausing;
                                m_Session.suspend();

                                // no connection => dump state and end
                                if (!haveConnection())
                                {
                                    stop = true;
                                    continue;
                                }
                                else if (!m_Session.Suspended)
                                {
                                    TraceManager.AddAsync(TextHelper.GetString("couldNotHalt"));
                                    m_CurrentState = DebuggerState.Running;

                                    if (PauseFailedEvent != null)
                                    {
                                        PauseFailedEvent(this);
                                    }
                                }
                            }
                            catch (ArgumentException)
                            {
                                TraceManager.AddAsync(TextHelper.GetString("escapingFromDebuggerPendingLoop"));
                                stop = true;
                            }
                            catch (IOException io)
                            {
                                System.Collections.IDictionary args = new System.Collections.Hashtable();
                                args["error"] = io.Message; //$NON-NLS-1$
                                TraceManager.AddAsync(replaceInlineReferences(TextHelper.GetString("continuingDueToError"), args));
                            }
                            catch (SuspendedException)
                            {
                                // lucky us, already paused
                            }
                        }
                    }

                    // sleep for a bit, then process our events.
                    try
                    {
                        System.Threading.Thread.Sleep(m_UpdateDelay);
                    }
                    catch (System.Threading.ThreadInterruptedException)
                    {
                    }
                }
                FlexDbgTrace.TraceInfo("loop end");

            }
            finally
            {
                if (DisconnectedEvent != null)
                {
                    DisconnectedEvent(this);
                }
                exitSession();
            }
		}

		internal virtual void initSession()
		{
			bool correctVersion = true;
			try
			{
				m_Session.bind();
			}
			catch (VersionException)
			{
				correctVersion = false;
			}

			// reset session properties
			m_MetadataAttemptsPeriod = 250;					// 1/4s per attempt
			m_MetadataNotAvailable = 0;						// counter for failures
			m_MetadataAttempts = METADATA_RETRIES;
			m_PlayerFullSupport = correctVersion ? 1 : 0;

			m_RequestStop = false;
			m_RequestPause = false;
			m_RequestResume = false;
			m_StepResume = false;
		}

		/// <summary> If we still have a socket try to send an exit message
		/// Doesn't seem to work ?!?
		/// </summary>
		internal virtual void exitSession()
		{
            // clear out our watchpoint list and displays
			// keep breakpoints around so that we can try to reapply them if we reconnect
			if (m_Session != null)
			{
				if (m_RequestDetach)
				{
					m_Session.unbind();
				}
				else
				{
					m_Session.terminate();
				}

				m_Session = null;
			}
            SessionManager mgr = Bootstrap.sessionManager();
            if (mgr.Listening) mgr.stopListening();
            m_CurrentState = DebuggerState.Stopped;
        }

		internal virtual void Detach()
		{
			m_RequestDetach = true;
			m_SuspendWait.Set();
		}

		private bool haveConnection()
		{
			return m_Session != null && m_Session.Connected;
		}

#if false
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
			else if ((path.IndexOf("\\mx\\") > -1) || (path.IndexOf("/mx/") > -1) || name.Equals("frameworks.as"))
				//$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
				return FRAMEWORK_FILE;
			else if (name.StartsWith("Actions for"))
				//$NON-NLS-1$
				return ACTIONS_FILE;
			else
				return AUTHORED_FILE;
		}
#endif

		private void waitForMetaData()
		{
			// perform a query to see if our metadata has loaded
			int metadatatries = m_MetadataAttempts;
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
					m_MetadataAttempts = remain;
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
			int period = m_MetadataAttemptsPeriod;
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

		/// <summary> Ask each swf if metadata processing is complete</summary>
		virtual public bool MetaDataAvailable
		{
			get
			{
				bool allLoaded = true;
				try
				{
					// we need to ask the session since our fileinfocache will hide the exception
					SwfInfo[] swfs = m_Session.Swfs;
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
					m_MetadataNotAvailable++;
				}
				else
				{
					// success so we reset our attempt counter
					m_MetadataAttempts = METADATA_RETRIES;
				}
				return allLoaded;
			}
		}

		/// <summary> Process the incoming debug event queue</summary>
		internal virtual void processEvents()
		{
			while (m_Session != null && m_Session.EventCount > 0)
			{
				DebugEvent e = m_Session.nextEvent();

				if (e is TraceEvent)
				{
					dumpTraceLine(e.information);

					if (TraceEvent != null)
					{
						TraceEvent(this, e.information);
					}
				}
				else if (e is SwfLoadedEvent)
				{
					dumpSwfLoadedEvent((SwfLoadedEvent)e);
				}
				else if (e is SwfUnloadedEvent)
				{
					dumpSwfUnloadedEvent((SwfUnloadedEvent)e);
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
					dumpFaultLine((FaultEvent)e);
				}
				else
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["type"] = e; //$NON-NLS-1$
					args["info"] = e.information; //$NON-NLS-1$
					TraceManager.AddAsync(replaceInlineReferences(TextHelper.GetString("unknownEvent"), args));
				}
			}
		}

		// wait a little bit of time until the player halts, if not throw an exception!
		internal virtual void waitTilHalted()
		{
			if (!haveConnection())
				throw new System.InvalidOperationException();

			// spin for a while waiting for a halt; updating trace messages as we get them
			waitForSuspend(m_HaltTimeout, m_UpdateDelay);

			if (!m_Session.Suspended)
			{
				throw new System.Threading.SynchronizationLockException();
			}
		}

		/// <summary> We spin in this spot until the player reaches the
		/// requested suspend state, either true or false.
		/// 
		/// During this time we wake up every period milliseconds
		/// and update the display and our state with information
		/// received from the debug event queue.
		/// </summary>
		internal virtual void waitForSuspend(int timeout, int period)
		{
			while (timeout > 0)
			{
				// dump our events to the console while we are waiting.
				processEvents();

				if (m_Session.Suspended)
				{
					break;
				}

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

		// pretty print a trace statement to the console
		internal virtual void dumpTraceLine(String s)
		{
			TraceManager.AddAsync(s, 1);
		}

		// pretty print a fault statement to the console
		internal virtual void dumpFaultLine(FaultEvent e)
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();

			// use a slightly different format for ConsoleErrorFaults
			if (e is ConsoleErrorFault)
			{
				sb.Append(TextHelper.GetString("linePrefixWhenDisplayingConsoleError")); //$NON-NLS-1$
				sb.Append(' ');
				sb.Append(e.information);
			}
			else
			{
				String name = e.name();
				sb.Append(TextHelper.GetString("linePrefixWhenDisplayingFault")); //$NON-NLS-1$
				sb.Append(' ');
				sb.Append(name);
				if (e.information != null && e.information.Length > 0)
				{
					sb.Append(TextHelper.GetString("informationAboutFault")); //$NON-NLS-1$
					sb.Append(e.information);
				}
			}
			TraceManager.AddAsync(sb.ToString(), 3);
		}

		/// <summary> Called when a swf has been loaded by the player</summary>
		/// <param name="e">event documenting the load
		/// </param>
		internal virtual void dumpSwfLoadedEvent(SwfLoadedEvent e)
		{
			// now rip off any trailing ? options
			int at = e.path.LastIndexOf('?');
			String name = (at > -1) ? e.path.Substring(0, (at) - (0)) : e.path;

			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			sb.Append(TextHelper.GetString("linePrefixWhenSwfLoaded"));
			sb.Append(' ');
			sb.Append(name);
			sb.Append(" - "); //$NON-NLS-1$

			System.Collections.IDictionary args = new System.Collections.Hashtable();
			args["size"] = e.swfSize.ToString("N0"); //$NON-NLS-1$
			sb.Append(replaceInlineReferences(TextHelper.GetString("sizeAfterDecompression"), args));
			TraceManager.AddAsync(sb.ToString());
		}

		/// <summary> Perform the tasks need for when a swf is unloaded
		/// the player
		/// </summary>
		internal virtual void dumpSwfUnloadedEvent(SwfUnloadedEvent e)
		{
			// now rip off any trailing ? options
			int at = e.path.LastIndexOf('?');
			String name = (at > -1) ? e.path.Substring(0, (at) - (0)) : e.path;

			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			sb.Append(TextHelper.GetString("linePrefixWhenSwfUnloaded")); //$NON-NLS-1$
			sb.Append(' ');
			sb.Append(name);
			TraceManager.AddAsync(sb.ToString());
		}

#if false
		internal virtual void dumpBreakLine(bool postStep, System.Text.StringBuilder sb)
		{
			int bp = -1;
			String name = Resource.unknownFilename; //$NON-NLS-1$
			int line = -1;

			/* dump a context line to the console */
			Location l = getCurrentLocation();

			// figure out why we stopped
			int reason = SuspendReason.Unknown;
			try
			{
				reason = m_Session.suspendReason();
			}
			catch (PlayerDebugException)
			{
			}

			// then see if it because of a swfloaded event
			if (reason == SuspendReason.ScriptLoaded)
			{
				try
				{
					waitForMetaData(80);
				}
				catch (InProgressException)
				{
				}

				//m_fileInfo.setDirty();
				processEvents();
				//propagateBreakpoints();

				sb.Append(Resource.additionalCodeLoaded); //$NON-NLS-1$
				sb.Append(System.Environment.NewLine);
			}
			else if (l == null || l.File == null)
			{
				// no idea where we are ?!?
				sb.Append(Resource.executionHalted);
				sb.Append(' ');

				/** disable this line (and enable the one after) if implementation Extensions are not provided */
				appendBreakInfo(sb);
				//sb.append("unknown location");
			}
			else
			{
				SourceFile file = l.File;
				name = file.Name;
				line = l.Line;
				String funcName = file.getFunctionNameForLine(m_Session, line);

				int thisModule = file.Id;

				// is it a fault?
				String reasonForHalting;
				if (reason == SuspendReason.Fault || reason == SuspendReason.StopRequest)
				{
					System.Text.StringBuilder s = new System.Text.StringBuilder();
					appendReason(s, reason);
					reasonForHalting = s.ToString();
				}
				// if its a breakpoint add that information
				else if ((bp = enabledBreakpointIndexOf(l)) > -1)
				{
					System.Collections.IDictionary args = new System.Collections.Hashtable();
					args["breakpointNumber"] = System.Convert.ToString(breakpointAt(bp).Id);
					reasonForHalting = replaceInlineReferences(Resource.hitBreakpoint, args);
				}
				else
				{
					reasonForHalting = Resource.executionHalted; //$NON-NLS-1$
				}

				System.Collections.IDictionary args2 = new System.Collections.Hashtable();
				args2["reasonForHalting"] = reasonForHalting; //$NON-NLS-1$
				args2["fileAndLine"] = name + ':' + line; //$NON-NLS-1$
				String formatString;
				if (funcName != null)
				{
					args2["functionName"] = funcName; //$NON-NLS-1$
					formatString = Resource.haltedInFunction;
				}
				else
				{
					formatString = Resource.haltedInFile;
				}
				sb.Append(replaceInlineReferences(formatString, args2));
				sb.Append(System.Environment.NewLine);

				// set current listing poistion and emit emacs trigger
				//setListingPosition(thisModule, line);

				// dump our source line if not in emacs mode
				//appendSource(sb, file.Id, line, file.getLine(line), false);
			}
		}

		public virtual void appendReason(System.Text.StringBuilder sb, int reason)
		{
			switch (reason)
			{
				case SuspendReason.Unknown:
					sb.Append(TextHelper.GetString("suspendReason_Unknown"));
					break;

				case SuspendReason.Breakpoint:
					sb.Append(TextHelper.GetString("suspendReason_HitBreakpoint"));
					break;

				case SuspendReason.Watch:
					sb.Append(TextHelper.GetString("suspendReason_HitWatchpoint"));
					break;

				case SuspendReason.Fault:
					sb.Append(TextHelper.GetString("suspendReason_ProgramThrewException"));
					break;

				case SuspendReason.StopRequest:
					sb.Append(TextHelper.GetString("suspendReason_StopRequest"));
					break;

				case SuspendReason.Step:
					sb.Append(TextHelper.GetString("suspendReason_ProgramFinishedStepping"));
					break;

				case SuspendReason.HaltOpcode:
					sb.Append(TextHelper.GetString("suspendReason_HaltOpcode"));
					break;

				case SuspendReason.ScriptLoaded:
					sb.Append(TextHelper.GetString("suspendReason_ScriptHasLoadedIntoFlashPlayer"));
					break;
			}
		}
#endif

		internal virtual Location getCurrentLocation()
		{
			Location where = null;
			try
			{
				Frame[] frames = m_Session.Frames;

				where = frames.Length > 0 ? frames[0].Location : null;
			}
			catch (PlayerDebugException)
			{
				// where == null
			}

			return where;
		}

		public void Stop()
		{
			m_RequestStop = true;
			m_SuspendWait.Set();
		}

		public void Cleanup()
		{
			if (isDebuggerStarted)
			{
				Stop();
			}
		}

		public void Next()
		{
			if (m_Session.Suspended)
			{
				m_Session.stepOver();
				m_SuspendWait.Set();
			}
		}

		public void Step()
		{
			if (m_Session.Suspended)
			{
				m_Session.stepInto();
				m_SuspendWait.Set();
			}
		}

		public void StepResume()
		{
			if (m_Session.Suspended)
			{
				m_StepResume = true;
				m_RequestResume = true;
				m_SuspendWait.Set();
			}
		}

		public void Continue()
		{
			if (m_Session.Suspended)
			{
				m_RequestResume = true;
				m_SuspendWait.Set();
			}
		}

		public void Pause()
		{
			if (!m_Session.Suspended)
			{
				m_RequestPause = true;
			}
		}

		public void Finish()
		{
			if (m_Session.Suspended)
			{
				m_Session.stepOut();
				m_SuspendWait.Set();
			}
		}

		public Frame[] GetFrames()
		{
			return m_Session.Frames;
		}

		public Variable[] GetArgs(int frameNumber)
		{
			return m_Session.Frames[frameNumber].getArguments(m_Session);
		}

		public Variable GetThis(int frameNumber)
		{
			return m_Session.Frames[frameNumber].getThis(m_Session);
		}

		public Variable[] GetLocals(int frameNumber)
		{
			return m_Session.Frames[frameNumber].getLocals(m_Session);
		}

		public Value GetValue(int idValue)
		{
			return m_Session.getValue(idValue);
		}

		public void UpdateBreakpoints(List<BreakPointInfo> breakpoints)
		{
			Dictionary<string, int> files = new Dictionary<string, int>();

			foreach (BreakPointInfo bp in breakpoints)
			{
				if (bp.Location == null)
				{
					if (!bp.IsDeleted && bp.IsEnabled)
					{
						if (!files.ContainsKey(bp.FileFullPath))
						{
							files.Add(bp.FileFullPath, 0);
						}
					}
				}
			}

			int nFiles = files.Count;

			if (nFiles > 0)
			{
				foreach (SwfInfo swf in m_Session.Swfs)
				{
					foreach (SourceFile src in swf.getSourceList(m_Session))
					{
						String localPath = PluginMain.debugManager.GetLocalPath(src);

						if (localPath != null && files.ContainsKey(localPath) && files[localPath] == 0)
						{
							files[localPath] = src.Id;
							nFiles--;

							if (nFiles == 0)
							{
								break;
							}
						}
					}

					if (nFiles == 0)
					{
						break;
					}
				}
			}

			foreach (BreakPointInfo bp in breakpoints)
			{
				if (bp.Location == null)
				{
					if (bp.IsEnabled && !bp.IsDeleted)
					{
						if (files.ContainsKey(bp.FileFullPath) && files[bp.FileFullPath] != 0)
						{
							bp.Location = m_Session.setBreakpoint(files[bp.FileFullPath], bp.Line + 1);
						}
					}
				}
				else
				{
					if (bp.IsDeleted || !bp.IsEnabled)
					{
						m_Session.clearBreakpoint(bp.Location);
						bp.Location = null;
					}
				}
			}
		}

		private static String replaceInlineReferences(String text, System.Collections.IDictionary parameters)
		{
			if (parameters == null)
				return text;

			int depth = 100;
			while (depth-- > 0)
			{
				int o = text.IndexOf("${");
				if (o == -1)
					break;
				if ((o >= 1) && (text[o - 1] == '$'))
				{
					o = text.IndexOf("${", o + 2);
					if (o == -1)
						break;
				}

				int c = text.IndexOf("}", o);

				if (c == -1)
				{
					return null; // FIXME
				}
				String name = text.Substring(o + 2, (c) - (o + 2));
				String value = null;
				if (parameters.Contains(name) && (parameters[name] != null))
				{
					value = parameters[name].ToString();
				}

				if (value == null)
				{
					value = "";
				}
				text = text.Substring(0, (o) - (0)) + value + text.Substring(c + 1);
			}
			return text.Replace("$${", "${");
		}

        #region IProgress Members

        public void setProgress(int current, int total)
        {
            if (ProgressEvent != null)
            {
                ProgressEvent(this, current, total);
            }
        }

        #endregion
    }
}
