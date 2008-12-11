package flash.display
{
	/// The Graphics class contains a set of methods that you can use to create a vector shape.
	public class Graphics
	{
		/// Clears the graphics that were drawn to this Graphics object, and resets fill and line style settings.
		public function clear():void;

		/// Specifies a single-color fill.
		public function beginFill(color:uint, alpha:Number=1.0):void;

		/// Specifies a gradient fill.
		public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:flash.geom.Matrix=null, spreadMethod:String=pad, interpolationMethod:String=rgb, focalPointRatio:Number=0):void;

		/// Begins a bitmap filled shape.
		public function beginBitmapFill(bitmap:flash.display.BitmapData, matrix:flash.geom.Matrix=null, repeat:Boolean=true, smooth:Boolean=false):void;

		/// Specifies a gradient to use for the stroke when drawing lines.
		public function lineGradientStyle(type:String, colors:Array, alphas:Array, ratios:Array, matrix:flash.geom.Matrix=null, spreadMethod:String=pad, interpolationMethod:String=rgb, focalPointRatio:Number=0):void;

		/// Specifies a line style that Flash uses for drawing lines.
		public function lineStyle(thickness:Number=unknown, color:uint=0, alpha:Number=1.0, pixelHinting:Boolean=false, scaleMode:String=normal, caps:String=null, joints:String=null, miterLimit:Number=3):void;

		/// Draws a round rectangle.
		public function drawRect(x:Number, y:Number, width:Number, height:Number):void;

		/// Draws a round rectangle.
		public function drawRoundRect(x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number, ellipseHeight:Number=unknown):void;

		/// Draws a circle.
		public function drawCircle(x:Number, y:Number, radius:Number):void;

		/// Draws an ellipse.
		public function drawEllipse(x:Number, y:Number, width:Number, height:Number):void;

		/// Moves the current drawing position to (x, y).
		public function moveTo(x:Number, y:Number):void;

		/// Draws a line from the current drawing position to (x, y).
		public function lineTo(x:Number, y:Number):void;

		/// Draws a curve from the current drawing position to (anchorX, anchorY) using the control point specified by (controlX, controlY).
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void;

		/// Applies a fill to the lines and curves.
		public function endFill():void;

	}

}

