/*
 * Required Interface between ASFileParser 
 * and the application using the parser
 */

using System;
using System.Collections;

namespace ASCompletion
{
	public interface IASContext
	{
		#region methods
		
		/// <summary>
		/// Add the current class' base path to the classpath
		/// </summary>
		/// <param name="fileName">Relative to this file</param>
		/// <param name="basePath">Resolved this base path</param>
		void SetTemporaryBasePath(string fileName, string basePath);
		
		/// <summary>
		/// Retrieves a class model from its name
		/// </summary>
		/// <param name="cname">Class (short or full) name</param>
		/// <param name="inClass">Current file</param>
		/// <returns>A parsed class or an empty ClassModel if the class is not found</returns>
		ClassModel ResolveClass(string cname, FileModel inFile);
		
		/// <summary>
		/// Look for a file in cache or parse a new file
		/// </summary>
		/// <param name="filename">Wanted class file</param>
		/// <returns>Parsed model</returns>
		FileModel GetFileModel(string fileName);
		
		/// <summary>
		/// Current active class
		/// </summary>
		ClassModel CurrentClass { get; }
		
		/// <summary>
		/// Current active file
		/// </summary>
		FileModel CurrentFile { get; }
				
		/// <summary>
		/// Find folder and classes in classpath
		/// </summary>
		/// <param name="folder">Path to eval</param>
		/// <param name="completeContent">Return package content</param>
		/// <returns>Package folders and classes</returns>
		MemberList FindPackage(string folder, bool completeContent);
		
		/// <summary>
		/// (Re)Parse (if necessary) and cache a class file
		/// </summary>
		/// <param name="aClass">Class object</param>
		/// <returns>The class object</returns>
		ClassModel UpdateClass(ClassModel aClass);
		
		/// <summary>
		/// Resolve wildcards in imports
		/// </summary>
		/// <param name="package">Package to explore</param>
		/// <param name="inClass">Current class</param>
		/// <param name="known">Packages already added</param>
		void ResolveImports(string package, ClassModel inClass, ArrayList known);
		
		/// <summary>
		/// Depending on the context UI, display some message
		/// </summary>
		void DisplayError(string message);
		#endregion
	}
}
