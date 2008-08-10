/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.advancedDataGridClasses {
	public class SortInfo {
		/**
		 * Contains true when the column is sorted in descending order,
		 *  and false when the column is sorted in ascending order.
		 */
		public var descending:Boolean;
		/**
		 * The number of this column in the sort order sequence.
		 *  This number is used when sorting by multiple columns.
		 */
		public var sequenceNumber:int;
		/**
		 * Contains PROPOSEDSORT if the sort is only a visual
		 *  indication of the proposed sort, or contains ACTUALSORT
		 *  if the sort is the actual current sort.
		 */
		public var status:String;
		/**
		 * Constructor
		 *
		 * @param sequenceNumber    <int (default = -1)> The number of this column in the sort order sequence.
		 * @param descending        <Boolean (default = false)> true when the column is sorted in descending order.
		 * @param status            <String (default = NaN)> PROPOSEDSORT if the sort is only a visual
		 *                            indication of the proposed sort, or ACTUALSORT
		 *                            if the sort is the actual current sort.
		 */
		public function SortInfo(sequenceNumber:int = -1, descending:Boolean = false, status:String);
		/**
		 * Specifies that the sort is the actual current sort.
		 */
		public static const ACTUALSORT:String = "actualSort";
		/**
		 * Specifies that the sort is only a visual
		 *  indication of the proposed sort.
		 */
		public static const PROPOSEDSORT:String = "proposedSort";
	}
}
