/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.controls {
	import mx.controls.DataGrid;
	import flash.display.DisplayObject;
	public class DataGridAutomationImpl extends ListBaseAutomationImpl {
		/**
		 * A matrix of the automationValues of each item in the grid. The return value
		 *  is an array of rows, each of which is an array of item renderers (row-major).
		 */
		public function get automationTabularData():Object;
		/**
		 * Constructor.
		 *
		 * @param obj               <DataGrid> DataGrid object to be automated.
		 */
		public function DataGridAutomationImpl(obj:DataGrid);
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
	}
}
