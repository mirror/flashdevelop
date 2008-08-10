/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts {
	import mx.charts.chartClasses.DualStyleObject;
	import mx.charts.chartClasses.IAxisRenderer;
	import mx.charts.chartClasses.IAxis;
	import mx.charts.chartClasses.ChartBase;
	import flash.geom.Rectangle;
	import mx.core.IFactory;
	public class AxisRenderer extends DualStyleObject implements IAxisRenderer {
		/**
		 * The axis object associated with this renderer.
		 *  This property is managed by the enclosing chart,
		 *  and could be explicitly set if multiple axes renderers are used.
		 */
		public function get axis():IAxis;
		public function set axis(value:IAxis):void;
		/**
		 * The base chart for this AxisRenderer.
		 */
		protected function get chart():ChartBase;
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
		 * Specifies wheter to highlight chart elements like Series on mouse rollover.
		 */
		public function get highlightElements():Boolean;
		public function set highlightElements(value:Boolean):void;
		/**
		 * true if the axis renderer
		 *  is being used as a horizontal axis.
		 *  This property is managed by the enclosing CartesianChart,
		 *  and should not be set directly.
		 */
		public function get horizontal():Boolean;
		public function set horizontal(value:Boolean):void;
		/**
		 * Called to format axis renderer values for display as labels.
		 */
		public function get labelFunction():Function;
		public function set labelFunction(value:Function):void;
		/**
		 * A reference to the factory used to render the axis labels.
		 *  This type must implement the IDataRenderer
		 *  and IFlexDisplayObject interfaces.
		 */
		public function get labelRenderer():IFactory;
		public function set labelRenderer(value:IFactory):void;
		/**
		 * Specifies the length of the axis, in screen coordinates.
		 *  The default length depends on a number of factors,
		 *  including the size of the chart, the size of the labels,
		 *  how the AxisRenderer chooses to lay out labels,
		 *  and any requirements imposed by other portions of the chart.
		 */
		public function get length():Number;
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
		 * A reference to the factory used to render the axis title.
		 *  This type must extend UIComponent and
		 *  implement the IDataRenderer and IFlexDisplayObject interfaces.
		 */
		public function get titleRenderer():IFactory;
		public function set titleRenderer(value:IFactory):void;
		/**
		 * Constructor.
		 */
		public function AxisRenderer();
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
		 * Called by the chart to indicate
		 *  when its current transition state has changed.
		 *
		 * @param oldState          <uint> A number representing the old state.
		 * @param newState          <uint> A number representing the new state.
		 */
		public function chartStateChanged(oldState:uint, newState:uint):void;
		/**
		 * Marks a component so that its updateDisplayList()
		 *  method gets called during a later screen update.
		 */
		public override function invalidateDisplayList():void;
		/**
		 * Marks a component so that its measure()
		 *  method gets called during a later screen update.
		 */
		public override function invalidateSize():void;
		/**
		 * Calculates the default size, and optionally the default minimum size,
		 *  of the component. This is an advanced method that you might override when
		 *  creating a subclass of UIComponent.
		 */
		protected override function measure():void;
		/**
		 * Moves this object to the specified x and y coordinates.
		 *
		 * @param x                 <Number> Left position of the component within its parent.
		 * @param y                 <Number> Top position of the component within its parent.
		 */
		public override function move(x:Number, y:Number):void;
		/**
		 * Sets the actual size of this object.
		 *
		 * @param w                 <Number> Width of the object.
		 * @param h                 <Number> Height of the object.
		 */
		public override function setActualSize(w:Number, h:Number):void;
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
