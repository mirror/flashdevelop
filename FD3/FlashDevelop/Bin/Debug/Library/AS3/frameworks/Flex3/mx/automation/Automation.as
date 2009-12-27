package mx.automation
{
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	import mx.automation.IAutomationMouseSimulator;
	import mx.automation.IAutomationObjectHelper;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;

	/**
	 * The Automation class defines the entry point for the Flex Automation framework.
	 */
	public class Automation
	{
		/**
		 *  @private
     *  Component class to Delegate class map
		 */
		static var delegateClassMap : Object;
		/**
		 *  @private
		 */
		private static var _automationManager : IAutomationManager;
		/**
		 *  @private
		 */
		private static var _automationObjectHelper : IAutomationObjectHelper;
		/**
		 *  @private
		 */
		private static var _mouseSimulator : IAutomationMouseSimulator;

		/**
		 * The IAutomationManager instance.
		 */
		public static function get automationManager () : IAutomationManager;
		/**
		 * @private
		 */
		public static function set automationManager (manager:IAutomationManager) : void;

		/**
		 * The available IAutomationObjectHelper instance.
		 */
		public static function get automationObjectHelper () : IAutomationObjectHelper;

		/**
		 * Contains <code>true</code> if the automation module has been initialized.
		 */
		public static function get initialized () : Boolean;

		/**
		 * The currently active mouse simulator.
		 */
		public static function get mouseSimulator () : IAutomationMouseSimulator;
		/**
		 * @private
		 */
		public static function set mouseSimulator (ms:IAutomationMouseSimulator) : void;

		/**
		 *  Registers the component class and delegate class association with Automation.
     * 
     *  @param compClass The component class. 
     * 
     *  @param delegateClass The delegate class associated with the component.
		 */
		public static function registerDelegateClass (compClass:Class, delegateClass:Class) : void;
	}
}
