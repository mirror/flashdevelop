/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.effectClasses {
	public class ResizeInstance extends TweenEffectInstance {
		/**
		 * Number of pixels by which to modify the height of the component.
		 *  Values may be negative.
		 */
		public function get heightBy():Number;
		public function set heightBy(value:Number):void;
		/**
		 * Initial height. If omitted, Flex uses the current size.
		 */
		public var heightFrom:Number;
		/**
		 * Final height, in pixels.
		 */
		public function get heightTo():Number;
		public function set heightTo(value:Number):void;
		/**
		 * An Array of Panels.
		 *  The children of these Panels are hidden while the Resize effect plays.
		 */
		public var hideChildrenTargets:Array;
		/**
		 * Number of pixels by which to modify the width of the component.
		 *  Values may be negative.
		 */
		public function get widthBy():Number;
		public function set widthBy(value:Number):void;
		/**
		 * Initial width. If omitted, Flex uses the current size.
		 */
		public var widthFrom:Number;
		/**
		 * Final width, in pixels.
		 */
		public function get widthTo():Number;
		public function set widthTo(value:Number):void;
		/**
		 * Constructor.
		 *
		 * @param target            <Object> The Object to animate with this effect.
		 */
		public function ResizeInstance(target:Object);
	}
}
