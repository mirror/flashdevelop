package mx.containers
{
	import flash.display.DisplayObject;
	import mx.containers.gridClasses.GridColumnInfo;
	import mx.containers.gridClasses.GridRowInfo;
	import mx.containers.utilityClasses.Flex;
	import mx.core.EdgeMetrics;
	import mx.core.ScrollPolicy;
	import mx.core.mx_internal;

	/**
	 *  Horizontal alignment of children in the container.
 *  Possible values are <code>"left"</code>, <code>"center"</code>,
 *  and <code>"right"</code>.
 *  The default value is <code>"left"</code>.
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 

	/**
	 *  Vertical alignment of children in the container.
 *  Possible values are <code>"top"</code>, <code>"middle"</code>,
 *  and <code>"bottom"</code>.
 *  The default value is <code>"top"</code>.
	 */
	[Style(name="verticalAlign", type="String", enumeration="bottom,middle,top", inherit="no")] 

	[Exclude(name="clipContent", kind="property")] 

	[Exclude(name="direction", kind="property")] 

	[Exclude(name="focusEnabled", kind="property")] 

	[Exclude(name="focusManager", kind="property")] 

	[Exclude(name="focusPane", kind="property")] 

	[Exclude(name="horizontalLineScrollSize", kind="property")] 

	[Exclude(name="horizontalPageScrollSize", kind="property")] 

	[Exclude(name="horizontalScrollBar", kind="property")] 

	[Exclude(name="horizontalScrollPolicy", kind="property")] 

	[Exclude(name="horizontalScrollPosition", kind="property")] 

	[Exclude(name="maxHorizontalScrollPosition", kind="property")] 

	[Exclude(name="maxVerticalScrollPosition", kind="property")] 

	[Exclude(name="mouseFocusEnabled", kind="property")] 

	[Exclude(name="verticalLineScrollSize", kind="property")] 

	[Exclude(name="verticalPageScrollSize", kind="property")] 

	[Exclude(name="verticalScrollBar", kind="property")] 

	[Exclude(name="verticalScrollPolicy", kind="property")] 

	[Exclude(name="verticalScrollPosition", kind="property")] 

	[Exclude(name="adjustFocusRect", kind="method")] 

	[Exclude(name="getFocus", kind="method")] 

	[Exclude(name="isOurFocus", kind="method")] 

	[Exclude(name="setFocus", kind="method")] 

	[Exclude(name="focusIn", kind="event")] 

	[Exclude(name="focusOut", kind="event")] 

	[Exclude(name="move", kind="event")] 

	[Exclude(name="scroll", kind="event")] 

	[Exclude(name="focusBlendMode", kind="style")] 

	[Exclude(name="focusSkin", kind="style")] 

	[Exclude(name="focusThickness", kind="style")] 

	[Exclude(name="horizontalGap", kind="style")] 

	[Exclude(name="horizontalScrollBarStyleName", kind="style")] 

	[Exclude(name="verticalGap", kind="style")] 

	[Exclude(name="verticalScrollBarStyleName", kind="style")] 

	[Exclude(name="focusInEffect", kind="effect")] 

	[Exclude(name="focusOutEffect", kind="effect")] 

	[Exclude(name="moveEffect", kind="effect")] 

include "../core/Version.as"
	/**
	 *  The GridRow container defines a row in a Grid container, and contains
 *  GridCell containers.
 *
 *  <p>GridRow containers have the following default sizing characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Height of each row and each cell</td>
 *           <td>The default or explicit height of the tallest item in the row. If a GridItem container does not 
 *               have an explicit size, its default height is the default or explicit height of the child in the cell.</td>
 *        </tr>
 *        <tr>
 *           <td>Width of each column and each cell</td>
 *           <td>The default or explicit width of the widest item in the column. If a GridItem container does not have an explicit 
 *               width, its default width is the default or explicit width of the child in the cell.</td>
 *        </tr>
 *        <tr>
 *           <td>Gap between rows and columns</td>
 *           <td>Determined by the horizontalGap and verticalGap properties of the Grid class. The default value for both 
 *               gaps is 6 pixels.</td>
 *        </tr>
 *        <tr>
 *           <td>Default padding</td>
 *           <td>0 pixels for the top, bottom, left, and right values, for all three container classes.</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:GridRow&gt;</code> must be a child of the 
 *  <code>&lt;mx:Grid&gt;</code> tag, and has one or more child 
 *  <code>&lt;mx:GridItem&gt;</code> tags that define the grid cells.</p>
 * 
 *  <p>The <code>&lt;mx:GridRow&gt;</code> container inherits the
 *  tag attributes of its superclass, and adds the following tag attributes:</p>
 * 
 *  <pre>
 *  &lt;mx:Grid&gt;
 *    &lt;mx:GridRow
 *    <strong>Styles</strong>
 *      horizontalAlign="left|center|right"
 *      verticalAlign="top|middle|bottom"
 *    &gt;
 *      &lt;mx:GridItem
 *        <i>child components</i>
 *      &lt;/mx:GridItem&gt;
 *      ...
 *    &lt;/mx:GridRow&gt;
 *    ...
 *  &lt;/mx:Grid&gt;
 *  </pre>
 *
 *  @see mx.containers.Grid
 *  @see mx.containers.GridItem
 *
 *  @includeExample examples/GridLayoutExample.mxml
	 */
	public class GridRow extends HBox
	{
		/**
		 *  @private
     *  Width of columns in the row.
		 */
		var columnWidths : Array;
		/**
		 *  @private
     *  Height of rows.
		 */
		var rowHeights : Array;
		/**
		 *  @private
     *  Index of this row.
		 */
		var rowIndex : int;
		/**
		 *  @private
		 */
		var numGridItems : int;

		/**
		 *  @private
		 */
		public function get clipContent () : Boolean;
		/**
		 *  @private
     *  Don't allow user to set clipContent.
     *  The Grid will clip all GridItems, if necessary.
     *  We don't want GridRows to do clipping, because GridItems with
     *  rowSpan > 1 will extend outside the borders of the GridRow.
		 */
		public function set clipContent (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
     *  Don't allow user to set horizontalScrollPolicy.
		 */
		public function set horizontalScrollPolicy (value:String) : void;

		/**
		 *  @private
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
     *  Don't allow user to set verticalScrollPolicy.
		 */
		public function set verticalScrollPolicy (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function GridRow ();

		/**
		 *  @private
     *  If the child index of a row item is changed, we need to recompute
     *  the column size and arrange children in proper order.
     *  Hence invalidate the size and layout of the Grid.
		 */
		public function setChildIndex (child:DisplayObject, newIndex:int) : void;

		/**
		 *  @private
     *  If something causes a GridRow's measurements to change,
     *  this function is called.
     *  Ordinarily, this function registers the object with the
     *  layout manager, so that measure is called later.
     *  For GridRows, we can't do measurement until after the parent Grid
     *  has done its measurement.
     *  Therefore, we register the parent Grid with the layout manager.
     *  The Grid.measure() contains code that calls measure()
     *  on each child GridRow.
		 */
		public function invalidateSize () : void;

		/**
		 *  @private
		 */
		public function invalidateDisplayList () : void;

		/**
		 *  Sets the size and position of each child of the GridRow container.
     *  For more information about the Grid layout algorithm, 
     *  see the <a href="Grid.html#updateDisplayList()">Grid.updateDisplayList()</a>
     *  method.
     *
     *  <p>You should not call this method directly.
     *  The Flex LayoutManager calls it at the appropriate time.
     *  At application startup, the Flex LayoutManager calls the
     *  <code>updateDisplayList()</code> method on every component,
     *  starting with the root and working downward.</p>
     *
     *  <p>This is an advanced method for use in subclassing.
     *  If you override this method, your implementation should call the
     *  <code>super.updateDisplayList()</code> method and call the
     *  <code>move()</code> and <code>setActualSize()</code> methods
     *  on each of the children.
     *  For the purposes of performing layout, you should get the size
     *  of this container from the <code>unscaledWidth</code> and
     *  <code>unscaledHeight</code> properties, not the <code>width</code>
     *  and <code>height</code> properties.
     *  The <code>width</code> and <code>height</code> properties
     *  do not take into account the value of the <code>scaleX</code>
     *  and <code>scaleY</code> properties for this container.</p>
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
     *  Use the horizontalGap from my parent grid;
     *  ignore any horizontalGap that is set on the GridRow.
		 */
		public function getStyle (styleProp:String) : *;

		/**
		 *  @private
     *  Calculates the preferred, minimum and maximum sizes
     *  of the GridRow container.
		 */
		function updateRowMeasurements () : void;

		/**
		 *  @private
		 */
		function doRowLayout (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		private function calculateColumnWidths () : void;
	}
}
