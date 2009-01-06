package flash.events
{
	import flash.desktop.NativeDragOptions;
	import flash.desktop.Clipboard;
	import flash.events.Event;
	import flash.display.InteractiveObject;

	/// Native drag events are dispatched by the interactive objects involved in a drag-and-drop operation.
	public class NativeDragEvent extends MouseEvent
	{
		/// [AIR] The NativeDragOptions object specifying the actions that are allowed by the display object that initiated this drag operation.
		public var allowedActions : NativeDragOptions;
		/// [AIR] The Clipboard object containing the data in this drag operation.
		public var clipboard : Clipboard;
		/// [AIR] The current action.
		public var dropAction : String;
		/// [AIR] NativeDragEvent.NATIVE_DRAG_COMPLETE defines the value of the type property of a nativeDragComplete event object.
		public static const NATIVE_DRAG_COMPLETE : String = "nativeDragComplete";
		/// [AIR] NativeDragEvent.NATIVE_DRAG_DROP defines the value of the type property of a nativeDragDrop event object.
		public static const NATIVE_DRAG_DROP : String = "nativeDragDrop";
		/// [AIR] NativeDragEvent.NATIVE_DRAG_ENTER defines the value of the type property of a nativeDragEnter event object.
		public static const NATIVE_DRAG_ENTER : String = "nativeDragEnter";
		/// [AIR] NativeDragEvent.NATIVE_DRAG_EXIT defines the value of the type property of a nativeDragExit event object.
		public static const NATIVE_DRAG_EXIT : String = "nativeDragExit";
		/// [AIR] NativeDragEvent.NATIVE_DRAG_OVER defines the value of the type property of a nativeDragOver event object.
		public static const NATIVE_DRAG_OVER : String = "nativeDragOver";
		/// [AIR] NativeDragEvent.NATIVE_DRAG_START defines the value of the type property of a nativeDragStart event object.
		public static const NATIVE_DRAG_START : String = "nativeDragStart";
		/// [AIR] NativeDragEvent.NATIVE_DRAG_UPDATE defines the value of the type property of a nativeDragUpdate event object.
		public static const NATIVE_DRAG_UPDATE : String = "nativeDragUpdate";

		/// [AIR] Creates a copy of this NativeDragEvent object.
		public function clone () : Event;

		/// [AIR] Creates an Event object with specific information relevant to native drag-and-drop events.
		public function NativeDragEvent (type:String = null, bubbles:Boolean = false, cancelable:Boolean = true, localX:Number = null, localY:Number = null, relatedObject:InteractiveObject = null, clipboard:Clipboard = null, allowedActions:NativeDragOptions = null, dropAction:String = null, controlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, commandKey:Boolean = false);

		/// [AIR] Formats the properties of this NativeDragEvent object as a string.
		public function toString () : String;
	}
}
