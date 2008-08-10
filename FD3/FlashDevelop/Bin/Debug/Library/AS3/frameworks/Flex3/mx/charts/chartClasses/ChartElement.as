/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	public class ChartElement extends DualStyleObject implements IChartElement2 {
		/**
		 * Refers to the chart component containing this element.
		 */
		protected function get chart():ChartBase;
		/**
		 * The data provider assigned to the enclosing chart.
		 *  Element types can choose to inherit the data provider
		 *  from the enclosing chart if necessary, or allow developers
		 *  to assign data providers specifically to the element.
		 *  Not all elements are necessarily driven by a data provider.
		 */
		public function set chartDataProvider(value:Object):void;
		/**
		 * Each ChartElement carries a cursor associated with their dataProvider
		 *  for their own internal use.
		 *  ChartElements have sole ownership of this cursor;
		 *  they can assume no other code will modify its position.
		 */
		protected var cursor:IViewCursor;
		/**
		 * A data provider assigned to the this specific element.
		 *  In general, elements inherit the dataProvider from the enclosing chart.
		 *  But individual elements can override with a specific dataProvider
		 *  of their own.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * The DataTransform object that the element is associated with.
		 *  A DataTransform object represents an association between a set of elements
		 *  and a set of axis objects used to transform those elements
		 *  from data space to screen coordinates and back.
		 *  A chart element uses its associated DataTransform object to calculate
		 *  how to render its data.
		 */
		public function get dataTransform():DataTransform;
		public function set dataTransform(value:DataTransform):void;
		/**
		 * The DisplayObject that displays labels rendered by this element.
		 *  In most cases, labels displayed in the data area of a chart
		 *  are rendered on top of all elements
		 *  rather than interleaved with the  data.
		 *  If an implementing Element has labels to display,
		 *  it can place them in a Sprite object
		 *  and return it as the value of the labelContainer property.
		 *  Enclosing charts will labelContainers
		 *  from  all enclosed elements and place them
		 *  in the data area above all other elements.
		 */
		public function get labelContainer():Sprite;
		/**
		 * Constructor.
		 */
		public function ChartElement();
		/**
		 * Adds a child DisplayObject instance to this DisplayObjectContainer instance. The child is added
		 *  to the front (top) of all other children in this DisplayObjectContainer instance. (To add a child to a
		 *  specific index position, use the addChildAt() method.)
		 *
		 * @param child             <DisplayObject> The DisplayObject to add as a child.
		 * @return                  <DisplayObject> The child that was added; this is the same
		 *                            as the argument passed in.
		 */
		public override function addChild(child:DisplayObject):DisplayObject;
		/**
		 * Adds a child DisplayObject instance to this DisplayObjectContainer
		 *  instance. The child is added
		 *  at the index position specified. An index of 0 represents the back (bottom)
		 *  of the display list for this DisplayObjectContainer object.
		 *
		 * @param child             <DisplayObject> The DisplayObject instance to add as a child of this
		 *                            DisplayObjectContainer instance.
		 * @param index             <int> The index position to which the child is added. If you specify a
		 *                            currently occupied index position, the child object that exists at that position and all
		 *                            higher positions are moved up one position in the child list.
		 * @return                  <DisplayObject> The DisplayObject instance that you pass in the
		 *                            child parameter.
		 */
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject;
		/**
		 * Called by the enclosing chart to indicate that the current state
		 *  of the chart has changed.
		 *  Implementing elements should respond to this method
		 *  in order to synchronize changes to the data displayed by the element.
		 *
		 * @param oldState          <uint> An integer representing the previous state.
		 * @param v                 <uint> An integer representing the new state.
		 */
		public function chartStateChanged(oldState:uint, v:uint):void;
		/**
		 * Called by the chart to allow associated elements
		 *  to claim style selectors from its chartSeriesStyles Array.
		 *  Each chart has an associated set of selectors that are
		 *  implicitly assigned to contained elements that require them.
		 *  Implementing this function gives an element a chance to 'claim'
		 *  elements out of that set, as necessary.
		 *  An element that requires N style selectors claims the values
		 *  from styles[firstAvailable] to
		 *  styles[firstAvailable + N - 1].
		 *  Elements return the new value for firstAvailable
		 *  after claiming any styles (for example,
		 *  firstAvailable + N).
		 *
		 * @param styles            <Array> An Array of styles to claim.
		 * @param firstAvailable    <uint> The first style selector in the Array to claim.
		 */
		public function claimStyles(styles:Array, firstAvailable:uint):uint;
		/**
		 * Called by the enclosing chart to collect any transitions
		 *  a particular element might play when the chart changes state.
		 *  The chart collects transitions from all elements
		 *  and ensures that they play in parallel.
		 *  It waits until all transitions have completed
		 *  before advancing to another state.
		 *  Implementors should append any necessary transitions
		 *  to the transitions Array parameter.
		 *
		 * @param chartState        <Number> The state at which the chart plays
		 *                            the new transitions.
		 * @param transitions       <Array> An Array of transition to add
		 *                            to the chart's list of transitions to play.
		 */
		public function collectTransitions(chartState:Number, transitions:Array):void;
		/**
		 * Creates a unique id to represent the a dataPoint
		 *  for comparison purposes.
		 *  Derived classes can call this function with a locally unique
		 *  data point ID to generate an ID that is unique across the application.
		 *
		 * @param dataPointID       <Number> 
		 */
		protected function createDataID(dataPointID:Number):Number;
		/**
		 * Indicates the underlying data represented by the element has changed.
		 *  You should call this method whenever the data your series or element
		 *  is displaying changes.
		 *  It gives any associated axes a chance to update their ranges
		 *  if appropriate.
		 */
		protected function dataChanged():void;
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
		public function dataToLocal(... dataValues):Point;
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
		public function describeData(dimension:String, requiredFields:uint):Array;
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
		public function findDataPoints(x:Number, y:Number, sensitivity2:Number):Array;
		/**
		 * Returns an array of HitData of the items of all the underlying
		 *  ChartElements whose dataTips are to be shown when
		 *  showAllDataTips is set to true on
		 *  chart
		 *
		 * @return                  <Array> The HitData objects describing the data points.
		 */
		public function getAllDataPoints():Array;
		/**
		 * Converts a coordinate on screen to a tuple of data values.
		 *  Call this function to determine what data values
		 *  a particular point on-screen represents.
		 *
		 * @param pt                <Point> The Point to convert.
		 * @return                  <Array> The tuple of data values.
		 */
		public function localToData(pt:Point):Array;
		/**
		 * Called when the mapping of one or more associated axes changes.
		 *  The DataTransform assigned to this ChartElement will call this method
		 *  when any of the axes it represents is modified in some way.
		 */
		public function mappingChanged():void;
		/**
		 * Called when a new dataProvider is assigned to the element.
		 *  Subclassers can override and define custom behavior
		 *  when a new dataProvider is assigned.
		 *  This method will be called when either the dataProvider property
		 *  is set, or when the chartDataProvider property is set
		 *  if no specific dataProvider has been assigned directly.
		 *
		 * @param value             <Object> 
		 */
		protected function processNewDataProvider(value:Object):void;
	}
}
