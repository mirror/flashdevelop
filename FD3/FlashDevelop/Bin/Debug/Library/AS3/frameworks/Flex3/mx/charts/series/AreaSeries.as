/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series {
	import mx.charts.chartClasses.Series;
	import mx.charts.chartClasses.IStackable2;
	import mx.charts.chartClasses.IAxis;
	import mx.charts.chartClasses.StackedSeries;
	import flash.utils.Dictionary;
	import flash.display.DisplayObject;
	import mx.charts.chartClasses.InstanceCache;
	import mx.charts.chartClasses.IStackable;
	public class AreaSeries extends Series implements IStackable2 {
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
		 * Gets all the items that are there in the series after filtering.
		 */
		public function get items():Array;
		/**
		 * The subtype of ChartItem used by this series to represent individual items.
		 *  Subclasses can override and return a more specialized class if they need to store additional information in the items
		 */
		protected function get itemType():Class;
		/**
		 * Specifies the field of the dataProvider that determines the bottom boundary of the area.
		 *  If null, the area is based at the range minimum (or maximum, if the field value is negative).
		 */
		public function get minField():String;
		public function set minField(value:String):void;
		/**
		 * The subtype of ChartRenderData used by this series to store all data necessary to render.
		 *  Subclasses can override and return a more specialized class if they need to store additional information for rendering.
		 */
		protected function get renderDataType():Class;
		/**
		 * Requests the line datapoints be sorted from left to right
		 *  before rendering.
		 */
		public function get sortOnXField():Boolean;
		public function set sortOnXField(value:Boolean):void;
		/**
		 * The StackedSeries associated with this AreaSeries.
		 *  The stacker manages the series's stacking behavior.
		 */
		public function get stacker():StackedSeries;
		public function set stacker(value:StackedSeries):void;
		/**
		 * The stack totals for the series.
		 */
		public function set stackTotals(value:Dictionary):void;
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
		 * Specifies the field of the data provider that determines the position of the data
		 *  points on the horizontal axis. If null, the
		 *  data points are rendered in the order they appear in the data provider.
		 */
		public function get xField():String;
		public function set xField(value:String):void;
		/**
		 * Specifies the field of the data provider that determines the position of the data point on the vertical axis.
		 *  If null, the AreaSeries assumes the dataProvider
		 *  is an Array of numbers, and uses the numbers as values for the data points.
		 */
		public function get yField():String;
		public function set yField(value:String):void;
		/**
		 * Constructor.
		 */
		public function AreaSeries();
		/**
		 * Customizes the item renderer instances used to represent the chart. This method is called
		 *  automatically whenever a new item renderer is needed while the chart is being rendered.
		 *  You can override this method to add your own customization as necessary.
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
		/**
		 * Informs the series that the underlying data
		 *  in the data provider has changed.
		 *  This function triggers calls to the updateData(),
		 *  updateMapping(), updateFilter(),
		 *  and updateTransform() methods on the next call
		 *  to the commitProperties() method.
		 *  If any data effects are assigned to any elements of the chart,
		 *  this method also triggers the show and hide effects.
		 *
		 * @param invalid           <Boolean (default = true)> 
		 */
		protected override function invalidateData(invalid:Boolean = true):void;
		/**
		 * Informs the series that the mapping of the data into numeric values
		 *  has changed and must be recalculated.
		 *  Calling this function triggers calls to the updateMapping(),
		 *  updateFilter(), and updateTransform() methods
		 *  on the next call to the commitProperties() method.
		 *  If any data effects are assigned to any elements of the chart,
		 *  this method also triggers the show and hide effects.
		 *
		 * @param invalid           <Boolean (default = true)> 
		 */
		protected override function invalidateMapping(invalid:Boolean = true):void;
		/**
		 * Stacks the series. Normally, a series implements the updateData() method
		 *  to load its data out of the data provider. But a stacking series performs special
		 *  operations because its values are not necessarily stored in its data provider.
		 *  Its values are whatever is stored in its data provider, summed with the values
		 *  that are loaded by the object it stacks on top of.
		 *
		 * @param stackedXValueDictionary<Dictionary> Contains the base values that the series should stack
		 *                            on top of. The keys in the dictionary are the y values, and the values are the x values.
		 * @param previousElement   <IStackable> The previous element in the stack. If, for example, the element
		 *                            is of the same type, you can use access to this property to avoid duplicate effort when
		 *                            rendering.
		 * @return                  <Number> The maximum value in the newly stacked series.
		 */
		public function stack(stackedXValueDictionary:Dictionary, previousElement:IStackable):Number;
		/**
		 * Stacks the series. Normally, a series implements the updateData() method
		 *  to load its data out of the data provider. But a stacking series performs special
		 *  operations because its values are not necessarily stored in its data provider.
		 *  Its values are whatever is stored in its data provider, summed with the values
		 *  that are loaded by the object it stacks on top of.
		 *
		 * @param stackedPosXValueDictionary<Dictionary> Contains the base values that the series should stack
		 *                            on top of. The keys in the dictionary are the x values, and the values are the positive
		 *                            x values.
		 * @param stackedNegXValueDictionary<Dictionary> Contains the base values that the series should stack
		 *                            on top of. The keys in the dictionary are the x values, and the values are the negative
		 *                            y values.
		 * @param previousElement   <IStackable2> The previous element in the stack. If, for example, the element
		 *                            is of the same type, you can use access to this property to avoid duplicate effort when
		 *                            rendering.
		 * @return                  <Object> An object representing the maximum and minimum values in the newly stacked series.
		 */
		public function stackAll(stackedPosXValueDictionary:Dictionary, stackedNegXValueDictionary:Dictionary, previousElement:IStackable2):Object;
	}
}
