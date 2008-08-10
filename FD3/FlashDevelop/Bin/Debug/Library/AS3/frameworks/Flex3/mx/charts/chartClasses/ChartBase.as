/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import mx.core.UIComponent;
	import mx.managers.IFocusManagerComponent;
	import flash.geom.Rectangle;
	import mx.core.IUIComponent;
	import mx.charts.ChartItem;
	import mx.events.DragEvent;
	import flash.geom.Point;
	public class ChartBase extends UIComponent implements IFocusManagerComponent {
		/**
		 * The set of all chart elements displayed in the chart.
		 *  This set includes series, second series, background elements,
		 *  and annotation elements.
		 */
		protected var allElements:Array;
		/**
		 * Sets an array of ChartElement objects that appears on top
		 *  of any data series rendered by the chart.
		 *  Each item in the array must extend the mx.charts.DualStyleObject
		 *  class and implement the IChartElement2 interface.
		 */
		public function get annotationElements():Array;
		public function set annotationElements(value:Array):void;
		/**
		 * Sets an array of background ChartElement objects that appear below
		 *  any data series rendered by the chart.
		 *  Each item in the Array must extend the mx.charts.DualStyleObject
		 *  class and implement the IChartElement2 interface.
		 */
		public function get backgroundElements():Array;
		public function set backgroundElements(value:Array):void;
		/**
		 * The current transition state of the chart.
		 *  Use this property to determine whether the chart
		 *  is currently transitioning out its old data,
		 *  transitioning in its new data,
		 *  or has completed all transitions and is showing its current data set.
		 *  See the mx.charts.chartClasses.ChartState enumeration
		 *  for possible values.
		 */
		public function get chartState():uint;
		/**
		 * Determines whether Flex clips the chart to the area bounded by the axes.
		 *  Set to false to clip the chart.
		 *  Set to true to avoid clipping when the data is rendered.
		 */
		public function get clipContent():Boolean;
		public function set clipContent(value:Boolean):void;
		/**
		 * Specifies the data provider for the chart.
		 *  Data series rendered by the chart are assigned this data provider.
		 *  To render disparate data series in the same chart,
		 *  use the dataProvider property on the individual series.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * The area of the chart used to display data.
		 *  This rectangle excludes the area used for gutters, axis lines and labels, and padding.
		 */
		protected function get dataRegion():Rectangle;
		/**
		 * Specifies a callback method used to generate data tips from values.
		 */
		public var dataTipFunction:Function;
		/**
		 * The index of the child that is responsible for rendering data tips.
		 *  Derived classes that add visual elements to the chart
		 *  should add them below this layer.
		 */
		protected function get dataTipLayerIndex():int;
		/**
		 * Specifies how Flex displays DataTip controls for the chart.
		 *  DataTip controls are similar to ToolTip controls, except that they display
		 *  an appropriate value that represents the nearest chart data point
		 *  under the mouse pointer.
		 */
		public function get dataTipMode():String;
		public function set dataTipMode(value:String):void;
		/**
		 * A short description of the data in the chart.
		 *  When accessibility is enabled, screen readers use this property to describe the chart.
		 */
		public function get description():String;
		public function set description(value:String):void;
		/**
		 * Specifies whether you can drag items out of
		 *  this chart and drop them on other controls.
		 *  If true, dragging is enabled for the chart.
		 *  If the dropEnabled property is also true,
		 *  you can drag items and drop them in the chart
		 *  to reorder the items.
		 */
		public function get dragEnabled():Boolean;
		public function set dragEnabled(value:Boolean):void;
		/**
		 * Gets an instance of a class that displays the visuals
		 *  during a drag-and-drop operation.
		 */
		protected function get dragImage():IUIComponent;
		/**
		 * Indicates which display cursor to show as drag feedback.
		 *  If true, and the dragEnabled property
		 *  is true and the Control key is not held down,
		 *  moveCursor is shown as feedback.
		 *  If the Control key is held down, copyCursor is shown.
		 *  If false and the dragEnabled property
		 *  is true, then copyCursor is shown
		 *  whether the Control key is held down or not.
		 */
		public function get dragMoveEnabled():Boolean;
		public function set dragMoveEnabled(value:Boolean):void;
		/**
		 * A flag that specifies whether dragged items can be dropped onto the
		 *  chart.
		 */
		public function get dropEnabled():Boolean;
		public function set dropEnabled(value:Boolean):void;
		/**
		 * The set of display objects that represent the labels
		 *  for the chart elements.
		 *  Some series, annotation, and background types include overlays
		 *  such elements and callouts.
		 *  Elements can pass a display object to the chart that contains
		 *  the overlays to be placed on top of all other chart elememnts.
		 *  Chart implementors can access these overlay objects
		 *  in the labelElements array.
		 */
		protected var labelElements:Array;
		/**
		 * An array of Legend items.
		 */
		public function get legendData():Array;
		/**
		 * Specifies the distance, in pixels, that Flex considers a data point
		 *  to be under the mouse pointer when the pointer moves around a chart.
		 *  Flex considers any data point less than mouseSensitivity
		 *  pixels away to be under the mouse pointer.
		 *  This value is also used by the findDataPoints method.
		 */
		public var mouseSensitivity:Number = 5;
		/**
		 * Specifies the selected ChartItem in the chart. If multiple items are selected,
		 *  this property specifies the most recently selected item.
		 */
		public function get selectedChartItem():ChartItem;
		/**
		 * Specifies an array of all the selected ChartItem objects in the chart.
		 */
		public function get selectedChartItems():Array;
		/**
		 * Specifies whether or not ChartItem objects can be selected. Possible
		 *  values are none, single, or multiple.
		 *  Set to none to prevent chart items from being selected.
		 *  Set to single to allow only one item to be selected at a time.
		 *  Set to multiple to allow one or more chart items to be selected at a time.
		 */
		public function get selectionMode():String;
		public function set selectionMode(value:String):void;
		/**
		 * An array of Series objects that define the chart data.
		 *  Each chart defines the type of Series objects
		 *  that you use to populate this array.
		 *  For example, a ColumnChart control expects ColumnSeries objects
		 *  as part of this array.
		 *  Some charts accept any object of type IChartElement2
		 *  as part of the array, but in general each chart
		 *  expects a specific type.
		 */
		public function get series():Array;
		public function set series(value:Array):void;
		/**
		 * An array of filters that are applied to all series in the chart.
		 *  Assign an array of bitmap filters to this property to apply them to all the series at once.
		 *  Set the seriesFilter property to an empty array to clear the default
		 *  filters on the chart's series.
		 *  Assigning filters to the seriesFilters property, which applies to all
		 *  series, is more efficient than assigning them to individual series.
		 */
		public function get seriesFilters():Array;
		public function set seriesFilters(value:Array):void;
		/**
		 * Specifies whether Flex shows all DataTip controls for the chart.
		 *  DataTip controls are similar to tool tips,
		 *  except that they display an appropriate value
		 *  representing the chart data point.
		 */
		public function get showAllDataTips():Boolean;
		public function set showAllDataTips(value:Boolean):void;
		/**
		 * Specifies whether Flex shows DataTip controls for the chart.
		 *  DataTip controls are similar to tool tips,
		 *  except that they display an appropriate value
		 *  that represents the nearest chart data point under the mouse pointer.
		 */
		public function get showDataTips():Boolean;
		public function set showDataTips(value:Boolean):void;
		/**
		 * Deprecated: Please Use IChartElement2.dataTransform
		 */
		protected var transforms:Array;
		/**
		 * Constructor.
		 */
		public function ChartBase();
		/**
		 * Adds the selected items to the DragSource object as part of a
		 *  drag and drop operation.
		 *  You can override this method to add other data to the drag source.
		 *
		 * @param ds                <Object> The DragSource object to which the data is added.
		 */
		protected function addDragData(ds:Object):void;
		/**
		 * Preprocesses the series and transform for display. You typically do not call
		 *  this method directly. Instead, this method is called automatically during the
		 *  chart control's commitProperties() cycle when the series has
		 *  been invalidated by a call to the invalidateSeries() method.
		 *
		 * @param seriesSet         <Array> An array of series to preprocess.
		 * @param transform         <DataTransform> The transform used by the series.
		 * @return                  <Array> An array of series with the series set applied.
		 */
		protected function applySeriesSet(seriesSet:Array, transform:DataTransform):Array;
		/**
		 * Deselects all selected chart items in the chart control. Sets the currentState property of all chart items in the
		 *  chart to none.
		 */
		public function clearSelection():void;
		/**
		 * Applies per-series customization and formatting to the series of the chart.
		 *  This method is called once for each series when the series
		 *  has been changed by a call to the invalidateSeries() method.
		 *
		 * @param seriesGlyph       <Series> The series to customize.
		 * @param i                 <uint> The series' index in the series array.
		 */
		protected function customizeSeries(seriesGlyph:Series, i:uint):void;
		/**
		 * Deprecated: Please Use IChartElement2.dataToLocal()
		 *
		 * @return                  <Point> Coordinates that are relative to the chart.
		 */
		public function dataToLocal(... dataValues):Point;
		/**
		 */
		public function dataToLocal(... dataValues):Point;
		/**
		 * Handles events of type DragEvent.DRAG_COMPLETE. This method
		 *  removes the item from the data provider.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected function dragCompleteHandler(event:DragEvent):void;
		/**
		 * Handles events of type DragEvent.DRAG_DROP. This method hides
		 *  the UI feeback by calling the hideDropFeedback() method.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected function dragDropHandler(event:DragEvent):void;
		/**
		 * Handles events of type DragEvent.DRAG_ENTER. This method
		 *  determines if the DragSource object contains valid elements and uses
		 *  the showDropFeedback() method to set up the UI feedback.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected function dragEnterHandler(event:DragEvent):void;
		/**
		 * Handles events of type DragEvent.DRAG_EXIT. This method hides
		 *  the UI feeback by calling the hideDropFeedback() method.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected function dragExitHandler(event:DragEvent):void;
		/**
		 * Handles events of type DragEvent.DRAG_OVER. This method
		 *  determines whether the DragSource object contains valid elements and uses
		 *  the showDropFeedback() method to set up the UI feeback.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected function dragOverHandler(event:DragEvent):void;
		/**
		 * The default handler for the dragStart event.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected function dragStartHandler(event:DragEvent):void;
		/**
		 * Returns an array of HitData objects that describe
		 *  the nearest data point to the coordinates passed to the method.
		 *  The x and y arguments should be values
		 *  in the coordinate system of the ChartBase object.
		 *
		 * @param x                 <Number> The x coordinate relative to the ChartBase object.
		 * @param y                 <Number> The y coordinate relative to the ChartBase object.
		 * @return                  <Array> An array of HitData objects.
		 */
		public function findDataPoints(x:Number, y:Number):Array;
		/**
		 * Returns an array of HitData objects representing the chart items
		 *  in the underlying objects that implement the IChartElement2 interface.
		 *
		 * @return                  <Array> An array of HitData objects that represent the data points.
		 */
		public function getAllDataPoints():Array;
		/**
		 * Deprecated: Please Use Series.getAxis()
		 *
		 * @param dimension         <String> 
		 */
		public function getAxis(dimension:String):IAxis;
		/**
		 * @param dimension         <String> 
		 */
		public function getAxis(dimension:String):IAxis;
		/**
		 * Gets the first item in the chart, with respect to the axes.
		 *
		 * @param direction         <String> The direction in which the first item should be returned. Possible values
		 *                            are ChartBase.NAVIGATE_HORIZONTAL, ChartBase.NAVIGATE_VERTICAL, and
		 *                            ChartBase.NONE. Cartesian charts implement horizontal and vertical, and Polar charts
		 *                            implement none.
		 * @return                  <ChartItem> The corresponding ChartItem object.
		 */
		public function getFirstItem(direction:String):ChartItem;
		/**
		 * Gets all the chart items that are within the defined rectangular region.
		 *  You call this method to determine what chart items are under
		 *  a particular rectangular region.
		 *
		 * @param value             <Rectangle> The rectangular region.
		 * @return                  <Array> An array of ChartItem objects.
		 */
		public function getItemsInRegion(value:Rectangle):Array;
		/**
		 * Gets the last chart item in the chart, with respect to the axes.
		 *
		 * @param direction         <String> The direction in which the last item should be returned. Possible values
		 *                            are ChartBase.NAVIGATE_HORIZONTAL, ChartBase.NAVIGATE_VERTICAL, and
		 *                            ChartBase.NONE. Cartesian charts implement horizontal and vertical, and Polar charts
		 *                            implement none.
		 * @return                  <ChartItem> The corresponding ChartItem object.
		 */
		public function getLastItem(direction:String):ChartItem;
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
		public function getNextItem(direction:String):ChartItem;
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
		public function getPreviousItem(direction:String):ChartItem;
		/**
		 * Informs the chart that the underlying data displayed in the chart
		 *  has been changed.
		 *  Chart series and elements call this function when their rendering has
		 *  changed in order to trigger a coordinated execution of show and hide data effects.
		 *  You typically do not call this method on the chart directly.
		 */
		public function hideData():void;
		/**
		 * Hides the drop indicator that indicates that a
		 *  drag-and-drop operation is allowed.
		 *
		 * @param event             <DragEvent> A DragEvent object that contains information about the
		 *                            mouse location.
		 */
		public function hideDropFeedback(event:DragEvent):void;
		/**
		 * Informs the chart that its child list was modified and should be reordererd.
		 *  Derived chart classes can call this method to trigger a call to the chart's internal
		 *  updateChildOrder() method on the next commitProperties() cycle.
		 */
		protected function invalidateChildOrder():void;
		/**
		 * Triggers a redraw of the chart.
		 *  Call this method when you add or change
		 *  the chart's series or data providers.
		 */
		protected function invalidateData():void;
		/**
		 * Informs the chart that its series array was modified and
		 *  should be reprocessed. Derived chart classes can call this method to trigger a
		 *  call to the chart's internal updateSeries() method on the next commitProperties() cycle.
		 */
		protected function invalidateSeries():void;
		/**
		 * Triggers a redraw of the chart.
		 *  Call this method when you change the style properties
		 *  of the chart's series.
		 */
		public function invalidateSeriesStyles():void;
		/**
		 * Dispatches a new LegendDataChanged event.
		 */
		public function legendDataChanged():void;
		/**
		 * Deprecated: Please Use IChartElement2.localToData()
		 *
		 * @param pt                <Point> The Point object to convert.
		 * @return                  <Array> The tuple of data values.
		 */
		public function localToData(pt:Point):Array;
		/**
		 * @param pt                <Point> 
		 */
		public function localToData(pt:Point):Array;
		/**
		 * Defines the locations of DataTip objects on the chart when the
		 *  showAllDataTips property is set to true.
		 *  This method ensures that DataTips do not overlap each other
		 *  (if multiple DataTips are visible) or overlap their target data items.
		 *
		 * @param hitSet            <Array> 
		 */
		protected function positionAllDataTips(hitSet:Array):void;
		/**
		 * Defines the locations of DataTip objects on the chart.
		 *  This method ensures that DataTip objects do not overlap each other
		 *  (if multiple DataTip objects are visible) or overlap their target data items.
		 */
		protected function positionDataTips():void;
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
		 * Deprecated: Please Use Series.setAxis()
		 *
		 * @param dimension         <String> 
		 * @param value             <IAxis> 
		 */
		public function setAxis(dimension:String, value:IAxis):void;
		/**
		 * @param dimension         <String> 
		 * @param value             <IAxis> 
		 */
		public function setAxis(dimension:String, value:IAxis):void;
		/**
		 * Displays a drop indicator under the mouse pointer to indicate that a
		 *  drag-and-drop operation is allowed. The drop indicator also indicates where the items will
		 *  be dropped.
		 *
		 * @param event             <DragEvent> A DragEvent object that contains information about where
		 *                            the mouse pointer is.
		 */
		public function showDropFeedback(event:DragEvent):void;
		/**
		 * Displays all noninteractive data tips
		 *  if showAllDataTips is set.
		 */
		public function updateAllDataTips():void;
		/**
		 */
		public static const HORIZONTAL:String = "H";
		/**
		 */
		public static const VERTICAL:String = "V";
	}
}
