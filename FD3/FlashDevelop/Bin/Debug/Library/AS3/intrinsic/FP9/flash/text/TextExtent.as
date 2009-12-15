package flash.text
{
	/// The TextExtent class contains information about the extents of some text in a text field.
	public class TextExtent extends Object
	{
		public var ascent : Number;
		public var descent : Number;
		public var height : Number;
		public var textFieldHeight : Number;
		public var textFieldWidth : Number;
		public var width : Number;

		/// The TextExtent class contains information about the extents of some text in a text field.
		public function TextExtent (width:Number, height:Number, textFieldWidth:Number, textFieldHeight:Number, ascent:Number, descent:Number);
	}
}
