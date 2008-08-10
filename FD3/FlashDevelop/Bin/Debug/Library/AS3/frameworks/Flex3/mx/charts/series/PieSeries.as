/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series {
	import mx.charts.chartClasses.Series;
	import mx.charts.chartClasses.IAxis;
	import flash.geom.Point;
	public class PieSeries extends Series {
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
		 * A number from 0 to 1, specifying how far all wedges of the pie
		 *  series should be exploded from the center of the chart
		 *  as a percentage of the total radius.
		 */
		public function get explodeRadius():Number;
		public function set explodeRadius(value:Number):void;
		/**
		 * Specifies the field of the data provider that determines
		 *  the data for each wedge of the PieChart control.
		 */
		public function get field():String;
		public function set field(value:String):void;
		/**
		 * Specifies a method that returns the fill for the current chart item in the series.
		 *  If this property is set, the return value of the custom fill function takes precedence over the
		 *  fills style property.
		 *  But if it returns null, then fills will be prefered.
		 */
		public function get fillFunction():Function;
		public function set fillFunction(value:Function):void;
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
		 * Name of a field in the data provider whose value appears as label
		 *  Ignored if labelFunction is specified
		 */
		public function get labelField():String;
		public function set labelField(value:String):void;
		/**
		 * Specifies a callback function used to render each label
		 *  of the PieSeries.
		 */
		public function get labelFunction():Function;
		public function set labelFunction(value:Function):void;
		/**
		 * The maximum amount of the PieSeries's radius
		 *  that can be allocated to labels.
		 *  This value is only applicable when the series
		 *  is rendering callout labels.
		 */
		public var maxLabelRadius:Number = 0.6;
		/**
		 * Specifies the field of the data provider that determines
		 *  the name of each wedge of the PieChart control.
		 */
		public function get nameField():String;
		public function set nameField(value:String):void;
		/**
		 * The percentage of the total space available to the PieSeries
		 *  to use when rendering the contents of the series.
		 *  This value is managed by the containing chart,
		 *  and should not be assigned to directly.
		 */
		public function get outerRadius():Number;
		public function set outerRadius(value:Number):void;
		/**
		 * An Array of numbers from 0 to 1, specifying how far each wedge
		 *  of the pie series should be exploded from the center of the chart
		 *  as a percentage of the total radius.
		 */
		public function get perWedgeExplodeRadius():Array;
		public function set perWedgeExplodeRadius(value:Array):void;
		/**
		 * The subtype of ChartRenderData used by this series
		 *  to store all data necessary to render.
		 *  Subclasses can override and return a more specialized class
		 *  if they need to store additional information for rendering.
		 */
		protected function get renderDataType():Class;
		/**
		 * A number from 0 to 1, specifying how much of the total radius
		 *  of the pie series should be reserved to explode wedges at runtime.
		 *  When a pie wedge is exploded, the series must shrink
		 *  the total radius of the pie to make sure it doesn't exceed
		 *  the bounds of its containing chart.
		 *  Thus if a developer changes the explode value of a wedge at runtime,
		 *  it can effectively shrink all the wedges rather than
		 *  the desired effect of pulling out a single wedge.
		 *  To avoid this, set reserveExplodeRadius
		 *  to the maximum value you intend to explode any wedge at runtime.
		 */
		public function get reserveExplodeRadius():Number;
		public function set reserveExplodeRadius(value:Number):void;
		/**
		 * Specifies the starting angle for the first slice of the PieChart control.
		 *  The default value is 0,
		 *  which is horizontal on the right side of the PieChart control.
		 */
		public function get startAngle():Number;
		public function set startAngle(value:Number):void;
		/**
		 * Constructor.
		 */
		public function PieSeries();
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
		 * Create child objects of the component.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 */
		protected override function createChildren():void;
		/**
		 * Converts a tuple of data values to an x-y coordinate on screen.
		 *  Call this function to transform data on to the screen
		 *  using the same transform that the individual elements go through.
		 *  For example, to create a custom highlight for a data region of a chart,
		 *  you might use this function to determine the on-screen coordinates
		 *  of the range of interest.
		 *
		 * @return                  <Point> Coordinates that are relative to the chart.
		 */
		public override function dataToLocal(... dataValues):Point;
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
		 * Called by the SeriesInterpolate effect to advance an interpolation.
		 *  The effect calls this once per frame until the interpolation
		 *  is complete.
		 *  The series is responsible for using the parameters
		 *  to render the interpolated values.
		 *  By default, the series assumes that interpolationData
		 *  is a data structure returned by the
		 *  initializeInterpolationData() method, and passes it
		 *  through to the applyInterpolation() method.
		 *
		 * @param interpolationValues<Array> An Array of Numbers, each ranging
		 *                            from 0 to 1, where the nth number indicates the percentage
		 *                            of the way in which the nth value in the data series should be
		 *                            interpolated between the start and end values.
		 * @param interpolationData <Object> The data returned from the
		 *                            beginInterpolation() method.
		 */
		public override function interpolate(interpolationValues:Array, interpolationData:Object):void;
		/**
		 * Converts a coordinate on screen to a tuple of data values.
		 *  Call this function to determine what data values
		 *  a particular point on-screen represents.
		 *
		 * @param pt                <Point> The Point to convert.
		 * @return                  <Array> The tuple of data values.
		 */
		public override function localToData(pt:Point):Array;
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
