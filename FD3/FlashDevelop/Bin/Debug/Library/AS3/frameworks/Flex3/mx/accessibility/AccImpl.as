package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityImplementation;
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import mx.containers.Form;
	import mx.containers.FormHeading;
	import mx.containers.FormItem;
	import mx.controls.Label;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.managers.SystemManager;

include "../core/Version.as"
	/**
	 *  The AccImpl class is Flex's base class for implementing accessibility
 *  in UIComponents.
 *  It is a subclass of the Flash Player's AccessibilityImplementation class.
	 */
	public class AccImpl extends AccessibilityImplementation
	{
		/**
		 *  @private
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
		 *  A reference to the UIComponent instance that this AccImpl instance
     *  is making accessible.
		 */
		protected var master : UIComponent;
		/**
		 *  Accessibility role of the component being made accessible.
		 */
		protected var role : uint;

		/**
		 *  All subclasses must override this function by returning an array
     *  of strings of the events to listen for.
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  Method for supporting Form Accessibility.
		 */
		public static function getFormName (component:UIComponent) : String;

		/**
		 *  @private
     *  Method for supporting Form Accessibility.
		 */
		private static function updateFormItemString (formItem:FormItem) : String;

		/**
		 *  Constructor.
     *
     *  @param master The UIComponent instance that this AccImpl instance
     *  is making accessible.
		 */
		public function AccImpl (master:UIComponent);

		/**
		 *  @private
     *  Returns the system role for the component.
     *
     *  @param childID uint.
     *
     *  @return Role associated with the component.
     *
     *  @tiptext Returns the system role for the component
     *  @helpid 3000
		 */
		public function get_accRole (childID:uint) : uint;

		/**
		 *  @private
     *  Returns the name of the component.
     *
     *  @param childID uint.
     *
     *  @return Name of the component.
     *
     *  @tiptext Returns the name of the component
     *  @helpid 3000
		 */
		public function get_accName (childID:uint) : String;

		/**
		 *  @private
     *  Method to return an array of childIDs.
     *
     *  @return Array
		 */
		public function getChildIDArray () : Array;

		/**
		 *  @private
     *  IAccessible method for giving focus to a child item in the component
     *  (but not to the component itself; accSelect() is never called
     *  with a childID of 0).
     *  Even though this method does nothing, without it the Player
     *  causes an IAccessible "Member not found" error.
		 */
		public function accSelect (selFlag:uint, childID:uint) : void;

		/**
		 *  Returns the name of the accessible component.
     *  All subclasses must implement this
     *  instead of implementing get_accName().
		 */
		protected function getName (childID:uint) : String;

		/**
		 *  Utility method to determine state of the accessible component.
		 */
		protected function getState (childID:uint) : uint;

		/**
		 *  @private
		 */
		private function getStatusName () : String;

		/**
		 *  @private
		 */
		protected function createChildIDArray (n:int) : Array;

		/**
		 *  Generic event handler.
     *  All AccImpl subclasses must implement this
     *  to listen for events from its master component.
		 */
		protected function eventHandler (event:Event) : void;

		/**
		 *  @private
     *  Handles events common to all accessible UIComponents.
		 */
		protected function $eventHandler (event:Event) : void;
	}
}
