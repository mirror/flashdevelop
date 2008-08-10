/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.graphics {
	import flash.events.EventDispatcher;
	public class GradientEntry extends EventDispatcher {
		/**
		 * The transparency of a gradient fill.
		 *  Possible values are 0.0 (invisible) through 1.0 (opaque).
		 */
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		/**
		 * The color value for a gradient fill.
		 */
		public function get color():uint;
		public function set color(value:uint):void;
		/**
		 * Where in the graphical element, as a percentage from 0.0 to 1.0,
		 *  Flex starts the transition to the associated color.
		 *  For example, a ratio of 0.33 means Flex begins the transition
		 *  to that color 33% of the way through the graphical element.
		 */
		public function get ratio():Number;
		public function set ratio(value:Number):void;
		/**
		 * Constructor.
		 *
		 * @param color             <uint (default = 0x000000)> The color for this gradient entry.
		 *                            The default value is 0x000000 (black).
		 * @param ratio             <Number (default = -1.0)> Where in the graphical element to start
		 *                            the transition to the associated color.
		 *                            Flex uniformly spaces any GradientEntries
		 *                            with missing ratio values.
		 *                            The default value is -1.0.
		 * @param alpha             <Number (default = 1.0)> The alpha value for this entry in the gradient.
		 *                            This parameter is optional. The default value is 1.0.
		 */
		public function GradientEntry(color:uint = 0x000000, ratio:Number = -1.0, alpha:Number = 1.0);
	}
}
