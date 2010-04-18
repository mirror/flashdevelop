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
using Flash.Tools.Debugger;
using ArrayUtil = Flash.Util.ArrayUtil;
using IntMap = Flash.Util.IntMap;

namespace Flex.Tools.Debugger.CLI
{
	/// <summary> FileInfoCache manages a list of files that are unique
	/// across multiple swfs.
	/// </summary>
	public class FileInfoCache : System.Collections.IComparer
	{
		virtual public SourceFile[] FileList
		{
			get
			{
				populate(); return m_files;
			}
			
		}
		virtual public System.Collections.IEnumerator AllFiles
		{
			get
			{
				populate(); return m_byInt.GetEnumerator();
			}
			
		}
		virtual public bool SwfFilterOn
		{
			get
			{
				return (m_swfFilter != null);
			}
			
		}
		virtual internal Session Session
		{
			set
			{
				m_session = value;
				m_swfFilter = null;
				clear();
			}
			
		}
		virtual public SwfInfo[] Swfs
		{
			// list all swfs we know about
			
			get
			{
				SwfInfo[] swfs = null;
				try
				{
					swfs = m_session.Swfs;
				}
				catch (NoResponseException)
				{
					swfs = new SwfInfo[]{}; // oh bery bad
				}
				return swfs;
			}
			
		}
		internal Session m_session;
		
		/// <summary> We can get at files by module id or path</summary>
		internal IntMap m_byInt = new IntMap();
		internal SourceFile[] m_files = null;
		internal SwfInfo m_swfFilter = null;
		internal int m_swfsLoaded = 0;
		internal bool m_dirty = false;
		
		public FileInfoCache()
		{
		}
		
		public virtual void  bind(Session s)
		{
			Session = s;
		}
		public virtual void  unbind()
		{
			m_session = null;
		}
		public virtual SourceFile getFile(int i)
		{
			populate(); return (SourceFile) m_byInt.get_Renamed(i);
		}
		public virtual SwfInfo getSwfFilter()
		{
			return m_swfFilter;
		}
		public virtual void  setDirty()
		{
			m_dirty = true;
		}
		
		internal virtual void  populate()
		{
			// do we have a new swf to load?
			if (m_session != null && (m_dirty || Swfs.Length > m_swfsLoaded))
				reloadCache();
		}
		
		internal virtual void  reloadCache()
		{
			clear();
			loadCache();
			m_dirty = false;
		}
		
		internal virtual void  clear()
		{
			m_byInt.clear();
			m_files = null;
		}
		
		/// <summary> Determine if the given SourceFile is in the current fileList</summary>
		public virtual bool inFileList(SourceFile f)
		{
			bool isIt = false;
			
			SourceFile[] files = FileList;
			for (int i = 0; i < files.Length && !isIt; i++)
			{
				if (files[i] == f)
					isIt = true;
			}
			return isIt;
		}
		
		/// <summary> Go out to the session and request a list of files
		/// But we dump ones that have a name collision.
		/// Also if selectedSwf is set then we only add files
		/// that are contained within the given swf.
		/// </summary>
		internal virtual void  loadCache()
		{
			bool worked = true; // check that all worked correctly
			System.Collections.ArrayList files = new System.Collections.ArrayList();
			SwfInfo[] swfs = Swfs;
			for (int i = 0; i < swfs.Length; i++)
			{
				if (swfs[i] != null)
					worked = loadSwfFiles(files, swfs[i])?worked:false;
			}
			
			// trim the file list
			System.Collections.ArrayList fa = trimFileList(files);
			m_files = (SourceFile[]) SupportClass.ICollectionSupport.ToArray(fa, new SourceFile[fa.Count]);
			
			// sort this array in place so calls to getFileList will be ordered
			ArrayUtil.sort(m_files, this);
			
			// mark our cache complete if all was good.
			if (worked)
				m_swfsLoaded = swfs.Length;
		}
		
		internal virtual bool loadSwfFiles(System.Collections.ArrayList ar, SwfInfo swf)
		{
			bool worked = true;
			try
			{
				// @todo should we include unloaded swfs?
				SourceFile[] files = swf.getSourceList(m_session);
				SupportClass.IListSupport.EnsureCapacity(ar, ar.Count + files.Length);
				
				// add each file to our global source file IntMap and our list
				for (int i = 0; i < files.Length; i++)
				{
					putFile(files[i]);
					ar.Add(files[i]);
				}
			}
			catch (InProgressException)
			{
				// can't load this one, its not ready yet
				worked = false;
			}
			return worked;
		}
		
