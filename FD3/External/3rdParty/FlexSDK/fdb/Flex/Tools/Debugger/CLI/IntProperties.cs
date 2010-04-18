////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2003-2005 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
using System;

namespace Flex.Tools.Debugger.CLI
{
	
	public class IntProperties
	{
		internal System.Collections.Hashtable m_map = new System.Collections.Hashtable();
		
		/* getters */
		public virtual System.Int32 this[String s]
		{
            get
            {
                if (m_map.Contains(s))
                {
                    return (System.Int32)m_map[s];
                }
                else
                {
                    throw new IndexOutOfRangeException(s);
                }
            }

            set
            {
                m_map[s] = value;
            }
		}

		public virtual SupportClass.SetSupport Keys
		{
            get
            {
                return new SupportClass.HashSetSupport(m_map.Keys);
            }
		}

        public virtual System.Collections.IDictionary Map
        {
            get
            {
                return m_map;
            }
        }
    }
}
