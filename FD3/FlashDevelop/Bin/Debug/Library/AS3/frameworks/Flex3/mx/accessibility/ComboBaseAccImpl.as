package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import mx.collections.CursorBookmark;
	import mx.collections.IViewCursor;
	import mx.controls.ComboBase;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The ComboBaseAccImpl class is the accessibility class for ComboBase. *  Since ComboBox inherits from ComboBase, *  this class is inherited by ComboBoxAccImpl. * *  @helpid 3004 *  @tiptext This is the ComboBase Accessibility Class. *  @review
	 */
	public class ComboBaseAccImpl extends AccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing ComboBaseAccImpl class to hook its	 *  createAccessibilityImplementation() method to ComboBase class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private
		 */
		private static const ROLE_SYSTEM_LISTITEM : uint = 0x22;
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
		private static const EVENT_OBJECT_VALUECHANGE : uint = 0x800E;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_SELECTION : uint = 0x8006;

		/**
		 *  @private	 *	Array of events that we should listen for from the master component.
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of ComboBase with the ComboBaseAccImpl class.
		 */
		private static function hookAccessibility () : Boolean;
		/**
		 *  @private	 *  Method for creating the Accessibility class.	 *  This method is called from UIComponent.	 *  @review
		 */
		static function createAccessibilityImplementation (component:UIComponent) : void;
		/**
		 *  Method call for enabling accessibility for a component.	 *  this method is required for the compiler to activate	 *  the accessibility classes for a component.
		 */
		public static function enableAccessibility () : void;
		/**
		 *  Constructor.	 *	 *  @param master The UIComponent instance that this AccImpl instance	 *  is making accessible.
		 */
		public function ComboBaseAccImpl (master:UIComponent);
		/**
		 *  @private	 *  Gets the role for the component.	 *	 *  @param childID uint.
		 */
		public function get_accRole (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the value of the ComboBase	 *  (which would be the text of the item selected).	 *  The ComboBase should return the content of the TextField as the value.	 *	 *  @param childID uint	 *	 *  @return Value String	 *  @review
		 */
		public function get_accValue (childID:uint) : String;
		/**
		 *  @private	 *  IAccessible method for returning the state of the ListItem	 *  (basically to remove 'not selected').	 *  States are predefined for all the components in MSAA.	 *  Values are assigned to each state.	 *  Depending upon the listItem being Selected, Selectable,	 *  Invisible, Offscreen, a value is returned.	 *	 *  @param childID uint	 *	 *  @return State uint
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  Method to return an array of childIDs.	 *	 *  @return Array
		 */
		public function getChildIDArray () : Array;
		/**
		 *  @private	 *  method for returning the name of the ComboBase	 *  For children items, it would add m of n string to the name.	 *  ComboBase should return the name specified in the AccessibilityProperties.	 *	 *  @param childID uint	 *	 *  @return Name String	 *  @review
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this to listen for events	 *  from its master component.
		 */
		protected function eventHandler (event:Event) : void;
	}
}
