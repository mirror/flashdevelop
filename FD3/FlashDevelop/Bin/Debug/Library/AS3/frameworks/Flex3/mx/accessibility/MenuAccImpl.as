package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import mx.controls.Menu;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.MenuEvent;

	/**
	 *  The MenuAccImpl class is the accessibility class for Menu. * *  @helpid 3007 *  @tiptext This is the MenuAccImpl Accessibility Class. *  @review
	 */
	public class MenuAccImpl extends ListBaseAccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing MenuAccImpl class to hook its	 *  createAccessibilityImplementation() method to Menu class	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private	 *  Role of menuItem
		 */
		private static const ROLE_SYSTEM_MENUITEM : uint = 0x0C;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_CHECKED : uint = 0x00000010;
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
		private static const STATE_SYSTEM_UNAVAILABLE : uint = 0x00000001;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_FOCUS : uint = 0x8005;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_SELECTION : uint = 0x8006;
		/**
		 *  @private
		 */
		private static const EVENT_SYSTEM_MENUPOPUPSTART : uint = 0x00000006;
		/**
		 *  @private
		 */
		private static const EVENT_SYSTEM_MENUPOPUPEND : uint = 0x00000007;

		/**
		 *  @private	 *	Array of events that we should listen for from the master component.
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of Menu with MenuAccImpl class.
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
		public function MenuAccImpl (master:UIComponent);
		/**
		 *  @private	 *  Gets the role for the component.	 *	 *  @param childID children of the component
		 */
		public function get_accRole (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the value of the MenuItem/Menu	 *  which is spoken out by the screen reader	 *  The Menu should return the name of the currently selected item	 *  with m of n string as value when focus moves to Menu.	 *	 *  @param childID uint	 *	 *  @return Value String	 *  @review
		 */
		public function get_accValue (childID:uint) : String;
		/**
		 *  @private	 *  IAccessible method for returning the state of the Menu.	 *  States are predefined for all the components in MSAA.	 *  Values are assigned to each state.	 *  Depending upon the menuItem being Selected, Selectable,	 *  Invisible, Offscreen, a value is returned.	 *	 *  @param childID uint	 *	 *  @return State uint	 *  @review
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the Default Action.	 *	 *  @param childID uint	 *	 *  @return focused childID.
		 */
		public function get_accDefaultAction (childID:uint) : String;
		/**
		 *  @private	 *  method for returning the name of the MenuItem	 *  which is spoken out by the screen reader	 *  The MenuItem should return the label as the name	 *  and Menu should return the name specified in the Accessibility Panel.	 *	 *  @param childID uint	 *	 *  @return Name String	 *  @review
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this	 *  to listen for events from its master component.
		 */
		protected function eventHandler (event:Event) : void;
	}
}
