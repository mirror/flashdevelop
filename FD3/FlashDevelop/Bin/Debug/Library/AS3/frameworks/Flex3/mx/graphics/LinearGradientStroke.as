package mx.graphics
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import mx.core.mx_internal;

	/**
	 *  The LinearGradientStroke class lets you specify a gradient filled stroke. *  You use the LinearGradientStroke class, along with the GradientEntry class, *  to define a gradient stroke. *   *  @see mx.graphics.Stroke *  @see mx.graphics.GradientEntry *  @see mx.graphics.RadialGradient  *  @see flash.display.Graphics
	 */
	public class LinearGradientStroke extends GradientBase implements IStroke
	{
		/**
		 *  @private     *  Storage for the angle property.
		 */
		private var _rotation : Number;
		/**
		 *  @private     *  Storage for the caps property.
		 */
		private var _caps : String;
		/**
		 *  @private     *  Storage for the interpolationMethod property.
		 */
		private var _interpolationMethod : String;
		/**
		 *  @private     *  Storage for the joints property.
		 */
		private var _joints : String;
		/**
		 *  @private     *  Storage for the miterLimit property.
		 */
		private var _miterLimit : Number;
		/**
		 *  @private     *  Storage for the pixelHinting property.
		 */
		private var _pixelHinting : Boolean;
		/**
		 *  @private     *  Storage for the scaleMode property.
		 */
		private var _scaleMode : String;
		/**
		 *  @private     *  Storage for the spreadMethod property.
		 */
		private var _spreadMethod : String;
		/**
		 *  @private     *  Storage for the weight property.
		 */
		private var _weight : Number;

		/**
		 *  By default, the LinearGradientStroke defines a transition     *  from left to right across the control.      *  Use the <code>angle</code> property to control the transition direction.      *  For example, a value of 180.0 causes the transition     *  to occur from right to left, rather than from left to right.     *     *  @default 0.0
		 */
		public function get angle () : Number;
		/**
		 *  @private
		 */
		public function set angle (value:Number) : void;
		/**
		 *  A value from the CapsStyle class     *  that specifies the type of caps at the end of lines.     *     *  <p>Valid values are <code>CapsStyle.NONE</code>,     *  <code>CapsStyle.ROUND</code>, and <code>CapsStyle.SQUARE</code>.     *  A <code>null</code> value is equivalent to     *  <code>CapsStyle.ROUND</code>.</p>     *     *  @default null
		 */
		public function get caps () : String;
		/**
		 *  @private
		 */
		public function set caps (value:String) : void;
		/**
		 *  A value from the InterpolationMethod class     *  that specifies which interpolation method to use.     *     *  <p>Valid values are <code>InterpolationMethod.LINEAR_RGB</code>     *  and <code>InterpolationMethod.RGB</code>.</p>     *       *  @default InterpolationMethod.RGB
		 */
		public function get interpolationMethod () : String;
		/**
		 *  @private
		 */
		public function set interpolationMethod (value:String) : void;
		/**
		 *  A value from the JointStyle class that specifies the type     *  of joint appearance used at angles.     *     *  <p>Valid values are <code>JointStyle.BEVEL</code>,     *  <code>JointStyle.MITER</code>, and <code>JointStyle.ROUND</code>.     *  A <code>null</code> value is equivalent to     *  <code>JoinStyle.ROUND</code>.</p>     *       *  @default null
		 */
		public function get joints () : String;
		/**
		 *  @private
		 */
		public function set joints (value:String) : void;
		/**
		 *  A number that indicates the limit at which a miter is cut off.      *     *  <p>Valid values range from 0 to 255     *  (and values outside of that range are rounded to 0 or 255).</p>     *     *  <p>This value is only used if the <code>jointStyle</code>      *  is set to <code>JointStyle.MITER</code>.</p>     *     *  <p>The <code>miterLimit</code> value represents the length that a miter     *  can extend beyond the point at which the lines meet to form a joint.     *  The value expresses a factor of the line <code>thickness</code>.     *  For example, with a <code>miterLimit</code> factor of 2.5     *  and a <code>thickness</code> of 10 pixels,     *  the miter is cut off at 25 pixels.</p>     *       *  @default 0
		 */
		public function get miterLimit () : Number;
		/**
		 *  @private
		 */
		public function set miterLimit (value:Number) : void;
		/**
		 *  A Boolean value that specifies whether to hint strokes to full pixels.     *     *  <p>This affects both the position of anchors of a curve     *  and the line stroke size itself.</p>     *     *  <p>With <code>pixelHinting</code> set to <code>true</code>,     *  Flash Player and AIR hint line widths to full pixel widths.     *  With <code>pixelHinting</code> set to <code>false</code>,     *  disjoints can appear for curves and straight lines.</p>     *       *  @default false
		 */
		public function get pixelHinting () : Boolean;
		/**
		 *  @private
		 */
		public function set pixelHinting (value:Boolean) : void;
		/**
		 *  A value from the LineScaleMode class     *  that  specifies which scale mode to use.     *  Value valids are:     *      *  <ul>     *  <li>     *  <code>LineScaleMode.NORMAL</code>&#151;     *  Always scale the line thickness when the object is scaled  (the default).     *  </li>     *  <li>     *  <code>LineScaleMode.NONE</code>&#151;     *  Never scale the line thickness.     *  </li>     *  <li>     *  <code>LineScaleMode.VERTICAL</code>&#151;     *  Do not scale the line thickness if the object is scaled vertically      *  <em>only</em>.      *  </li>     *  <li>     *  <code>LineScaleMode.HORIZONTAL</code>&#151;     *  Do not scale the line thickness if the object is scaled horizontally      *  <em>only</em>.      *  </li>     *  </ul>     *      *  @default LineScaleMode.NORMAL
		 */
		public function get scaleMode () : String;
		/**
		 *  @private
		 */
		public function set scaleMode (value:String) : void;
		/**
		 *  A value from the SpreadMethod class     *  that specifies which spread method to use.     *     *  <p>Value values are <code>SpreadMethod.PAD</code>,      *  <code>SpreadMethod.REFLECT</code>,     *  and <code>SpreadMethod.REPEAT</code>.</p>     *       *  @default SpreadMethod.PAD
		 */
		public function get spreadMethod () : String;
		/**
		 *  @private
		 */
		public function set spreadMethod (value:String) : void;
		/**
		 *  The line weight, in pixels.     *  For many charts, the default value is 1 pixel.
		 */
		public function get weight () : Number;
		/**
		 *  @private
		 */
		public function set weight (value:Number) : void;

		/**
		 *  Constructor.     *     *  @param weight Specifies the line weight, in pixels.     *  This parameter is optional,     *  with a default value of <code>0</code>.      *     *  @param pixelHinting A Boolean value that specifies     *  whether to hint strokes to full pixels.     *  This affects both the position of anchors of a curve     *  and the line stroke size itself.     *  With <code>pixelHinting</code> set to <code>true</code>,     *  Flash Player and AIR hint line widths to full pixel widths.     *  With <code>pixelHinting</code> set to <code>false</code>,     *  disjoints can  appear for curves and straight lines.      *  This parameter is optional,     *  with a default value of <code>false</code>.      *     *  @param scaleMode A value from the LineScaleMode class     *  that specifies which scale mode to use.     *  Valid values are <code>LineScaleMode.HORIZONTAL</code>,     *  <code>LineScaleMode.NONE</code>, <code>LineScaleMode.NORMAL</code>,     *  and <code>LineScaleMode.VERTICAL</code>.     *  This parameter is optional,     *  with a default value of <code>LineScaleMode.NORMAL</code>.      *     *  @param caps A value from the CapsStyle class     *  that specifies the type of caps at the end of lines.     *  Valid values are <code>CapsStyle.NONE</code>,     *  <code>CapsStyle.ROUND</code>, and <code>CapsStyle.SQUARE</code>.     *  A <code>null</code> value is equivalent to     *  <code>CapsStyle.ROUND</code>.     *  This parameter is optional,     *  with a default value of <code>null</code>.      *     *  @param joints A value from the JointStyle class     *  that specifies the type of joint appearance used at angles.     *  Valid values are <code>JointStyle.BEVEL</code>,     *  <code>JointStyle.MITER</code>, and <code>JointStyle.ROUND</code>.     *  A <code>null</code> value is equivalent to     *  <code>JoinStyle.ROUND</code>.     *  This parameter is optional,     *  with a default value of <code>null</code>.      *     *  @param miterLimit A number that indicates the limit     *  at which a miter is cut off.      *  Valid values range from 1 to 255     *  (and values outside of that range are rounded to 1 or 255).      *  This value is only used if the <code>jointStyle</code> property      *  is set to <code>miter</code>.     *  The <code>miterLimit</code> value represents the length that a miter     *  can extend beyond the point at which the lines meet to form a joint.     *  The value expresses a factor of the line <code>thickness</code>.     *  For example, with a <code>miterLimit</code> factor of 2.5 and a      *  <code>thickness</code> of 10 pixels, the miter is cut off at 25 pixels.      *  This parameter is optional,     *  with a default value of <code>0</code>.
		 */
		public function LinearGradientStroke (weight:Number = 0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 0);
		/**
		 *  Applies the properties to the specified Graphics object.     *       *  @param g The Graphics object to which the LinearGradientStroke styles     *  are applied.
		 */
		public function apply (g:Graphics) : void;
	}
}
