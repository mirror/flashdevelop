package mx.accessibility
{
	import mx.containers.Panel;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The PanelAccImpl class is the accessibility class for Panel. * *  @helpid 3011 *  @tiptext This is the Panel Accessibility Class. *  @review
	 */
	public class PanelAccImpl extends AccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing PanelAccImpl class to hook its	 *  createAccessibilityImplementation() method to Panel class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private
		 */
		private static const ROLE_SYSTEM_DIALOG : uint = 0x12;
		/**
		 *  @private
		 */
		private static const ROLE_SYSTEM_TITLEBAR : uint = 0x01;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_FOCUSED : uint = 0x00000004;

		/**
		 *  @private	 *  Static Method for swapping the	 *  createAccessibilityImplementation method of Panel with	 *  the PanelAccImpl class.
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
		public function PanelAccImpl (master:UIComponent);
		/**
		 *  @private	 *  Gets the role for the component.	 *	 *  @param childID children of the component
		 */
		public function get_accRole (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the state of the Panel.	 *  States are predefined for all the components in MSAA. Values are assigned to each state.	 *  Depending upon the Panel being Focusable, Focused and Moveable, a value is returned.	 *	 *  @param childID:int	 *	 *  @return State:uint
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  Method to return an array of childIDs of Panel component	 *	 *  @return Array
		 */
		public function getChildIDArray () : Array;
		/**
		 *  @private	 *  IAccessible method for returning the bounding box of the Panel.	 *	 *  @param childID:uint	 *	 *  @return Location:Object
		 */
		public function accLocation (childID:uint) : *;
		/**
		 *  @private	 *  method for returning the name of the Panel	 *  which is spoken out by the screen reader	 *  The Panel should return the Title as the name.	 *	 *  @param childID:uint	 *	 *  @return Name:String
		 */
		protected function getName (childID:uint) : String;
	}
}
