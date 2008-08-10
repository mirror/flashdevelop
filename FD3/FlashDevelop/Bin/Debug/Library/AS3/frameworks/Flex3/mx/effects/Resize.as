/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public class Resize extends TweenEffect {
		/**
		 * Number of pixels by which to modify the height of the component.
		 *  Values may be negative.
		 */
		public var heightBy:Number;
		/**
		 * Initial height, in pixels.
		 *  If omitted, Flex uses the current height.
		 */
		public var heightFrom:Number;
		/**
		 * Final height, in pixels.
		 */
		public var heightTo:Number;
		/**
		 * An Array of Panel containers.
		 *  The children of these Panel containers are hidden while the Resize
		 *  effect plays.
		 */
		public var hideChildrenTargets:Array;
		/**
		 * Number of pixels by which to modify the width of the component.
		 *  Values may be negative.
		 */
		public var widthBy:Number;
		/**
		 * Initial width, in pixels.
		 *  If omitted, Flex uses the current width.
		 */
		public var widthFrom:Number;
		/**
		 * Final width, in pixels.
		 */
		public var widthTo:Number;
		/**
		 * Constructor.
		 *
		 * @param target            <Object (default = null)> The Object to animate with this effect.
		 */
		public function Resize(target:Object = null);
	}
}
