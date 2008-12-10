package mx.accessibility
{
	import mx.controls.List;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The ListAccImpl class is the accessibility class for List. * *  @helpid 3007 *  @tiptext This is the ListAccImpl Accessibility Class.
	 */
	public class ListAccImpl extends ListBaseAccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing ListAccImpl class to hook its	 *  createAccessibilityImplementation() method to List class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of List with the ListAccImpl class.
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
		public function ListAccImpl (master:UIComponent);
	}
}
