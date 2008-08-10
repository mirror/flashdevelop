/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series {
	import mx.charts.chartClasses.StackedSeries;
	import mx.charts.chartClasses.IColumn;
	import mx.charts.chartClasses.IChartElement;
	import mx.charts.HitData;
	public class ColumnSet extends StackedSeries implements IColumn {
		/**
		 * Specifies the width of columns relative to the category width. A value of 1 uses the entire space, while a value of .6
		 *  uses 60% of the column's available space.
		 *  You typically do not set this property directly.
		 *  The actual column width used is the smaller of columnWidthRatio and the maxColumnWidth property
		 */
		public function get columnWidthRatio():Number;
		public function set columnWidthRatio(value:Number):void;
		/**
		 * Specifies the width of the columns, in pixels. The actual column width used is the smaller of this style and the columnWidthRatio property.
		 *  Clustered columns divide this space proportionally among the columns in each cluster.
		 */
		public function get maxColumnWidth():Number;
		public function set maxColumnWidth(value:Number):void;
		/**
		 * Specifies how far to offset the center of the columns from the center of the available space, relative to the category width.
		 *  At the value of default 0, the columns are centered on the space.
		 *  Set to -50 to center the column at the beginning of the available space.
		 *  You typically do not set this property directly. The ColumnChart control manages this value based on
		 *  its columnWidthRatio property.
		 */
		public function get offset():Number;
		public function set offset(value:Number):void;
		/**
		 * Constructor.
		 */
		public function ColumnSet();
		/**
		 * Processes the Array of sub-series for display, when necessary.
		 *  This method ensures that all sub-series are added as children of this
		 *  stacking set, and applies any per-series customization that is necessary
		 *  (for example, assigning inherited data providers or clustering properties).
		 */
		protected override function buildSubSeries():void;
		/**
		 * Applies any customization to a sub-series
		 *  when building the stacking behavior.
		 *  By default, this method assigns the inherited data providers
		 *  to the sub-series.
		 *  Derived classes can override this method
		 *  to apply further customization.
		 *
		 * @param g                 <IChartElement> 
		 * @param i                 <uint> 
		 */
		protected override function customizeSeries(g:IChartElement, i:uint):void;
		/**
		 * Called by the governing DataTransform to obtain a description
		 *  of the data represented by this IChartElement.
		 *  Implementors fill out and return an Array of
		 *  mx.charts.chartClasses.DataDescription objects
		 *  to guarantee that their data is correctly accounted for
		 *  by any axes that are autogenerating values
		 *  from the displayed data (such as minimum, maximum,
		 *  interval, and unitSize).
		 *  Most element types return an Array
		 *  containing a single DataDescription.
		 *  Aggregate elements, such as BarSet and ColumnSet,
		 *  might return multiple DataDescription instances
		 *  that describe the data displayed by their subelements.
		 *  When called, the implementor describes the data
		 *  along the axis indicated by the dimension argument.
		 *  This function might be called for each axis
		 *  supported by the containing chart.
		 *
		 * @param dimension         <String> Determines the axis to get data descriptions of.
		 * @param requiredFields    <uint> A bitfield that indicates which values
		 *                            of the DataDescription object the particular axis cares about.
		 *                            Implementors can optimize by only calculating the necessary fields.
		 * @return                  <Array> An Array containing the DataDescription instances that describe
		 *                            the data that is displayed.
		 */
		public override function describeData(dimension:String, requiredFields:uint):Array;
		/**
		 * Provides custom text for DataTips.
		 *  Stacking sets override the DataTip text of their contained sub-series
		 *  to display additional information related to the stacking behavior.
		 *  Derived classes must override this method to define custom DataTip text.
		 *
		 * @param hitData           <HitData> 
		 */
		protected override function formatDataTip(hitData:HitData):String;
	}
}
