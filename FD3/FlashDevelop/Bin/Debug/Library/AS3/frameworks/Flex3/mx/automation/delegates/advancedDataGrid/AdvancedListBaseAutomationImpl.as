/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.advancedDataGrid {
	import mx.automation.delegates.core.ScrollControlBaseAutomationImpl;
	import mx.controls.listClasses.AdvancedListBase;
	import flash.display.DisplayObject;
	public class AdvancedListBaseAutomationImpl extends ScrollControlBaseAutomationImpl {
		/**
		 * A matrix of the automationValues of each item in the grid. The return value
		 *  is an array of rows, each of which is an array of item renderers (row-major).
		 */
		public function get automationTabularData():Object;
		/**
		 * Constructor.
		 *
		 * @param obj               <AdvancedListBase> AdvancedListBase object to be automated.
		 */
		public function AdvancedListBaseAutomationImpl(obj:AdvancedListBase);
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
	}
}
