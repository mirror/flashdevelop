/*
 * Created by SharpDevelop.
 * User: Frederico Garcia
 * Date: 25-07-2009
 * Time: 0:33
 * 
 */
using System;

namespace CodeFormatter.Handlers
{
	/// <summary>
	/// Description of WrapOptions.
	/// </summary>
	public class WrapOptions
	{
		public const int WRAP_NONE=1;
		public const int WRAP_DONT_PROCESS=2;
//	public const int WRAP_ITEMS_PER_LINE=4;
		public const int WRAP_FORMAT_NO_CRs=4;
		public const int WRAP_BY_COLUMN=8;
		public const int WRAP_BY_COLUMN_ONLY_ADD_CRS=16;
		public const int WRAP_BY_TAG=128;

		public const int WRAP_STYLE_INDENT_NORMAL=1000;
		public const int WRAP_STYLE_INDENT_TO_WRAP_ELEMENT=1001;
		
		
		private int mWrapType;
		private bool mBeforeSeparator; //usually, separator is 'comma'
		private int mIndentStyle;
		
		public WrapOptions(int wrapType)
		{
			mWrapType=wrapType;
			mBeforeSeparator=false;
			mIndentStyle=WRAP_STYLE_INDENT_NORMAL;
		}
		
		public int WrapType
		{
			get { return this.mWrapType; }
			set { this.mWrapType = value; }
		}
		
		public bool BeforeSeparator
		{
			get { return this.mBeforeSeparator; }
			set { this.mBeforeSeparator = value; }
		}
		
		public int IndentStyle
		{
			get { return this.mIndentStyle; }
			set { this.mIndentStyle = value; }
		}
	}
}
