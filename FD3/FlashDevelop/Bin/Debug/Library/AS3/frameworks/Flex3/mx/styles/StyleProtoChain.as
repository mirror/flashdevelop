package mx.styles
{
	import flash.display.DisplayObject;
	import mx.core.UIComponent;
	import mx.core.IUITextField;
	import mx.core.mx_internal;
	import mx.styles.IStyleClient;
	import mx.styles.StyleProxy;

	/**
	 *  @private *  This is an all-static class with methods for building the protochains *  that Flex uses to look up CSS style properties.
	 */
	public class StyleProtoChain
	{
		/**
		 *  @private	 *  If the styleName property points to a UIComponent, then we search	 *  for stylable properties in the following order:	 *  	 *  1) Look for inline styles on this object	 *  2) Look for inline styles on the styleName object	 *  3) Look for class selectors on the styleName object	 *  4) Look for type selectors on the styleName object	 *  5) Look for type selectors on this object	 *  6) Follow the usual search path for the styleName object	 *  	 *  If this object doesn't have any type selectors, then the	 *  search path can be simplified to two steps:	 *  	 *  1) Look for inline styles on this object	 *  2) Follow the usual search path for the styleName object
		 */
		public static function initProtoChainForUIComponentStyleName (obj:IStyleClient) : void;
		/**
		 *  See the comment for the initProtoChainForUIComponentStyleName	 *  function. The comment for that function includes a six-step	 *  sequence. This sub-function implements the following pieces	 *  of that sequence:	 *  	 *  2) Look for inline styles on the styleName object	 *  3) Look for class selectors on the styleName object	 *  4) Look for type selectors on the styleName object	 *  	 *   This piece is broken out as a separate function so that it	 *  can be called recursively when the styleName object has a	 *  styleName property is itself another UIComponent.
		 */
		private static function addProperties (chain:Object, obj:IStyleClient, bInheriting:Boolean) : Object;
		/**
		 *  @private
		 */
		public static function initTextField (obj:IUITextField) : void;
	}
}
