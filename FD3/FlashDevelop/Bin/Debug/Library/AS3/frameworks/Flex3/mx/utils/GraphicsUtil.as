package mx.utils
{
	import flash.display.Graphics;

include "../core/Version.as"
	/**
	 *  The Graphics class is an all-static class with utility methods
 *  related to the Graphics class.
 *  You do not create instances of GraphicsUtil;
 *  instead you simply call methods such as the
 *  <code>GraphicsUtil.drawRoundRectComplex()</code> method.
	 */
	public class GraphicsUtil
	{
		/**
		 * Draws a rounded rectangle using the size of a radius to draw the rounded corners. 
	 * You must set the line style, fill, or both 
	 * on the Graphics object before 
	 * you call the <code>drawRoundRectComplex()</code> method 
	 * by calling the <code>linestyle()</code>, 
	 * <code>lineGradientStyle()</code>, <code>beginFill()</code>, 
	 * <code>beginGradientFill()</code>, or 
	 * <code>beginBitmapFill()</code> method.
	 * 
     * @param graphics The Graphics object that draws the rounded rectangle.
     *
     * @param x The horizontal position relative to the 
     * registration point of the parent display object, in pixels.
     * 
     * @param y The vertical position relative to the 
     * registration point of the parent display object, in pixels.
     * 
     * @param width The width of the round rectangle, in pixels.
     * 
     * @param height The height of the round rectangle, in pixels.
     * 
     * @param topLeftRadius The radius of the upper-left corner, in pixels.
     * 
     * @param toRightRadius The radius of the upper-right corner, in pixels.
     * 
     * @param bottomLeftRadius The radius of the bottom-left corner, in pixels.
     * 
     * @param bottomRightRadius The radius of the bottom-right corner, in pixels.
     *
		 */
		public static function drawRoundRectComplex (graphics:Graphics, x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number) : void;
	}
}
