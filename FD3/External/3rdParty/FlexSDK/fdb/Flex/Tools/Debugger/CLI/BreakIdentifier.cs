////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2004-2005 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

namespace Flex.Tools.Debugger.CLI
{
	
	/// <summary> An singleton object that doles out unique identifiers to breakpoints and watchpoints</summary>
	public class BreakIdentifier
	{
		private static int s_uniqueIdentifier = 1;
		
		public static int next()
		{
			return s_uniqueIdentifier++;
		}
	}
}
