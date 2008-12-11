package flash.text.engine
{
	/// The TabStop class represents the properties of a tab stop in a text block.
	public class TabStop
	{
		/// Specifies the tab alignment for this tab stop.
		public var alignment:String;

		/// The position of the tab stop, in pixels, relative to the start of the text line.
		public var position:Number;

		/// Specifies the alignment token to use when you set the alignment property to TabAlignment.DECIMAL.
		public var decimalAlignmentToken:String;

		/// [FP10] Creates a new TabStop.
		public function TabStop(alignment:String=start, position:Number=0.0, decimalAlignmentToken:String=null);

	}

}

