/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.olap.IOLAPAxisPosition;
	import mx.olap.IOLAPMember;
	public class OLAPDataGrid extends AdvancedDataGrid {
		/**
		 * An OLAPDataGrid accepts only an IOLAPResult as dataProvider
		 *  other dataProviders are simply ignored.
		 *  One can set dataProvider to null, to reset the control.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * String displayed in a cell when the data for that cell returned by
		 *  the IOLAPResult instance is null or NaN.
		 */
		public var defaultCellString:String = "NaN";
		/**
		 * Array of OLAPDataGridHeaderRendererProvider instances that specify a
		 *  custom header renderer for the columns of the control.
		 *  You can use several header renderer providers to specify custom header renderers for
		 *  different columns the control.
		 */
		public function get headerRendererProviders():Array;
		public function set headerRendererProviders(value:Array):void;
		/**
		 * Array of OLAPDataGridItemRendererProvider instances that specify a
		 *  custom item renderer for the cells of the control.
		 *  You can use several renderer providers to specify custom item renderers used for
		 *  different locations in the control.
		 */
		public function get itemRendererProviders():Array;
		public function set itemRendererProviders(value:Array):void;
		/**
		 * A callback function called while rendering each cell in the cell data area.
		 */
		public function set styleFunction(value:Function):void;
		/**
		 * Constructor.
		 */
		public function OLAPDataGrid();
		/**
		 * Decide which renderer to use for the particular cell.
		 *  A cell falls at the intersection of a position on row as well as
		 *  column axis, thus it can fall in rules defined by the
		 *  itemRendererProviders property for both axis.
		 *  This method gives row axis a priority and searches for the
		 *  the right value of the itemRendererProviders property
		 *  to be used for the renderer.
		 *
		 * @param row               <IOLAPAxisPosition> The position of the cell in a row axis.
		 * @param column            <IOLAPAxisPosition> The position of the cell in a column axis.
		 * @return                  <OLAPDataGridItemRendererProvider> The item renderer to use for the cell at the intersection
		 *                            of the row and column axis.
		 */
		protected function getCellRendererInfo(row:IOLAPAxisPosition, column:IOLAPAxisPosition):OLAPDataGridItemRendererProvider;
		/**
		 * Applies the formatting associated with a particular cell to a String value.
		 *  A cell falls at the intersection of a position on row as well as
		 *  column axis.
		 *
		 * @param label             <String> The String value to be formatted.
		 * @param row               <IOLAPAxisPosition> The position of the cell in a row axis with an associated formatter.
		 * @param col               <IOLAPAxisPosition> The position of the cell in a column axis with an associated formatter.
		 * @return                  <String> The formatted value of label,
		 *                            or label if the cell does not exist or the cell does not have a formatter applied to it.
		 */
		protected function getFormattedCellValue(label:String, row:IOLAPAxisPosition, col:IOLAPAxisPosition):String;
		/**
		 * Returns the indent, in pixels, of the label in a renderer.
		 *
		 * @param position          <IOLAPAxisPosition> The position of the renderer on the axis.
		 * @param m                 <IOLAPMember> The member of the dimension to which the indent is requested.
		 * @param mIndex            <int> The index of m in position.members.
		 * @return                  <int> The indent, in pixels, of the label in a renderer.
		 */
		protected function getIndent(position:IOLAPAxisPosition, m:IOLAPMember, mIndex:int):int;
		/**
		 * Detects changes to style properties. When any style property is set,
		 *  Flex calls the styleChanged() method,
		 *  passing to it the name of the style being set.
		 *
		 * @param styleProp         <String> The name of the style property that changed.
		 */
		public override function styleChanged(styleProp:String):void;
		/**
		 * A constant that corresponds to the column axis.
		 */
		public static const COLUMN_AXIS:int = 0;
		/**
		 * A constant that corresponds to a member of an axis.
		 */
		public static const OLAP_DIMENSION:int = 3;
		/**
		 * A constant that corresponds to a member of an axis.
		 */
		public static const OLAP_HIERARCHY:int = 2;
		/**
		 * A constant that corresponds to a level of an axis.
		 */
		public static const OLAP_LEVEL:int = 1;
		/**
		 * A constant that corresponds to a member of an axis.
		 */
		public static const OLAP_MEMBER:int = 0;
		/**
		 * A constant that corresponds to the row axis.
		 */
		public static const ROW_AXIS:int = 1;
		/**
		 * A constant that corresponds to the slicer axis.
		 */
		public static const SLICER_AXIS:int = 2;
	}
}
