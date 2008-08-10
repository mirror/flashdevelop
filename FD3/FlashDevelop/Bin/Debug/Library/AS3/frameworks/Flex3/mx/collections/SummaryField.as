/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	public class SummaryField {
		/**
		 * Data field for which the summary is computed.
		 */
		public var dataField:String;
		/**
		 * The property used inside the summary object,
		 *  an instance of the SummaryObject class, to
		 *  hold summary information.
		 */
		public var label:String;
		/**
		 * The function that should be performed on the children.
		 *  You can specify one of the following values for numeric fields:
		 *  SUM, MIN, MAX, AVG, or COUNT.
		 */
		public var operation:String = "SUM";
		/**
		 * Specifies a callback function to compute a custom data summary.
		 */
		public var summaryFunction:Function;
		/**
		 * Constructor.
		 *
		 * @param dataField         <String (default = null)> Data field for which the summary is computed.
		 * @param operation         <String (default = "SUM")> The function that should be performed on the children.
		 *                            You can specify one of the following values for numeric fields:
		 *                            SUM, MIN, MAX, AVG, or COUNT.
		 */
		public function SummaryField(dataField:String = null, operation:String = "SUM");
	}
}
