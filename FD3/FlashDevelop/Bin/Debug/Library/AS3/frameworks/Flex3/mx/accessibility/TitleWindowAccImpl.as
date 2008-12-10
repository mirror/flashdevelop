package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mx.containers.Panel;
	import mx.containers.TitleWindow;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The TitleWindowAccImpl class is the accessibility class for TitleWindow. * *  @helpid 3011 *  @tiptext This is the TitleWindow Accessibility Class. *  @review
	 */
	public class TitleWindowAccImpl extends PanelAccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing TitleWindowAccImpl class to hook its	 *  createAccessibilityImplementation() method to TitleWindow class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_FOCUSED : uint = 0x00000004;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_MOVEABLE : uint = 0x00040000;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_CREATE : uint = 0x8000;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_DESTROY : uint = 0x8001;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_LOCATIONCHANGE : uint = 0x800B;

		/**
		 *  @private	 *  Static Method for swapping the	 *  createAccessibilityImplementation method of TitleWindow with	 *  the TitleWindowAccImpl class.
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
		public function TitleWindowAccImpl (master:UIComponent);
		/**
		 *  @private	 *  IAccessible method for returning the state of the TitleWindow.	 *  States are predefined for all the components in MSAA.	 *  Values are assigned to each state.	 *  Depending upon the TitleWindow being Focusable, Focused and Moveable,	 *  a value is returned.	 *	 *  @param childID:uint	 *	 *  @return State:uint
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  Override the generic event handler.	 *  All AccImpl must implement this	 *  to listen for events from its master component.
		 */
		protected function eventHandler (event:Event) : void;
	}
}
