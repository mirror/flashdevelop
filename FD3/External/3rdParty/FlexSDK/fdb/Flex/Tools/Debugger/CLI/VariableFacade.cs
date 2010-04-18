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
using Flash.Tools.Debugger;
using FaultEvent = Flash.Tools.Debugger.Events.FaultEvent;

namespace Flex.Tools.Debugger.CLI
{
	
	/// <summary> A VariableFacade provides a wrapper around a Variable object
	/// that provides a convenient way of storing parent information.
	/// 
	/// Don't ask me why we didn't just add a parent member to 
	/// Variable and be done with it.
	/// </summary>
	public class VariableFacade : Variable
	{
		virtual public String QualifiedName
		{
			get
			{
				return m_var.QualifiedName;
			}
			
		}
		virtual public String Namespace
		{
			get
			{
				return m_var.Namespace;
			}
			
		}
		virtual public int Level
		{
			get
			{
				return m_var.Level;
			}
			
		}
		virtual public int Scope
		{
			get
			{
				return m_var.Scope;
			}
			
		}
		virtual public String Path
		{
			get
			{
				return m_path;
			}
			
			set
			{
				m_path = value;
			}
			
		}
		/// <summary> Our lone get context (i.e. parent) interface </summary>
		virtual public int Context
		{
			get
			{
				return (int) m_context;
			}
			
		}
		virtual public Variable Variable
		{
			get
			{
				return m_var;
			}
			
		}
		internal Variable m_var;
		internal long m_context;
		internal String m_name;
		internal String m_path;
		
		public VariableFacade(Variable v, long context)
		{
			init(context, v, null);
		}
		public VariableFacade(long context, String name)
		{
			init(context, null, name);
		}
		
		internal virtual void  init(long context, Variable v, String name)
		{
			m_var = v;
			m_context = context;
			m_name = name;
		}
		
		/// <summary> The variable interface </summary>
		public virtual String getName()
		{
			return (m_var == null)?m_name:m_var.getName();
		}
		public virtual String getDefiningClass()
		{
			return m_var.getDefiningClass();
		}
		public virtual int getAttributes()
		{
			return m_var.getAttributes();
		}
		public virtual bool isAttributeSet(int variableAttribute)
		{
			return m_var.isAttributeSet(variableAttribute);
		}
		public virtual Value getValue()
		{
			return m_var.getValue();
		}
		public virtual bool hasValueChanged()
		{
			return m_var.hasValueChanged();
		}
		public virtual FaultEvent setValue(int type, String value)
		{
			return m_var.setValue(type, value);
		}
		public override String ToString()
		{
			return (m_var == null)?m_name:m_var.ToString();
		}
		public virtual bool needsToInvokeGetter()
		{
			return m_var.needsToInvokeGetter();
		}
		public virtual void  invokeGetter()
		{
			m_var.invokeGetter();
		}
	}
}
