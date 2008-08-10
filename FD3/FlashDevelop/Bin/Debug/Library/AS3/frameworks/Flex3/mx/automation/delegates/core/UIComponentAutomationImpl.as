/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.core {
	import flash.events.EventDispatcher;
	import mx.automation.IAutomationObject;
	import flash.display.DisplayObject;
	import mx.core.UIComponent;
	public class UIComponentAutomationImpl extends EventDispatcher implements IAutomationObject {
		/**
		 * Name that can be used as an identifier for this object.
		 */
		public function get automationName():String;
		public function set automationName(value:String):void;
		/**
		 * This value generally corresponds to the rendered appearance of the
		 *  object and should be usable for correlating the identifier with
		 *  the object as it appears visually within the application.
		 */
		public function get automationValue():Array;
		/**
		 * Returns the component instance associated with this delegate instance.
		 */
		public function get uiComponent():DisplayObject;
		public function set uiComponent(value:DisplayObject):void;
		/**
		 * Constructor.
		 *
		 * @param obj               <UIComponent> UIComponent object to be automated.
		 */
		public function UIComponentAutomationImpl(obj:UIComponent);
		/**
		 * Sets up a automation synchronization with layout manager update complete event.
		 *  When certain actions are being replayed automation needs to wait before it can
		 *  replay the next event. This wait is required to allow the framework to complete
		 *  actions requested by the component. Normally a layout manager update complte event
		 *  signals end of all updates. This method adds syncrhonization which gets signaled as
		 *  complete when update_complete event is received.
		 */
		protected function addLayoutCompleteSynchronization():void;
		/**
		 * Method which gets called after the component has been initialized.
		 *  This can be used to access any sub-components and act on them.
		 */
		protected function componentInitialized():void;
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> DisplayObject object representing the application root.
		 */
		public static function init(root:DisplayObject):void;
	}
}
