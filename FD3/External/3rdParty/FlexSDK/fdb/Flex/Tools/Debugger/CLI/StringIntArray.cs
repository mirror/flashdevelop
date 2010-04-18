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
	
	/// <summary> This class wraps a Nx2 array and provides a List interface
	/// for each of the 2 columns of the array.
	/// 
	/// It's main purpose is to provide the method elementsStartingWith()
	/// which returns a ArrayList of index numbers for each element whose
	/// String component matches the provided argument.
	/// </summary>
	public class StringIntArray:System.Collections.IList
	{
		public Object this[Int32 at]
		{
			get
			{
				return m_ar[at];
			}
			
			set
			{
			}
			
		}
		public virtual int Count
		{
			get
			{
				return m_size;
			}
			
		}
		internal Object[] m_ar;
		internal int m_size = 0;
		internal double m_growthRatio = 1.60;
		
		public StringIntArray(Object[] ar)
		{
			m_ar = ar;
			m_size = m_ar.Length;
		}
		
		public StringIntArray():this(10)
		{
		}
		
		public StringIntArray(int size)
		{
			m_ar = new Object[size];
			m_size = 0;
		}
		
		public virtual Object[] getElement(int at)
		{
			return (Object[]) this[at];
		}
		public virtual String getString(int at)
		{
			return (String) getElement(at)[0];
		}
		public virtual Int32 getInteger(int at)
		{
			return (Int32) getElement(at)[1];
		}
		public virtual int getInt(int at)
		{
			return getInteger(at);
		}
		
		/// <summary> Sequentially walk through the entire list 
		/// matching the String components against the 
		/// given string 
		/// </summary>
		public virtual System.Collections.ArrayList elementsStartingWith(String s)
		{
			System.Collections.ArrayList alist = new System.Collections.ArrayList();
			for (int i = 0; i < m_size; i++)
				if (getString(i).StartsWith(s))
					alist.Add((Int32) i);
			
			return alist;
		}
		
		public void  Insert(int at, Object e)
		{
			// make sure there is enough room in the array, then add the element 
			ensureCapacity(1);
			int size = Count;
			
			// open a spot for the element and stick it in
			//		System.out.println("add("+at+"), moving "+at+" to "+(at+1)+" for "+(size-at)+",size="+size);
			Array.Copy(m_ar, at, m_ar, at + 1, size - at);
			m_ar[at] = e;
			
			m_size++;
		}
		
		public void RemoveAt(int at)
		{
			int size = Count;
			
			//		System.out.println("remove("+at+"), moving "+(at+1)+" to "+at+" for "+(size-at+1)+",size="+size);
			Array.Copy(m_ar, at + 1, m_ar, at, size - at + 1);
			m_size--;
		}
		
		internal virtual void  ensureCapacity(int amt)
		{
			int size = Count;
			int newSize = amt + size;
			if (newSize > m_ar.Length)
			{
				// we need a new array, compute a good size for it
				double growTo = m_ar.Length * m_growthRatio; // make bigger
				if (newSize > growTo)
					growTo += newSize + (newSize * m_growthRatio);
				
				Object[] nAr = new Object[(int) growTo + 1];
				Array.Copy(m_ar, 0, nAr, 0, m_ar.Length);
				m_ar = nAr;
			}
		}
		//UPGRADE_TODO: The following method was automatically generated and it must be implemented in order to preserve the class logic. "ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?index='!DefaultContextWindowIndex'&keyword='jlca1232'"
		virtual public Int32 Add(Object value)
		{
			return 0;
		}
		//UPGRADE_TODO: The following method was automatically generated and it must be implemented in order to preserve the class logic. "ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?index='!DefaultContextWindowIndex'&keyword='jlca1232'"
		virtual public Boolean Contains(Object value)
		{
			return false;
		}
		//UPGRADE_TODO: The following method was automatically generated and it must be implemented in order to preserve the class logic. "ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?index='!DefaultContextWindowIndex'&keyword='jlca1232'"
		virtual public void  Clear()
		{
		}
		//UPGRADE_TODO: The following method was automatically generated and it must be implemented in order to preserve the class logic. "ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?index='!DefaultContextWindowIndex'&keyword='jlca1232'"
		virtual public Int32 IndexOf(Object value)
		{
			return 0;
		}
		//UPGRADE_TODO: The following method was automatically generated and it must be implemented in order to preserve the class logic. "ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?index='!DefaultContextWindowIndex'&keyword='jlca1232'"
		virtual public void  Remove(Object value)
		{
		}
		virtual public void  CopyTo(Array array, Int32 index)
		{
            for (int i = index; i < this.Count; i++)
            {
                array.SetValue(this[i], i);
            }
		}
		//UPGRADE_TODO: The following method was automatically generated and it must be implemented in order to preserve the class logic. "ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?index='!DefaultContextWindowIndex'&keyword='jlca1232'"
		virtual public System.Collections.IEnumerator GetEnumerator()
		{
			return null;
		}
		virtual public Boolean IsReadOnly
		{
			get
			{
				return false;
			}
			
		}
		virtual public Boolean IsFixedSize
		{
			get
			{
				return false;
			}
			
		}
		virtual public Object SyncRoot
		{
			get
			{
				return null;
			}
			
		}
		virtual public Boolean IsSynchronized
		{
			get
			{
				return false;
			}
			
		}
	}
}
