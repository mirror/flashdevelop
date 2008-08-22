/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	import mx.core.IFlexDisplayObject;
	import flash.display.Sprite;
	public interface IChartElement extends IFlexDisplayObject, IBitmapDrawable, IEventDispatcher {
		/**
		 * The data provider assigned to the enclosing chart.
		 *  Element types can choose to inherit the data provider
		 *  from the enclosing chart if necessary, or allow developers
		 *  to assign data providers specifically to the element.
		 *  Not all elements are necessarily driven by a data provider.
		 */
		public function set chartDataProvider(value:Object):void;
		/**
		 * The DataTransform object that the element uses
		 *  to map between data and screen coordinates.
		 *  This property is assigned by the enclosing chart.
		 */
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
		 * Returns a HitData object describing the nearest data point
		 *  to the coordinates passed to the method.
		 *  The x and y arguments
		 *  should be values in the Element's coordinate system.
		 *  This method aheres to the limits specifies by the
		 *  sensitivity2 parameter
		 *  when looking for nearby data points.
		 *
		 * @param x                 <Number> The x coordinate relative to the ChartBase object.
		 * @param y                 <Number> The y coordinate relative to the ChartBase object.
		 * @param sensitivity2      <Number> 
		 * @return                  <Array> A HitData object describing the nearest data point
		 *                            within sensitivity2 pixels.
		 */
		public function findDataPoints(x:Number, y:Number, sensitivity2:Number):Array;
		/**
		 * Indicates to the element that the data mapping
		 *  of the associated axes has changed.
		 *  Implementors should dispose of cached data
		 *  and re-render appropriately.
		 *  This function is called automatically
		 *  by the associated DataTransform when necessary.
		 */
		public function mappingChanged():void;
	}
}
