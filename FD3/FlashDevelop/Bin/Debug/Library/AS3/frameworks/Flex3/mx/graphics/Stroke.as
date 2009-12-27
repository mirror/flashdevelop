package mx.graphics
{
	import flash.display.Graphics;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import mx.events.PropertyChangeEvent;

include "../core/Version.as"
	/**
	 *  The Stroke class defines the properties for a line. 
 *  
 *  You can define a Stroke object in MXML, but you must attach that Stroke to
 *  another object for it to appear in your application. The following example
 *  defines two Stroke objects and then uses them in the horizontalAxisRenderer
 *  of a LineChart control:
 *  
 *  <pre>
 *  ...
 *  &lt;mx:Stroke id="ticks" color="0xFF0000" weight="1"/&gt;
 *  &lt;mx:Stroke id="mticks" color="0x0000FF" weight="1"/&gt;
 *  
 *  &lt;mx:LineChart id="mychart" dataProvider="{ndxa}"&gt;
 *  	&lt;mx:horizontalAxisRenderer&gt;
 *  		&lt;mx:AxisRenderer placement="bottom" canDropLabels="true"&gt;
 *  			&lt;mx:tickStroke&gt;{ticks}&lt;/mx:tickStroke&gt;
 *  			&lt;mx:minorTickStroke&gt;{mticks}&lt;/mx:minorTickStroke&gt;
 *  		&lt;/mx:AxisRenderer&gt;
 *  	&lt;/mx:horizontalAxisRenderer&gt;
 *  &lt;/LineChart&gt;
 *  ...
 *  </pre>
 *  
 *  @mxml
 *
 *  <p>The <code>&lt;mx:Stroke&gt;</code> tag inherits all the tag attributes
 *  of its superclass, and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:Stroke
 *    <b>Properties</b>
 *    alpha="1.0"
 *    caps="null|none|round|square"
 *    color="0x000000"
 *    joints="null|bevel|miter|round"
 *    miterLimit="0"
 *    pixelHinting="false|true"
 *    scaleMode="normal|none|noScale|vertical"
 *    weight="1 (<i>in most cases</i>)"
 *  /&gt;
 *  </pre>
 *
 *  @see flash.display.Graphics
	 */
	public class Stroke extends EventDispatcher implements IStroke
	{
		private var _alpha : Number;
		private var _caps : String;
		private var _color : uint;
		private var _joints : String;
		private var _miterLimit : Number;
		private var _pixelHinting : Boolean;
		private var _scaleMode : String;
		/**
		 *  @private
	 *  Storage for the weight property.
		 */
		private var _weight : Number;

		/**
		 *  The transparency of a line.
	 *  Possible values are 0.0 (invisible) through 1.0 (opaque). 
	 *  
	 *  @default 1.0.
		 */
		public function get alpha () : Number;
		public function set alpha (value:Number) : void;

		/**
		 *  Specifies the type of caps at the end of lines.
	 *  Valid values are: <code>"round"</code>, <code>"square"</code>,
	 *  and <code>"none"</code>.
		 */
		public function get caps () : String;
		public function set caps (value:String) : void;

		/**
		 *  The line color. 
	 *  
	 *  @default 0x000000 (black).
		 */
		public function get color () : uint;
		public function set color (value:uint) : void;

		/**
		 *  Specifies the type of joint appearance used at angles.
	 *  Valid values are <code>"round"</code>, <code>"miter"</code>,
	 *  and <code>"bevel"</code>.
		 */
		public function get joints () : String;
		public function set joints (value:String) : void;

		/**
		 *  Indicates the limit at which a miter is cut off.
	 *  Valid values range from 0 to 255.
	 *  
	 *  @default 0
		 */
		public function get miterLimit () : Number;
		public function set miterLimit (value:Number) : void;

		/**
		 *  Specifies whether to hint strokes to full pixels.
	 *  This value affects both the position of anchors of a curve
	 *  and the line stroke size itself.
	 *  
	 *  @default false
		 */
		public function get pixelHinting () : Boolean;
		public function set pixelHinting (value:Boolean) : void;

		/**
		 *  Specifies how to scale a stroke.
	 *  Valid values are <code>"normal"</code>, <code>"none"</code>,
	 *  <code>"vertical"</code>, and <code>"noScale"</code>.
	 *  
	 *  @default "normal"
		 */
		public function get scaleMode () : String;
		public function set scaleMode (value:String) : void;

		/**
		 *  The line weight, in pixels.
	 *  For many charts, the default value is 1 pixel.
		 */
		public function get weight () : Number;
		/**
		 *  @private
		 */
		public function set weight (value:Number) : void;

		/**
		 *  Constructor. 
	 *
	 *  @param color Specifies the line color.
	 *  The default value is 0x000000 (black).
	 *
	 *  @param weight Specifies the line weight, in pixels.
	 *  The default value is 0.
	 *
	 *  @param alpha Specifies the alpha value in the range 0.0 to 1.0.
	 *  The default value is 1.0 (opaque).
	 *
	 *  @param pixelHinting Specifies whether to hint strokes to full pixels.
	 *  This value affects both the position of anchors of a curve
	 *  and the line stroke size itself.
	 *  The default value is false.
	 *
	 *  @param scaleMode Specifies how to scale a stroke.
	 *  Valid values are <code>"normal"</code>, <code>"none"</code>,
	 *  <code>"vertical"</code>, and <code>"noScale"</code>.
	 *  The default value is <code>"normal"</code>.
	 *
	 *  @param caps Specifies the type of caps at the end of lines.
	 *  Valid values are <code>"round"</code>, <code>"square"</code>,
	 *  and <code>"none"</code>.
	 *  The default value is <code>null</code>.
	 *
	 *  @param joints Specifies the type of joint appearance used at angles.
	 *  Valid values are <code>"round"</code>, <code>"miter"</code>,
	 *  and <code>"bevel"</code>.
	 *  The default value is <code>null</code>.
	 *
	 *  @param miterLimit Indicates the limit at which a miter is cut off.
	 *  Valid values range from 0 to 255.
	 *  The default value is 0.
		 */
		public function Stroke (color:uint = 0x000000, weight:Number = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 0);

		/**
		 *  Applies the properties to the specified Graphics object.
	 *  
	 *  @param g The Graphics object to which the Stroke's styles are applied.
		 */
		public function apply (g:Graphics) : void;

		/**
		 *  @private
		 */
		private function dispatchStrokeChangedEvent (prop:String, oldValue:*, value:*) : void;
	}
}
