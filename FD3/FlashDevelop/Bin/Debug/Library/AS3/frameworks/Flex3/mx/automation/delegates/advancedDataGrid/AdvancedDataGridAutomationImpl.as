/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.advancedDataGrid {
	import mx.controls.AdvancedDataGrid;
	import flash.display.DisplayObject;
	public class AdvancedDataGridAutomationImpl extends AdvancedDataGridBaseExAutomationImpl {
		/**
		 * A matrix of the automationValues of each item in the grid1. The return value
		 *  is an array of rows, each of which is an array of item renderers (row-major).
		 */
		public function get automationTabularData():Object;
		public function set automationTabularData(value:Object):void;
		/**
		 * Constructor.
		 *
		 * @param obj               <AdvancedDataGrid> AdvancedDataGrid object to be automated.
		 */
		public function AdvancedDataGridAutomationImpl(obj:AdvancedDataGrid);
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
	}
}
