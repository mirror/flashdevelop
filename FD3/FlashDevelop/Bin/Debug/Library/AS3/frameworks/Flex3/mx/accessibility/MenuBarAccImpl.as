package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import mx.controls.MenuBar;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.MenuEvent;

	/**
	 *  The MenuBarAccImpl class is the accessibility class for MenuBar. * *  @helpid 3007 *  @tiptext This is the MenuBarAccImpl Accessibility Class. *  @review
	 */
	public class MenuBarAccImpl extends AccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing MenuBarAccImpl class to hook its	 *  createAccessibilityImplementation() method to MenuBar class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private	 *  Role of menuItem.
		 */
		private static const ROLE_SYSTEM_MENUITEM : uint = 0x0C;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_FOCUSABLE : uint = 0x00100000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_FOCUSED : uint = 0x00000004;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_HASPOPUP : uint = 0x40000000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_HOTTRACKED : uint = 0x00000080;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_SELECTABLE : uint = 0x00200000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_UNAVAILABLE : uint = 0x00000001;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_FOCUS : uint = 0x8005;
		/**
		 *  @private
		 */
		private static const EVENT_SYSTEM_MENUEND : uint = 0x00000005;
		/**
		 *  @private
		 */
		private static const EVENT_SYSTEM_MENUSTART : uint = 0x00000004;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_SELECTION : uint = 0x8006;

		/**
		 *  @private	 *	Array of events that we should listen for from the master component.
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of MenuBar with the MenuBarAccImpl class.
		 */
		private static function hookAccessibility () : Boolean;
		/**
		 *  @private	 *  Method for creating the Accessibility class.	 *  This method is called from UIComponent.	 *  @review
		 */
		static function createAccessibilityImplementation (component:UIComponent) : void;
		/**
		 *  Method call for enabling accessibility for a component.	 *  This method is required for the compiler to activate	 *  the accessibility classes for a component.
		 */
		public static function enableAccessibility () : void;
		/**
		 *  Constructor.	 *	 *  @param master The UIComponent instance that this AccImpl instance	 *  is making accessible.
		 */
		public function MenuBarAccImpl (master:UIComponent);
		/**
		 *  Gets the role for the component.	 *	 *  @param childID uint
		 */
		public function get_accRole (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the state of the MenuItem.	 *  States are predefined for all the components in MSAA.	 *  Values are assigned to each state.	 *  Depending upon the listItem being Selected, Selectable,	 *  Invisible, Offscreen, a value is returned.	 *	 *  @param childID uint	 *	 *  @return State uint
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the Default Action.	 *	 *  @param childID uint	 *	 *  @return name of default action.
		 */
		public function get_accDefaultAction (childID:uint) : String;
		/**
		 *  @private	 *  IAccessible method for executing the Default Action.	 *	 *  @param childID uint
		 */
		public function accDoDefaultAction (childID:uint) : void;
		/**
		 *  @private	 *  Method to return an array of childIDs.	 *	 *  @return Array
		 */
		public function getChildIDArray () : Array;
		/**
		 *  @private	 *  IAccessible method for returning the bounding box of the MenuBarItem.	 *	 *  @param childID uint	 *	 *  @return Location Object
		 */
		public function accLocation (childID:uint) : *;
		/**
		 *  @private	 *  IAccessible method for returning the childFocus of the List.	 *	 *  @param childID uint	 *	 *  @return focused childID.
		 */
		public function get_accFocus () : uint;
		/**
		 *  @private	 *  IAccessible method for returning the name of the MenuBar	 *  which is spoken out by the screen reader.	 *  The MenuItem should return the label as the name	 *  and MenuBar should return the name specified in the Accessibility Panel.	 *	 *  @param childID uint	 *	 *  @return Name String
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this	 *  to listen for events from its master component.
		 */
		protected function eventHandler (event:Event) : void;
	}
}
