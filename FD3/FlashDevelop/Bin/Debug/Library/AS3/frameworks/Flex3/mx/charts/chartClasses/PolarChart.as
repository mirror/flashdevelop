/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import flash.geom.Rectangle;
	import flash.geom.Point;
	public class PolarChart extends ChartBase {
		/**
		 * The axis object used to map data values to an angle
		 *  between 0 and 2 PI.
		 *  By default, this is a linear axis with the autoAdjust
		 *  property set to false.
		 *  So, data values are mapped uniformly around the chart.
		 */
		public function get angularAxis():IAxis;
		public function set angularAxis(value:IAxis):void;
		/**
		 * The area of the chart used to display data.
		 *  This rectangle excludes the area used for gutters, axis lines and labels, and padding.
		 */
		protected function get dataRegion():Rectangle;
		/**
		 * The axis object used to map data values to a radial distance
		 *  between the center and the outer edge of the chart.
		 *  By default, this is a linear axis with the autoAdjust
		 *  property set to false.
		 *  So, data values are  mapped uniformly from the inside
		 *  to the outside of the chart
		 */
		public function get radialAxis():IAxis;
		public function set radialAxis(value:IAxis):void;
		/**
		 * Constructor.
		 */
		public function PolarChart();
		/**
		 * Processes the properties set on the component.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 */
		protected override function commitProperties():void;
		/**
		 * Deprecated: Please Use IChartElement2.dataToLocal()
		 *
		 * @return                  <Point> Coordinates that are relative to the chart.
		 */
		public override function dataToLocal(... dataValues):Point;
		/**
		 */
		public override function dataToLocal(... dataValues):Point;
		/**
		 * Gets the first item in the chart, with respect to the axes.
		 *
		 * @param direction         <String> The direction in which the first item should be returned. Possible values
		 *                            are ChartBase.NAVIGATE_HORIZONTAL, ChartBase.NAVIGATE_VERTICAL, and
		 *                            ChartBase.NONE. Cartesian charts implement horizontal and vertical, and Polar charts
		 *                            implement none.
		 * @return                  <ChartItem> The corresponding ChartItem object.
		 */
		public override function getFirstItem(direction:String):ChartItem;
		/**
		 * Gets the last chart item in the chart, with respect to the axes.
		 *
		 * @param direction         <String> The direction in which the last item should be returned. Possible values
		 *                            are ChartBase.NAVIGATE_HORIZONTAL, ChartBase.NAVIGATE_VERTICAL, and
		 *                            ChartBase.NONE. Cartesian charts implement horizontal and vertical, and Polar charts
		 *                            implement none.
		 * @return                  <ChartItem> The corresponding ChartItem object.
		 */
		public override function getLastItem(direction:String):ChartItem;
		/**
		 * Gets the chart item next to the currently focused item in the chart,
		 *  with respect to the axes. If no chart items are currently selected,
		 *  then this method returns the first item in the first series.
		 *
		 * @param direction         <String> The direction in which the next item should be returned. Possible values
		 *                            are ChartBase.NAVIGATE_HORIZONTAL, ChartBase.NAVIGATE_VERTICAL, and
		 *                            ChartBase.NONE. Cartesian charts implement horizontal and vertical, and Polar charts
		 *                            implement none.
		 * @return                  <ChartItem> The corresponding ChartItem object.
		 */
		public override function getNextItem(direction:String):ChartItem;
		/**
		 * Gets the chart item that is before the currently focused item in the chart,
		 *  with respect to the axes. If no chart items are currently selected,
		 *  then this method returns the first item in the first series.
		 *
		 * @param direction         <String> The direction in which the previous item should be returned. Possible values
		 *                            are ChartBase.NAVIGATE_HORIZONTAL, ChartBase.NAVIGATE_VERTICAL, and
		 *                            ChartBase.NONE. Cartesian charts implement horizontal and vertical, and Polar charts
		 *                            implement none.
		 * @return                  <ChartItem> The corresponding ChartItem object.
		 */
		public override function getPreviousItem(direction:String):ChartItem;
		/**
		 * Deprecated: Please Use IChartElement2.localToData()
		 *
		 * @param pt                <Point> The Point object to convert.
		 * @return                  <Array> The tuple of data values.
		 */
		public override function localToData(pt:Point):Array;
		/**
		 * @param v                 <Point> 
		 */
		public override function localToData(v:Point):Array;
		/**
		 * Draws the object and/or sizes and positions its children.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void;
	}
}
