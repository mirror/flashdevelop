/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import flash.geom.Rectangle;
	import flash.geom.Point;
	public class CartesianChart extends ChartBase {
		/**
		 * The current computed size of the gutters of the CartesianChart.
		 *  The gutters represent the area between the padding
		 *  and the data area of the chart, where the titles and axes render.
		 *  By default, the gutters are computed dynamically.
		 *  You can set explicit values through the gutter styles.
		 *  The gutters are computed to match any changes to the chart
		 *  when it is validated by the LayoutManager.
		 */
		public function get computedGutters():Rectangle;
		/**
		 * The area of the chart used to display data.
		 *  This rectangle excludes the area used for gutters, axis lines and labels, and padding.
		 */
		protected function get dataRegion():Rectangle;
		/**
		 * Defines the labels, tick marks, and data position
		 *  for items on the x-axis.
		 *  Use either the LinearAxis class or the CategoryAxis class
		 *  to set the properties of the horizontalAxis as a child tag in MXML
		 *  or create a LinearAxis or CategoryAxis object in ActionScript.
		 */
		public function get horizontalAxis():IAxis;
		public function set horizontalAxis(value:IAxis):void;
		/**
		 * Determines the height limit of the horiztonal axis.
		 *  The limit is the width of the axis times this ratio.
		 */
		public var horizontalAxisRatio:Number = 0.33;
		/**
		 * Deprecated: Please Use CartesianChart.horizontalAxisRenderers
		 */
		public function get horizontalAxisRenderer():IAxisRenderer;
		public function set horizontalAxisRenderer(value:IAxisRenderer):void;
		/**
		 * Specifies how data appears along the x-axis of a chart.
		 *  Use the AxisRenderer class to define the properties
		 *  for horizontalAxisRenderer as a child tag in MXML
		 *  or create an AxisRenderer object in ActionScript.
		 */
		public function get horizontalAxisRenderers():Array;
		public function set horizontalAxisRenderers(value:Array):void;
		/**
		 * Deprecated: Please Use CartesianChart.dataProvider
		 */
		public function get secondDataProvider():Object;
		public function set secondDataProvider(value:Object):void;
		/**
		 * Deprecated: Please Use horizontalAxis in individual series
		 */
		public function get secondHorizontalAxis():IAxis;
		public function set secondHorizontalAxis(value:IAxis):void;
		/**
		 * Deprecated: Please Use CartesianChart.horizontalAxisRenderers
		 */
		public function get secondHorizontalAxisRenderer():IAxisRenderer;
		public function set secondHorizontalAxisRenderer(value:IAxisRenderer):void;
		/**
		 * Deprecated: Please Use CartesianChart.series
		 */
		public function get secondSeries():Array;
		public function set secondSeries(value:Array):void;
		/**
		 * Deprecated: Please Use verticalAxis in individual series
		 */
		public function get secondVerticalAxis():IAxis;
		public function set secondVerticalAxis(value:IAxis):void;
		/**
		 * Deprecated: Please Use CartesianChart.verticalAxisRenderers
		 */
		public function get secondVerticalAxisRenderer():IAxisRenderer;
		public function set secondVerticalAxisRenderer(value:IAxisRenderer):void;
		/**
		 */
		public function get selectedChartItems():Array;
		/**
		 * Defines the labels, tick marks, and data position
		 *  for items on the y-axis.
		 *  Use either the LinearAxis class or the CategoryAxis class
		 *  to set the properties of the horizontal axis as a child tag in MXML
		 *  or create a LinearAxis or CategoryAxis object in ActionScript.
		 */
		public function get verticalAxis():IAxis;
		public function set verticalAxis(value:IAxis):void;
		/**
		 * Determines the width limit of the vertical axis.
		 *  The limit is the width of the axis times this ratio.
		 */
		public var verticalAxisRatio:Number = 0.33;
		/**
		 * Deprecated: Please Use CartesianChart.verticalAxisRenderers
		 */
		public function get verticalAxisRenderer():IAxisRenderer;
		public function set verticalAxisRenderer(value:IAxisRenderer):void;
		/**
		 * Specifies how data appears along the y-axis of a chart.
		 *  Use the AxisRenderer class to set the properties
		 *  for verticalAxisRenderer as a child tag in MXML
		 *  or create an AxisRenderer object in ActionScript.
		 */
		public function get verticalAxisRenderers():Array;
		public function set verticalAxisRenderers(value:Array):void;
		/**
		 * Constructor.
		 */
		public function CartesianChart();
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
		 * Deprecated: Please Use series.getAxis()
		 *
		 * @param dimension         <String> 
		 */
		public function getSecondAxis(dimension:String):IAxis;
		/**
		 * Initializes the chart for displaying a second series.
		 *  This function is called automatically whenever any of the secondary
		 *  properties, such as secondSeries or
		 *  secondHorizontalAxis, are set.
		 *  Specific chart subtypes override this method
		 *  to initialize default secondary values.
		 *  Column charts, for example, initialize a separate secondary vertical
		 *  axis, but leave the primary and secondary horizontal axes linked.
		 */
		protected function initSecondaryMode():void;
		/**
		 * Deprecated: Please Use IChartElement2.localToData()
		 *
		 * @param pt                <Point> The Point object to convert.
		 * @return                  <Array> The tuple of data values.
		 */
		public override function localToData(pt:Point):Array;
		/**
		 */
		protected override function measure():void;
		/**
		 * Deprecated: Please Use series.getAxis()
		 *
		 * @param dimension         <String> 
		 * @param value             <IAxis> 
		 */
		public function setSecondAxis(dimension:String, value:IAxis):void;
		/**
		 * Detects changes to style properties. When any style property is set,
		 *  Flex calls the styleChanged() method,
		 *  passing to it the name of the style being set.
		 *
		 * @param styleProp         <String> The name of the style property, or null if all styles for this
		 *                            component have changed.
		 */
		public override function styleChanged(styleProp:String):void;
		/**
		 * private
		 *
		 * @param unscaledWidth     <Number> 
		 * @param unscaledHeight    <Number> 
		 */
		protected function updateAxisLayout(unscaledWidth:Number, unscaledHeight:Number):void;
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
