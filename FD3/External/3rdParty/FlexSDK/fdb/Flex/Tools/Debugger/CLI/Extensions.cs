////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2004-2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
using System;
using System.IO;
using Flash.Tools.Debugger;
using Flash.Tools.Debugger.Concrete;
using ActionList = Flash.Swf.Types.ActionList;
using ActionLocation = Flash.Tools.ActionLocation;
using Disassembler = Flash.Swf.tools.Disassembler;
using FieldFormat = Flash.Util.FieldFormat;
using LocalizationManager = Flash.Localization.LocalizationManager;

namespace Flex.Tools.Debugger.CLI
{
	/// <summary> Extensions class is a singleton that contains
	/// every cli method that does not conform to the 
	/// API.  Thus we can easily remove these features
	/// from the cli if the implementation does not
	/// support these calls.
	/// </summary>
	public class Extensions
	{
		private static LocalizationManager LocalizationManager
		{
			get
			{
				return DebugCLI.LocalizationManager;
			}
			
		}
		public static readonly String m_newline = Environment.NewLine; //$NON-NLS-1$
		
		public static void doShowStats(DebugCLI cli)
		{
			/* we do some magic casting */
			Session session = cli.Session;
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			try
			{
				PlayerSession p = (PlayerSession) session;
				DMessageCounter cnt = p.MessageCounter;
				
				sb.Append(LocalizationManager.getLocalizedTextString("key16")); //$NON-NLS-1$
				sb.Append(m_newline);
				for (int i = 0; i <= DMessage.InSIZE; i++)
				{
					long amt = cnt.getInCount(i);
					if (amt > 0)
					{
						sb.Append('\n');
						sb.Append(DMessage.inTypeName(i));
						sb.Append(" = "); //$NON-NLS-1$
						sb.Append(amt);
					}
				}
				
				sb.Append("\n\n"); //$NON-NLS-1$
				sb.Append(LocalizationManager.getLocalizedTextString("key17")); //$NON-NLS-1$
				sb.Append("\n"); //$NON-NLS-1$
				for (int i = 0; i <= DMessage.OutSIZE; i++)
				{
					long amt = cnt.getOutCount(i);
					if (amt > 0)
					{
						sb.Append('\n');
						sb.Append(DMessage.outTypeName(i));
						sb.Append(" = "); //$NON-NLS-1$
						sb.Append(amt);
					}
				}
				
				sb.Append('\n');
				cli.output(sb.ToString());
			}
			catch (NullReferenceException)
			{
				throw new InvalidOperationException();
			}
		}
		
		public static void  doShowFuncs(DebugCLI cli)
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			
			String arg = null;
			FileInfoCache fileInfo = cli.FileCache;
			
			// we take an optional single arg which specifies a module
			try
			{
				// let's wait a bit for the background load to complete
				cli.waitForMetaData();
				
				if (cli.hasMoreTokens())
				{
					arg = cli.nextToken();
					int id = arg.Equals(".")?cli.propertyGet(DebugCLI.LIST_MODULE):cli.parseFileArg(- 1, arg); //$NON-NLS-1$
					
					DModule m = (DModule) fileInfo.getFile(id);
					m.lineMapping(sb);
				}
				else
				{
					SourceFile[] ar = fileInfo.FileList;
					if (ar == null)
						cli.err(LocalizationManager.getLocalizedTextString("key18"));
					//$NON-NLS-1$
					else
					{
						for (int i = 0; ar != null && i < ar.Length; i++)
						{
							DModule m = (DModule) ar[i];
							m.lineMapping(sb);
						}
					}
				}
				
				cli.output(sb.ToString());
			}
			catch (NullReferenceException)
			{
				cli.err(LocalizationManager.getLocalizedTextString("key19")); //$NON-NLS-1$
			}
			catch (FormatException pe)
			{
				cli.err(pe.Message);
			}
			catch (AmbiguousException ae)
			{
				cli.err(ae.Message);
			}
			catch (NoMatchException nme)
			{
				cli.err(nme.Message);
			}
			catch (InProgressException)
			{
				cli.err(LocalizationManager.getLocalizedTextString("key20")); //$NON-NLS-1$
			}
		}
		
