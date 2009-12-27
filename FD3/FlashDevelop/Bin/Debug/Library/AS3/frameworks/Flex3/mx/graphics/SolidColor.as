package mx.graphics
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import mx.events.PropertyChangeEvent;

	[DefaultProperty("color")] 

include "../core/Version.as"
	/**
	 *  Defines a representation for a color,
 *  including a color and an alpha value. 
 *  
 *  @see mx.graphics.IFill
	 */
	public class SolidColor extends EventDispatcher implements IFill
	{
		private var _alpha : Number;
		private var _color : uint;

		/**
		 *  The transparency of a color.
	 *  Possible values are 0.0 (invisible) through 1.0 (opaque). 
	 *  
	 *  @default 1.0
		 */
		public function get alpha () : Number;
		public function set alpha (value:Number) : void;

		/**
		 *  A color value.
		 */
		public function get color () : uint;
		public function set color (value:uint) : void;

		/**
		 *  Constructor.
	 *
	 *  @param color Specifies the color.
	 *  The default value is 0x000000 (black).
	 *
	 *  @param alpha Specifies the level of transparency.
	 *  Valid values range from 0.0 (completely transparent)
	 *  to 1.0 (completely opaque).
	 *  The default value is 1.0.
		 */
		public function SolidColor (color:uint = 0x000000, alpha:Number = 1.0);

		/**
		 *  @inheritDoc
		 */
		public function begin (target:Graphics, rc:Rectangle) : void;

		/**
		 *  @inheritDoc
		 */
		public function end (target:Graphics) : void;

		/**
		 *  @private
		 */
		private function dispatchFillChangedEvent (prop:String, oldValue:*, value:*) : void;
	}
}
