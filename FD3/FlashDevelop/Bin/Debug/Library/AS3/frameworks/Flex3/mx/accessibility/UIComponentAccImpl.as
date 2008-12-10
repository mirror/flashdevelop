package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import mx.containers.Form;
	import mx.containers.FormHeading;
	import mx.containers.FormItem;
	import mx.controls.FormItemLabel;
	import mx.controls.Label;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.core.Application;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The UIComponentAccImpl class is the accessibility class for UIComponent. *  It is used to provide accessibility to FormView, ToolTip & Error ToolTip. * *  @helpid 3030 *  @tiptext This is the UIComponent Accessibility Class. *  @review
	 */
	public class UIComponentAccImpl extends AccessibilityProperties
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing UIComponentAccImpl class to hook its	 *  createAccessibilityImplementation() method to UIComponent class 	 *  before it gets called from UIComponent.initialize().
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private
		 */
		private var oldToolTip : String;
		/**
		 *  @private
		 */
		private var oldErrorString : String;
		/**
		 *  A reference to the UIComponent itself.
		 */
		protected var master : UIComponent;

		/**
		 *  @private	 *  Static Method for swapping the	 *  createAccessibilityImplementation method of UIComponent with	 *  the UIComponentAccImpl class.
		 */
		private static function hookAccessibility () : Boolean;
		/**
		 *  @private	 *  Method for creating the Accessibility class.	 *  This method is called from UIComponent. 	 *  @review
		 */
		static function createAccessibilityImplementation (component:UIComponent) : void;
		/**
		 *  Method call for enabling accessibility for a component.	 *  This method is required for the compiler to activate	 *  the accessibility classes for a component.
		 */
		public static function enableAccessibility () : void;
		/**
		 *  Method for supporting Form Accessibility.	 *  @review
		 */
		public static function getFormName (component:UIComponent) : String;
		/**
		 *  @private	 *  Method for supporting Form Accessibility.
		 */
		private static function updateFormItemString (formItem:FormItem) : String;
		/**
		 *  Constructor.	 *	 *  @param master The UIComponent instance that this AccImpl instance	 *  is making accessible.
		 */
		public function UIComponentAccImpl (component:UIComponent);
		/**
		 *  Generic event handler.	 *  All UIComponentAccImpl subclasses must implement this	 *  to listen for events from its master component.
		 */
		protected function eventHandler (event:Event) : void;
	}
}
