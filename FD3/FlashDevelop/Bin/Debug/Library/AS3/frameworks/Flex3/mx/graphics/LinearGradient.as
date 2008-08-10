/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.graphics {
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	public class LinearGradient extends GradientBase implements IFill {
		/**
		 * Controls the transition direction.
		 */
		public function get angle():Number;
		public function set angle(value:Number):void;
		/**
		 * Constructor.
		 */
		public function LinearGradient();
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
