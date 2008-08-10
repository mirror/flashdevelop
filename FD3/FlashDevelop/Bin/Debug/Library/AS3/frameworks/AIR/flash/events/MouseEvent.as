/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
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
		 * Indicates whether or not the mouse down event is part of a multi-click sequence.
		 *  This parameter will be zero for all mouse events other than MouseEvent.mouseDown,
		 *  MouseEvent.mouseUp, MouseEvent.middleMouseDown, MouseEvent.middleMouseUp,
		 *  MouseEvent.rightMouseDown, and MouseEvent.rightMouseUp. Listening
		 *  for single clicks, double clicks, or any multi-click sequence is possible with the clickCount parameter.
		 *  For example, an initial MouseEvent.mouseDown and MouseEvent.mouseUp will have a
		 *  clickCount of 1, and the second MouseEvent.mouseDown and MouseEvent.mouseUp
		 *  in a double-click sequence will have a
		 *  clickCount of 2. If the mouse moves sufficiently or the multi-click sequence is
		 *  interrupted for some reason, then the next MouseEvent.mouseDown will have a clickCount of 1.
		 *  The doubleClick event will continue to fire as expected.
		 */
		public function get clickCount():int;
		/**
		 * Indicates whether the command key is activated. Mac only. The value of property commandKey
		 *  will have the same value as property ctrlKey on the Mac.
		 *  Always false on Windows.
		 */
		public function get commandKey():Boolean;
		public function set commandKey(value:Boolean):void;
		/**
		 * Indicates whether the Ctrl key is activated.
		 */
		public function get controlKey():Boolean;
		public function set controlKey(value:Boolean):void;
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
		 * Creates an Event object that contains information about mouse events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Possible values are: MouseEvent.CLICK,
		 *                            MouseEvent.DOUBLE_CLICK, MouseEvent.MOUSE_DOWN,
		 *                            MouseEvent.MOUSE_MOVE, MouseEvent.MOUSE_OUT,
		 *                            MouseEvent.MOUSE_OVER, MouseEvent.MOUSE_UP,
		 *                            MouseEvent.MIDDLE_CLICK, MouseEvent.MIDDLE_MOUSE_DOWN, MouseEvent.MIDDLE_MOUSE_UP,
		 *                            MouseEvent.RIGHT_CLICK, MouseEvent.RIGHT_MOUSE_DOWN, MouseEvent.RIGHT_MOUSE_UP,
		 *                            MouseEvent.MOUSE_WHEEL, MouseEvent.ROLL_OUT, and MouseEvent.ROLL_OVER.
		 * @param bubbles           <Boolean (default = true)> Determines whether the Event object participates in the bubbling phase of the event flow.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled.
		 * @param localX            <Number (default = NaN)> The horizontal coordinate at which the event occurred relative to the containing sprite.
		 * @param localY            <Number (default = NaN)> The vertical coordinate at which the event occurred relative to the containing sprite.
		 * @param relatedObject     <InteractiveObject (default = null)> The complementary InteractiveObject instance that is affected by the event. For example, when a mouseOut event occurs, relatedObject represents the display list object to which the pointing device now points.
		 * @param ctrlKey           <Boolean (default = false)> On Windows, indicates whether the Ctrl key is activated. On Mac, indicates whether either the Ctrl key or the Command key is activated.
		 * @param altKey            <Boolean (default = false)> Indicates whether the Alt key is activated (Windows only).
		 * @param shiftKey          <Boolean (default = false)> Indicates whether the Shift key is activated.
		 * @param buttonDown        <Boolean (default = false)> Indicates whether the primary mouse button is pressed.
		 * @param delta             <int (default = 0)> Indicates how many lines should be scrolled for each unit the user rotates the mouse wheel. A positive delta value indicates an upward scroll; a negative value indicates a downward scroll. Typical values are 1 to 3, but faster rotation may produce larger values. This parameter is used only for the MouseEvent.mouseWheel event.
		 * @param commandKey        <Boolean (default = false)> Indicates whether the Command key is activated (Mac only). This parameter is used only for the MouseEvent.click, MouseEvent.mouseDown, MouseEvent.mouseUp, MouseEvent.middleClick, MouseEvent.middleMouseDown, MouseEvent.middleMouseUp, MouseEvent.rightClick, MouseEvent.rightMouseDown, MouseEvent.rightMouseUp, and MouseEvent.doubleClick events.
		 * @param controlKey        <Boolean (default = false)> Indicates whether the Ctrl key is activated. This parameter is used only for the MouseEvent.click, MouseEvent.mouseDown, MouseEvent.mouseUp, MouseEvent.middleClick, MouseEvent.middleMouseDown, MouseEvent.middleMouseUp, MouseEvent.rightClick, MouseEvent.rightMouseDown, MouseEvent.rightMouseUp, and MouseEvent.doubleClick events.
		 * @param clickCount        <int (default = 0)> Indicates whether or not the mouse event is part of a multi-click sequence. This parameter will be zero for all mouse events other than MouseEvent.mouseDown, MouseEvent.mouseUp, MouseEvent.middleMouseDown, MouseEvent.middleMouseUp, MouseEvent.rightMouseDown and MouseEvent.rightMouseUp. Listening for single clicks, double clicks, or any multi-click sequence is possible with the clickCount parameter.
		 */
		public function MouseEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, localX:Number = NaN, localY:Number = NaN, relatedObject:InteractiveObject = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, delta:int = 0, commandKey:Boolean = false, controlKey:Boolean = false, clickCount:int = 0);
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
		 * The InteractiveIconMouseEvent.CONTEXT_MENU constant defines the value of the
		 *  type property of a contextMenu event object.
		 */
		public static const CONTEXT_MENU:String = "contextMenu";
		/**
		 * Defines the value of the type property of a doubleClick event object.
		 */
		public static const DOUBLE_CLICK:String = "doubleClick";
		/**
		 * Defines the value of the type property of a middleClick event object.
		 */
		public static const MIDDLE_CLICK:String = "middleClick";
		/**
		 * Defines the value of the type property of a middleMouseDown event object.
		 */
		public static const MIDDLE_MOUSE_DOWN:String = "middleMouseDown";
		/**
		 * Defines the value of the type property of a middleMouseUp event object.
		 */
		public static const MIDDLE_MOUSE_UP:String = "middleMouseUp";
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
		 * Defines the value of the type property of a rightClick event object.
		 */
		public static const RIGHT_CLICK:String = "rightClick";
		/**
		 * Defines the value of the type property of a rightMouseDown event object.
		 */
		public static const RIGHT_MOUSE_DOWN:String = "rightMouseDown";
		/**
		 * Defines the value of the type property of a rightMouseUp event object.
		 */
		public static const RIGHT_MOUSE_UP:String = "rightMouseUp";
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
