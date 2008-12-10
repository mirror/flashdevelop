package mx.graphics
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import mx.core.FlexShape;
	import mx.utils.GraphicsUtil;

	/**
	 *  Drop shadows are typically created using the DropShadowFilter class. *  However, the DropShadowFilter, like all bitmap filters, *  can be computationally expensive. *  If the DropShadowFilter is applied to a DisplayObject, *  then the drop shadow is recalculated *  whenever the appearance of the object changes. *  If the DisplayObject is animated (using a Resize effect, for example), *  then the presence of drop shadows hurts the animation refresh rate. * *  <p>This class optimizes drop shadows for a common case. *  If you are applying a drop shadow to a rectangularly-shaped object *  whose edges fall on pixel boundaries, then this class should *  be used instead of using the DropShadowFilter directly.</p> * *  <p>This class accepts the first four parameters that are passed *  to DropShadowFilter: <code>alpha</code>, <code>angle</code>, *  <code>color</code>, and <code>distance</code>. *  In addition, this class accepts the corner radii for each of the four *  corners of the rectangularly-shaped object that is casting a shadow.</p> * *  <p>Once those 8 values have been set, *  this class pre-computes the drop shadow in an offscreen Bitmap. *  When the <code>drawShadow()</code> method is called, pieces of the *  precomputed drop shadow are  copied onto the passed-in Graphics object.</p> *   *  @see flash.filters.DropShadowFilter *  @see flash.display.DisplayObject
	 */
	public class RectangularDropShadow
	{
		/**
		 *  @private	 *  The drop shadow is rendered into this BitmapData object,	 *  which is later copied to the passed-in Graphics
		 */
		private var shadow : BitmapData;
		/**
		 *  @private
		 */
		private var leftShadow : BitmapData;
		/**
		 *  @private
		 */
		private var rightShadow : BitmapData;
		/**
		 *  @private
		 */
		private var topShadow : BitmapData;
		/**
		 *  @private
		 */
		private var bottomShadow : BitmapData;
		/**
		 *  @private	 *  Remembers whether any of the public properties have changed	 *  since the most recent call to drawDropShadow().
		 */
		private var changed : Boolean;
		/**
		 *  @private     *  Storage for the alpha property.
		 */
		private var _alpha : Number;
		/**
		 *  @private     *  Storage for the angle property.
		 */
		private var _angle : Number;
		/**
		 *  @private     *  Storage for the color property.
		 */
		private var _color : int;
		/**
		 *  @private     *  Storage for the distance property.
		 */
		private var _distance : Number;
		/**
		 *  @private     *  Storage for the tlRadius property.
		 */
		private var _tlRadius : Number;
		/**
		 *  @private     *  Storage for the trRadius property.
		 */
		private var _trRadius : Number;
		/**
		 *  @private     *  Storage for the blRadius property.
		 */
		private var _blRadius : Number;
		/**
		 *  @private     *  Storage for the brRadius property.
		 */
		private var _brRadius : Number;

		/**
		 *  @copy flash.filters.DropShadowFilter#alpha
		 */
		public function get alpha () : Number;
		/**
		 *  @private
		 */
		public function set alpha (value:Number) : void;
		/**
		 *  @copy flash.filters.DropShadowFilter#angle
		 */
		public function get angle () : Number;
		/**
		 *  @private
		 */
		public function set angle (value:Number) : void;
		/**
		 *  @copy flash.filters.DropShadowFilter#color
		 */
		public function get color () : int;
		/**
		 *  @private
		 */
		public function set color (value:int) : void;
		/**
		 *  @copy flash.filters.DropShadowFilter#distance
		 */
		public function get distance () : Number;
		/**
		 *  @private
		 */
		public function set distance (value:Number) : void;
		/**
		 *  The corner radius of the top left corner	 *  of the rounded rectangle that is casting the shadow.	 *  May be zero for non-rounded rectangles.
		 */
		public function get tlRadius () : Number;
		/**
		 *  @private
		 */
		public function set tlRadius (value:Number) : void;
		/**
		 *  The corner radius of the top right corner	 *  of the rounded rectangle that is casting the shadow.	 *  May be zero for non-rounded rectangles.
		 */
		public function get trRadius () : Number;
		/**
		 *  @private
		 */
		public function set trRadius (value:Number) : void;
		/**
		 *  The corner radius of the bottom left corner	 *  of the rounded rectangle that is casting the shadow.	 *  May be zero for non-rounded     *  rectangles.
		 */
		public function get blRadius () : Number;
		/**
		 *  @private
		 */
		public function set blRadius (value:Number) : void;
		/**
		 *  The corner radius of the bottom right corner	 *  of the rounded rectangle that is casting the shadow.	 *  May be zero for non-rounded rectangles.
		 */
		public function get brRadius () : Number;
		/**
		 *  @private
		 */
		public function set brRadius (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function RectangularDropShadow ();
		/**
		 *  Renders the shadow on the screen.      *       *  @param g The Graphics object on which to draw the shadow.     *       *  @param x The horizontal offset of the drop shadow,	 *  based on the Graphics object's position.     *       *  @param y The vertical offset of the drop shadow,	 *  based on the Graphics object's position.     *       *  @param width The width of the shadow, in pixels.     *       *  @param height The height of the shadow, in pixels.
		 */
		public function drawShadow (g:Graphics, x:Number, y:Number, width:Number, height:Number) : void;
		/**
		 *  @private	 *  Render the drop shadow for the rounded rectangle	 *  in a small BitmapData object.	 *  The shadow will be copied onto the graphics object	 *  passed into drawDropShadow().
		 */
		private function createShadowBitmaps () : void;
	}
}
