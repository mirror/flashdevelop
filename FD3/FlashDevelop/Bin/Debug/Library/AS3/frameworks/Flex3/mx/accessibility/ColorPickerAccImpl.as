package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import mx.collections.CursorBookmark;
	import mx.collections.IViewCursor;
	import mx.controls.ColorPicker;
	import mx.controls.colorPickerClasses.SwatchPanel;
	import mx.controls.ComboBase;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.ColorPickerEvent;
	import mx.events.DropdownEvent;
	import mx.skins.halo.SwatchSkin;

	public class ColorPickerAccImpl extends ComboBaseAccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing DateChooserAccImpl class to hook its	 *  createAccessibilityImplementation() method to DateChooser class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
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
		public function ColorPickerAccImpl (master:UIComponent);
		private function openHandler (event:Event) : void;
		private function closeHandler (event:Event) : void;
		private function dropdown_changeHandler (event:Event) : void;
		/**
		 *  @private	 *  method for returning the name of the ComboBase	 *  For children items (i. e. ColorSwatch colors), it returns the digits if the hex	 *  color. We add a space between each digit to force the screen reader to read it	 *  as a series of text, not a number (e.g. #009900 is "zero, zero, nine, nine, zero, zero",	 *  not "nine thousand, nine hundred".	 *  	 *  ComboBase should return the name specified in the AccessibilityProperties.	 *	 *  @param childID uint	 *	 *  @return Name String	 *  @review
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private	 *  IAccessible method for returning the state of the ListItem	 *  (basically to remove 'not selected').	 *  States are predefined for all the components in MSAA.	 *  Values are assigned to each state.	 *  Depending upon the listItem being Selected, Selectable,	 *  Invisible, Offscreen, a value is returned.	 *	 *  @param childID uint	 *	 *  @return State uint
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  Method to return the current val;ue of the component	 *	 *  @return string
		 */
		public function get_accValue (childID:uint) : String;
		/**
		 *  @private	 *  Method to return an array of childIDs.	 *	 *  @return Array
		 */
		public function getChildIDArray () : Array;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this to listen for events	 *  from its master component.
		 */
		protected function eventHandler (event:Event) : void;
		/**
		 *  @private	 *  formats string color to add a space between each digit (hexit?).	 *  Makes screen readers read color properly.
		 */
		private function formatColorString (color:String) : String;
	}
}
