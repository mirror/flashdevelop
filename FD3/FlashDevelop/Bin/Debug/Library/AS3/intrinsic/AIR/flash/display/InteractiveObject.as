package flash.display
{
	import flash.accessibility.AccessibilityImplementation;
	import flash.display.NativeMenuItem;
	import flash.display.NativeMenu;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenuClipboardItems;

	/**
	 * Dispatched when the user selects the context menu associated with this interactive object in an AIR application.
	 * @eventType flash.events.MouseEvent.CONTEXT_MENU
	 */
	[Event(name="contextMenu", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched by the drag initiator InteractiveObject when the user releases the drag gesture.
	 * @eventType flash.events.NativeDragEvent.NATIVE_DRAG_COMPLETE
	 */
	[Event(name="nativeDragComplete", type="flash.events.NativeDragEvent")] 

	/**
	 * Dispatched during a drag operation by the InteractiveObject that is specified as the drag initiator in the DragManager.doDrag() call.
	 * @eventType flash.events.NativeDragEvent.NATIVE_DRAG_UPDATE
	 */
	[Event(name="nativeDragUpdate", type="flash.events.NativeDragEvent")] 

	/**
	 * Dispatched at the beginning of a drag operation by the InteractiveObject that is specified as the drag initiator in the DragManager.doDrag() call.
	 * @eventType flash.events.NativeDragEvent.NATIVE_DRAG_START
	 */
	[Event(name="nativeDragStart", type="flash.events.NativeDragEvent")] 

	/**
	 * Dispatched by an InteractiveObject when a drag gesture leaves its boundary.
	 * @eventType flash.events.NativeDragEvent.NATIVE_DRAG_EXIT
	 */
	[Event(name="nativeDragExit", type="flash.events.NativeDragEvent")] 

	/**
	 * Dispatched by the target InteractiveObject when a dragged object is dropped on it and the drop has been accepted with a call to DragManager.acceptDragDrop().
	 * @eventType flash.events.NativeDragEvent.NATIVE_DRAG_DROP
	 */
	[Event(name="nativeDragDrop", type="flash.events.NativeDragEvent")] 

	/**
	 * Dispatched by an InteractiveObject continually while a drag gesture remains within its boundary.
	 * @eventType flash.events.NativeDragEvent.NATIVE_DRAG_OVER
	 */
	[Event(name="nativeDragOver", type="flash.events.NativeDragEvent")] 

	/**
	 * Dispatched by an InteractiveObject when a drag gesture enters its boundary.
	 * @eventType flash.events.NativeDragEvent.NATIVE_DRAG_ENTER
	 */
	[Event(name="nativeDragEnter", type="flash.events.NativeDragEvent")] 

	/**
	 * Dispatched when the value of the object's tabIndex property changes.
	 * @eventType flash.events.Event.TAB_INDEX_CHANGE
	 */
	[Event(name="tabIndexChange", type="flash.events.Event")] 

	/**
	 * Dispatched when the object's tabEnabled flag changes.
	 * @eventType flash.events.Event.TAB_ENABLED_CHANGE
	 */
	[Event(name="tabEnabledChange", type="flash.events.Event")] 

	/**
	 * Dispatched when the value of the object's tabChildren flag changes.
	 * @eventType flash.events.Event.TAB_CHILDREN_CHANGE
	 */
	[Event(name="tabChildrenChange", type="flash.events.Event")] 

	/**
	 * Dispatched when the user releases a key.
	 * @eventType flash.events.KeyboardEvent.KEY_UP
	 */
	[Event(name="keyUp", type="flash.events.KeyboardEvent")] 

	/**
	 * Dispatched when the user presses a key.
	 * @eventType flash.events.KeyboardEvent.KEY_DOWN
	 */
	[Event(name="keyDown", type="flash.events.KeyboardEvent")] 

	/**
	 * Dispatched when a user releases the pointing device button over an InteractiveObject instance.
	 * @eventType flash.events.MouseEvent.RIGHT_MOUSE_UP
	 */
	[Event(name="rightMouseUp", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when a user presses the pointing device button over an InteractiveObject instance.
	 * @eventType flash.events.MouseEvent.RIGHT_MOUSE_DOWN
	 */
	[Event(name="rightMouseDown", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when a user presses and releases the right button of the user's pointing device over the same InteractiveObject.
	 * @eventType flash.events.MouseEvent.RIGHT_CLICK
	 */
	[Event(name="rightClick", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when a user releases the pointing device button over an InteractiveObject instance.
	 * @eventType flash.events.MouseEvent.MIDDLE_MOUSE_UP
	 */
	[Event(name="middleMouseUp", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when a user presses the middle pointing device button over an InteractiveObject instance.
	 * @eventType flash.events.MouseEvent.MIDDLE_MOUSE_DOWN
	 */
	[Event(name="middleMouseDown", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when a user presses and releases the middle button of the user's pointing device over the same InteractiveObject.
	 * @eventType flash.events.MouseEvent.MIDDLE_CLICK
	 */
	[Event(name="middleClick", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when the user moves a pointing device over an InteractiveObject instance.
	 * @eventType flash.events.MouseEvent.ROLL_OVER
	 */
	[Event(name="rollOver", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when the user moves a pointing device away from an InteractiveObject instance.
	 * @eventType flash.events.MouseEvent.ROLL_OUT
	 */
	[Event(name="rollOut", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when a mouse wheel is spun over an InteractiveObject instance.
	 * @eventType flash.events.MouseEvent.MOUSE_WHEEL
	 */
	[Event(name="mouseWheel", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when a user releases the pointing device button over an InteractiveObject instance.
	 * @eventType flash.events.MouseEvent.MOUSE_UP
	 */
	[Event(name="mouseUp", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when the user moves a pointing device over an InteractiveObject instance.
	 * @eventType flash.events.MouseEvent.MOUSE_OVER
	 */
	[Event(name="mouseOver", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when the user moves a pointing device away from an InteractiveObject instance.
	 * @eventType flash.events.MouseEvent.MOUSE_OUT
	 */
	[Event(name="mouseOut", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when a user moves the pointing device while it is over an InteractiveObject.
	 * @eventType flash.events.MouseEvent.MOUSE_MOVE
	 */
	[Event(name="mouseMove", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when a user presses the pointing device button over an InteractiveObject instance.
	 * @eventType flash.events.MouseEvent.MOUSE_DOWN
	 */
	[Event(name="mouseDown", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when a user presses and releases the main button of a pointing device twice in rapid succession over the same InteractiveObject when that object's doubleClickEnabled flag is set to true.
	 * @eventType flash.events.MouseEvent.DOUBLE_CLICK
	 */
	[Event(name="doubleClick", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when a user presses and releases the main button of the user's pointing device over the same InteractiveObject.
	 * @eventType flash.events.MouseEvent.CLICK
	 */
	[Event(name="click", type="flash.events.MouseEvent")] 

	/**
	 * Dispatched when the user attempts to change focus by using a pointer device.
	 * @eventType flash.events.FocusEvent.MOUSE_FOCUS_CHANGE
	 */
	[Event(name="mouseFocusChange", type="flash.events.FocusEvent")] 

	/**
	 * Dispatched when the user attempts to change focus by using keyboard navigation.
	 * @eventType flash.events.FocusEvent.KEY_FOCUS_CHANGE
	 */
	[Event(name="keyFocusChange", type="flash.events.FocusEvent")] 

	/**
	 * Dispatched after a display object loses focus.
	 * @eventType flash.events.FocusEvent.FOCUS_OUT
	 */
	[Event(name="focusOut", type="flash.events.FocusEvent")] 

	/**
	 * Dispatched after a display object gains focus.
	 * @eventType flash.events.FocusEvent.FOCUS_IN
	 */
	[Event(name="focusIn", type="flash.events.FocusEvent")] 

	/**
	 * Dispatched when the user activates the platform specific accelerator key combination for a select all operation or selects 'Select All' from the text context menu.
	 * @eventType flash.events.Event.SELECT_ALL
	 */
	[Event(name="selectAll", type="flash.events.Event")] 

	/**
	 * Dispatched when the user activates the platform specific accelerator key combination for a paste operation or selects 'Paste' from the text context menu.
	 * @eventType flash.events.Event.PASTE
	 */
	[Event(name="paste", type="flash.events.Event")] 

	/**
	 * Dispatched when the user activates the platform specific accelerator key combination for a cut operation or selects 'Cut' from the text context menu.
	 * @eventType flash.events.Event.CUT
	 */
	[Event(name="cut", type="flash.events.Event")] 

	/**
	 * Dispatched when the user activates the platform specific accelerator key combination for a copy operation or selects 'Copy' from the text context menu.
	 * @eventType flash.events.Event.COPY
	 */
	[Event(name="copy", type="flash.events.Event")] 

	/**
	 * Dispatched when the user selects 'Clear' (or 'Delete') from the text context menu.
	 * @eventType flash.events.Event.CLEAR
	 */
	[Event(name="clear", type="flash.events.Event")] 

	/// The InteractiveObject class is the abstract base class for all display objects with which the user can interact, using the mouse and keyboard.
	public class InteractiveObject extends DisplayObject
	{
		public function get accessibilityImplementation () : AccessibilityImplementation;
		public function set accessibilityImplementation (value:AccessibilityImplementation) : void;

		/// Specifies the context menu associated with this object.
		public function get contextMenu () : NativeMenu;
		public function set contextMenu (cm:NativeMenu) : void;

		/// Specifies whether the object receives doubleClick events.
		public function get doubleClickEnabled () : Boolean;
		public function set doubleClickEnabled (enabled:Boolean) : void;

		/// Specifies whether this object displays a focus rectangle.
		public function get focusRect () : Object;
		public function set focusRect (focusRect:Object) : void;

		/// Specifies whether this object receives mouse messages.
		public function get mouseEnabled () : Boolean;
		public function set mouseEnabled (enabled:Boolean) : void;

		/// Specifies whether this object is in the tab order.
		public function get tabEnabled () : Boolean;
		public function set tabEnabled (enabled:Boolean) : void;

		/// Specifies the tab ordering of objects in a SWF file.
		public function get tabIndex () : int;
		public function set tabIndex (index:int) : void;

		/// Calling the new InteractiveObject() constructor throws an ArgumentError exception.
		public function InteractiveObject ();
	}
}
