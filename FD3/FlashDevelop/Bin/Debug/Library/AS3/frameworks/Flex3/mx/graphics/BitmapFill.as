/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.graphics {
	public class BitmapFill implements IFill {
		/**
		 * How far the bitmap is horizontally offset from the origin.
		 *  This adjustment is performed after rotation and scaling.
		 */
		public var offsetX:Number = 0;
		/**
		 * How far the bitmap is vertically offset from the origin.
		 *  This adjustment is performed after rotation and scaling.
		 */
		public var offsetY:Number = 0;
		/**
		 * The horizontal origin for the bitmap fill.
		 *  The bitmap fill is offset so that this point appears at the origin.
		 *  Scaling and rotation of the bitmap are performed around this point.
		 */
		public var originX:Number = 0;
		/**
		 * The vertical origin for the bitmap fill.
		 *  The bitmap fill is offset so that this point appears at the origin.
		 *  Scaling and rotation of the bitmap are performed around this point.
		 */
		public var originY:Number = 0;
		/**
		 * Whether the bitmap is repeated to fill the area.
		 *  Set to true to cause the fill to tile outward
		 *  to the edges of the filled region.
		 *  Set to false to end the fill at the edge of the region.
		 */
		public var repeat:Boolean = true;
		/**
		 * The number of degrees to rotate the bitmap.
		 *  Valid values range from 0.0 to 360.0.
		 */
		public var rotation:Number = 0.0;
		/**
		 * The percent to horizontally scale the bitmap when filling,
		 *  from 0.0 to 1.0.
		 *  If 1.0, the bitmap is filled at its natural size.
		 */
		public var scaleX:Number = 1.0;
		/**
		 * The percent to vertically scale the bitmap when filling,
		 *  from 0.0 to 1.0.
		 *  If 1.0, the bitmap is filled at its natural size.
		 */
		public var scaleY:Number = 1.0;
		/**
		 * A flag indicating whether to smooth the bitmap data
		 *  when filling with it.
		 */
		public var smooth:Boolean = false;
		/**
		 * The source used for the bitmap fill.
		 *  The fill can render from various graphical sources,
		 *  including the following:
		 *  A Bitmap or BitmapData instance.
		 *  A class representing a subclass of DisplayObject.
		 *  The BitmapFill instantiates the class
		 *  and creates a bitmap rendering of it.
		 *  An instance of a DisplayObject.
		 *  The BitmapFill copies it into a Bitmap for filling.
		 *  The name of a subclass of DisplayObject.
		 *  The BitmapFill loads the class, instantiates it,
		 *  and creates a bitmap rendering of it.
		 */
		public function get source():Object;
		public function set source(value:Object):void;
		/**
		 * Constructor.
		 */
		public function BitmapFill();
	}
}
