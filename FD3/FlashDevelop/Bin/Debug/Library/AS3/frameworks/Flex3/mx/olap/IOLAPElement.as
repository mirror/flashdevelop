/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	public interface IOLAPElement {
		/**
		 * The dimension to which this element belongs.
		 */
		public function get dimension():IOLAPDimension;
		/**
		 * The name of the OLAP element, as a String, which can be used for display.
		 */
		public function get displayName():String;
		/**
		 * The name of the OLAP element that includes the OLAP schema hierarchy of the element.
		 *  For example, "Time_Year" is the name of the OLAP element,
		 *  where "Year" is a level of the "Time" dimension in an OLAP schema.
		 */
		public function get name():String;
		/**
		 * The unique name of the OLAP element in the cube.
		 *  For example, "[Time][Year][2007]" is a unique name,
		 *  where 2007 is the element name belonging to the "Year" level of the "Time" dimension.
		 */
		public function get uniqueName():String;
	}
}
