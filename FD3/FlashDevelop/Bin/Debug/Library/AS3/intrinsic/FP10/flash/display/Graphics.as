package flash.display
{
	import flash.display.Shader;
	import flash.geom.Matrix;
	import flash.display.BitmapData;
	import flash.display.IGraphicsData;
	import flash.display.Graphics;

	/// The Graphics class contains a set of methods that you can use to create a vector shape.
	public class Graphics extends Object
	{
		/// Begins a bitmap filled shape.
		public function beginBitmapFill (bitmap:BitmapData, matrix:Matrix, repeat:Boolean, smooth:Boolean) : void;

		/// Specifies a single-color fill.
		public function beginFill (color:uint, alpha:Number) : void;

		/// Specifies a gradient fill.
		public function beginGradientFill (type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix, spreadMethod:String, interpolationMethod:String, focalPointRatio:Number) : void;

		/// Specifies a shader fill.
		public function beginShaderFill (shader:Shader, matrix:Matrix) : void;

		/// Clears the graphics that were drawn to this Graphics object, and resets fill and line style settings.
		public function clear () : void;

		/// Copies all of drawing commands from the source Graphics object into the calling Graphics object.
		public function copyFrom (sourceGraphics:Graphics) : void;

		/// Draws a curve from the current drawing position to (anchorX, anchorY) using the control point specified by (controlX, controlY).
		public function curveTo (controlX:Number, controlY:Number, anchorX:Number, anchorY:Number) : void;

		/// Draws a circle.
		public function drawCircle (x:Number, y:Number, radius:Number) : void;

		/// Draws an ellipse.
		public function drawEllipse (x:Number, y:Number, width:Number, height:Number) : void;

		/// Submits a series of IGraphicsData instances for drawing.
		public function drawGraphicsData (graphicsData:Vector.<IGraphicsData>) : void;

		/// Submits a series of commands for drawing.
		public function drawPath (commands:Vector.<int>, data:Vector.<Number>, winding:String) : void;

		/// Draws a round rectangle.
		public function drawRect (x:Number, y:Number, width:Number, height:Number) : void;

		/// Draws a round rectangle.
		public function drawRoundRect (x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number, ellipseHeight:Number) : void;

		public function drawRoundRectComplex (x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number) : void;

		/// Renders a set of triangles, typically to distort bitmaps and give them a three-dimensional appearance.
		public function drawTriangles (vertices:Vector.<Number>, indices:Vector.<int>, uvtData:Vector.<Number>, culling:String) : void;

		/// Applies a fill to the lines and curves.
		public function endFill () : void;

		/// Specifies a bitmap to use for the line stroke when drawing lines.
		public function lineBitmapStyle (bitmap:BitmapData, matrix:Matrix, repeat:Boolean, smooth:Boolean) : void;

		/// Specifies a gradient to use for the stroke when drawing lines.
		public function lineGradientStyle (type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix, spreadMethod:String, interpolationMethod:String, focalPointRatio:Number) : void;

		/// Specifies a shader to use for the line stroke when drawing lines.
		public function lineShaderStyle (shader:Shader, matrix:Matrix) : void;

		/// Specifies a line style that Flash uses for drawing lines.
		public function lineStyle (thickness:Number, color:uint, alpha:Number, pixelHinting:Boolean, scaleMode:String, caps:String, joints:String, miterLimit:Number) : void;

		/// Draws a line from the current drawing position to (x, y).
		public function lineTo (x:Number, y:Number) : void;

		/// Moves the current drawing position to (x, y).
		public function moveTo (x:Number, y:Number) : void;
	}
}
