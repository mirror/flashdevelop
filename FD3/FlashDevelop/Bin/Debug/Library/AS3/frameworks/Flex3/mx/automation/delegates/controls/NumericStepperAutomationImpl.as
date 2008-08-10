/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.controls {
	import mx.automation.delegates.core.UIComponentAutomationImpl;
	import mx.controls.NumericStepper;
	import flash.display.DisplayObject;
	import mx.events.NumericStepperEvent;
	public class NumericStepperAutomationImpl extends UIComponentAutomationImpl {
		/**
		 * Constructor.
		 *
		 * @param obj               <NumericStepper> NumericStepper object to be automated.
		 */
		public function NumericStepperAutomationImpl(obj:NumericStepper);
		/**
		 */
		protected override function componentInitialized():void;
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
		/**
		 * @param event             <NumericStepperEvent> 
		 */
		protected function nsChangeHandler(event:NumericStepperEvent):void;
	}
}
