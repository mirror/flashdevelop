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
using ValueExp = Flash.Tools.Debugger.Expression.ValueExp;

namespace Flex.Tools.Debugger.CLI
{
	
	/// <summary> An object that relates a CLI debugger 'display' command
	/// with the contents of the display 
	/// </summary>
	public class DisplayAction
	{
		virtual public String Content
		{
			/* getters */
			
			get
			{
				return m_content;
			}
			
		}
		virtual public int Id
		{
			get
			{
				return m_id;
			}
			
		}
		virtual public bool Enabled
		{
			get
			{
				return m_enabled;
			}
			
			/* setters */
			
			set
			{
				m_enabled = value;
			}
			
		}
		virtual public ValueExp Expression
		{
			get
			{
				return m_expression;
			}
			
		}
		private static int s_uniqueIdentifier = 1;
		
		internal bool m_enabled;
		internal int m_id;
		internal ValueExp m_expression;
		internal String m_content;
		
		public DisplayAction(ValueExp expr, String content)
		{
			init();
			m_expression = expr;
			m_content = content;
		}
		
		internal virtual void  init()
		{
			m_enabled = true;
			m_id = s_uniqueIdentifier++;
		}
	}
}
