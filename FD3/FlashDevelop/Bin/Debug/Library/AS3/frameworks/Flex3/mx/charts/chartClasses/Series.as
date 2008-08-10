/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import mx.charts.ChartItem;
	import flash.geom.Rectangle;
	public class Series extends ChartElement {
		/**
		 * Specifies a method that returns the value that should be used for
		 *  positioning the current chart item in the series.
		 *  If this property is set, the return value of the custom data function takes precedence over the
		 *  other related properties, such as xField and yField
		 *  for AreaSeries, BarSeries, BubbleSeries, ColumnSeries, LineSeries, and PlotSeries.
		 *  For BubbleSeries, the return value takes precedence over the radiusField property.
		 *  For PieSeries, the return value takes precedence over the field property.
		 */
		public function get dataFunction():Function;
		public function set dataFunction(value:Function):void;
		/**
		 * Array of chart items for which data tips are to be shown
		 *  non-interactively on the chart.
		 */
		public function get dataTipItems():Array;
		public function set dataTipItems(value:Array):void;
		/**
		 * The DataTransform object that the element is associated with.
		 *  A DataTransform object represents an association between a set of elements
		 *  and a set of axis objects used to transform those elements
		 *  from data space to screen coordinates and back.
		 *  A chart element uses its associated DataTransform object to calculate
		 *  how to render its data.
		 */
		public function set dataTransform(value:DataTransform):void;
		/**
		 * The name of the series, for display to the user.
		 *  This property is used to represent the series in user-visible labels,
		 *  such as data tips.
		 */
		public function get displayName():String;
		public function set displayName(value:String):void;
		/**
		 * true if the series filters its data
		 *  before displaying.
		 *  If a series renders data that contains missing values
		 *  (such as null, undefined, or NaN),
		 *  or renders values that are outside the range of the chart axes,
		 *  this property should be set to true (the default).
		 *  If you know that all of the data in the series is valid,
		 *  you can set this to false to improve performance.
		 */
		public function get filterData():Boolean;
		public function set filterData(value:Boolean):void;
		/**
		 * Determines whether data tips appear when users interact
		 *  with chart data on the screen.
		 *  Set to false to prevent the series
		 *  from showing data tips or generating hit data.
		 */
		public function get interactive():Boolean;
		public function set interactive(value:Boolean):void;
		/**
		 * Gets all the items that are there in the series after filtering.
		 */
		public function get items():Array;
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
		 * Stores the information necessary to render this series.
		 */
		protected function get renderData():Object;
		/**
		 * Specifies whether a series is selectable or not.
		 */
		public function get selectable():Boolean;
		public function set selectable(value:Boolean):void;
		/**
		 * Index of the selected item in the data provider of the series. If multiple items are selected,
		 *  then this property refers to the most recently selected item.
		 */
		public function get selectedIndex():int;
		public function set selectedIndex(value:int):void;
		/**
		 * An Array of indexes of the selected items in the data provider of the series.
		 */
		public function get selectedIndices():Array;
		public function set selectedIndices(value:Array):void;
		/**
		 * The chart item that is selected in the series. If multiple items are selected,
		 *  then this property refers to the most recently selected item.
		 */
		public function get selectedItem():ChartItem;
		public function set selectedItem(value:ChartItem):void;
		/**
		 * An Array of chart items that are selected in the series.
		 */
		public function get selectedItems():Array;
		public function set selectedItems(value:Array):void;
		/**
		 * A render data structure passed in by a running transtion.
		 *  When a series effect is set to play on a series, it first captures
		 *  the current state of the series by asking for its render data.
		 *  The transition modifies the render data to create the desired effect
		 *  and passes the structure back to the series for display.
		 *  If the transitionRenderData property is a value other than null,
		 *  a series uses its contents to update its display.
		 */
		public function get transitionRenderData():Object;
		public function set transitionRenderData(value:Object):void;
		/**
		 * Constructor.
		 */
		public function Series();
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
		public function beginInterpolation(sourceRenderData:Object, destRenderData:Object):Object;
		/**
		 * Caches the values stored in the measureName property
		 *  from the original dataProvider items in the chart item's
		 *  fieldName property.
		 *  If the measureName property is null
		 *  or the empty string, this method assumes the original data provider items
		 *  are raw values and caches them instead.
		 *
		 * @param measureName       <String> 
		 * @param cache             <Array> 
		 * @param fieldName         <String> 
		 */
		protected function cacheDefaultValues(measureName:String, cache:Array, fieldName:String):Boolean;
		/**
		 * Caches the values stored in the measureName property
		 *  from the original dataProvider items in the chart item's
		 *  fieldName property.
		 *  If the measureName property is null
		 *  or the empty string, this method stores the index of the items
		 *  in the fieldName property instead.
		 *
		 * @param measureName       <String> 
		 * @param cache             <Array> 
		 * @param fieldName         <String> 
		 */
		protected function cacheIndexValues(measureName:String, cache:Array, fieldName:String):Boolean;
		/**
		 * Caches the values stored in the measureName property
		 *  from the original dataProvider items in the chart item's
		 *  fieldName property.
		 *
		 * @param measureName       <String> 
		 * @param cache             <Array> 
		 * @param fieldName         <String> 
		 */
		protected function cacheNamedValues(measureName:String, cache:Array, fieldName:String):Boolean;
		/**
		 * @param styles            <Array> 
		 * @param firstAvailable    <uint> 
		 */
		public override function claimStyles(styles:Array, firstAvailable:uint):uint;
		/**
		 * Processes the properties set on the component.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 */
		protected override function commitProperties():void;
		/**
		 * Called by the SeriesInterpolate effect to end an interpolation effect.
		 *  The effect uses this method to complete the interpolation
		 *  and clean up any temporary state associated with the effect.
		 *
		 * @param interpolationData <Object> 
		 */
		public function endInterpolation(interpolationData:Object):void;
		/**
		 * Extracts the minimum value, maximum value, and, optionally,
		 *  the minimum interval from an Array of ChartItem objects.
		 *  Derived classes can call this method from their
		 *  implementations of the describeData() method to fill in the details
		 *  of the DataDescription structure.
		 *
		 * @param cache             <Array> 
		 * @param measureName       <String> 
		 * @param desc              <DataDescription> 
		 */
		protected function extractMinInterval(cache:Array, measureName:String, desc:DataDescription):void;
		/**
		 * Extracts the minimum value, maximum value, and, optionally,
		 *  the minimum interval from an Array of ChartItem objects.
		 *  Derived classes can call this method from their
		 *  implementations of the describeData() method to fill in the details
		 *  of the DataDescription structure.
		 *
		 * @param cache             <Array> 
		 * @param measureName       <String> 
		 * @param desc              <DataDescription> 
		 * @param calculateInterval <Boolean (default = false)> 
		 */
		protected function extractMinMax(cache:Array, measureName:String, desc:DataDescription, calculateInterval:Boolean = false):void;
		/**
		 * Retrieves the Axis instance for a particular dimension of the chart.
		 *  This is a low-level accessor.
		 *  You typically retrieve the Axis instance directly through a named property
		 *  (such as for a Cartesian-based series horizontalAxis, verticalAxis,
		 *  or radiusAxis).
		 *
		 * @param dimension         <String> 
		 */
		public function getAxis(dimension:String):IAxis;
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
		public function getElementBounds(renderData:Object):void;
		/**
		 * Gets all the items that are in a rectangular region for the series.
		 *  Call this function to determine what items are in
		 *  a particular rectangular region in that series.
		 *
		 * @param r                 <Rectangle> A Rectangle object that defines the region.
		 * @return                  <Array> An Array of ChartItem objects that are within the specified rectangular region.
		 */
		public function getItemsInRegion(r:Rectangle):Array;
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
		protected function getMissingInterpolationValues(sourceProps:Object, srcCache:Array, destProps:Object, destCache:Array, index:Number, customData:Object):void;
		/**
		 * Returns a copy of the data needed to represent the data of this series.
		 *  Effect classes call this method to capture the before
		 *  and after states of the series for animation.
		 *
		 * @param type              <String> Specifies whether the effect is requesting
		 *                            a description of the data being hidden, or the new data being shown.
		 */
		public function getRenderDataForTransition(type:String):Object;
		/**
		 * Helper method to implement the interpolation effect.
		 *  A custom series can call this method from its
		 *  beginInterpolation() method to initialize
		 *  a data structure to interpolate  an arbitrary set
		 *  of numeric properties over the life of the effect.
		 *  You can pass that data structure to the
		 *  applyInterpolation() utility method to actually modify
		 *  the values when the interpolate() method is called.
		 *
		 * @param srcCache          <Array> An Array of objects whose fields
		 *                            contain the beginning values for the interpolation.
		 * @param dstCache          <Array> An Array of objects whose fields
		 *                            contain the ending values for the interpolation.
		 * @param iProps            <Object> A hash table whose keys identify the names
		 *                            of the properties from the cache to be interpolated.
		 * @param cacheType         <Class (default = null)> The class to instantiate that holds the delta values
		 *                            computed for the interpolation.
		 *                            Typically this is null,
		 *                            in which case a generic Object is used.
		 * @param customData        <Object (default = null)> An object containing series-specific data.
		 *                            When the initialization process encounters a missing value,
		 *                            it calls the getMissingInterpolationValues()
		 *                            method of the series to fill in the missing value.
		 *                            This custom data is passed to that method,
		 *                            and can be used to pass through arbitrary parameters.
		 */
		protected function initializeInterpolationData(srcCache:Array, dstCache:Array, iProps:Object, cacheType:Class = null, customData:Object = null):Object;
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
		public function interpolate(interpolationValues:Array, interpolationData:Object):void;
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
		protected function invalidateData(invalid:Boolean = true):void;
		/**
		 * Informs the series that the filter of the data against the axes
		 *  has changed and must be recalculated.
		 *  Calling this method triggers calls to the updateFilter()
		 *  and updateTransform() methods on the next call
		 *  to the commitProperties() method.
		 *  If any data effects are assigned to any elements of the chart,
		 *  this method also triggers the show and hide effects.
		 *
		 * @param invalid           <Boolean (default = true)> 
		 */
		protected function invalidateFilter(invalid:Boolean = true):void;
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
		protected function invalidateMapping(invalid:Boolean = true):void;
		/**
		 * Informs the series that the transform of the data to screen coordinates
		 *  has changed and must be recalculated.
		 *  Calling this function triggers a call to the
		 *  updateTransform() method on the next call
		 *  to the commitProperties() method.
		 *
		 * @param invalid           <Boolean (default = true)> 
		 */
		protected function invalidateTransform(invalid:Boolean = true):void;
		/**
		 * Informs the series that a significant change has occured
		 *  in the display of data.
		 *  This triggers any ShowData and HideData effects.
		 */
		protected function invalidateTransitions():void;
		/**
		 * Updates the Legend items when the series display name changes
		 *  by dispatching a new LegendDataChanged event.
		 */
		protected function legendDataChanged():void;
		/**
		 * Sizes the object.
		 *  Unlike directly setting the width and height
		 *  properties, calling the setActualSize() method
		 *  does not set the explictWidth and
		 *  explicitHeight properties, so a future layout
		 *  calculation may result in the object returning to its previous size.
		 *  This method is used primarily by component developers implementing
		 *  the updateDisplayList() method, by Effects,
		 *  and by the LayoutManager.
		 *
		 * @param w                 <Number> Width of the object.
		 * @param h                 <Number> Height of the object.
		 */
		public override function setActualSize(w:Number, h:Number):void;
		/**
		 * Assigns an Axis instance to a particular dimension of the chart.
		 *  This is a low-level accessor.
		 *  You typically set the Axis instance directly through a named property
		 *  (such as for a Cartesian-based series horizontalAxis, verticalAxis,
		 *  or radiusAxis).
		 *
		 * @param dimension         <String> 
		 * @param value             <IAxis> 
		 */
		public function setAxis(dimension:String, value:IAxis):void;
		/**
		 * Removes any item from the provided cache whose field
		 *  property is NaN.
		 *  Derived classes can call this method from their implementation of the updateFilter()
		 *  method to remove any ChartItem objects that were filtered out by the axes.
		 *
		 * @param cache             <Array> 
		 * @param field             <String> 
		 */
		protected function stripNaNs(cache:Array, field:String):void;
		/**
		 * Calls the legendDataChanged() method.
		 */
		public override function stylesInitialized():void;
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
		protected function updateData():void;
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
		protected function updateFilter():void;
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
		protected function updateMapping():void;
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
		protected function updateTransform():void;
		/**
		 * Calls the updateData() and
		 *  updateMapping() methods of the series, if necessary.
		 *  This method is called automatically by the series
		 *  from the commitProperties() method, as necessary,
		 *  but a derived series might call it explicitly
		 *  if the generated values are needed at an explicit time.
		 *  Loading and mapping data against the axes is designed
		 *  to be acceptable by the axes at any time.
		 *  It is safe this method explicitly at any point.
		 */
		protected function validateData():void;
		/**
		 * Calls the updateFilter() and
		 *  updateTransform() methods of the series, if necessary.
		 *  This method is called automatically by the series
		 *  during the commitProperties() method, as necessary,
		 *  but a derived series might call it explicitly
		 *  if the generated values are needed at an explicit time.
		 *  Filtering and transforming of data relies on specific values
		 *  being calculated by the axes, which can in turn
		 *  depend on the data that is displayed in the chart.
		 *  Calling this function at the wrong time might result
		 *  in extra work being done, if those values are updated.
		 */
		protected function validateTransform():void;
	}
}
