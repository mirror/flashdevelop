package flash.display
{
	/// Defines a line style or stroke.
	public class GraphicsStroke
	{
		/// Indicates the thickness of the line in points; valid values are 0-255.
		public var thickness:Number;

		/// Specifies whether to hint strokes to full pixels.
		public var pixelHinting:Boolean;

		/// Indicates the limit at which a miter is cut off.
		public var miterLimit:Number;

		/// Specifies the instance containing data for filling a stroke.
		public var fill:flash.display.IGraphicsFill;

		/// Specifies the type of caps at the end of lines.
		public var caps:String;

		/// Specifies the type of joint appearance used at angles.
		public var joints:String;

		/// Specifies the stroke thickness scaling.
		public var scaleMode:String;

		/// [FP10] Creates a new GraphicsStroke object.
		public function GraphicsStroke(thickness:Number=unknown, pixelHinting:Boolean=false, scaleMode:String=normal, caps:String=none, joints:String=round, miterLimit:Number=3.0, fill:flash.display.IGraphicsFill=null);

	}

}

