package flash.text
{
	/// The StyleSheet class lets you create a StyleSheet object that contains text formatting rules for font size, color, and other styles.
	public class StyleSheet extends flash.events.EventDispatcher
	{
		/// An array that contains the names (as strings) of all of the styles registered in this style sheet.
		public var styleNames:Array;

		/// Creates a new StyleSheet object.
		public function StyleSheet();

		/// Returns a copy of the style object associated with the style named styleName.
		public function getStyle(styleName:String):Object;

		/// Adds a new style with the specified name to the style sheet object.
		public function setStyle(styleName:String, styleObject:Object):void;

		/// Removes all styles from the style sheet object.
		public function clear():void;

		/// Extends the CSS parsing capability.
		public function transform(formatObject:Object):flash.text.TextFormat;

		/// Parses the CSS in cssText and loads the StyleSheet with it.
		public function parseCSS(CSSText:String):void;

	}

}

