/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.graphics {
	import flash.display.Graphics;
	public class RectangularDropShadow {
		/**
		 * The alpha transparency value for the shadow color. Valid values are 0.0 to 1.0.
		 *  For example,
		 *  .25 sets a transparency value of 25%. The default value is 1.0.
		 */
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		/**
		 * The angle of the shadow. Valid values are 0 to 360 degrees (floating point). The
		 *  default value is 45.
		 */
		public function get angle():Number;
		public function set angle(value:Number):void;
		/**
		 * The corner radius of the bottom left corner
		 *  of the rounded rectangle that is casting the shadow.
		 *  May be zero for non-rounded
		 *  rectangles.
		 */
		public function get blRadius():Number;
		public function set blRadius(value:Number):void;
		/**
		 * The corner radius of the bottom right corner
		 *  of the rounded rectangle that is casting the shadow.
		 *  May be zero for non-rounded rectangles.
		 */
		public function get brRadius():Number;
		public function set brRadius(value:Number):void;
		/**
		 * The color of the shadow. Valid values are in hexadecimal format 0xRRGGBB. The
		 *  default value is 0x000000.
		 */
		public function get color():int;
		public function set color(value:int):void;
		/**
		 * The offset distance for the shadow, in pixels. The default
		 *  value is 4.0 (floating point).
		 */
		public function get distance():Number;
		public function set distance(value:Number):void;
		/**
		 * The corner radius of the top left corner
		 *  of the rounded rectangle that is casting the shadow.
		 *  May be zero for non-rounded rectangles.
		 */
		public function get tlRadius():Number;
		public function set tlRadius(value:Number):void;
		/**
		 * The corner radius of the top right corner
		 *  of the rounded rectangle that is casting the shadow.
		 *  May be zero for non-rounded rectangles.
		 */
		public function get trRadius():Number;
		public function set trRadius(value:Number):void;
		/**
		 * Constructor.
		 */
		public function RectangularDropShadow();
		/**
		 * Renders the shadow on the screen.
		 *
		 * @param g                 <Graphics> The Graphics object on which to draw the shadow.
		 * @param x                 <Number> The horizontal offset of the drop shadow,
		 *                            based on the Graphics object's position.
		 * @param y                 <Number> The vertical offset of the drop shadow,
		 *                            based on the Graphics object's position.
		 * @param width             <Number> The width of the shadow, in pixels.
		 * @param height            <Number> The height of the shadow, in pixels.
		 */
		public function drawShadow(g:Graphics, x:Number, y:Number, width:Number, height:Number):void;
	}
}
