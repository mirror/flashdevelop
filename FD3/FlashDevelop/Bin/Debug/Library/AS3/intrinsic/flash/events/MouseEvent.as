/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	import flash.display.InteractiveObject;
	public class MouseEvent extends Event {
		/**
		 * Indicates whether the Alt key is active (true) or inactive (false).
		 *  Supported for Windows operating systems only.
		 */
		public function get altKey():Boolean;
		public function set altKey(value:Boolean):void;
		/**
		 * Indicates whether the primary mouse button is pressed (true) or not (false).
		 */
		public function get buttonDown():Boolean;
		public function set buttonDown(value:Boolean):void;
		/**
		 * On Windows, indicates whether the Ctrl key is active (true) or inactive (false).
		 *  On Macintosh, indicates whether either the Ctrl key or the Command key is activated.
		 */
		public function get ctrlKey():Boolean;
		public function set ctrlKey(value:Boolean):void;
		/**
		 * Indicates how many lines should be scrolled for each unit the user rotates the
		 *  mouse wheel. A positive delta value indicates an upward scroll; a negative
		 *  value indicates a downward scroll. Typical values are 1 to 3, but faster
		 *  rotation may produce larger values. This setting depends on the device
		 *  and operating system and is usually configurable by the user. This
		 *  property applies only to the MouseEvent.mouseWheel event.
		 */
		public function get delta():int;
		public function set delta(value:int):void;
		/**
		 * The horizontal coordinate at which the event occurred relative to the containing sprite.
		 */
		public function get localX():Number;
		public function set localX(value:Number):void;
		/**
		 * The vertical coordinate at which the event occurred relative to the containing sprite.
		 */
		public function get localY():Number;
		public function set localY(value:Number):void;
		/**
		 * A reference to a display list object that is related to the event. For example, when a mouseOut event occurs, relatedObject represents the display list object to which the pointing device now points. This property applies only to the mouseOut and mouseOver events.
		 */
		public function get relatedObject():InteractiveObject;
		public function set relatedObject(value:InteractiveObject):void;
		/**
		 * Indicates whether the Shift key is active (true) or inactive
		 *  (false).
		 */
		public function get shiftKey():Boolean;
		public function set shiftKey(value:Boolean):void;
		/**
		 * The horizontal coordinate at which the event occurred in global Stage coordinates.
		 *  This property is calculated when the localX property is set.
		 */
		public function get stageX():Number;
		/**
		 * The vertical coordinate at which the event occurred in global Stage coordinates.
		 *  This property is calculated when the localY property is set.
		 */
		public function get stageY():Number;
		/**
		 * Creates a copy of the MouseEvent object and sets the value of each property to match that of the original.
		 *
		 * @return                  <Event> A new MouseEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the MouseEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the MouseEvent object.
		 */
		public override function toString():String;
		/**
		 * Instructs Flash Player or Adobe AIR to render after processing of this event completes, if the display list has been modified.
		 */
		public function updateAfterEvent():void;
		/**
		 * Defines the value of the type property of a click event object.
		 */
		public static const CLICK:String = "click";
		/**
		 * Defines the value of the type property of a doubleClick event object.
		 */
		public static const DOUBLE_CLICK:String = "doubleClick";
		/**
		 * Defines the value of the type property of a mouseDown event object.
		 */
		public static const MOUSE_DOWN:String = "mouseDown";
		/**
		 * Defines the value of the type property of a mouseMove event object.
		 */
		public static const MOUSE_MOVE:String = "mouseMove";
		/**
		 * Defines the value of the type property of a mouseOut event object.
		 */
		public static const MOUSE_OUT:String = "mouseOut";
		/**
		 * Defines the value of the type property of a mouseOver event object.
		 */
		public static const MOUSE_OVER:String = "mouseOver";
		/**
		 * Defines the value of the type property of a mouseUp event object.
		 */
		public static const MOUSE_UP:String = "mouseUp";
		/**
		 * Defines the value of the type property of a mouseWheel event object.
		 */
		public static const MOUSE_WHEEL:String = "mouseWheel";
		/**
		 * Defines the value of the type property of a rollOut event object.
		 */
		public static const ROLL_OUT:String = "rollOut";
		/**
		 * Defines the value of the type property of a rollOver event object.
		 */
		public static const ROLL_OVER:String = "rollOver";
	}
}
