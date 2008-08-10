/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series {
	import mx.charts.chartClasses.Series;
	import mx.charts.chartClasses.IAxis;
	import flash.display.DisplayObject;
	import mx.charts.chartClasses.InstanceCache;
	public class BubbleSeries extends Series {
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
		 * An Array of LegendData instances that describe the items
		 *  that should show up in a legend representing this series.
		 *  Derived series classes override this getter and return legend data that is
		 *  specific to their styles and data representation method.
		 *  Although most series types return only a single LegendData instance,
		 *  some series types, such as PieSeries and  StackedSeries,
		 *  return multiple instances representing individual items
		 *  in the Array, or multiple ways of rendering data.
		 */
		public function get legendData():Array;
		/**
		 * The radius of the largest item renderered in this series. When you use a BubbleSeries object in a BubbleChart,
		 *  the chart automatically assigns its maxRadius style value to this property
		 *  on all series in the chart. When you use BubbleSeries objects in CartesianChart controls, you manage this property manually.
		 */
		public var maxRadius:Number = 50;
		/**
		 * The radius of the smallest item renderered in this series. When you use a BubbleSeries object in a BubbleChart, the chart automatically assigns its minRadius style value to this property
		 *  on all series in the chart. When you use BubbleSeries objects in CartesianChart controls, you manage this property manually.
		 */
		public var minRadius:Number = 0;
		/**
		 * The axis the bubble radius is mapped against.
		 *  Bubble charts treat the size of the individual bubbles
		 *  as a third dimension of data which is transformed
		 *  in a similar manner to how x and y position is transformed.
		 *  By default, the radiusAxis is a LinearAxis
		 *  with the autoAdjust property set to false.
		 */
		public function get radiusAxis():IAxis;
		public function set radiusAxis(value:IAxis):void;
		/**
		 * Specifies the field of the data provider that determines the radius of each symbol, relative to the other
		 *  data points in the chart.
		 */
		public function get radiusField():String;
		public function set radiusField(value:String):void;
		/**
		 * Stores the information necessary to render this series.
		 */
		protected function get renderData():Object;
		/**
		 * The subtype of ChartRenderData used by this series to store all data necessary to render.
		 *  Subclasses can override and return a more specialized class if they need to store additional information for rendering.
		 */
		protected function get renderDataType():Class;
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
		 * Specifies the field of the data provider that determines the x-axis location of
		 *  each data point. If null, Flex renders the
		 *  data points in the order that they appear in the data provider.
		 */
		public function get xField():String;
		public function set xField(value:String):void;
		/**
		 * Specifies the field of the data provider that determines the y-axis location of each data point.
		 *  If null, the BubbleSeries assumes that the data provider is an Array of numbers,
		 *  and uses the numbers as values for the data points.
		 */
		public function get yField():String;
		public function set yField(value:String):void;
		/**
		 * Constructor.
		 */
		public function BubbleSeries();
		/**
		 * Applies style properties to the specified DisplayObject. This method is the
		 *  callback that the InstanceCache calls when it creates a new renderer.
		 *
		 * @param instance          <DisplayObject> The instance being created.
		 * @param cache             <InstanceCache> A reference to the instance cache itself.
		 */
		protected function applyItemRendererProperties(instance:DisplayObject, cache:InstanceCache):void;
		/**
		 * Called by the SeriesInterpolate effect to initiate an interpolation effect.
		 *  The effect passes in the source and destination data
		 *  for the series to interpolate between.
		 *  The effect passes the return value of this method
		 *  repeatedly to the interpolate() method of the series
		 *  to advance the animation for the duration of the effect.
		 *  The series calculates the data it needs to
		 *  perform the interpolation and returns it in this method.
		 *
		 * @param sourceRenderData  <Object> The source data for the series to interpolate between.
		 * @param destRenderData    <Object> The destination data for the series to interpolate between.
		 * @return                  <Object> The data the series needs to perform the interpolation.
		 */
		public override function beginInterpolation(sourceRenderData:Object, destRenderData:Object):Object;
		/**
		 * Processes the properties set on the component.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 */
		protected override function commitProperties():void;
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
		 * Finds the closest data point represented by the element
		 *  under the given coordinates.
		 *
		 * @param x                 <Number> The X coordinate.
		 * @param y                 <Number> The Y coordinate.
		 * @param sensitivity2      <Number> How close, in pixels, the pointer must be
		 *                            to the exact coordinates to be considered "under".
		 *                            This property is similar to the value of the mouseSensitivity
		 *                            property of the chart control.
		 */
		public override function findDataPoints(x:Number, y:Number, sensitivity2:Number):Array;
		/**
		 * Fills in the elementBounds, bounds,
		 *  and visibleBounds properties of a renderData
		 *  structure that is generated by this series.
		 *  Effect classes call this method to fill in these fields
		 *  for use in implementing various effect types.
		 *  Derived classes should implement this method
		 *  to generate the bounds of the items of the series only when requested.
		 *
		 * @param renderData        <Object> 
		 */
		public override function getElementBounds(renderData:Object):void;
		/**
		 * Fills in missing values in an interpolation structure.
		 *  When a series calls the initializeInterpolationData() method,
		 *  it passes in Arrays of source and destination values
		 *  for the interpolation.
		 *  If either of those two Arrays is incomplete, the series must
		 *  provide "appropriate" placeholder values for the interpolation.
		 *  How those placeholder values are determined
		 *  is specific to the series type.
		 *  Series extenders should override this method
		 *  to provide those placeholder values.
		 *
		 * @param sourceProps       <Object> An object containing the source values
		 *                            being interpolated for a particular item.
		 *                            When this method exits, all properties in this object
		 *                            should have values other than NaN.
		 * @param srcCache          <Array> The Array of source chart items that are being interpolated.
		 * @param destProps         <Object> An object containing the destination values
		 *                            that are being interpolated for a particular item.
		 *                            When this method exits, all properties in this Object
		 *                            should have values other than NaN.
		 * @param destCache         <Array> The Array of destination chart items that are being interpolated.
		 * @param index             <Number> The index of the item that is being populated in the cache.
		 * @param customData        <Object> The data that was passed by the series
		 *                            into the initializeInterpolationData() method.
		 */
		protected override function getMissingInterpolationValues(sourceProps:Object, srcCache:Array, destProps:Object, destCache:Array, index:Number, customData:Object):void;
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
		 * Called when the underlying data that the series represents
		 *  has changed and needs to be reloaded from the data provider.
		 *  If you implement custom series types, you should override this method
		 *  and load all data necessary to render the series
		 *  out of the backing data provider.
		 *  You must also be sure to call the super.updateData() method
		 *  in your subclass.
		 *  You do not generally call this method directly.
		 *  Instead, to guarantee that your data has been updated
		 *  at a given point, call the validateData() method
		 *  of the Series class.
		 */
		protected override function updateData():void;
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
		/**
		 * Called when the underlying data the series represents
		 *  needs to be filtered against the ranges represented by the axes
		 *  of the associated data transform.
		 *  This can happen either because the underlying data has changed
		 *  or because the range of the associated axes has changed.
		 *  If you implement a custom series type, you should override this method
		 *  and filter out any outlying data using the filterCache()
		 *  method of the axes managed by its associated data transform.
		 *  The filterCache() method converts any values
		 *  that are out of range to NaN.
		 *  You must be sure to call the super.updateFilter() method
		 *  in your subclass.
		 *  You should not generally call this method directly.
		 *  Instead, if you need to guarantee that your data has been filtered
		 *  at a given point, call the validateTransform() method
		 *  of the Series class.
		 *  You can generally assume that your updateData()
		 *  and updateMapping() methods have been called
		 *  prior to this method, if necessary.
		 */
		protected override function updateFilter():void;
		/**
		 * Called when the underlying data the series represents
		 *  needs to be mapped to numeric representations.
		 *  This can happen either because the underlying data has changed
		 *  or because the axes used to render the series have changed
		 *  in some relevant way.
		 *  If you implement a custom series, you should override this method
		 *  and convert the data represented into numeric values by
		 *  using the mapCache() method of the axes
		 *  that are managed by its associated data transform.
		 *  You must also be sure to call the super.updateMapping() method
		 *  in your subclass.
		 *  You should not generally call this method directly.
		 *  Instead, to guarantee that your data has been mapped
		 *  at a given point, call the validateData() method
		 *  of the Series class.
		 *  You can generally assume that your updateData() method
		 *  has been called prior to this method, if necessary.
		 */
		protected override function updateMapping():void;
		/**
		 * Called when the underlying data the series represents
		 *  needs to be transformed from data to screen values
		 *  by the axes of the associated data transform.
		 *  This can happen either because the underlying data has changed,
		 *  because the range of the associated axes has changed,
		 *  or because the size of the area on screen has changed.
		 *  If you implement a custom series type, you should override this method
		 *  and transform the data using the transformCache() method
		 *  of the associated data transform.
		 *  You must be sure to call the super.updateTransform() method
		 *  in your subclass.
		 *  You should not generally call this method directly.
		 *  Instead, if you need to guarantee that your data has been filtered
		 *  at a given point, call the valiateTransform() method
		 *  of the Series class.
		 *  You can generally assume that your updateData(),
		 *  updateMapping(), and updateFilter() methods
		 *  have been called prior to this method, if necessary.
		 */
		protected override function updateTransform():void;
		/**
		 * The type of radius axis.
		 */
		public static const RADIUS_AXIS:String = "bubbleRadius";
	}
}