		/// <summary> Walk the file list looking for name collisions.
		/// If we find one, then we remove it
		/// </summary>
		internal virtual System.Collections.ArrayList trimFileList(System.Collections.ArrayList files)
		{
			System.Collections.Hashtable names = new System.Collections.Hashtable();
			System.Collections.ArrayList list = new System.Collections.ArrayList();
			
			int size = files.Count;
			for (int i = 0; i < size; i++)
			{
				bool addIt = false;
				
				SourceFile fi = (SourceFile) files[i];
				// no filter currently in place so we add the file as long
				// as no duplicates exist.  We use the original Swd full
				// name for matching.
				String fName = fi.RawName;
				if (m_swfFilter == null)
				{
					// If it exists, then we don't add it!
					if (!names.ContainsKey(fName))
						addIt = true;
				}
				else
				{
					// we have a filter in place so, see
					// if the source file is in our currently
					// selected swf.
					addIt = m_swfFilter.containsSource(fi);
				}
				
				// did we mark this one to add?
				if (addIt)
				{
					names[fName] = fName;
					list.Add(fi);
				}
			}
			return list;
		}
		
		/// <summary> All files from all swfs are placed into our byInt map
		/// since we know that ids are unique across the entire
		/// Player session.
		/// 
		/// This is also important in the case that the player
		/// halts in one of these files, that the debugger
		/// be able to locate the SourceFile so that we can
		/// display the correct context for the user.
		/// </summary>
		internal virtual void  putFile(SourceFile s)
		{
			int i = s.Id;
			m_byInt.put(i, s);
		}
		
		/// <summary> Attempt to set a swf as a filter
		/// for the file list that we create
		/// </summary>
		public virtual bool setSwfFilter(String swfName)
		{
			// look for a match in our list
			bool worked = false;
			if (swfName == null)
			{
				m_swfFilter = null;
				worked = true;
			}
			else
			{
				SwfInfo[] swfs = Swfs;
				for (int i = 0; i < swfs.Length; i++)
				{
					SwfInfo e = swfs[i];
					if (e != null && nameOfSwf(e).ToUpper().Equals(swfName.ToUpper()))
					{
						worked = true;
						m_swfFilter = e;
						break;
					}
				}
			}
			
			// reload if it worked
			if (worked)
				reloadCache();
			
			return worked;
		}
		
		/// <summary> Given a SourceFile locate the swf which it came from</summary>
		public virtual SwfInfo swfForFile(SourceFile f)
		{
			// We use the id to determine which swf this source files resides in
			int id = f.Id;
			SwfInfo info = null;
			SwfInfo[] swfs = Swfs;
			for (int i = 0; (i < swfs.Length && (info == null)); i++)
			{
				if (swfs[i] != null && swfs[i].containsSource(f))
					info = swfs[i];
			}
			return info;
		}
		
		// locate the name of the swf
		public static String nameOfSwf(SwfInfo e)
		{
			int at = - 1;
			String name = e.Url;
			if ((at = e.Url.LastIndexOf('/')) > - 1)
				name = e.Url.Substring(at + 1);
			if ((at = e.Url.LastIndexOf('\\')) > - 1)
				name = e.Url.Substring(at + 1);
			else if ((at = e.Path.LastIndexOf('\\')) > - 1)
				name = e.Path.Substring(at + 1);
			else if ((at = e.Path.LastIndexOf('/')) > - 1)
				name = e.Path.Substring(at + 1);
			
			// now rip off any trailing ? options
			at = name.LastIndexOf('?');
			name = (at > - 1)?name.Substring(0, (at) - (0)):name;
			
			return name;
		}
		
		// locate the name of the swf
		public static String shortNameOfSwf(SwfInfo e)
		{
			String name = nameOfSwf(e);
			
			// now strip off any leading path
			int at = - 1;
			if ((at = name.LastIndexOf('/')) > - 1)
				name = name.Substring(at + 1);
			else if ((at = name.LastIndexOf('\\')) > - 1)
				name = name.Substring(at + 1);
			return name;
		}
		
		/// <summary> Given the URL of a specfic swf determine
		/// if there is a file within it that appears
		/// to be the same as the given source file
		/// </summary>
		/// <param name="f">
		/// </param>
		/// <returns>
		/// </returns>
		public virtual SourceFile similarFileInSwf(SwfInfo info, SourceFile f)
		{
			SourceFile hit = null;
			SourceFile[] files = info.getSourceList(m_session);
			if (!info.ProcessingComplete)
				throw new InProgressException();
			
			for (int i = 0; i < files.Length; i++)
			{
				if (filesMatch(f, files[i]))
					hit = files[i];
			}
			return hit;
		}
		
