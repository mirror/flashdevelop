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

using Flash.Tools.Debugger.Expression;

namespace Flex.Tools.Debugger.CLI
{
	public class InternalProperty
	{
		virtual public String Name
		{
			/* getters */
			
			get
			{
				return m_key;
			}
			
		}
		internal String m_key;
		internal System.Object m_value;
		
		public InternalProperty(String key, System.Object value)
		{
			m_key = key;
			m_value = value;
		}
		public override String ToString()
		{
			return (m_value == null)?"null":m_value.ToString();
		} //$NON-NLS-1$
		
		public virtual String valueOf()
		{
			if (m_value == null)
				throw new NoSuchVariableException(m_key);
			
			return ToString();
		}
	}
}
