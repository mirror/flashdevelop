package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityProperties;
	import flash.events.Event;
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.managers.SystemManager;

	/**
	 *  The AlertAccImpl class is the accessibility class for Alert. * *  @helpid 3030 *  @tiptext This is the Alert Accessibility Class. *  @review
	 */
	public class AlertAccImpl extends TitleWindowAccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing AlertAccImpl class to hook its	 *  createAccessibilityImplementation() method to Alert class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;

		/**
		 *  @private	 *	Array of events that we should listen for from the master component.
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of Alert with the AlertAccImpl class.
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
		public function AlertAccImpl (master:UIComponent);
		/**
		 *  @private	 *  method for returning the name of the child	 *  which is spoken out by the screen reader.	 *	 *  @param childID uint	 *	 *  @return Name String	 *  @review
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this	 *  to listen for events from its master component.
		 */
		protected function eventHandler (event:Event) : void;
	}
}
