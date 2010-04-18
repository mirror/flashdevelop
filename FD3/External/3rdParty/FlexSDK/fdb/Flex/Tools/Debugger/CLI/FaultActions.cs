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

namespace Flex.Tools.Debugger.CLI
{
	
	/// <summary> FaultActions proivdes a convenient wrapper for housing the user specified
	/// behaviour for a set of faults (aka text strings)
	/// 
	/// The underlying data structure is a HashMap that maps strings (i.e. fault
	/// names) to Integers.  The integers are used as bit fields for holding
	/// the state of setting per fault.
	/// 
	/// Add new actions by calling addAction("name") 
	/// </summary>
	public class FaultActions
	{
		internal System.Collections.Hashtable m_faults = new System.Collections.Hashtable();
		internal System.Collections.Hashtable m_description = new System.Collections.Hashtable(); // @todo should really use an object within the faults map for this 
		internal System.Collections.Hashtable m_actions = new System.Collections.Hashtable();
		
		internal int m_nextBitForAction = 0x1; // the next bit to use for the action
		
		public FaultActions()
		{
		}
		
		internal virtual Int32 getFault(String o)
		{
			return m_faults.ContainsKey(o) ? (Int32) m_faults[o] : -1;
		}
		internal virtual Int32 getAction(String o)
		{
			return (Int32) m_actions[o];
		}
		internal virtual void  putFault(String k, Int32 v)
		{
			m_faults[k] = v;
		}
		
		/* getters */
		public virtual void  clear()
		{
			m_faults.Clear();
		}
		public virtual int size()
		{
			return m_faults.Count;
		}
		public virtual Object[] names()
		{
			return SupportClass.ICollectionSupport.ToArray(new SupportClass.HashSetSupport(m_faults.Keys));
		}
		public virtual Object[] actions()
		{
			return SupportClass.ICollectionSupport.ToArray(new SupportClass.HashSetSupport(m_actions.Keys));
		}
		public virtual bool exists(String k)
		{
			return getFault(k) != -1;
		}
		
		public virtual void  putDescription(String k, String v)
		{
			m_description[k] = v;
		}
		public virtual String getDescription(String k)
		{
			return (m_description[k] == null)?"":(String) m_description[k];
		} //$NON-NLS-1$
		
		/// <summary> Add a new fault to the table, with all actions disabled</summary>
		public virtual void  add(String k)
		{
			putFault(k, 0);
		}
		
		/// <summary> Add a new action type to the table </summary>
		public virtual void  addAction(String k)
		{
			Int32 v = (Int32) m_nextBitForAction++;
			m_actions[k] = v;
		}
		
		/// <summary> Check if the given fault has the action set or not </summary>
		public virtual bool isSet(String fault, String action)
		{
			int mask = getAction(action);
			int bits = getFault(fault);
			
			return (bits & mask) == mask;
		}
		
		/// <summary> Sets the action bits as appropriate for the given fault 
		/// and action 
		/// </summary>
		public virtual int action(String fault, String action)
		{
			// first check if fault is legal
			Int32 current = getFault(fault);
			if (current == -1)
				throw new ArgumentException(fault);
			
			// check for no?
			bool no = action.StartsWith("no"); //$NON-NLS-1$
			if (no)
				action = action.Substring(2);
			
			// do the search for action 
			Int32 bit = getAction(action);
			if (bit == -1)
				throw new ArgumentException(action);
			
			// now do the math
			int old = current;
			int mask = bit;
			
			int n = (old & (~ mask)); // turn it off
			n = (no)?n:(n | mask); // leave it off or turn it on
			
			putFault(fault, n);
			
			return n;
		}
	}
}
