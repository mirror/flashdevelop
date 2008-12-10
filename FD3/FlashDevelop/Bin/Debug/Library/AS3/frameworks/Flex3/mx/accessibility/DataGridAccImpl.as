package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import mx.collections.CursorBookmark;
	import mx.collections.IViewCursor;
	import mx.controls.DataGrid;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.DataGridEvent;

	/**
	 *  The DataGridAccImpl class is the accessibility class for DataGrid. * *  @helpid 3009 *  @tiptext This is the DataGrid Accessibility Class. *  @review
	 */
	public class DataGridAccImpl extends ListBaseAccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing DataGridAccImpl class to hook its	 *  createAccessibilityImplementation() method to DataGrid class 	 *  before it gets called from UIComponent.
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
		private static const STATE_SYSTEM_INVISIBLE : uint = 0x00008000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_OFFSCREEN : uint = 0x00010000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_SELECTABLE : uint = 0x00200000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_SELECTED : uint = 0x00000002;
		/**
		 *  @private	 *  Event emitted if 1 item is selected.
		 */
		private static const EVENT_OBJECT_FOCUS : uint = 0x8005;
		/**
		 *  @private	 *  Event emitted if 1 item is selected.
		 */
		private static const EVENT_OBJECT_SELECTION : uint = 0x8006;

		/**
		 *  @private	 *	Array of events that we should listen for from the master component.	 *  @review
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of DataGrid with the DataGridAccImpl class.
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
		public function DataGridAccImpl (master:UIComponent);
		/**
		 *  @private	 *  Gets the role for the component.	 *	 *  @param childID Children of the component
		 */
		public function get_accRole (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the value of the ListItem/DataGrid	 *  which is spoken out by the screen reader	 *  The DataGrid should return the name of the currently selected item	 *  with m of n string as value when focus moves to DataGrid.	 *	 *  @param childID uint	 *	 *  @return Name String	 *  @review
		 */
		public function get_accValue (childID:uint) : String;
		/**
		 *  @private	 *  IAccessible method for returning the state of the GridItem.	 *  States are predefined for all the components in MSAA.	 *  Values are assigned to each state.	 *  Depending upon the GridItem being Selected, Selectable, Invisible,	 *  Offscreen, a value is returned.	 *	 *  @param childID uint	 *	 *  @return State uint
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for executing the Default Action.	 *	 *  @param childID uint
		 */
		public function accDoDefaultAction (childID:uint) : void;
		/**
		 *  @private	 *  Method to return an array of childIDs.	 *	 *  @return Array
		 */
		public function getChildIDArray () : Array;
		/**
		 *  @private	 *  IAccessible method for returning the bounding box of the GridItem.	 *	 *  @param childID uint	 *	 *  @return Location Object
		 */
		public function accLocation (childID:uint) : *;
		/**
		 *  @private	 *  IAccessible method for returning the childFocus of the DataGrid.	 *	 *  @param childID uint	 *	 *  @return focused childID.
		 */
		public function get_accFocus () : uint;
		/**
		 *  @private	 *  method for returning the name of the ListItem/DataGrid	 *  which is spoken out by the screen reader	 *  The ListItem should return the label as the name with m of n string and	 *  DataGrid should return the name specified in the AccessibilityProperties.	 *	 *  @param childID uint	 *	 *  @return Name String	 *  @review
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this to listen	 *  for events from its master component.
		 */
		protected function eventHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function getItemAt (index:int) : Object;
	}
}
