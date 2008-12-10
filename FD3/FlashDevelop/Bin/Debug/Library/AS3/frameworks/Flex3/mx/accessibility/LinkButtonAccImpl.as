package mx.accessibility
{
	import mx.controls.LinkButton;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The LinkButtonAccImpl class is the accessibility class for Link. * *  @helpid 3002 *  @tiptext This is the LinkButton Accessibility Class. *  @review
	 */
	public class LinkButtonAccImpl extends ButtonAccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing LinkButtonAccImpl class to hook its	 *  createAccessibilityImplementation() method to LinkButton class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;

		/**
		 *  @private	 *  Static Method for swapping the	 *  createAccessibilityImplementation method of LinkButton with	 *  the LinkButtonAccImpl class.
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
		public function LinkButtonAccImpl (master:UIComponent);
		/**
		 *  @private	 *  IAccessible method for returning the default action	 *  of the LinkButton, which is Jump.	 *	 *  @param childID uint	 *	 *  @return DefaultAction String
		 */
		public function get_accDefaultAction (childID:uint) : String;
	}
}
