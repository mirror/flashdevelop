/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.graphics {
	import flash.events.EventDispatcher;
	import flash.display.Graphics;
	public class Stroke extends EventDispatcher implements IStroke {
		/**
		 * The transparency of a line.
		 *  Possible values are 0.0 (invisible) through 1.0 (opaque).
		 */
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		/**
		 * Specifies the type of caps at the end of lines.
		 *  Valid values are: "round", "square",
		 *  and "none".
		 */
		public function get caps():String;
		public function set caps(value:String):void;
		/**
		 * The line color.
		 */
		public function get color():uint;
		public function set color(value:uint):void;
		/**
		 * Specifies the type of joint appearance used at angles.
		 *  Valid values are "round", "miter",
		 *  and "bevel".
		 */
		public function get joints():String;
		public function set joints(value:String):void;
		/**
		 * Indicates the limit at which a miter is cut off.
		 *  Valid values range from 0 to 255.
		 */
		public function get miterLimit():Number;
		public function set miterLimit(value:Number):void;
		/**
		 * Specifies whether to hint strokes to full pixels.
		 *  This value affects both the position of anchors of a curve
		 *  and the line stroke size itself.
		 */
		public function get pixelHinting():Boolean;
		public function set pixelHinting(value:Boolean):void;
		/**
		 * Specifies how to scale a stroke.
		 *  Valid values are "normal", "none",
		 *  "vertical", and "noScale".
		 */
		public function get scaleMode():String;
		public function set scaleMode(value:String):void;
		/**
		 * The line weight, in pixels.
		 *  For many charts, the default value is 1 pixel.
		 */
		public function get weight():Number;
		public function set weight(value:Number):void;
		/**
		 * Constructor.
		 *
		 * @param color             <uint (default = 0x000000)> Specifies the line color.
		 *                            The default value is 0x000000 (black).
		 * @param weight            <Number (default = 0)> Specifies the line weight, in pixels.
		 *                            The default value is 0.
		 * @param alpha             <Number (default = 1.0)> Specifies the alpha value in the range 0.0 to 1.0.
		 *                            The default value is 1.0 (opaque).
		 * @param pixelHinting      <Boolean (default = false)> Specifies whether to hint strokes to full pixels.
		 *                            This value affects both the position of anchors of a curve
		 *                            and the line stroke size itself.
		 *                            The default value is false.
		 * @param scaleMode         <String (default = "normal")> Specifies how to scale a stroke.
		 *                            Valid values are "normal", "none",
		 *                            "vertical", and "noScale".
		 *                            The default value is "normal".
		 * @param caps              <String (default = null)> Specifies the type of caps at the end of lines.
		 *                            Valid values are "round", "square",
		 *                            and "none".
		 *                            The default value is null.
		 * @param joints            <String (default = null)> Specifies the type of joint appearance used at angles.
		 *                            Valid values are "round", "miter",
		 *                            and "bevel".
		 *                            The default value is null.
		 * @param miterLimit        <Number (default = 0)> Indicates the limit at which a miter is cut off.
		 *                            Valid values range from 0 to 255.
		 *                            The default value is 0.
		 */
		public function Stroke(color:uint = 0x000000, weight:Number = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 0);
		/**
		 * Applies the properties to the specified Graphics object.
		 *
		 * @param g                 <Graphics> The Graphics object to which the Stroke's styles are applied.
		 */
		public function apply(g:Graphics):void;
	}
}
