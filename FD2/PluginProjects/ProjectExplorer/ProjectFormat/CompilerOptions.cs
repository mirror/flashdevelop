using System;
using System.ComponentModel;
using System.Text;

namespace ProjectExplorer.ProjectFormat
{
	public enum TraceMode
	{
		Disable,
		FlashMX,
		FlashOut,
		FlashConnect,
		FlashConnectExtended,
		CustomFunction
	}

	public class CompilerOptions
	{
		int frame;
		bool useMX;
		bool infer;
		bool strict;
		bool useMain;
		bool verbose;
		bool keep;
		bool groupClasses;
		bool warnUnusedImports;
		TraceMode traceMode;
		string traceFunction;
		string libraryPrefix;
		string[] includePackages;
		string excludeFile;

		public CompilerOptions()
		{
			frame = 1;
			useMX = true;
			infer = false;
			strict = false;
			useMain = true;
			verbose = false;
			keep = true;
			groupClasses = false;
			warnUnusedImports = false;
			traceMode = TraceMode.FlashOut;
			excludeFile = "";
			traceFunction = "";
			libraryPrefix = "";
			includePackages = new string[0];
		}

		//[DisplayName("Strict Mode")]
		[Category("General")]
		[Description("If set to true, the compiler will require that all variables are either explicitly typed or inferrable (see 'Infer Types').")]
		[DefaultValue(false)]
		public bool Strict { get { return strict; } set { strict = value; } }

		//[DisplayName("Infer Types")]
		[Category("General")]
		[Description("If set to true, the compiler will attempt to automatically determine the type of a local variable declared with the 'var' keyword.")]
		[DefaultValue(false)]
		public bool Infer { get { return infer; } set { infer = value; } }

		//[DisplayName("Verbose Output")]
		[Category("General")]
		[Description("If set to true, the compiler will produce more detailed output, which can be viewed in the Output Panel.")]
		[DefaultValue(false)]
		public bool Verbose { get { return verbose; } set { verbose = value; } }

		//[DisplayName("Warn on Unused Imports")]
		[Category("General")]
		[Description("If set to true, the compiler will warn you when you have used the 'import' keyword needlessly.")]
		[DefaultValue(false)]
		public bool WarnUnusedImports
		{
			get { return warnUnusedImports; }
			set { warnUnusedImports = value; }
		}

		//[DisplayName("Trace Mode")]
		[Category("Trace")]
		[Description("Controls how the trace() call is handled by the compiler.  The default is 'FlashOut', which will cause trace output to be sent to FlashDevelop's output panel.")]
		[DefaultValue(TraceMode.FlashOut)]
		public TraceMode TraceMode
		{
			get { return traceMode; }
			set { traceMode = value; }
		}

		//[DisplayName("Custom Trace Function")]
		[Category("Trace")]
		[Description("If the 'Trace Mode' is set to 'CustomFunction', you may type in the full path to the function you would like to replace trace() calls with.  You may need to ensure the class containing the function is compiled in by marking it as 'Always Compile'.")]
		[DefaultValue("")]
		public string TraceFunction
		{
			get { return (traceMode == TraceMode.CustomFunction) ? traceFunction : ""; }
			set { traceFunction = value; }
		}

		[Category("Advanced")]
		[Description("Specifies a string to be placed in front of all auto-generated library asset IDs (useful to prevent namespace collisions if this project is a shared library)")]
		[DefaultValue("")]
		public string LibraryPrefix
		{
			get { return libraryPrefix; }
			set { libraryPrefix = value; }
		}

		//[DisplayName("Use Main Entry Point")]
		[Category("Advanced")]
		[Description("If set to true, you must define a single static function called main() that will be the entry point of your movie.")]
		[DefaultValue(true)]
		public bool UseMain { get { return useMain; } set { useMain = value; } }

		//[DisplayName("Include Packages")]
		[Category("Advanced")]
		[Description("Allows you to specify one or more packages that will always be compiled into your movie.  See www.mtasc.org for more information.")]
		[DefaultValue(new string[]{})]
		public string[] IncludePackages
		{
			get { return includePackages; }
			set { includePackages = value; }
		}

		[Category("Advanced")]
		[Description("Excluded code generation of classes listed in specified file (format is one full class path per line).")]
		[DefaultValue("")]
		public string ExcludeFile
		{
			get { return excludeFile; }
			set { excludeFile = value; }
		}

		[Category("Advanced")]
		[Description("Merges classes into one single MovieClip (this will reduce SWF size but might cause some problems if you're using Code Injection or UseMX).")]
		[DefaultValue(false)]
		public bool GroupClasses
		{
			get { return groupClasses; }
			set { groupClasses = value; }
		}

		[Category("Advanced")]
		[Description("If set to true, all code in the mx.* namespace will never be compiled into the output SWF.")]
		[DefaultValue(true)]
		public bool UseMX { get { return useMX; } set { useMX = value; } }

		[Category("Code Injection")]
		[Description("[If using Code Injection Only] Exports your classes into a specific frame of the Input SWF.")]
		[DefaultValue(1)]
		public int Frame
		{
			get { return frame; }
			set
			{
				if (frame < 1)
					throw new ArgumentException("The value for Frame must be greater than zero.");
				
				frame = value;
			}
		}

		[Category("Code Injection")]
		[Description("[If using Code Injection Only] Keeps classes compiled by the Flash IDE into the Output SWF (this could cause some classes to be present two times if also compiled with FlashDevelop).")]
		[DefaultValue(true)]
		public bool Keep
		{
			get { return keep; }
			set { keep = value; }
		}
	}
}
