package flash.events
{
	/// Flash&#xAE; Player dispatches MouseEvent objects into the event flow whenever mouse events occur.
	public class MouseEvent extends flash.events.Event
	{
		/// Defines the value of the type property of a click event object.
		public static const CLICK:String = "click";

		/// Defines the value of the type property of a doubleClick event object.
		public static const DOUBLE_CLICK:String = "doubleClick";

		/// Defines the value of the type property of a mouseDown event object.
		public static const MOUSE_DOWN:String = "mouseDown";

		/// Defines the value of the type property of a mouseMove event object.
		public static const MOUSE_MOVE:String = "mouseMove";

		/// Defines the value of the type property of a mouseOut event object.
		public static const MOUSE_OUT:String = "mouseOut";

		/// Defines the value of the type property of a mouseOver event object.
		public static const MOUSE_OVER:String = "mouseOver";

		/// Defines the value of the type property of a mouseUp event object.
		public static const MOUSE_UP:String = "mouseUp";

		/// Defines the value of the type property of a mouseWheel event object.
		public static const MOUSE_WHEEL:String = "mouseWheel";

		/// Defines the value of the type property of a rollOut event object.
		public static const ROLL_OUT:String = "rollOut";

		/// Defines the value of the type property of a rollOver event object.
		public static const ROLL_OVER:String = "rollOver";

		/// The horizontal coordinate at which the event occurred relative to the containing sprite.
		public var localX:Number;

		/// The vertical coordinate at which the event occurred relative to the containing sprite.
		public var localY:Number;

		/// A reference to a display list object that is related to the event.
		public var relatedObject:flash.display.InteractiveObject;

		/// Indicates whether the Control key is active (true) or inactive (false).
		public var ctrlKey:Boolean;

		/// Indicates whether the Alt key is active (true) or inactive (false).
		public var altKey:Boolean;

		/// Indicates whether the Shift key is active (true) or inactive (false).
		public var shiftKey:Boolean;

		/// Indicates whether the primary mouse button is pressed (true) or not (false).
		public var buttonDown:Boolean;

		/// Indicates how many lines should be scrolled for each unit the user rotates the mouse wheel.
		public var delta:int;

		/// The horizontal coordinate at which the event occurred in global Stage coordinates.
		public var stageX:Number;

		/// The vertical coordinate at which the event occurred in global Stage coordinates.
		public var stageY:Number;

		/// Indicates whether the relatedObject property was set to null for security reasons.
		public var isRelatedObjectInaccessible:Boolean;

		/// Constructor for MouseEvent objects.
		public function MouseEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, localX:Number=unknown, localY:Number=unknown, relatedObject:flash.display.InteractiveObject=null, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false, buttonDown:Boolean=false, delta:int=0);

		/// Creates a copy of the MouseEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the MouseEvent object.
		public function toString():String;

		/// Instructs Flash Player to render after processing of this event completes, if the display list has been modified.
		public function updateAfterEvent():void;

	}

}

