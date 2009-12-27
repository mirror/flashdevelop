package mx.graphics
{
	import flash.geom.Rectangle;

include "../core/Version.as"
	/**
	 *  RoundedRectangle represents a Rectangle with curved corners
	 */
	public class RoundedRectangle extends Rectangle
	{
		/**
		 *  The radius of each corner (in pixels).
	 *  
	 *  @default 0
		 */
		public var cornerRadius : Number;

		/**
		 *  Constructor.
	 *
	 *  @param x The x coordinate of the top-left corner of the rectangle.
	 *
	 *  @param y The y coordinate of the top-left corner of the rectangle.
	 *
	 *  @param width The width of the rectangle, in pixels.
	 *
	 *  @param height The height of the rectangle, in pixels.
	 *
	 *  @param cornerRadius The radius of each corner, in pixels.
		 */
		public function RoundedRectangle (x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, cornerRadius:Number = 0);
	}
}