		/// <summary> Dump the content of internal variables</summary>
		public static void  doShowProperties(DebugCLI cli)
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			
			Session session = cli.Session;
            foreach (String key in cli.propertyKeys())
            {
				int value = cli.propertyGet(key);
				sb.Append(key);
				sb.Append(" = "); //$NON-NLS-1$
				sb.Append(value);
				sb.Append('\n');
			}
			
			// session manager
			{
				PlayerSessionManager mgr = (PlayerSessionManager) Bootstrap.sessionManager();
				sb.Append(LocalizationManager.getLocalizedTextString("key21")); //$NON-NLS-1$
				sb.Append('\n');
                foreach (String key in mgr.keySet())
				{
					Object value = mgr.getPreferenceAsObject(key);
					sb.Append(key);
					sb.Append(" = "); //$NON-NLS-1$
					sb.Append(value);
					sb.Append('\n');
				}
			}
			
			if (session != null)
			{
				PlayerSession psession = (PlayerSession) session;
				sb.Append(LocalizationManager.getLocalizedTextString("key22")); //$NON-NLS-1$
				sb.Append('\n');
                foreach (String key in psession.keySet())
                {
					Object value = psession.getPreferenceAsObject(key);
					sb.Append(key);
					sb.Append(" = "); //$NON-NLS-1$
					sb.Append(value);
					sb.Append('\n');
				}
			}
			
