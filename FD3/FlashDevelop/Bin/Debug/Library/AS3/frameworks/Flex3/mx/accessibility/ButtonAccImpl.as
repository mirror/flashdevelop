package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import mx.controls.Button;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The ButtonAccImpl class is the accessibility class for Button.  *  This AccImpl class is used in CheckBox and RadioButton,  *  as these components extend the Button class.  *  *  @helpid 3002  *  @tiptext This is the Button Accessibility Class.  *  @review
	 */
	public class ButtonAccImpl extends AccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing ButtonAccImpl class to hook its	 *  createAccessibilityImplementation() method to Button class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_PRESSED : uint = 0x00000008;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_NAMECHANGE : uint = 0x800C;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_STATECHANGE : uint = 0x800A;

		/**
		 *  @private	 *	Array of events that we should listen for from the master component.
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of Button with the ButtonAccImpl class.
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
		public function ButtonAccImpl (master:UIComponent);
		/**
		 *  @private	 *  IAccessible method for returning the state of the Button.	 *  States are predefined for all the components in MSAA.	 *  Values are assigned to each state.	 *  Depending upon the button being pressed or released,	 *  a value is returned.	 *	 *  @param childID uint	 *	 *  @return State uint
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the default action	 *  of the Button, which is Press.	 *	 *  @param childID uint	 *	 *  @return DefaultAction String
		 */
		public function get_accDefaultAction (childID:uint) : String;
		/**
		 *  @private	 *  IAccessible method for performing the default action	 *  associated with Button, which is Press.	 *	 *  @param childID uint
		 */
		public function accDoDefaultAction (childID:uint) : void;
		/**
		 *  @private	 *  method for returning the name of the Button	 *  which is spoken out by the screen reader	 *  The Button should return the label inside as the name of the Button.	 *  The name returned here would take precedence over the name	 *  specified in the accessibility panel.	 *	 *  @param childID uint	 *	 *  @return Name String
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this	 *  to listen for events from its master component.
		 */
		protected function eventHandler (event:Event) : void;
	}
}
