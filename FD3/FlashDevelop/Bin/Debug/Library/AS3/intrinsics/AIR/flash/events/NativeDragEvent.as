package flash.events
{
	/// Native drag events are dispatched by the interactive objects involved in a drag-and-drop operation.
	public class NativeDragEvent extends flash.events.MouseEvent
	{
		/// [AIR] NativeDragEvent.NATIVE_DRAG_ENTER defines the value of the type property of a nativeDragEnter event object.
		public static const NATIVE_DRAG_ENTER:String = "nativeDragEnter";

		/// [AIR] NativeDragEvent.NATIVE_DRAG_OVER defines the value of the type property of a nativeDragOver event object.
		public static const NATIVE_DRAG_OVER:String = "nativeDragOver";

		/// [AIR] NativeDragEvent.NATIVE_DRAG_DROP defines the value of the type property of a nativeDragDrop event object.
		public static const NATIVE_DRAG_DROP:String = "nativeDragDrop";

		/// [AIR] NativeDragEvent.NATIVE_DRAG_EXIT defines the value of the type property of a nativeDragExit event object.
		public static const NATIVE_DRAG_EXIT:String = "nativeDragExit";

		/// [AIR] NativeDragEvent.NATIVE_DRAG_START defines the value of the type property of a nativeDragStart event object.
		public static const NATIVE_DRAG_START:String = "nativeDragStart";

		/// [AIR] NativeDragEvent.NATIVE_DRAG_UPDATE defines the value of the type property of a nativeDragUpdate event object.
		public static const NATIVE_DRAG_UPDATE:String = "nativeDragUpdate";

		/// [AIR] NativeDragEvent.NATIVE_DRAG_COMPLETE defines the value of the type property of a nativeDragComplete event object.
		public static const NATIVE_DRAG_COMPLETE:String = "nativeDragComplete";

		/// [AIR] The Clipboard object containing the data in this drag operation.
		public var clipboard:flash.desktop.Clipboard;

		/// [AIR] The NativeDragOptions object specifying the actions that are allowed by the display object that initiated this drag operation.
		public var allowedActions:flash.desktop.NativeDragOptions;

		/// [AIR] The current action.
		public var dropAction:String;

		/// [AIR] Creates an Event object with specific information relevant to native drag-and-drop events.
		public function NativeDragEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=true, localX:Number=unknown, localY:Number=unknown, relatedObject:flash.display.InteractiveObject=null, clipboard:flash.desktop.Clipboard=null, allowedActions:flash.desktop.NativeDragOptions=null, dropAction:String=null, controlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false, commandKey:Boolean=false);

		/// [AIR] Creates a copy of this NativeDragEvent object.
		public function clone():flash.events.Event;

		/// [AIR] Formats the properties of this NativeDragEvent object as a string.
		public function toString():String;

	}

}

