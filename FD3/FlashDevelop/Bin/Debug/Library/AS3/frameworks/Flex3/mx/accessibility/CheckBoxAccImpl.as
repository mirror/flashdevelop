package mx.accessibility
{
	import mx.controls.Button;
	import mx.controls.CheckBox;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The CheckBoxAccImpl class is the accessibility class for CheckBox. * *  @helpid 3003 *  @tiptext This is the CheckBoxAccImpl Accessibility Class. *  @review
	 */
	public class CheckBoxAccImpl extends ButtonAccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing CheckBoxAccImpl class to hook its	 *  createAccessibilityImplementation() method to CheckBox class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_CHECKED : uint = 0x00000010;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of CheckBox with the CheckBoxAccImpl class.
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
		public function CheckBoxAccImpl (master:UIComponent);
		/**
		 *  @private	 *  IAccessible method for returning the state of the CheckBox.	 *  States are predefined for all the components in MSAA.	 *  Values are assigned to each state.	 *  Depending upon whether the CheckBox is checked or unchecked,	 *  a value is returned.	 *	 *  @param childID uint	 *	 *  @return State Whether the CheckBox is checked or unchecked.
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private	 *  IAccessible method for returning the default action of	 *  the CheckBox, which is Check or UnCheck depending on the state.	 *	 *  @param childID uint	 *	 *  @return DefaultAction Check or UnCheck.
		 */
		public function get_accDefaultAction (childID:uint) : String;
	}
}