		/// <summary> Comparator interface for sorting SourceFiles</summary>
		public virtual int Compare(Object o1, Object o2)
		{
			SourceFile s1 = (SourceFile) o1;
			SourceFile s2 = (SourceFile) o2;
			
			String n1 = s1.Name;
			String n2 = s2.Name;
			
			return String.CompareOrdinal(n1, n2);
		}
		
		/// <summary> Compare two files and determine if they are the same.
		/// Our criteria included only line count package names
		/// and the name of the class itself.  If there are
		/// any other differences then we won't be able to detect
		/// them.  We should probably do something like an MD5
		/// computation on the characters in ScriptText. Then
		/// we'd really be sure of a match.
		/// </summary>
		/// <param name="a">first file to compare
		/// </param>
		/// <param name="b">second file to compare
		/// </param>
		/// <returns>  true if files appear to be the same
		/// </returns>
		public virtual bool filesMatch(SourceFile a, SourceFile b)
		{
			bool yes = true;
			
			if (a == null || b == null)
				yes = false;
			else if (String.CompareOrdinal(a.getPackageName(), b.getPackageName()) != 0)
				yes = false;
			else if (String.CompareOrdinal(a.Name, b.Name) != 0)
				yes = false;
			else if (a.LineCount != b.LineCount)
			// warning, this is sometimes expensive, so do it last
				yes = false;
			
			return yes;
		}
		/// <summary> Return a array of SourceFiles whose names match
		/// the specified string. The array is sorted by name.
		/// The input can be mx.controls.xxx which will
		/// </summary>
		public virtual SourceFile[] getFiles(String matchString)
		{
			bool doStartsWith = false;
			bool doIndexOf = false;
			bool doEndsWith = false;
			
			bool leadingAsterisk = matchString.StartsWith("*") && matchString.Length > 1; //$NON-NLS-1$
			bool trailingAsterisk = matchString.EndsWith("*"); //$NON-NLS-1$
			bool usePath = matchString.IndexOf('.') > - 1;
			
			if (leadingAsterisk && trailingAsterisk)
			{
				matchString = matchString.Substring(1, (matchString.Length - 1) - (1));
				doIndexOf = true;
			}
			else if (leadingAsterisk)
			{
				matchString = matchString.Substring(1);
				doEndsWith = true;
			}
			else if (trailingAsterisk)
			{
				matchString = matchString.Substring(0, (matchString.Length - 1) - (0));
				doStartsWith = true;
			}
			else if (usePath)
			{
				doIndexOf = true;
			}
			else
			{
				doStartsWith = true;
			}
			
			SourceFile[] files = FileList;
			System.Collections.ArrayList fileList = new System.Collections.ArrayList();
			int n = files.Length;
			int exactHitAt = - 1;
			// If the matchString already starts with "." (e.g. ".as" or ".mxml"), then dotMatchString
			// will be equal to matchString; otherwise, dotMatchString will be "." + matchString
			String dotMatchString = (matchString.StartsWith("."))?matchString:("." + matchString); //$NON-NLS-1$ //$NON-NLS-2$
			for (int i = 0; i < n; i++)
			{
				SourceFile sourceFile = files[i];
                bool pathExists = (usePath && new System.Text.RegularExpressions.Regex(@".*[/\\].*").Match(sourceFile.FullPath).Success); //$NON-NLS-1$
				String name = pathExists?sourceFile.FullPath:sourceFile.Name;
				
				// if we are using the full path string, then prefix a '.' to our matching string so that abc.as and Gabc.as don't both hit
				String match = (usePath && pathExists)?dotMatchString:matchString;
				
				name = name.Replace('/', '.'); // get rid of path identifiers and use dots
				name = name.Replace('\\', '.'); // would be better to modify the input string, but we don't know which path char will be used.
				
				// exact match? We are done
				if (name.Equals(match))
				{
					exactHitAt = i;
					break;
				}
				else if (doStartsWith && name.StartsWith(match))
					fileList.Add(sourceFile);
				else if (doEndsWith && name.EndsWith(match))
					fileList.Add(sourceFile);
				else if (doIndexOf && name.IndexOf(match) > - 1)
					fileList.Add(sourceFile);
			}
			
			// trim all others if we have an exact file match
			if (exactHitAt > - 1)
			{
				fileList.Clear();
				fileList.Add(files[exactHitAt]);
			}
			
			SourceFile[] fileArray = (SourceFile[]) SupportClass.ICollectionSupport.ToArray(fileList, new SourceFile[fileList.Count]);
			ArrayUtil.sort(fileArray, this);
			return fileArray;
		}
	}
}
