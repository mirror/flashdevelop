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
	
	/// <summary> ExtensionsDisabled class is a singleton that contains
	/// every cli method that does not conform to the 
	/// API.  There are two implementations of this singleton
	/// In Extensions the full code is provided in this class
	/// ExtensionsDisabled emtpy stubs are provided that allow
	/// for DebugCLI to be fully compliant with the API 
	/// </summary>
	public class ExtensionsDisabled
	{
		public static void  doShowStats(DebugCLI cli)
		{
			cli.output("Command not supported.");
		}
		public static void  doShowFuncs(DebugCLI cli)
		{
			cli.output("Command not supported.");
		}
		public static void  doShowProperties(DebugCLI cli)
		{
			cli.output("Command not supported.");
		}
		public static void  doShowBreak(DebugCLI cli)
		{
			cli.output("Command not supported.");
		}
		public static void  appendBreakInfo(DebugCLI cli, System.Text.StringBuilder sb, bool includeFault)
		{
			cli.output("Command not supported.");
		}
		public static void  doShowVariable(DebugCLI cli)
		{
			cli.output("Command not supported.");
		}
		public static void  doDisassemble(DebugCLI cli)
		{
			cli.output("Command not supported.");
		}
	}
}
