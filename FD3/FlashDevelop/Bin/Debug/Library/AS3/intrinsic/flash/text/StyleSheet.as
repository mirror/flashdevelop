/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.text {
	import flash.events.EventDispatcher;
	public dynamic  class StyleSheet extends EventDispatcher {
		/**
		 * An array that contains the names (as strings) of all of the styles registered
		 *  in this style sheet.
		 */
		public function get styleNames():Array;
		/**
		 * Creates a new StyleSheet object.
		 */
		public function StyleSheet();
		/**
		 * Removes all styles from the style sheet object.
		 */
		public function clear():void;
		/**
		 * Returns a copy of the style object associated with the style named styleName.
		 *  If there is no style object associated with styleName,
		 *  null is returned.
		 *
		 * @param styleName         <String> A string that specifies the name of the style to retrieve.
		 * @return                  <Object> An object.
		 */
		public function getStyle(styleName:String):Object;
		/**
		 * Parses the CSS in CSSText and loads the style sheet with it. If a style in
		 *  CSSText is already in styleSheet, the properties in
		 *  styleSheet are retained, and only the ones in CSSText
		 *  are added or changed in styleSheet.
		 *
		 * @param CSSText           <String> The CSS text to parse (a string).
		 */
		public function parseCSS(CSSText:String):void;
		/**
		 * Adds a new style with the specified name to the style sheet object.
		 *  If the named style does not already exist in the style sheet, it is added.
		 *  If the named style already exists in the style sheet, it is replaced.
		 *  If the styleObject parameter is null, the named style is removed.
		 *
		 * @param styleName         <String> A string that specifies the name of the style to add to the style sheet.
		 * @param styleObject       <Object> An object that describes the style, or null.
		 */
		public function setStyle(styleName:String, styleObject:Object):void;
		/**
		 * Extends the CSS parsing capability. Advanced developers can override this method by extending the
		 *  StyleSheet class.
		 *
		 * @param formatObject      <Object> An object that describes the style, containing style rules as properties of the object,
		 *                            or null.
		 * @return                  <TextFormat> A TextFormat object containing the result of the mapping of CSS rules
		 *                            to text format properties.
		 */
		public function transform(formatObject:Object):TextFormat;
	}
}
