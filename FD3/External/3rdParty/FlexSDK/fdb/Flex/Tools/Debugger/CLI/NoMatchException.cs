////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2005 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
using System;

namespace Flex.Tools.Debugger.CLI
{
	
	/// <summary> While attempting to resolve a function name or filename, no match
	/// was found.  For example, this is thrown if the user enters
	/// "break foo.mxml:12" but there is no file called "foo.mxml".
	/// </summary>
	[Serializable]
	public class NoMatchException:System.Exception
	{
		public NoMatchException()
		{
		}
		public NoMatchException(String s):base(s)
		{
		}
	}
}
