/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.styles {
	public interface ISimpleStyleClient {
		/**
		 * The source of this object's style values.
		 *  The value of the styleName property can be one of three possible types:
		 *  String, such as "headerStyle". The String names a class selector that is defined in a CSS style sheet.
		 *  CSSStyleDeclaration, such as StyleManager.getStyleDeclaration(".headerStyle").
		 *  UIComponent. The object that implements this interface inherits all the style values from the referenced UIComponent.
		 */
		public function get styleName():Object;
		public function set styleName(value:Object):void;
		/**
		 * Called when the value of a style property is changed.
		 *
		 * @param styleProp         <String> The name of the style property that changed.
		 */
		public function styleChanged(styleProp:String):void;
	}
}