			cli.output(sb.ToString());
		}
		
		/// <summary> Dump the break reason and offset</summary>
		public static void  doShowBreak(DebugCLI cli)
		{
			cli.waitTilHalted();
			try
			{
				Session session = cli.Session;
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				if (session.Suspended)
				{
					sb.Append(LocalizationManager.getLocalizedTextString("stopped")); //$NON-NLS-1$
					sb.Append(' ');
					appendBreakInfo(cli, sb, true);
				}
				else
					sb.Append(LocalizationManager.getLocalizedTextString("key24")); //$NON-NLS-1$
				
				cli.output(sb.ToString());
			}
			catch (NullReferenceException)
			{
				cli.err(LocalizationManager.getLocalizedTextString("key25")); //$NON-NLS-1$
			}
		}
		
		// Extended low level break information
		public static void  appendBreakInfo(DebugCLI cli, System.Text.StringBuilder sb, bool includeFault)
		{
			Session session = cli.Session;
			FileInfoCache fileInfo = cli.FileCache;
			
			int reason = session.suspendReason();
			int offset = ((PlayerSession) session).SuspendOffset;
			int index = ((PlayerSession) session).SuspendActionIndex;
			
			SwfInfo info = null;
			try
			{
				info = fileInfo.Swfs[index];
			}
			catch (IndexOutOfRangeException)
			{
			}
			if (info != null)
			{
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["swfName"] = FileInfoCache.nameOfSwf(info); //$NON-NLS-1$
				sb.Append(LocalizationManager.getLocalizedTextString("key35", args)); //$NON-NLS-1$
				sb.Append(' ');
			}
			
			System.Collections.IDictionary args2 = new System.Collections.Hashtable();
            System.Text.StringBuilder sb2 = new System.Text.StringBuilder();
			args2["address"] = "0x" + FieldFormat.formatLongToHex(sb2, offset, 8) + " (" + offset + ")"; //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$
			sb.Append(LocalizationManager.getLocalizedTextString("atAddress", args2)); //$NON-NLS-1$
			
			if (includeFault)
			{
				args2 = new System.Collections.Hashtable();
				System.Text.StringBuilder reasonBuffer = new System.Text.StringBuilder();
				cli.appendReason(reasonBuffer, reason);
				args2["fault"] = reasonBuffer.ToString(); //$NON-NLS-1$
				sb.Append(' ');
				sb.Append(LocalizationManager.getLocalizedTextString("haltedDueToFault", args2)); //$NON-NLS-1$
			}
		}
		
		// Raw direct call to Player
		public static void  doShowVariable(DebugCLI cli)
		{
			cli.waitTilHalted();
			try
			{
				// an integer followed by a variable name
				Session session = cli.Session;
				int id = cli.nextIntToken();
				String name = (cli.hasMoreTokens())?cli.nextToken():null;
				
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				sb.Append(name);
				sb.Append(" = "); //$NON-NLS-1$
				Value v = ((PlayerSession) session).getValue(id, name);
				ExpressionCache.appendVariableValue(sb, v);
				cli.output(sb.ToString());
			}
			catch (NullReferenceException)
			{
				cli.err(LocalizationManager.getLocalizedTextString("key26")); //$NON-NLS-1$
			}
		}
		
		public static void  doDisassemble(DebugCLI cli)
		{
			/* currentXXX may NOT be invalid! */
			int currentModule = cli.propertyGet(DebugCLI.LIST_MODULE);
			int currentLine = cli.propertyGet(DebugCLI.LIST_LINE);
			
			String arg1 = null;
			int module1 = currentModule;
			int line1 = currentLine;
			
			String arg2 = null;
			int line2 = currentLine;
			
			bool functionNamed = false;
			int numLines = 0;
			try
			{
				FileInfoCache fileInfo = cli.FileCache;
				Session session = cli.Session;
				if (cli.hasMoreTokens())
				{
					arg1 = cli.nextToken();
					if (arg1.Equals("-"))
					//$NON-NLS-1$
					{
						// move back one line
						line1 = line2 = line1 - 1;
					}
					else
					{
						int[] result = cli.parseLocationArg(currentModule, currentLine, arg1);
						module1 = result[0];
						line2 = line1 = result[1];
						functionNamed = (result[2] == 0)?false:true;
						
						if (cli.hasMoreTokens())
						{
							arg2 = cli.nextToken();
							line2 = cli.parseLineArg(module1, arg2);
						}
					}
				}
				else
				{
					// since no parms test for valid location if none use players concept of where we stopped
					if (fileInfo.getFile(currentModule) == null)
					{
						//here we simply use the players concept of suspsend
						DSuspendInfo info = ((PlayerSession) session).SuspendInfo;
						int at = info.Offset;
						int which = info.ActionIndex;
						int until = info.NextOffset;
						if (info.Reason == SuspendReason.Unknown)
							throw new SuspendedException();
						
						SwfInfo swf = fileInfo.Swfs[which];
						outputAssembly(cli, (DSwfInfo) swf, at, until);
						throw new AmbiguousException(LocalizationManager.getLocalizedTextString("key27")); //$NON-NLS-1$
					}
				}
				
				/*
				* Check for a few error conditions, otherwise we'll write a listing!
				*/
				if (cli.hasMoreTokens())
				{
					cli.err(LocalizationManager.getLocalizedTextString("key28")); //$NON-NLS-1$
				}
				else
				{
					SourceFile file = fileInfo.getFile(module1);
					numLines = file.LineCount;
					
					// pressing return is ok, otherwise throw the exception
					if (line1 > numLines && arg1 != null)
						throw new IndexOutOfRangeException();
					
					/* if no arg2 then user list a single line */
					if (arg2 == null)
						line2 = line1;
					
					/* adjust our range of lines to ensure we conform */
					if (line1 < 1)
					{
						/* shrink line 1, grow line2 */
						line2 += - (line1 - 1);
						line1 = 1;
					}
					
					if (line2 > numLines)
						line2 = numLines;
					
					//			    System.out.println("1="+module1+":"+line1+",2="+module2+":"+line2+",num="+numLines+",half="+half);
					
					/* nothing to display */
					if (line1 > line2)
						throw new IndexOutOfRangeException();
					
					/* now dump the mixed source / assembly */
					// now lets find which swf this in 
					DSwfInfo swf = (DSwfInfo) fileInfo.swfForFile(file);
					ActionLocation lStart = null;
					ActionLocation lEnd = null;
					
					if (swf == null)
					{
						System.Collections.IDictionary args = new System.Collections.Hashtable();
						args["arg3"] = file.Name; //$NON-NLS-1$
						cli.err(LocalizationManager.getLocalizedTextString("key29", args)); //$NON-NLS-1$
					}
					else if (functionNamed)
					{
						// if we name a function just dump the whole thing without source.
						int offset = file.getOffsetForLine(line1);
						lStart = swf.locate(offset);
						if (lStart.function == null)
							cli.err(LocalizationManager.getLocalizedTextString("key30"));
						//$NON-NLS-1$
						else
						{
							// create a psudeo action list from which to disasemble the function
							ActionList al = new ActionList(true);
							al.setActionOffset(0, lStart.function);
							lStart.actions = al;
							lStart.at = 0;
							lEnd = new ActionLocation();
							lEnd.actions = al;
							lEnd.at = 0;
							outputAssembly(cli, swf, lStart, lEnd);
						}
					}
					else
					{
						ActionLocation lastEnd = null;
						for (int i = line1; i <= line2; i++)
						{
							int offset = file.getOffsetForLine(i);
							
							// locate the action list associated with this of the swf
							if (offset != 0)
							{
								// get the starting point and try to locate a nice ending
								lStart = swf.locate(offset);
								lEnd = swf.locateSourceLineEnd(lStart);
								
								// now see if we skipped some assembly between source lines
								if (lastEnd != null)
								{
									lastEnd.at++; // point our pseudo start to the next action
									
									// new actions list so attempt to find the end of source in the old actions list
									if (lastEnd.actions != lStart.actions && lastEnd.actions.size() != lastEnd.at)
									{
                                        String atString = lastEnd.actions.getOffset(lastEnd.at).ToString("X");
										System.Collections.IDictionary args = new System.Collections.Hashtable();
										args["arg4"] = atString; //$NON-NLS-1$
										cli.output(LocalizationManager.getLocalizedTextString("key31", args)); //$NON-NLS-1$
										
										// we are missing some of the dissassembly, so back up a bit and dump it out
										ActionLocation gapEnd = swf.locateSourceLineEnd(lastEnd);
										outputAssembly(cli, swf, lastEnd, gapEnd);
									}
									else if (lastEnd.at < lStart.at)
									{
										// same action list but we skipped some instructions 
										ActionLocation gapEnd = new ActionLocation(lStart);
										gapEnd.at--;
										outputAssembly(cli, swf, lastEnd, gapEnd);
									}
								}
								lastEnd = lEnd;
							}
							
							// dump source
							cli.outputSource(module1, i, file.getLine(i));
							
							// obtain the offset, locate it in the swf
							if (offset != 0)
								outputAssembly(cli, swf, lStart, lEnd);
						}
						
						/* save away valid context */
						cli.propertyPut(DebugCLI.LIST_MODULE, module1);
						cli.propertyPut(DebugCLI.LIST_LINE, line2 + 1); // add one
						cli.m_repeatLine = "disassemble"; /* allow repeated listing by typing CR */ //$NON-NLS-1$
					}
				}
			}
			catch (IndexOutOfRangeException)
			{
				String name = "#" + module1; //$NON-NLS-1$
				System.Collections.IDictionary args = new System.Collections.Hashtable();
				args["arg5"] = Convert.ToString(line1); //$NON-NLS-1$
				args["arg6"] = name; //$NON-NLS-1$
				args["arg7"] = Convert.ToString(numLines); //$NON-NLS-1$
				cli.err(LocalizationManager.getLocalizedTextString("key32", args)); //$NON-NLS-1$
			}
			catch (AmbiguousException ae)
			{
				cli.err(ae.Message);
			}
			catch (NullReferenceException)
			{
				cli.err(LocalizationManager.getLocalizedTextString("key33")); //$NON-NLS-1$
			}
			catch (FormatException pe)
			{
				cli.err(pe.Message);
			}
			catch (NoMatchException nme)
			{
				cli.err(nme.Message);
			}
			catch (SuspendedException)
			{
				cli.err(LocalizationManager.getLocalizedTextString("key34")); //$NON-NLS-1$
			}
		}
		
		/// <summary> Disassemble part of the swf to the output </summary>
		public static ActionLocation outputAssembly(DebugCLI cli, DSwfInfo swf, int start, int end)
		{
			// first we need to locate the action list associated with this
			// portion of the swf
			ActionLocation lStart = swf.locate(start);
			ActionLocation lEnd = (end > - 1)?swf.locate(end):swf.locateSourceLineEnd(lStart);
			
			return outputAssembly(cli, swf, lStart, lEnd);
		}
		
		public static ActionLocation outputAssembly(DebugCLI cli, SwfInfo info, ActionLocation lStart, ActionLocation lEnd)
		{
			// now make sure our actions lists are the same (i.e we haven't spanned past one tag)
			if (lStart.actions != lEnd.actions)
				lEnd.at = lStart.actions.size() - 1;
			
			Disassembler.disassemble(lStart.actions, lStart.pool, lStart.at, lEnd.at, new StreamWriter(cli.Out.BaseStream, System.Text.Encoding.Default));
			return lEnd;
		}
	}
}
