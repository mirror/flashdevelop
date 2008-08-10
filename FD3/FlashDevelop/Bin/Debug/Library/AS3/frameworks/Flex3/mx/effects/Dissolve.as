/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public class Dissolve extends TweenEffect {
		/**
		 * Initial transparency level between 0.0 and 1.0,
		 *  where 0.0 means transparent and 1.0 means fully opaque.
		 */
		public var alphaFrom:Number;
		/**
		 * Final transparency level between 0.0 and 1.0,
		 *  where 0.0 means transparent and 1.0 means fully opaque.
		 */
		public var alphaTo:Number;
		/**
		 * Hex value that represents the color of the floating rectangle
		 *  that the effect displays over the target object.
		 *  The default value is the color specified by the target component's
		 *  backgroundColor style property, or 0xFFFFFF, if
		 *  backgroundColor is not set.
		 */
		public var color:uint = 0xFFFFFFFF;
		/**
		 * The area of the target to play the effect upon.
		 *  The dissolve overlay is drawn using this property's dimensions.
		 *  UIComponents create an overlay over the entire component.
		 *  Containers create an overlay over their content area,
		 *  but not their chrome.
		 */
		public var targetArea:RoundedRectangle;
		/**
		 * Constructor.
		 *
		 * @param target            <Object (default = null)> The Object to animate with this effect.
		 */
		public function Dissolve(target:Object = null);
	}
}
