package flash.display
{
	import flash.ui.ContextMenu;
	import flash.accessibility.AccessibilityImplementation;

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
