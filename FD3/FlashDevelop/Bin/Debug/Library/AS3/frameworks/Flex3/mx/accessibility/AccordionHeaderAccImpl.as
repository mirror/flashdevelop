package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import mx.containers.Accordion;
	import mx.containers.accordionClasses.AccordionHeader;
	import mx.controls.Button;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The AccordionHeaderAccImpl is the class *  for enabling Accordion Accessibility. * *  @helpid *  @tiptext This is the AccordionHeader Accessibility Class. *  @review
	 */
	public class AccordionHeaderAccImpl extends AccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing AccordionHeaderAccImpl class to hook its	 *  createAccessibilityImplementation() method to AccordionHeader class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
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
		private static const MAX_NUM : uint = 100000;

		/**
		 *  @private	 *	Array of events that we should listen for from the master component.
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of AccordionHeader with the AccordionHeaderAccImpl class.
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
		public function AccordionHeaderAccImpl (master:UIComponent);
		/**
		 *  @private	 *  IAccessible method for returning the state of Tab selected.	 *	 *  @param childID uint	 *	 *  @return State uint	 *  @review
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the Default Action.	 *	 *  @param childID uint	 *	 *  @return name of default action.
		 */
		public function get_accDefaultAction (childID:uint) : String;
		/**
		 *  @private	 *  method for returning the name of the Tab	 *  which is spoken out by the screen reader.	 *	 *  @param childID uint	 *	 *  @return Name String
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this to listen for events	 *  from its master component.
		 */
		protected function eventHandler (event:Event) : void;
		/**
		 *  @private	 *  Remove the change handler on the accordion that was causing this to stick around in memory 	 *  and cause RTE. Also remove self.
		 */
		protected function removedHandler (event:Event) : void;
	}
}
