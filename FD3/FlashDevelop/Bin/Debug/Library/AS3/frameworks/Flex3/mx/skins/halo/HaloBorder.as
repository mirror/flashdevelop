package mx.skins.halo
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import mx.core.IContainer;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.graphics.RectangularDropShadow;
	import mx.skins.RectangularBorder;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;
	import mx.graphics.GradientEntry;

include "../../core/Version.as"
	/**
	 *  Defines the appearance of the default border for the Halo theme.
	 */
	public class HaloBorder extends RectangularBorder
	{
		/**
		 *  @private
	 *  A look up table for the offsets.
		 */
		private static var BORDER_WIDTHS : Object;
		/**
		 *  @private
	 *  A reference to the object used to cast a drop shadow.
	 *  See the drawDropShadow() method for details.
		 */
		private var dropShadow : RectangularDropShadow;
		var backgroundColor : Object;
		var backgroundAlphaName : String;
		var backgroundHole : Object;
		var bRoundedCorners : Boolean;
		var radius : Number;
		var radiusObj : Object;
		/**
		 *  @private
	 *  Internal object that contains the thickness of each edge
	 *  of the border
		 */
		protected var _borderMetrics : EdgeMetrics;

		/**
		 *  @private
	 *  Return the thickness of the border edges.
	 *
	 *  @return Object	top, bottom, left, right thickness in pixels
		 */
		public function get borderMetrics () : EdgeMetrics;

		/**
		 *  Constructor.
		 */
		public function HaloBorder ();

		/**
		 *  @private
	 *  If borderStyle may have changed, clear the cached border metrics.
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
	 *  Draw the border, either 3D or 2D or nothing at all.
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;

		/**
		 *  @private
		 */
		function drawBorder (w:Number, h:Number) : void;

		/**
		 *  @private
	 *  Draw a 3D border.
		 */
		function draw3dBorder (c1:Number, c2:Number, c3:Number, c4:Number, c5:Number, c6:Number) : void;

		/**
		 *  @private
		 */
		function drawBackground (w:Number, h:Number) : void;

		/**
		 *  @private
	 *  Apply a drop shadow using a bitmap filter.
	 *
	 *  Bitmap filters are slow, and their slowness is proportional
	 *  to the number of pixels being filtered.
	 *  For a large HaloBorder, it's wasteful to create a big shadow.
	 *  Instead, we'll create the shadow offscreen
	 *  and stretch it to fit the HaloBorder.
		 */
		function drawDropShadow (x:Number, y:Number, width:Number, height:Number, tlRadius:Number, trRadius:Number, brRadius:Number, blRadius:Number) : void;

		/**
		 *  @private
	 *  Convert the value of the shadowDirection property
	 *  into a shadow angle.
		 */
		function getDropShadowAngle (distance:Number, direction:String) : Number;

		/**
		 *  @private
		 */
		function getBackgroundColor () : Object;

		/**
		 *  @private
		 */
		function getBackgroundColorMetrics () : EdgeMetrics;
	}
}
