/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	import flash.display.Graphics;
	public class GraphicsUtil {
		/**
		 * Draws a rounded rectangle using the size of a radius to draw the rounded corners.
		 *  You must set the line style, fill, or both
		 *  on the Graphics object before
		 *  you call the drawRoundRectComplex() method
		 *  by calling the linestyle(),
		 *  lineGradientStyle(), beginFill(),
		 *  beginGradientFill(), or
		 *  beginBitmapFill() method.
		 *
		 * @param graphics          <Graphics> The Graphics object that draws the rounded rectangle.
		 * @param x                 <Number> The horizontal position relative to the
		 *                            registration point of the parent display object, in pixels.
		 * @param y                 <Number> The vertical position relative to the
		 *                            registration point of the parent display object, in pixels.
		 * @param width             <Number> The width of the round rectangle, in pixels.
		 * @param height            <Number> The height of the round rectangle, in pixels.
		 * @param topLeftRadius     <Number> The radius of the upper-left corner, in pixels.
		 * @param topRightRadius    <Number> The radius of the upper-right corner, in pixels.
		 * @param bottomLeftRadius  <Number> The radius of the bottom-left corner, in pixels.
		 * @param bottomRightRadius <Number> The radius of the bottom-right corner, in pixels.
		 */
		public static function drawRoundRectComplex(graphics:Graphics, x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number):void;
	}
}
