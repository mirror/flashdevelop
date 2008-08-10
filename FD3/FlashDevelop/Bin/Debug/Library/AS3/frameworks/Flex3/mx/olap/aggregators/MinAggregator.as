/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap.aggregators {
	import mx.olap.IOLAPCustomAggregator;
	public class MinAggregator implements IOLAPCustomAggregator {
		/**
		 * Flex calls this method to start the computation of an aggregation value.
		 *
		 * @param dataField         <String> The name of the OLAPMeasure.dataField property
		 *                            for the measure to be aggregated.
		 * @return                  <Object> An Object initialized for the aggregation.
		 *                            Use this Object to hold any information necessary to perform the aggregation.
		 *                            You pass this Object to subsequent calls to the computeLoop()
		 *                            and computeEnd() methods.
		 */
		public function computeBegin(dataField:String):Object;
		/**
		 * Flex calls this method to end the computation of the aggregation value.
		 *
		 * @param data              <Object> The Object returned by the call to the computeLoop() method.
		 *                            Use this Object to hold information necessary to perform the aggregation.
		 * @param dataField         <String> The name of the OLAPMeasure.dataField property
		 *                            for the measure to be aggregated.
		 * @return                  <Number> The aggregated value.
		 */
		public function computeEnd(data:Object, dataField:String):Number;
		/**
		 * Flex calls this method when a new value needs to be added to the aggregation.
		 *
		 * @param data              <Object> The Object returned by the call to the computeBegin() method,
		 *                            or calculated by a previous call to the computeLoop() method.
		 *                            Use this Object to hold information necessary to perform the aggregation.
		 *                            This method modifies this Object; it does not return a value.
		 * @param dataField         <String> The name of the OLAPMeasure.dataField property
		 *                            for the measure to be aggregated.
		 * @param value             <Object> The object representing the rows data that is being analyzed.
		 */
		public function computeLoop(data:Object, dataField:String, value:Object):void;
		/**
		 * Flex calls this method to start aggregation of aggregated values.
		 *  Calculating the average value of a group of averages is an example of
		 *  an aggregation of aggregated values.
		 *
		 * @param value             <Object> The Object returned by the call to the computeEnd() method
		 *                            for a previous aggregation.
		 *                            Use this Object to hold the information necessary to perform the aggregation.
		 * @return                  <Object> An Object initialized for the aggregation.
		 *                            Use this Object to hold any information necessary to perform the aggregation.
		 *                            You pass this Object to subsequent calls to the computeObjectLoop()
		 *                            and computeObjectEnd() methods.
		 */
		public function computeObjectBegin(value:Object):Object;
		/**
		 * Flex calls this method to end the computation.
		 *
		 * @param value             <Object> The Object returned by a call to the computeObjectLoop() method
		 *                            that is used to store the aggregation results.
		 *                            This method modifies this Object; it does not return a value.
		 * @param dataField         <String> The name of the OLAPMeasure.dataField property
		 *                            for the measure to be aggregated.
		 * @return                  <Number> The aggregated value.
		 */
		public function computeObjectEnd(value:Object, dataField:String):Number;
		/**
		 * Flex calls this method when a new aggregated value needs to be added to the aggregation.
		 *
		 * @param value             <Object> The Object returned by a call the computeObjectBegin() method,
		 *                            or calculated by a previous call to the computeObjectLoop() method.
		 *                            This method modifies this Object; it does not return a value.
		 * @param newValue          <Object> The Object returned by the call to the computeEnd() method
		 *                            for a previous aggregation.
		 */
		public function computeObjectLoop(value:Object, newValue:Object):void;
	}
}
