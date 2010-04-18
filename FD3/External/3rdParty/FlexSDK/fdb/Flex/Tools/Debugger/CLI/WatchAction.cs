////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2004-2006 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
using System;
using Watch = Flash.Tools.Debugger.Watch;

namespace Flex.Tools.Debugger.CLI
{
	
	/// <summary> An object that relates a CLI debugger watchpoint with the
	/// actual Watch obtained from the Session
	/// </summary>
	public class WatchAction
	{
		virtual public int Id
		{
			/* getters */
			
			get
			{
				return m_id;
			}
			
		}
		virtual public int VariableId
		{
			get
			{
				return m_watch.ValueId;
			}
			
		}
		virtual public int Kind
		{
			get
			{
				return m_watch.Kind;
			}
			
		}
		virtual public Watch Watch
		{
			get
			{
				return m_watch;
			}
			
		}
		virtual public String Expr
		{
			get
			{
				String memberName = m_watch.MemberName;
				int namespaceSeparator = memberName.IndexOf("::"); //$NON-NLS-1$
				if (namespaceSeparator != - 1)
					memberName = memberName.Substring(namespaceSeparator + 2);
				return "#" + VariableId + "." + memberName; //$NON-NLS-1$ //$NON-NLS-2$
			}
			
		}
		internal Watch m_watch;
		internal int m_id;
		
		public WatchAction(Watch w)
		{
			init(w);
		}
		
		internal virtual void  init(Watch w)
		{
			m_watch = w;
			m_id = BreakIdentifier.next();
		}
		
		/* setters */
		public virtual void  resetWatch(Watch w)
		{
			m_watch = w;
		}
	}
}
