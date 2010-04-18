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
using Flash.Tools.Debugger.Concrete;
using Flash.Tools.Debugger.Expression;
using LocalizationManager = Flash.Localization.LocalizationManager;
using SystemProperties = JavaCompatibleClasses.SystemProperties;

namespace Flex.Tools.Debugger.CLI
{
	public class ExpressionCache
	{
		private static LocalizationManager LocalizationManager
		{
			get
			{
				return DebugCLI.LocalizationManager;
			}
			
		}
		internal Session m_session;
		internal ASTBuilder m_builder;
		internal System.Collections.ArrayList m_expressions;
		internal IntProperties m_props;
		internal DebugCLI m_cli;
		
		/// <summary> We can get at files by name or module id, eventually we will put functions in here too</summary>
		
		public ExpressionCache(DebugCLI cli)
		{
			m_builder = new ASTBuilder(true); // allow fdb's "*x" and "x." indirection operators
			m_expressions = System.Collections.ArrayList.Synchronized(new System.Collections.ArrayList(10));
			m_props = new IntProperties();
			m_cli = cli;
		}
		
		public virtual void  clear()
		{
			m_expressions.Clear();
		}
		public virtual void  unbind()
		{
			m_session = null;
		}
		public virtual int size()
		{
			return m_expressions.Count;
		}
		public virtual Object at(int i)
		{
			return m_expressions[i];
		}
		
		internal virtual void  setSession(Session s)
		{
			m_session = s;
		}
		
		public virtual Session getSession()
		{
			return m_session;
		}
		public virtual String getPackageName(int id)
		{
			return m_cli.module2ClassName(id);
		}
		
		public virtual void  bind(Session s)
		{
			setSession(s);
			
			// propagates our properties to the session / non-critical if fails
			try
			{
				((PlayerSession) s).Preferences = m_props.Map;
			}
			catch (Exception)
			{
			}
		}
		
		public virtual Object evaluate(ValueExp e)
		{
			// evaluate away...
			ExpressionContext c = new ExpressionContext(this);
			return e.evaluate(c);
		}
		
		public virtual ValueExp parse(String s)
		{
			return m_builder.parse(new StringReader(s));
		}
		
		public virtual int add(Object e)
		{
			int at = m_expressions.Count;
			m_expressions.Add(e);
			return at + 1;
		}
		
		//
		// Interface for accessing previous expression values and also the properties
		//
		public virtual bool propertyEnabled(String which)
		{
			bool enabled = false;
			try
			{
				ValueType number = (ValueType) get_Renamed(which);
				if (number != null)
					enabled = (Convert.ToInt32(number) != 0);
			}
			catch (Exception)
			{
				// nothing; leave 'enabled' as false
			}
			return enabled;
		}
		
		// this goes in properties
		public virtual void  put(String s, int value)
		{
			m_props[s] = value; setSessionProperty(s, value);
		}
		public virtual SupportClass.SetSupport keySet()
		{
			return m_props.Keys;
		}
		
		/// <summary> Allow the session to receive property updates </summary>
		internal virtual void  setSessionProperty(String s, int value)
		{
			Session sess = getSession();
			if (sess != null)
				sess.setPreference(s, value);
			Bootstrap.sessionManager().setPreference(s, value);
		}
		
		/// <summary> We are able to fetch properties or expressions (i.e previous expression)
		/// using this single call, despite the fact that each of these types of 
		/// results lie in different data structures m_expressions and m_props.
		/// This allows us to easily perform expression evaluation without
		/// need or concern over which 'type' of $ reference we are dealing with
		/// </summary>
		public virtual Object get_Renamed(String s)
		{
			Object exp = null;
			
			// should be of form '$n' where n is a number 0..size()
			if (s[0] != '$')
				throw new ArgumentOutOfRangeException(s);
			
			String num = s.Substring(1);
			if (num == null || num.Length == 0)
				exp = at(size() - 1);
			else if (num.Equals("$"))
			//$NON-NLS-1$
				exp = at(size() - 2);
            else if (Char.IsDigit(num[0]))
            {
                try
                {
                    int index = Int32.Parse(num);
                    exp = at(index - 1);
                }
                catch (FormatException)
                {
                    // must be in the property list
                    try
                    {
                        exp = m_props[s];
                    }
                    catch (IndexOutOfRangeException)
                    {
                        exp = null;
                    }
                }
            }
            else
            {
                exp = m_props[s];
            }
			return exp;
		}
		
