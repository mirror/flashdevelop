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
using Flash.Tools.Debugger;

namespace Flex.Tools.Debugger.CLI
{
	/// <summary> This object is a container for source locations
	/// that represent the same underlying file and line
	/// number. 
	/// 
	/// The reason we need this is because multiple 
	/// swfs each contain their own unique version of
	/// a source file and we'd like to be able to 
	/// refer to any one location freely 
	/// 
	/// It is modelled after the Collection interface
	/// </summary>
	public class LocationCollection
	{
		virtual public bool Empty
		{
			get
			{
				return (m_locations.Count == 0);
			}
			
		}
        public virtual int Count
        {
            get
            {
                return m_locations.Count;
            }
        }
        public virtual Location this[int index]
        {
            get
            {
                return (Location)m_locations[index];
            }
        }
		private System.Collections.ArrayList m_locations = new System.Collections.ArrayList();
		
		public virtual bool add(Location l)
		{
			return m_locations.Add(l) >= 0;
		}
		public virtual bool contains(Location l)
		{
			return m_locations.Contains(l);
		}
		public virtual bool remove(Location l)
		{
			m_locations.Remove(l);
            return true;
		}
		public virtual System.Collections.IEnumerator GetEnumerator()
		{
			return m_locations.GetEnumerator();
		}
		
		// Return the first Location object or null
		public virtual Location first()
		{
			return (Location) ((m_locations.Count > 0)?m_locations[0]:null);
		}
		
		/// <summary> Removes Locations from the Collection which contain
		/// SourceFiles with Ids in the range [startingId, endingId].
		/// </summary>
		public virtual void  removeFileIdRange(int startingId, int endingId)
		{
            foreach (Location l in m_locations)
            {
				int id = (l.File == null) ? -1 : l.File.Id;
				if (id >= startingId && id <= endingId)
				{
                    m_locations.Remove(l);
				}
			}
		}
		
		/// <summary> See if the collection contains a Location 
		/// which is identical to the given file id and 
		/// line number
		/// </summary>
		public virtual bool contains(int fileId, int line)
		{
            foreach (Location l in m_locations)
			{
                if (l.File != null)
                {
                    if (l.File.Id == fileId && l.Line == line)
                        return true;
                }
			}
			return false;
		}
		
		/// <summary>for debugging </summary>
		public override String ToString()
		{
			return SupportClass.CollectionToString(m_locations);
		}
	}
}
