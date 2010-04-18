////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2003-2006 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
using System;
using Location = Flash.Tools.Debugger.Location;
using ValueExp = Flash.Tools.Debugger.Expression.ValueExp;

namespace Flex.Tools.Debugger.CLI
{
	
	
	/// <summary> An object that relates a CLI debugger breakpoint with an associated set
	/// of CLI commands to perform.
	/// 
	/// A breakpoint can be enabled or disabled.  It can be set such
	/// that it disabled or deletes itself after being hit N times.
	/// </summary>
	public class BreakAction
	{
		virtual public int CommandCount
		{
			/* getters */
			
			get
			{
				return m_commands.Count;
			}
			
		}
		virtual public Location Location
		{
			get
			{
				return (m_where != null)?m_where.first():null;
			}
			
		}
		virtual public LocationCollection Locations
		{
			get
			{
				return m_where;
			}
			
			set
			{
				m_where = value;
				if (value != null)
					Status = RESOLVED;
			}
			
		}
		virtual public int Id
		{
			get
			{
				return m_id;
			}
			
		}
		virtual public int Hits
		{
			get
			{
				return m_hits;
			}
			
		}
		virtual public bool Enabled
		{
			get
			{
				return m_enabled;
			}
			
			set
			{
				m_enabled = value;
			}
			
		}
		virtual public bool AutoDisable
		{
			get
			{
				return m_autoDisable;
			}
			
			set
			{
				m_autoDisable = value;
			}
			
		}
		virtual public bool AutoDelete
		{
			get
			{
				return m_autoDelete;
			}
			
			set
			{
				m_autoDelete = value;
			}
			
		}
		virtual public bool Silent
		{
			get
			{
				return m_silent;
			}
			
			set
			{
				m_silent = value;
			}
			
		}
		virtual public bool SingleSwf
		{
			get
			{
				return m_singleSwf;
			}
			
			set
			{
				m_singleSwf = value;
			}
			
		}
		virtual public String ConditionString
		{
			get
			{
				return m_conditionString;
			}
			
		}
		virtual public String BreakpointExpression
		{
			get
			{
				return m_breakpointExpression;
			}
			
			set
			{
				m_breakpointExpression = value;
			}
			
		}
		virtual public int Status
		{
			get
			{
				return m_status;
			}
			
			set
			{
				m_status = value;
			}
			
		}
		// return values for getStatus()
		public const int RESOLVED = 1;
		public const int UNRESOLVED = 2;
		public const int AMBIGUOUS = 3;
		public const int NOCODE = 4; // there is no executable code at the specified line
		
		/// <summary> This will be null if the user typed in a breakpoint expression which
		/// did not match any currently loaded location, but we have saved it
		/// (with status == UNRESOLVED) in case it gets resolved later when another
		/// SWF or ABC gets loaded.
		/// </summary>
		private LocationCollection m_where; // may be null
		
		/// <summary> This will be null if the breakpoint was created via the
		/// <code>BreakAction(String unresolvedLocation)</code> constructor.
		/// </summary>
		private String m_breakpointExpression; // may be null
		
		private System.Collections.ArrayList m_commands;
		private bool m_enabled;
		private bool m_autoDelete;
		private bool m_autoDisable;
		private bool m_silent;
		private bool m_singleSwf; // is breakpoint meant for a single swf only
		private int m_id;
		private int m_hits;
		private ValueExp m_condition;
		private String m_conditionString;
		private int m_status;
		
		public BreakAction(LocationCollection c)
		{
			m_where = c;
			Flash.Tools.Debugger.SourceFile generatedAux = m_where.first().File; // force NullPointerException if l == null
			m_status = RESOLVED;
			init();
		}
		
		public BreakAction(String unresolvedLocation)
		{
			m_breakpointExpression = unresolvedLocation;
			m_status = UNRESOLVED;
			init();
		}
		
		private void  init()
		{
			m_id = BreakIdentifier.next();
			m_commands = System.Collections.ArrayList.Synchronized(new System.Collections.ArrayList(10));
		}
		public virtual String commandAt(int i)
		{
			return (String) m_commands[i];
		}
		public virtual ValueExp getCondition()
		{
			return m_condition;
		}
		
		/* setters */
		public virtual void  addCommand(String cmd)
		{
			m_commands.Add(cmd);
		}
		public virtual void  clearCommands()
		{
			m_commands.Clear();
		}
		public virtual void  addLocation(Location l)
		{
			m_where.add(l);
		}
		public virtual void  setCondition(ValueExp c, String s)
		{
			m_condition = c; m_conditionString = s;
		}
		public virtual void  clearCondition()
		{
			setCondition(null, "");
		} //$NON-NLS-1$
		public virtual void  hit()
		{
			m_hits++;
		}
		public virtual void  clearHits()
		{
			m_hits = 0;
		}
		
		/*
		* Check to see if our location matches the requested one
		*/
		public virtual bool locationMatches(int fileId, int line)
		{
			if (Locations != null)
			{
                foreach (Location l in Locations)
                {
                    // probe all locations looking for a match
                    if (l != null && l.File.Id == fileId && l.Line == line)
                    {
                        return true;
                    }
                }
			}
			return false;
		}
	}
}
