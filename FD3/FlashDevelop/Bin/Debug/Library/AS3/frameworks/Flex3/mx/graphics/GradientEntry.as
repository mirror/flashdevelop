package mx.graphics
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.events.PropertyChangeEvent;

include "../core/Version.as"
	/**
	 *  The GradientEntry class defines the objects
 *  that control a transition as part of a gradient fill. 
 *  You use this class with the LinearGradient and RadialGradient classes
 *  to define a gradient fill. 
 *  
 *  @mxml
 *
 *  <p>The <code>&lt;mx:GradientEntry&gt;</code> tag inherits all the tag attributes
 *  of its superclass, and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:GradientEntry
 *    <b>Properties</b>
 *    alpha="1.0"
 *    color="0x000000"
 *    ratio="-1"
 *  /&gt;
 *  </pre>
 *  
 *  @see mx.graphics.LinearGradient 
 *  @see mx.graphics.RadialGradient
	 */
	public class GradientEntry extends EventDispatcher
	{
		private var _alpha : Number;
		private var _color : uint;
		private var _ratio : Number;

		/**
		 *  The transparency of a gradient fill.
	 *  Possible values are 0.0 (invisible) through 1.0 (opaque). 
	 *  
	 *  @default 1.0
		 */
		public function get alpha () : Number;
		public function set alpha (value:Number) : void;

		/**
		 *  The color value for a gradient fill.
		 */
		public function get color () : uint;
		public function set color (value:uint) : void;

		/**
		 *  Where in the graphical element, as a percentage from 0.0 to 1.0,
	 *  Flex starts the transition to the associated color. 
	 *  For example, a ratio of 0.33 means Flex begins the transition
	 *  to that color 33% of the way through the graphical element.
		 */
		public function get ratio () : Number;
		public function set ratio (value:Number) : void;

		/**
		 *  Constructor.
	 *
	 *  @param color The color for this gradient entry.
	 *  The default value is 0x000000 (black).
	 *
	 *  @param ratio Where in the graphical element to start
	 *  the transition to the associated color.
	 *  Flex uniformly spaces any GradientEntries
	 *  with missing ratio values.
	 *  The default value is -1.0.
	 *
	 *  @param alpha The alpha value for this entry in the gradient. 
	 *  This parameter is optional. The default value is 1.0.
		 */
		public function GradientEntry (color:uint = 0x000000, ratio:Number = -1.0, alpha:Number = 1.0);

		/**
		 *  @private
		 */
		private function dispatchEntryChangedEvent (prop:String, oldValue:*, value:*) : void;
	}
}
