/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	public class LinkBar extends NavBar {
		/**
		 * The index of the last selected LinkButton control if the LinkBar
		 *  control uses a ViewStack container as its data provider.
		 */
		public function get selectedIndex():int;
		public function set selectedIndex(value:int):void;
		/**
		 * Constructor.
		 */
		public function LinkBar();
		/**
		 * Detects changes to style properties. When any style property is set,
		 *  Flex calls the styleChanged() method,
		 *  passing to it the name of the style being set.
		 *
		 * @param styleProp         <String> The name of the style property that changed.
		 */
		public override function styleChanged(styleProp:String):void;
		/**
		 * Responds to size changes by setting the positions and sizes
		 *  of this LinkBar control's children.
		 *  For more information about the updateDisplayList() method,
		 *  see the UIComponent.updateDisplayList() method.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            of the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void;
	}
}