		//
		// Statics for formatting stuff
		//
		
		/// <summary> Formatting function for variable</summary>
		public static void  appendVariable(System.Text.StringBuilder sb, Variable v)
		{
			//sb.append('\'');
			String name = v.getName();
			sb.Append(name);
			//sb.append('\'');
			sb.Append(" = "); //$NON-NLS-1$
			appendVariableValue(sb, v.getValue(), name);
			//appendVariableAttributes(sb, v);
		}
		
		public static void  appendVariableValue(System.Text.StringBuilder sb, Value val)
		{
			appendVariableValue(sb, val, "");
		} //$NON-NLS-1$
		
		public static void  appendVariableValue(System.Text.StringBuilder sb, Value val, String variableName)
		{
			int type = val.getType();
			String typeName = val.getTypeName();
			String className = val.getClassName();
			
			// if no string or empty then typeName is blank
			if (typeName != null && typeName.Length == 0)
				typeName = null;
			
			switch (type)
			{
				
				case VariableType.NUMBER: 
				{
					double value = ((Double) val.ValueAsObject);
					long longValue = (long) value;
					// The value is stored as a double; however, in practice most values are
					// actually integers.  Check to see if this is the case, and if it is,
					// then display it:
					//    - without a fraction, and
					//    - with its hex equivalent in parentheses.
					// Note, we use 'long' instead of 'int', in order to deal with the
					// ActionScript type 'uint'.
					if (longValue == value)
					{
						sb.Append(longValue);
						sb.Append(" (0x"); //$NON-NLS-1$
						sb.Append(Convert.ToString(longValue, 16));
						sb.Append(")"); //$NON-NLS-1$
					}
					else
					{
						sb.Append(value);
					}
					break;
				}
				
				
				case VariableType.BOOLEAN: 
				{
					Boolean b = (Boolean) val.ValueAsObject;
					if (b)
						sb.Append("true");
					//$NON-NLS-1$
					else
						sb.Append("false"); //$NON-NLS-1$
					break;
				}
				
				
				case VariableType.STRING: 
				{
					bool isException = (val.isAttributeSet(ValueAttribute.IS_EXCEPTION));
					sb.Append(isException?'<':'\"');
					sb.Append(val.ValueAsString);
					sb.Append(isException?'>':'\"');
					break;
				}
				
				
				case VariableType.OBJECT: 
				{
					sb.Append("["); //$NON-NLS-1$
					sb.Append(className);
					
					// Normally, we include the object id after the class name.
					// However, when running fdbunit, don't show object IDs, so that
					// results can reproduce consistently from one run to the next.
					if (SystemProperties.getProperty("fdbunit") == null)
					//$NON-NLS-1$
					{
						sb.Append(" "); //$NON-NLS-1$
						sb.Append(val.ValueAsObject); // object id
					}
					if (typeName != null && !typeName.Equals(className))
					{
						sb.Append(", class='"); //$NON-NLS-1$
						
						// Often the typename is of the form 'classname@hexaddress',
						// but the hex address is the same as the object id which
						// is returned by getValue() -- we don't want to display it
						// here.
						int at = typeName.IndexOf('@');
						if (at != - 1)
							typeName = typeName.Substring(0, (at) - (0));
						
						sb.Append(typeName);
						sb.Append('\'');
					}
					sb.Append(']');
					break;
				}
				
				
				case VariableType.FUNCTION: 
				{
					// here we have a special case for getters/setters which 
					// look like functions to us, except the attribute is set.
					sb.Append('[');
					if (val.isAttributeSet(VariableAttribute.HAS_GETTER))
						sb.Append(LocalizationManager.getLocalizedTextString("getterFunction"));
					//$NON-NLS-1$
					else if (val.isAttributeSet(VariableAttribute.HAS_SETTER))
						sb.Append(LocalizationManager.getLocalizedTextString("setterFunction"));
					//$NON-NLS-1$
					else
						sb.Append(LocalizationManager.getLocalizedTextString("function")); //$NON-NLS-1$
					sb.Append(' ');
					
					sb.Append(val.ValueAsObject);
					if (typeName != null && !typeName.Equals(variableName))
					{
						sb.Append(", name='"); //$NON-NLS-1$
						sb.Append(typeName);
						sb.Append('\'');
					}
					sb.Append(']');
					break;
				}
				
				
				case VariableType.MOVIECLIP: 
				{
					sb.Append("["); //$NON-NLS-1$
					sb.Append(className);
					sb.Append(" "); //$NON-NLS-1$
					sb.Append(val.ValueAsObject);
					if (typeName != null && !typeName.Equals(className))
					{
						sb.Append(", named='"); //$NON-NLS-1$
						sb.Append(typeName);
						sb.Append('\'');
					}
					sb.Append(']');
					break;
				}
				
				
				case VariableType.NULL: 
				{
					sb.Append("null"); //$NON-NLS-1$
					break;
				}
				
				
				case VariableType.UNDEFINED: 
				{
					sb.Append("undefined"); //$NON-NLS-1$
					break;
				}
				
				
				case VariableType.UNKNOWN: 
				{
					sb.Append(LocalizationManager.getLocalizedTextString("unknownVariableType")); //$NON-NLS-1$
					break;
				}
				}
		}
		
