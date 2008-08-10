/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.olapDataGridClasses {
	import mx.core.IFactory;
	public class OLAPDataGridRendererProvider {
		/**
		 * The renderer object used for customizing the OLAPDataGrid control.
		 */
		public function get renderer():IFactory;
		public function set renderer(value:IFactory):void;
		/**
		 * The name of a CSS style declaration for controlling
		 *  the appearance of the cell.
		 */
		public var styleName:String;
		/**
		 * Specifies whether the renderer is applied to a
		 *  dimension (OLAPDataGrid.OLAP_DIMENSION),
		 *  hierarchy(OLAPDataGrid.OLAP_HIERARCHY),
		 *  level(OLAPDataGrid.OLAP_LEVEL),
		 *  or member (OLAPDataGrid.OLAP_MEMBER) of an axis.
		 */
		public function get type():int;
		public function set type(value:int):void;
		/**
		 * The unique name of the IOLAPElement to which the renderer is applied.
		 *  For example, "[TimeDim][YearHier][2007]" is a unique name,
		 *  where "2007" is the level belonging to the "YearHier" hierarchy
		 *  of the "TimeDim" dimension.
		 */
		public function get uniqueName():String;
		public function set uniqueName(value:String):void;
	}
}
