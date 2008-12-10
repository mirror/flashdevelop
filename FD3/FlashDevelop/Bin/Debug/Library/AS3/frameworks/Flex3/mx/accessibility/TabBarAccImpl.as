package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import mx.containers.TabNavigator;
	import mx.controls.TabBar;
	import mx.controls.tabBarClasses.Tab;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The TabBarAccImpl class is the accessibility class for TabBar and TabNavigator. * *  @helpid *  @tiptext This is the TabNavigator Accessibility Class. *  @review
	 */
	public class TabBarAccImpl extends AccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing TabBarAccImpl class to hook its	 *  createAccessibilityImplementation() method to TabBar class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private
		 */
		private static const ROLE_SYSTEM_PAGETAB : uint = 0x25;
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
		private static const STATE_SYSTEM_SELECTABLE : uint = 0x00200000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_SELECTED : uint = 0x00000002;
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
		private static const MAX_NUM : uint = 100000;

		/**
		 *  @private	 *	Array of events that we should listen for from the master component.
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of TabBar with TabBarAccImpl class.
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
		public function TabBarAccImpl (master:UIComponent);
		/**
		 *  @private	 *  Gets the role for the component.	 *	 *  @param childID children of the component
		 */
		public function get_accRole (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the state of the Tabs.	 *  States are predefined for all the components in MSAA. Values are assigned to each state.	 *  Depending upon the Tab being Focusable, Focused and Moveable, a value is returned.	 *  @review	 *	 *  @param childID:uint	 *	 *  @return STATE:uint
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the Default Action.	 *	 *  @param childID uint	 *	 *  @return focused childID.
		 */
		public function get_accDefaultAction (childID:uint) : String;
		/**
		 *  @private	 *  IAccessible method for executing the Default Action.	 *	 *  @param childID uint	 *	 *  @return focused childID.
		 */
		public function accDoDefaultAction (childID:uint) : void;
		/**
		 *  @private	 *  Method to return the childID Array.	 *	 *  @return Array
		 */
		public function getChildIDArray () : Array;
		/**
		 *  @private	 *  IAccessible method for returning the bounding box of the Tabs.	 *  @review	 *	 *  @param childID:uint	 *	 *  @return Location:Object
		 */
		public function accLocation (childID:uint) : *;
		/**
		 *  @private	 *  IAccessible method for returning the childFocus of the TabBar.	 *	 *  @param childID uint	 *	 *  @return focused childID.
		 */
		public function get_accFocus () : uint;
		/**
		 *  @private	 *  method for returning the name of the Tab	 *  which is spoken out by the screen reader.	 *	 *  @param childID:uint	 *	 *  @return Name:String
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this to listen for events	 *  from its master component.
		 */
		protected function eventHandler (event:Event) : void;
	}
}