		public static void  appendVariableAttributes(System.Text.StringBuilder sb, Variable v)
		{
			if (v.getAttributes() == 0)
				return ;
			
			sb.Append("  "); //$NON-NLS-1$
			
			if (v.isAttributeSet(VariableAttribute.DONT_ENUMERATE))
				sb.Append(", " + LocalizationManager.getLocalizedTextString("variableAttribute_dontEnumerate")); //$NON-NLS-1$ //$NON-NLS-2$
			
			if (v.isAttributeSet(VariableAttribute.READ_ONLY))
				sb.Append(", " + LocalizationManager.getLocalizedTextString("variableAttribute_readOnly")); //$NON-NLS-1$ //$NON-NLS-2$
			
			if (v.isAttributeSet(VariableAttribute.IS_LOCAL))
				sb.Append(", " + LocalizationManager.getLocalizedTextString("variableAttribute_localVariable")); //$NON-NLS-1$ //$NON-NLS-2$
			
			if (v.isAttributeSet(VariableAttribute.IS_ARGUMENT))
				sb.Append(", " + LocalizationManager.getLocalizedTextString("variableAttribute_functionArgument")); //$NON-NLS-1$ //$NON-NLS-2$
			
			if (v.isAttributeSet(VariableAttribute.HAS_GETTER))
				sb.Append(", " + LocalizationManager.getLocalizedTextString("variableAttribute_getterFunction")); //$NON-NLS-1$ //$NON-NLS-2$
			
			if (v.isAttributeSet(VariableAttribute.HAS_SETTER))
				sb.Append(", " + LocalizationManager.getLocalizedTextString("variableAttribute_setterFunction")); //$NON-NLS-1$ //$NON-NLS-2$
			
			if (v.isAttributeSet(VariableAttribute.IS_DYNAMIC))
				sb.Append(", dynamic"); //$NON-NLS-1$
			
			if (v.isAttributeSet(VariableAttribute.IS_STATIC))
				sb.Append(", static"); //$NON-NLS-1$
			
			if (v.isAttributeSet(VariableAttribute.IS_CONST))
				sb.Append(", const"); //$NON-NLS-1$
			
			if (v.isAttributeSet(VariableAttribute.PRIVATE_SCOPE))
				sb.Append(", private"); //$NON-NLS-1$
			
			if (v.isAttributeSet(VariableAttribute.PUBLIC_SCOPE))
				sb.Append(", public"); //$NON-NLS-1$
			
			if (v.isAttributeSet(VariableAttribute.PROTECTED_SCOPE))
				sb.Append(", protected"); //$NON-NLS-1$
			
			if (v.isAttributeSet(VariableAttribute.INTERNAL_SCOPE))
				sb.Append(", internal"); //$NON-NLS-1$
			
			if (v.isAttributeSet(VariableAttribute.NAMESPACE_SCOPE))
				sb.Append(", " + LocalizationManager.getLocalizedTextString("variableAttribute_hasNamespace")); //$NON-NLS-1$ //$NON-NLS-2$
		}
	}
}
