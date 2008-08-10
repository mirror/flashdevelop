/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	public class SummaryRow {
		/**
		 * Array of SummaryField instances that define the characteristics of the
		 *  data fields used to create the summary.
		 */
		public var fields:Array;
		/**
		 * Specifies a callback function that defines the summary object,
		 *  which is an instance of the SummaryObject class.
		 *  The SummaryObject instance collects summary data for display in the
		 *  AdvancedDataGrid control.
		 *  The AdvancedDataGrid control adds the SummaryObject instance to the
		 *  data provider to display the summary data in the control.
		 *  Therefore, define within the SummaryObject instance the properties that you want to display.
		 */
		public var summaryObjectFunction:Function;
		/**
		 * Specifies where the summary row appears in the AdvancedDataGrid control.
		 *  Possible values are:
		 *  "first" - Create a summary row as the first row in the group.
		 *  "last" - Create a summary row as the last row in the group.
		 *  "group" - Add the summary data to the row corresponding to the group.
		 */
		public var summaryPlacement:String = "last";
		/**
		 * Constructor.
		 */
		public function SummaryRow();
	}
}
