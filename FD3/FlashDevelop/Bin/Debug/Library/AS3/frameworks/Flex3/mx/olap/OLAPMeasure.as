/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	public class OLAPMeasure extends OLAPMember {
		/**
		 * The aggregation to be performed for this measure.
		 *  You can use one of the following values for the property:
		 *  "SUM", "AVG", "MIN",
		 *  "MAX", or "COUNT".
		 */
		public function get aggregator():Object;
		public function set aggregator(value:Object):void;
		/**
		 * Constructor.
		 *
		 * @param name              <String (default = null)> The name of the OLAP element that includes the OLAP schema hierarchy of the element.
		 *                            For example, "Time_Year", where "Year" is a level of the "Time" dimension in an OLAP schema.
		 * @param displayName       <String (default = null)> The name of the measure, as a String, which can be used for display.
		 */
		public function OLAPMeasure(name:String = null, displayName:String = null);
	}
}
