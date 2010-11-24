/*
 * Criado por SharpDevelop.
 * Utilizador: Frederico Garcia
 * Data: 02-08-2009
 * Hora: 14:03
 * 
 */
using System;
using System.Drawing;

namespace CodeFormatter.Handlers
{
	/// <summary>
	/// Description of ReplacementRange.
	/// </summary>
	public class ReplacementRange
	{
		Point mRangeInFormattedDoc;
		Point mRangeInOriginalDoc;
		public ReplacementRange(Point rangeInFormattedDoc, Point rangeInOrigDoc)
		{
			mRangeInOriginalDoc=rangeInOrigDoc;
			mRangeInFormattedDoc=rangeInFormattedDoc;
		}
		public Point GetRangeInFormattedDoc() {
			return mRangeInFormattedDoc;
		}
		public Point GetRangeInOriginalDoc() {
			return mRangeInOriginalDoc;
		}
	}
}
