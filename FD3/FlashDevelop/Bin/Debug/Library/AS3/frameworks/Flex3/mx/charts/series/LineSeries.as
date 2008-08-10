/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series {
	import mx.charts.chartClasses.Series;
	import mx.charts.chartClasses.IAxis;
	import flash.display.DisplayObject;
	import mx.charts.chartClasses.InstanceCache;
	public class LineSeries extends Series {
		/**
		 * Specifies a method that returns the fill for the current chart item in the series.
		 *  If this property is set, the return value of the custom fill function takes precedence over the
		 *  fill and fills style properties.
		 *  But if it returns null, then fills and fill will be
		 *  prefered in that order.
		 */
		public function get fillFunction():Function;
		public function set fillFunction(value:Function):void;
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
		 * Specifies how to represent missing data.
		 */
		public function get interpolateValues():Boolean;
		public function set interpolateValues(value:Boolean):void;
		/**
		 * Gets all the items that are there in the series after filtering.
		 */
		public function get items():Array;
		/**
		 * The subtype of ChartItem used by this series
		 *  to represent individual items.
		 *  Subclasses can override and return a more specialized class
		 *  if they need to store additional information in the items.
		 */
		protected function get itemType():Class;
		/**
		 * The class used by this series to store all data
		 *  necessary to represent a line segment.
		 *  Subclasses can override and return a more specialized class
		 *  if they need to store additional information for rendering.
		 */
		protected function get lineSegmentType():Class;
		/**
		 * Specifies the radius, in pixels, of the chart elements
		 *  for the data points.
		 *  This property applies only if you specify an item renderer
		 *  using the itemRenderer property.
		 *  You can specify the itemRenderer in MXML or using styles.
		 */
		public function get radius():Number;
		public function set radius(value:Number):void;
		/**
		 * The subtype of ChartRenderData used by this series
		 *  to store all data necessary to render.
		 *  Subclasses can override and return a more specialized class
		 *  if they need to store additional information for rendering.
		 */
		protected function get renderDataType():Class;
		/**
		 * Requests the line datapoints be sorted from left to right
		 *  before rendering.
		 */
		public function get sortOnXField():Boolean;
		public function set sortOnXField(value:Boolean):void;
		/**
		 * Defines the labels, tick marks, and data position
		 *  for items on the y-axis.
		 *  Use either the LinearAxis class or the CategoryAxis class
		 *  to set the properties of the verticalAxis as a child tag in MXML
		 *  or create a LinearAxis or CategoryAxis object in ActionScript.
		 */
		public function get verticalAxis():IAxis;
		public function set verticalAxis(value:IAxis):void;
		/**
		 * Specifies the field of the data provider
		 *  that determines the x-axis location of each data point.
		 *  If null, the data points are rendered
		 *  in the order they appear in the data provider.
		 */
		public function get xField():String;
		public function set xField(value:String):void;
		/**
		 * Specifies the field of the data provider
		 *  that determines the y-axis location of each data point.
		 *  If null, the LineSeries assumes the data provider
		 *  is an Array of numbers, and uses the numbers as values.
		 */
		public function get yField():String;
		public function set yField(value:String):void;
		/**
		 * Constructor.
		 */
		public function LineSeries();
		/**
		 * Customizes the item renderer instances that are used to represent the chart. This method is called automatically
		 *  whenever a new item renderer is needed while the chart is being rendered. You can override this method to add your own customization as necessary.
		 *
		 * @param instance          <DisplayObject> The new item renderer instance that is being created.
		 * @param cache             <InstanceCache> The InstanceCache that is used to manage the item renderer instances.
		 */
		protected function applyItemRendererProperties(instance:DisplayObject, cache:InstanceCache):void;
		/**
		 * Processes the properties set on the component.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 */
		protected override function commitProperties():void;
	}
}
