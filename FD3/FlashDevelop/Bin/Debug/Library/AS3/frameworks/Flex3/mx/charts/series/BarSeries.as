/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series {
	import mx.charts.chartClasses.Series;
	import mx.charts.chartClasses.IStackable2;
	import mx.charts.chartClasses.IBar;
	import mx.charts.chartClasses.IAxis;
	import mx.charts.chartClasses.StackedSeries;
	import flash.utils.Dictionary;
	import flash.display.DisplayObject;
	import mx.charts.chartClasses.InstanceCache;
	import mx.charts.chartClasses.IStackable;
	public class BarSeries extends Series implements IStackable2, IBar {
		/**
		 * Specifies how wide to render the bars relative to the category width.
		 *  A value of 1 uses the entire space, while a value of .6
		 *  uses 60% of the bar's available space.
		 *  You typically do not set this property directly.
		 *  The actual bar width used is the smaller of barWidthRatio and the maxbarWidth property
		 */
		public function get barWidthRatio():Number;
		public function set barWidthRatio(value:Number):void;
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
		 *  Subclasses can override and return a more specialized class if they need to store additional information in the items.
		 */
		protected function get itemType():Class;
		/**
		 * Name of a field in the data provider whose value appears as the label.
		 *  This property is ignored if the labelFunction property is specified.
		 */
		public function get labelField():String;
		public function set labelField(value:String):void;
		/**
		 * Specifies a callback function used to render each label
		 *  of the Series.
		 */
		public function get labelFunction():Function;
		public function set labelFunction(value:Function):void;
		/**
		 * Specifies the width of the bars, in pixels.
		 *  The actual bar width used is the smaller of this style and the barWidthRatio property.
		 *  Clustered bars divide this space proportionally among the bars in each cluster.
		 */
		public function get maxBarWidth():Number;
		public function set maxBarWidth(value:Number):void;
		/**
		 * Specifies the field of the data provider that determines the bottom of each bar.
		 *  If null, the columns are based at
		 *  the range minimum (or maximum, if the field value is negative).
		 */
		public function get minField():String;
		public function set minField(value:String):void;
		/**
		 * Specifies how far to offset the center of the bars from the center of the available space, relative the category width.
		 *  The range of values is a percentage in the range -100 to 100.
		 *  Set to 0 to center the bars in the space. Set to -50 to center the column at the beginning of the available space. You typically do not set this property directly.
		 */
		public function get offset():Number;
		public function set offset(value:Number):void;
		/**
		 * The subtype of ChartRenderData used by this series to store all data necessary to render.
		 *  Subclasses can override and return a more specialized class if they need to store additional information for rendering.
		 */
		protected function get renderDataType():Class;
		/**
		 * The StackedSeries associated with this BarSeries.
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
		 * Specifies the field of the data provider that determines the x-axis location of the top of each bar. If null,
		 *  the BarSeries assumes that the data provider is an Array of numbers, and uses the numbers as values.
		 */
		public function get xField():String;
		public function set xField(value:String):void;
		/**
		 * Specifies the field of the data provider that determines the y-axis location of the bottom of each bar in the chart.
		 *  If null, Flex arranges the bars in the order of the data in the data provider.
		 */
		public function get yField():String;
		public function set yField(value:String):void;
		/**
		 * Constructor.
		 */
		public function BarSeries();
		/**
		 * Customizes the item renderer instances that are used to represent the chart. This method is called automatically
		 *  whenever a new item renderer is needed while the chart is being rendered. You can override this method to add your own customization as necessary.
		 *
		 * @param instance          <DisplayObject> The new item renderer instance that is being created.
		 * @param cache             <InstanceCache> The InstanceCache that is being used to manage the item renderer instances.
		 */
		protected function applyItemRendererProperties(instance:DisplayObject, cache:InstanceCache):void;
		/**
		 * Processes the properties set on the component.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 */
		protected override function commitProperties():void;
		/**
		 */
		protected override function createChildren():void;
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
		 * @param stackedYValueDictionary<Dictionary> Contains the base values that the series should stack
		 *                            on top of. The keys in the dictionary are the x values, and the values are the y values.
		 * @param previousElement   <IStackable> The previous element in the stack. If, for example, the element
		 *                            is of the same type, you can use access to this property to avoid duplicate effort when
		 *                            rendering.
		 * @return                  <Number> The maximum value in the newly stacked series.
		 */
		public function stack(stackedYValueDictionary:Dictionary, previousElement:IStackable):Number;
		/**
		 * Stacks the series. Normally, a series implements the updateData() method
		 *  to load its data out of the data provider. But a stacking series performs special
		 *  operations because its values are not necessarily stored in its data provider.
		 *  Its values are whatever is stored in its data provider, summed with the values
		 *  that are loaded by the object it stacks on top of.
		 *
		 * @param stackedPosYValueDictionary<Dictionary> Contains the base values that the series should stack
		 *                            on top of. The keys in the dictionary are the y values, and the values are the positive
		 *                            x values.
		 * @param stackedNegYValueDictionary<Dictionary> Contains the base values that the series should stack
		 *                            on top of. The keys in the dictionary are the y values, and the values are the negative
		 *                            x values.
		 * @param previousElement   <IStackable2> The previous element in the stack. If, for example, the element
		 *                            is of the same type, you can use access to this property to avoid duplicate effort when
		 *                            rendering.
		 * @return                  <Object> An object representing the maximum and minimum values in the newly stacked series.
		 */
		public function stackAll(stackedPosYValueDictionary:Dictionary, stackedNegYValueDictionary:Dictionary, previousElement:IStackable2):Object;
	}
}
