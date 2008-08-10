/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.core {
	import mx.core.Repeater;
	import flash.display.DisplayObject;
	public class RepeaterAutomationImpl extends UIComponentAutomationImpl {
		/**
		 * An array of all components within this repeater
		 *  found in the automation hierarchy.
		 */
		public function get automationTabularData():Object;
		/**
		 * Constructor.
		 *
		 * @param obj               <Repeater> Repeater object to be automated.
		 */
		public function RepeaterAutomationImpl(obj:Repeater);
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
	}
}
