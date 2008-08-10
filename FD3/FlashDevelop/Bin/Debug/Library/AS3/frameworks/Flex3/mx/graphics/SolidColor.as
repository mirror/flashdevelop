/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.graphics {
	import flash.events.EventDispatcher;
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	public class SolidColor extends EventDispatcher implements IFill {
		/**
		 * The transparency of a color.
		 *  Possible values are 0.0 (invisible) through 1.0 (opaque).
		 */
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		/**
		 * A color value.
		 */
		public function get color():uint;
		public function set color(value:uint):void;
		/**
		 * Constructor.
		 *
		 * @param color             <uint (default = 0x000000)> Specifies the color.
		 *                            The default value is 0x000000 (black).
		 * @param alpha             <Number (default = 1.0)> Specifies the level of transparency.
		 *                            Valid values range from 0.0 (completely transparent)
		 *                            to 1.0 (completely opaque).
		 *                            The default value is 1.0.
		 */
		public function SolidColor(color:uint = 0x000000, alpha:Number = 1.0);
		/**
		 * Starts the fill.
		 *
		 * @param target            <Graphics> The target Graphics object that is being filled.
		 * @param rc                <Rectangle> The Rectangle object that defines the size of the fill
		 *                            inside the target.
		 *                            If the dimensions of the Rectangle are larger than the dimensions
		 *                            of the target, the fill is clipped.
		 *                            If the dimensions of the Rectangle are smaller than the dimensions
		 *                            of the target, the fill expands to fill the entire
		 *                            target.
		 */
		public function begin(target:Graphics, rc:Rectangle):void;
		/**
		 * Ends the fill.
		 *
		 * @param target            <Graphics> The Graphics object that is being filled.
		 */
		public function end(target:Graphics):void;
	}
}
