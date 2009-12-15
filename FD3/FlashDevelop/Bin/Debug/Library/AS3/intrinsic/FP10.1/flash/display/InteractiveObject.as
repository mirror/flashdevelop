package flash.display
{
	import flash.accessibility.AccessibilityImplementation;
	import flash.ui.ContextMenu;

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
		public function get contextMenu () : ContextMenu;
		public function set contextMenu (cm:ContextMenu) : void;

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
