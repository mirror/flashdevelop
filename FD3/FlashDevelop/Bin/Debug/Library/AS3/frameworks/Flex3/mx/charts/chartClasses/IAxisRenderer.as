/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import mx.core.IUIComponent;
	import mx.core.IFlexDisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	public interface IAxisRenderer extends IUIComponent, IFlexDisplayObject, IBitmapDrawable, IEventDispatcher {
		/**
		 * The axis object associated with this renderer.
		 *  This property is managed by the enclosing chart,
		 *  and should not be explicitly set.
		 */
		public function get axis():IAxis;
		public function set axis(value:IAxis):void;
		/**
		 * The distance between the axisRenderer
		 *  and the sides of the surrounding chart.
		 *  This property is assigned automatically by the chart,
		 *  and should not be assigned directly.
		 */
		public function get gutters():Rectangle;
		public function set gutters(value:Rectangle):void;
		/**
		 * The maximum amount of space, in pixels,
		 *  that an axis renderer will take from a chart.
		 *  Axis Renderers by default will take up as much space in the chart
		 *  as necessary to render all of their labels at full size.
		 *  If heightLimit is set, an AxisRenderer will resort to reducing
		 *  the labels in size in order to guarantee the total size of the axis
		 *  is less than heightLimit.
		 */
		public function get heightLimit():Number;
		public function set heightLimit(value:Number):void;
		/**
		 * true if the axis renderer
		 *  is being used as a horizontal axis.
		 *  This property is managed by the enclosing CartesianChart,
		 *  and should not be set directly.
		 */
		public function get horizontal():Boolean;
		public function set horizontal(value:Boolean):void;
		/**
		 * Contains an array that specifies where Flex
		 *  draws the minor tick marks along the axis.
		 *  Each array element contains a value between 0 and 1.
		 */
		public function get minorTicks():Array;
		/**
		 * An Array of axes.
		 */
		public function set otherAxes(value:Array):void;
		/**
		 * The side of the chart the axisRenderer will appear on.
		 *  Legal values are "left" and "right"
		 *  for vertical axis renderers and "top"
		 *  and "bottom" for horizontal axis renderers.
		 *  By default, primary axes are placed on the left and top,
		 *  and secondary axes are placed on the right and bottom.
		 *  CartesianCharts automatically guarantee that secondary axes
		 *  are placed opposite primary axes; if you explicitly place
		 *  a primary vertical axis on the right, for example,
		 *  the secondary vertical axis is swapped to the left.
		 */
		public function get placement():String;
		public function set placement(value:String):void;
		/**
		 * Contains an array that specifies where Flex
		 *  draws the tick marks along the axis.
		 *  Each array element contains a value between 0 and 1.
		 */
		public function get ticks():Array;
		/**
		 * Adjusts its layout to accomodate the gutters passed in.
		 *  This method is called by the enclosing chart to determine
		 *  the size of the gutters and the corresponding data area.
		 *  This method provides the AxisRenderer with an opportunity
		 *  to calculate layout based on the new gutters,
		 *  and to adjust them if necessary.
		 *  If a given gutter is adjustable, an axis renderer
		 *  can optionally adjust the gutters inward (i.e., larger)
		 *  but not outward (smaller).
		 *  The renderer should return the gutters plus any adjustments made.
		 *
		 * @param workingGutters    <Rectangle> Defines the gutters to adjust.
		 * @param adjustable        <Object> Consists of four Boolean properties
		 *                            (left=true/false, top=true/false, right=true/false,
		 *                            and bottom=true/false) that indicate whether the axis renderer
		 *                            can optionally adjust each of the gutters further.
		 */
		public function adjustGutters(workingGutters:Rectangle, adjustable:Object):Rectangle;
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
	}
}
