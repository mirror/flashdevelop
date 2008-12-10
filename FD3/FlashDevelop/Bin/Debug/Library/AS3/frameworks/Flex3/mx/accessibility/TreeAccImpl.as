package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import mx.collections.ICollectionView;
	import mx.collections.CursorBookmark;
	import mx.collections.IViewCursor;
	import mx.controls.Tree;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.treeClasses.HierarchicalCollectionView;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.TreeEvent;

	/**
	 *  The TreeAccImpl class is the accessibility class for Tree. * *  @helpid 3009 *  @tiptext This is the Tree Accessibility Class. *  @review
	 */
	public class TreeAccImpl extends AccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing TreeAccImpl class to hook its	 *  createAccessibilityImplementation() method to Tree class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private	 *  Role of treeItem.
		 */
		private static const ROLE_SYSTEM_OUTLINEITEM : uint = 0x24;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_COLLAPSED : uint = 0x00000400;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_EXPANDED : uint = 0x00000200;
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
		 *  @private
		 */
		private static const EVENT_OBJECT_STATECHANGE : uint = 0x800A;

		/**
		 *  @private	 *	Array of events that we should listen for from the master component.
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of Tree with the TreeAccImpl class.
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
		public function TreeAccImpl (master:UIComponent);
		/**
		 *  @private	 *  Gets the role for the component.	 *	 *  @param childID children of the component
		 */
		public function get_accRole (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the value of the TreeItem/Tree	 *  which is spoken out by the screen reader	 *  The Tree should return the name of the currently selected item	 *  with m of n string with level info as value when focus moves to Tree.	 *	 *  @param childID uint	 *	 *  @return Name String	 *  @review
		 */
		public function get_accValue (childID:uint) : String;
		/**
		 *  @private	 *  IAccessible method for returning the state of the TreeItem.	 *  States are predefined for all the components in MSAA.	 *  Values are assigned to each state.	 *  Depending upon the treeItem being Selected, Selectable,	 *  Invisible, Offscreen, a value is returned.	 *	 *  @param childID uint	 *	 *  @return State uint
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the Default Action.	 *	 *  @param childID uint	 *	 *  @return name of default action.
		 */
		public function get_accDefaultAction (childID:uint) : String;
		/**
		 *  @private	 *  IAccessible method for executing the Default Action.	 *	 *  @param childID uint
		 */
		public function accDoDefaultAction (childID:uint) : void;
		/**
		 *  @private	 *  Method to return an array of childIDs.	 *	 *  @return Array
		 */
		public function getChildIDArray () : Array;
		/**
		 *  @private	 *  IAccessible method for returning the bounding box of the TreeItem.	 *	 *  @param childID uint	 *	 *  @return Location Object
		 */
		public function accLocation (childID:uint) : *;
		/**
		 *  @private	 *  IAccessible method for returning the childFocus of the List.	 *	 *  @param childID uint	 *	 *  @return focused childID.
		 */
		public function get_accFocus () : uint;
		/**
		 *  @private	 *  method for returning the name of the TreeItem/Tree	 *  which is spoken out by the screen reader	 *  The TreeItem should return the label as the name	 *  with m of n string with level info and	 *  Tree should return the name specified in the Accessibility Panel.	 *	 *  @param childID uint	 *	 *  @return Name String	 *  @review
		 */
		protected function getName (childID:uint) : String;
		private function getItemAt (index:int) : Object;
		/**
		 *  @private	 *  Local method to return m of n String.	 *	 *  @param item Object	 *	 *  @return string.
		 */
		private function getMOfN (item:Object) : String;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this	 *  to listen for events from its master component.
		 */
		protected function eventHandler (event:Event) : void;
	}
}
