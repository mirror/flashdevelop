package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import mx.controls.DateChooser;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The DateChooserAccImpl class is the accessibility class for DateChooser. * *  @helpid *  @tiptext This is the Button Accessibility Class. *  @review
	 */
	public class DateChooserAccImpl extends AccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing DateChooserAccImpl class to hook its	 *  createAccessibilityImplementation() method to DateChooser class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
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
		private var calFlag : Boolean;
		/**
		 *  @private
		 */
		private var monthFlag : Boolean;
		/**
		 *  @private
		 */
		private var lastSelectedDate : Date;
		/**
		 *  @private
		 */
		private var selDateFallsInCurrMonth : Boolean;

		/**
		 *  @private	 *	Array of events that we should listen for from the master component.
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of DateChooser withthe DateChooserAccImpl class.
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
		public function DateChooserAccImpl (master:UIComponent);
		/**
		 *  @private	 *  IAccessible method for returning the state of the DateChooser.	 *  States are predefined for all the components in MSAA.	 *	 *  @param childID uint	 *	 *  @return State uint	 *  @review
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for executing the Default Action.	 *	 *  @param childID uint
		 */
		public function accDoDefaultAction (childID:uint) : void;
		/**
		 *  @private	 *  method for returning the name of the DateChooser	 *  should return the selected date with weekday, month and year.	 *  appends 'today' if selected date is also today date.	 *	 *  @param childID uint	 *	 *  @return Name String	 *  @review
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this to listen	 *  for events from its master component.
		 */
		protected function eventHandler (event:Event) : void;
	}
}
