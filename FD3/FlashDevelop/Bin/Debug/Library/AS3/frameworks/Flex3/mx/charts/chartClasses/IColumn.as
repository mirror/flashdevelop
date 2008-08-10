/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	public interface IColumn {
		/**
		 * Specifies the width of items relative to the category size.
		 *  A value of 1 uses the entire space, while a value
		 *  of 0.6 uses 60% of the item's available space.
		 *  You typically do not set this property directly.
		 *  A governing ColumSet or ColumnChart would implicitly assign this value.
		 *  The actual item width used is the smaller of the
		 *  columnWidthRatio and the maxColumnWidth
		 *  properties.
		 */
		public function set columnWidthRatio(value:Number):void;
		/**
		 * Specifies how wide to draw the items, in pixels.
		 *  The actual item width used is the smaller of this property
		 *  and the columnWidthRatio property.
		 *  You typically do not set this property directly.
		 *  The ColumSet or ColumnChart object assigns this value.
		 *  The actual item width used is the smaller of the
		 *  columnWidthRatio and maxColumnWidth
		 *  properties.
		 */
		public function set maxColumnWidth(value:Number):void;
		/**
		 * Specifies how far to offset the center of the items
		 *  from the center of the available space, relative the category size.
		 *  The range of values is a percentage in the range
		 *  -100 to 100.
		 *  Set to 0 to center the items in the space.
		 *  Set to -50 to center the item
		 *  at the beginning of the available space.
		 *  You typically do not set this property directly.
		 *  The ColumSet or ColumnChart object assigns this value.
		 */
		public function set offset(value:Number):void;
	}
}
