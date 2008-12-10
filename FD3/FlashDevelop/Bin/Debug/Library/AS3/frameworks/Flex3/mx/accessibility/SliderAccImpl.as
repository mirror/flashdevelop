package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import mx.controls.sliderClasses.Slider;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.SliderEvent;
	import flash.events.FocusEvent;

	/**
	 *  The SliderAccImpl class is the accessibility class for HSlider and VSlider. * *  @helpid *  @tiptext This is the TabNavigator Accessibility Class. *  @review
	 */
	public class SliderAccImpl extends AccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing DateChooserAccImpl class to hook its	 *  createAccessibilityImplementation() method to DateChooser class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
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
		private static const EVENT_OBJECT_VALUECHANGE : uint = 0x800E;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_SELECTION : uint = 0x8006;
		/**
		 *  @private
		 */
		private static const ROLE_SLIDER : uint = 0x33;

		/**
		 *  @private	 *	Array of events that we should listen for from the master component.
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of Slider withthe SliderAccImpl class.
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
		public function SliderAccImpl (master:UIComponent);
		/**
		 *  @private	 *  Gets the role for the component.	 *	 *  @param childID uint.
		 */
		public function get_accRole (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the value of the slider	 *  (which would be the value of the item selected).	 *  The slider should return the value of the current thumb as the value.	 *	 *  @param childID uint	 *	 *  @return Value String	 *  @review
		 */
		public function get_accValue (childID:uint) : String;
		/**
		 *  @private	 *  Method to return an array of childIDs.	 *	 *  @return Array
		 */
		public function getChildIDArray () : Array;
		/**
		 *  @private	 *  method for returning the name of the slider	 *  should return the value	 *	 *  @param childID uint	 *	 *  @return Name String	 *  @review
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private	 *  IAccessible method for returning the state of the Button.	 *  States are predefined for all the components in MSAA.	 *  Values are assigned to each state.	 *	 *  @param childID uint	 *	 *  @return State uint
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  Utility method determines state of the accessible component.
		 */
		protected function getState (childID:uint) : uint;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this to listen	 *  for events from its master component.
		 */
		protected function eventHandler (event:Event) : void;
		/**
		 *  @private	 *  This is (kind of) a hack to get around the fact that Slider is not 	 *  an IFocusManagerComponent. It forces frocus from accessibility when one of 	 *  its thumbs get focus.
		 */
		private function focusInHandler (event:Event) : void;
	}
}
