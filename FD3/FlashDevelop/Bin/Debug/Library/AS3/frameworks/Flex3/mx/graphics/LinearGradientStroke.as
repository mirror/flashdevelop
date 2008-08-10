/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.graphics {
	import flash.display.Graphics;
	public class LinearGradientStroke extends GradientBase implements IStroke {
		/**
		 * By default, the LinearGradientStroke defines a transition
		 *  from left to right across the control.
		 *  Use the angle property to control the transition direction.
		 *  For example, a value of 180.0 causes the transition
		 *  to occur from right to left, rather than from left to right.
		 */
		public function get angle():Number;
		public function set angle(value:Number):void;
		/**
		 * A value from the CapsStyle class
		 *  that specifies the type of caps at the end of lines.
		 */
		public function get caps():String;
		public function set caps(value:String):void;
		/**
		 * A value from the InterpolationMethod class
		 *  that specifies which interpolation method to use.
		 */
		public function get interpolationMethod():String;
		public function set interpolationMethod(value:String):void;
		/**
		 * A value from the JointStyle class that specifies the type
		 *  of joint appearance used at angles.
		 */
		public function get joints():String;
		public function set joints(value:String):void;
		/**
		 * A number that indicates the limit at which a miter is cut off.
		 */
		public function get miterLimit():Number;
		public function set miterLimit(value:Number):void;
		/**
		 * A Boolean value that specifies whether to hint strokes to full pixels.
		 */
		public function get pixelHinting():Boolean;
		public function set pixelHinting(value:Boolean):void;
		/**
		 * A value from the LineScaleMode class
		 *  that  specifies which scale mode to use.
		 *  Value valids are:
		 *  LineScaleMode.NORMAL
		 *  Always scale the line thickness when the object is scaled  (the default).
		 *  LineScaleMode.NONE
		 *  Never scale the line thickness.
		 *  LineScaleMode.VERTICAL
		 *  Do not scale the line thickness if the object is scaled vertically
		 *  only.
		 *  LineScaleMode.HORIZONTAL
		 *  Do not scale the line thickness if the object is scaled horizontally
		 *  only.
		 */
		public function get scaleMode():String;
		public function set scaleMode(value:String):void;
		/**
		 * A value from the SpreadMethod class
		 *  that specifies which spread method to use.
		 */
		public function get spreadMethod():String;
		public function set spreadMethod(value:String):void;
		/**
		 * The line weight, in pixels.
		 *  For many charts, the default value is 1 pixel.
		 */
		public function get weight():Number;
		public function set weight(value:Number):void;
		/**
		 * Constructor.
		 *
		 * @param weight            <Number (default = 0)> Specifies the line weight, in pixels.
		 *                            This parameter is optional,
		 *                            with a default value of 0.
		 * @param pixelHinting      <Boolean (default = false)> A Boolean value that specifies
		 *                            whether to hint strokes to full pixels.
		 *                            This affects both the position of anchors of a curve
		 *                            and the line stroke size itself.
		 *                            With pixelHinting set to true,
		 *                            Flash Player and AIR hint line widths to full pixel widths.
		 *                            With pixelHinting set to false,
		 *                            disjoints can  appear for curves and straight lines.
		 *                            This parameter is optional,
		 *                            with a default value of false.
		 * @param scaleMode         <String (default = "normal")> A value from the LineScaleMode class
		 *                            that specifies which scale mode to use.
		 *                            Valid values are LineScaleMode.HORIZONTAL,
		 *                            LineScaleMode.NONE, LineScaleMode.NORMAL,
		 *                            and LineScaleMode.VERTICAL.
		 *                            This parameter is optional,
		 *                            with a default value of LineScaleMode.NORMAL.
		 * @param caps              <String (default = null)> A value from the CapsStyle class
		 *                            that specifies the type of caps at the end of lines.
		 *                            Valid values are CapsStyle.NONE,
		 *                            CapsStyle.ROUND, and CapsStyle.SQUARE.
		 *                            A null value is equivalent to
		 *                            CapsStyle.ROUND.
		 *                            This parameter is optional,
		 *                            with a default value of null.
		 * @param joints            <String (default = null)> A value from the JointStyle class
		 *                            that specifies the type of joint appearance used at angles.
		 *                            Valid values are JointStyle.BEVEL,
		 *                            JointStyle.MITER, and JointStyle.ROUND.
		 *                            A null value is equivalent to
		 *                            JoinStyle.ROUND.
		 *                            This parameter is optional,
		 *                            with a default value of null.
		 * @param miterLimit        <Number (default = 0)> A number that indicates the limit
		 *                            at which a miter is cut off.
		 *                            Valid values range from 1 to 255
		 *                            (and values outside of that range are rounded to 1 or 255).
		 *                            This value is only used if the jointStyle property
		 *                            is set to miter.
		 *                            The miterLimit value represents the length that a miter
		 *                            can extend beyond the point at which the lines meet to form a joint.
		 *                            The value expresses a factor of the line thickness.
		 *                            For example, with a miterLimit factor of 2.5 and a
		 *                            thickness of 10 pixels, the miter is cut off at 25 pixels.
		 *                            This parameter is optional,
		 *                            with a default value of 0.
		 */
		public function LinearGradientStroke(weight:Number = 0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 0);
		/**
		 * Applies the properties to the specified Graphics object.
		 *
		 * @param g                 <Graphics> The Graphics object to which the LinearGradientStroke styles
		 *                            are applied.
		 */
		public function apply(g:Graphics):void;
	}
}
