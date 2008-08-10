/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import flash.utils.Proxy;
	public class OLAPElement extends Proxy implements IOLAPElement {
		/**
		 * The dimension to which this element belongs.
		 */
		public function get dimension():IOLAPDimension;
		public function set dimension(value:IOLAPDimension):void;
		/**
		 * The name of the OLAP element, as a String, which can be used for display.
		 */
		public function get displayName():String;
		public function set displayName(value:String):void;
		/**
		 * The name of the OLAP element that includes the OLAP schema hierarchy of the element.
		 *  For example, "Time_Year" is the name of the OLAP element,
		 *  where "Year" is a level of the "Time" dimension in an OLAP schema.
		 */
		public function get name():String;
		public function set name(value:String):void;
		/**
		 * The unique name of the OLAP element in the cube.
		 *  For example, "[Time][Year][2007]" is a unique name,
		 *  where 2007 is the element name belonging to the "Year" level of the "Time" dimension.
		 */
		public function get uniqueName():String;
		/**
		 * Constructor
		 *
		 * @param name              <String (default = null)> The name of the OLAP element that includes the OLAP schema hierarchy of the element.
		 *                            For example, "Time_Year", where "Year" is a level of the "Time" dimension in an OLAP schema.
		 * @param displayName       <String (default = null)> The name of the OLAP element, as a String, which can be used for display.
		 */
		public function OLAPElement(name:String = null, displayName:String = null);
		/**
		 * Returns the unique name of the element.
		 *
		 * @return                  <String> The unique name of the element.
		 */
		public function toString():String;
	}
}
