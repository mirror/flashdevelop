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
	
	/// <summary> An exception that is thrown when some ambiguous condition or state
	/// was encountered.  It is usually not fatal, and normally caused
	/// by some user interaction which can be overcome. 
	/// </summary>
	[Serializable]
	public class AmbiguousException:Exception
	{
		public AmbiguousException()
		{
		}
		public AmbiguousException(String s):base(s)
		{
		}
	}
}
