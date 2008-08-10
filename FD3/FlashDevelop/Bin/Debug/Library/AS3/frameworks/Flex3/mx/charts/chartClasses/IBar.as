/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	public interface IBar {
		/**
		 * Specifies how wide to render the items relative to the category.
		 *  A value of 1 uses the entire space, while a value
		 *  of 0.6 uses 60% of the category's available space.
		 *  You typically do not set this property directly.
		 *  A governing BarSet or BarChart would implicitly assign this value.
		 *  The actual size used is the smaller of barWidthRatio
		 *  and the maxbarWidth property
		 */
		public function set barWidthRatio(value:Number):void;
		/**
		 * Specifies how wide to draw the items, in pixels.
		 *  The actual item width used is the smaller of this style
		 *  and the barWidthRatio property.
		 *  You typically do not set this property directly.
		 *  The BarSet or BarChart objects assign this value.
		 */
		public function set maxBarWidth(value:Number):void;
		/**
		 * Specifies how far to offset the center of the items
		 *  from the center of the available space, relative the category size.
		 *  The range of values is a percentage in the range
		 *  -100 to 100.
		 *  Set to 0 to center the items in the space.
		 *  Set to -50 to center the item
		 *  at the beginning of the available space.
		 *  You typically do not set this property directly.
		 *  The BarSet or BarChart objects assign this value.
		 */
		public function set offset(value:Number):void;
	}
}
