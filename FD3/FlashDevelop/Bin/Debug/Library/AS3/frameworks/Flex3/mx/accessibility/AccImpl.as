package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityImplementation;
	import flash.accessibility.AccessibilityProperties;
	import flash.events.Event;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The AccImpl class is the base class for accessibility in components. *  AccImpl supports system roles, object based events, and states. * *  @helpid 3001 *  @tiptext The base class for accessibility in components.
	 */
	public class AccImpl extends AccessibilityImplementation
	{
		/**
		 *  @private	 *  Default state for all the components.
		 */
		private static const STATE_SYSTEM_NORMAL : uint = 0x00000000;
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
		private static const STATE_SYSTEM_UNAVAILABLE : uint = 0x00000001;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_NAMECHANGE : uint = 0x800C;
		/**
		 *  A reference to the UIComponent instance that this AccImpl instance	 *  is making accessible.
		 */
		protected var master : UIComponent;
		/**
		 *  Accessibility Role of the component being made accessible.	 *  @review
		 */
		protected var role : uint;

		/**
		 *  All subclasses must override this function by returning an array	 *  of strings of the events to listen for.
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private	 *  All subclasses must implement this function.
		 */
		static function createAccessibilityImplementation (component:UIComponent) : void;
		/**
		 *  Method call for enabling accessibility for a component.	 *  This method is required for the compiler to activate	 *  the accessibility classes for a component.
		 */
		public static function enableAccessibility () : void;
		/**
		 *  Constructor.	 *	 *  @param master The UIComponent instance that this AccImpl instance	 *  is making accessible.
		 */
		public function AccImpl (master:UIComponent);
		/**
		 *  @private	 *  Returns the system role for the component.	 *	 *  @param childID uint.	 *	 *  @return Role associated with the component.	 *	 *  @tiptext Returns the system role for the component	 *  @helpid 3000
		 */
		public function get_accRole (childID:uint) : uint;
		/**
		 *  @private	 *  Returns the name of the component.	 *	 *  @param childID uint.	 *	 *  @return Name of the component.	 *	 *  @tiptext Returns the name of the component	 *  @helpid 3000
		 */
		public function get_accName (childID:uint) : String;
		/**
		 *  Returns the name of the accessible component.	 *  All subclasses must implement this	 *  instead of implementing get_accName.
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  Utility method determines state of the accessible component.
		 */
		protected function getState (childID:uint) : uint;
		/**
		 *  @private
		 */
		private function getStatusName () : String;
		/**
		 *  Generic event handler.	 *  All AccImpl subclasses must implement this	 *  to listen for events from its master component.
		 */
		protected function eventHandler (event:Event) : void;
	}
}
