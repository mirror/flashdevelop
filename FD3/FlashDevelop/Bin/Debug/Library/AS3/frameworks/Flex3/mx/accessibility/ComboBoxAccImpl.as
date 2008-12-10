package mx.accessibility
{
	import mx.collections.CursorBookmark;
	import mx.controls.ComboBox;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The ComboBoxAccImpl class is the accessibility class for List. * *  @helpid 3005 *  @tiptext This is the ComboBoxAccImpl Accessibility Class. *  @review
	 */
	public class ComboBoxAccImpl extends ComboBaseAccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing ComboBoxAccImpl class to hook its	 *  createAccessibilityImplementation() method to ComboBox class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of ComboBox with the ComboBoxAccImpl class.
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
		public function ComboBoxAccImpl (master:UIComponent);
		/**
		 *  @private	 *  method for returning the name of the ComboBox	 *  Have to override getName as itemToLabel() is only in ComboBox	 *  The ListItem should return the label as the name with m of n string and	 *  ComboBox should return the name specified in the AccessibilityProperties.	 *	 *  @param childID uint	 *	 *  @return Name String	 *  @review
		 */
		protected function getName (childID:uint) : String;
	}
}
