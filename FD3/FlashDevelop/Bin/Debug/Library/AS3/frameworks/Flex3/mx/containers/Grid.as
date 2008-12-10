﻿package mx.containers
{
	import mx.containers.gridClasses.GridColumnInfo;
	import mx.containers.gridClasses.GridRowInfo;
	import mx.core.EdgeMetrics;

	/**
	 *  Number of pixels between children in the horizontal direction.  *  The default value is 8.
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between children in the vertical direction.  *  The default value is 6.
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  A Grid container lets you arrange children as rows and columns *  of cells, similar to an HTML table.  *  The Grid container contains one or more rows, and each row can contain *  one or more cells, or items. You use the following tags to define a Grid control: * *  <ul> *     <li>The <code>&lt;mx:Grid&gt;</code> tag defines a Grid container.</li> *  *     <li>The <code>&lt;mx:GridRow&gt;</code> tag defines a grid row,  *     which has one or more cells. The grid row must be a child of the  *     <code>&lt;Grid&gt;</code> tag.</li> *  *     <li>The <code>&lt;mx:GridItem&gt;</code> tag defines a grid cell, *     and must be a child of the <code>&lt;GridRow&gt;</code> tag. *     The <code>&lt;mx:GridItem&gt;</code> tag can contain *     any number of children.</li> *  </ul> *  *  <p>The height of all the cells in a single row is the same, *  but each row can have a different height.  *  The width of all cells in a single column is the same, *  but each column can have a different width.  *  You can define a different number of cells *  for each row or each column of the Grid container.  *  In addition, a cell can span multiple columns *  or multiple rows of the container.</p> *   *  <p>The Grid, GridRow, and GridItem containers have the following default sizing characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Grid height</td> *           <td>The sum of the default or explicit heights of all rows plus the gaps between rows.</td> *        </tr> *        <tr> *           <td>Grid width</td> *           <td>The sum of the default or explicit width of all columns plus the gaps between columns.</td> *        </tr> *        <tr> *           <td>Height of each row and each cell</td> *           <td>The default or explicit height of the tallest item in the row. If a GridItem container does not  *               have an explicit size, its default height is the default or explicit height of the child in the cell.</td> *        </tr> *        <tr> *           <td>Width of each column and each cell</td> *           <td>The default or explicit width of the widest item in the column. If a GridItem container does not have an explicit  *               width, its default width is the default or explicit width of the child in the cell.</td> *        </tr> *        <tr> *           <td>Gap between rows and columns</td> *           <td>Determined by the horizontalGap and verticalGap properties of the Grid class. The default value for both  *               gaps is 6 pixels.</td> *        </tr> *        <tr> *           <td>Default padding</td> *           <td>0 pixels for the top, bottom, left, and right values, for all three container classes.</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:Grid&gt;</code> tag inherits all of the tag  *  attributes of its superclass, except the <code>Box.direction</code> *  property, and adds the following tag attributes:</p> *   *  <pre> *  &lt;mx:Grid *    <strong>Styles</strong> *    horizontalGap="8" *    verticalGap="6" *    &gt; *      ... *    <i>These child tags are examples only:</i> *       &lt;mx:GridRow id="row1"&gt; *        &lt;mx:GridItem *          rowSpan="1" *          colSpan="1"> *            &lt;mx:Button label="Button 1"/&gt; *        &lt;/mx:GridItem&gt; *        ... *       &lt;/mx:GridRow&gt; *    ... *  &lt;/mx:Grid&gt; *  </pre> *   *  @includeExample examples/GridLayoutExample.mxml * *  @see mx.containers.GridRow *  @see mx.containers.GridItem
	 */
	public class Grid extends Box
	{
		/**
		 *  @private     *  Minimum, maximum, and preferred width of each column.
		 */
		private var columnWidths : Array;
		/**
		 *  @private     *  Minimum, maximum, and preferred height of each row.
		 */
		private var rowHeights : Array;
		/**
		 *  @private
		 */
		private var needToRemeasure : Boolean;

		/**
		 *  Constructor.
		 */
		public function Grid ();
		/**
		 *  @private
		 */
		public function invalidateSize () : void;
		/**
		 *  Calculates the preferred, minimum, and maximum sizes of the Grid.     *  <p>You should not call this method directly; it is an advanced      *  method for use in subclassing.     *  The Flex LayoutManger calls the <code>measure()</code> method      *  at the appropriate time.     *  At application startup, the Flex LayoutManager attempts     *  to measure all components from the children to the parents     *  before setting them to their final sizes.</p>     *     *  <p>To understand how the Grid container calculates its measurements,     *  assume that every GridItem container has its <code>rowSpan</code>     *  property and <code>colSpan</code> property set to 1.     *  The measured width of the first column of the Grid container     *  is equal to the maximum among of the measured widths     *  of all GridItem containers in the first column.     *  Similarly, the measured width of the second column is     *  the maximum of all measured widths among the GridItem containers     *  in the second column, and so on.     *  The <code>measuredWidth</code> of the entire Grid container     *  is the sum of all columns' measured widths, plus the thickness     *  of the border, plus the left and right padding, plus room     *  for the horizontal gap between adjacent grid cells.</p>     *     *  <p>The <code>measuredHeight</code>, <code>minWidth</code>,     *  <code>minHeight</code>, <code>maxWidth</code>, and     *  <code>maxHeight</code> properties' values are all calculated     *  in a similar manner, by adding together the values of the     *  GridItem containers' <code>measuredHeight</code> properties,     *  <code>minWidth</code> properties, and so on.</p>     *     *  <p>If a GridItem container's <code>colSpan</code> property is 3,     *  that GridItem container's <code>measuredWidth</code> is divided     *  among 3 columns.     *  If the <code>measuredWidth</code> is divided equally,     *  each of the three columns calculates its measured width     *  as if the GridItem container were only in that column     *  and the GridItem container's <code>measuredWidth</code>     *  were one-third of its actual value.</p>     *     *  <p>However, the GridItem container's <code>measuredWidth</code>     *  property is not always divided equally among all the columns it spans.     *  If some of the columns have a property with a percentage value     *  of <code>width</code>, the GridItem container's     *  <code>measuredWidth</code> property is divided accordingly,     *  attempting to give each column the requested percentage     *  of the Grid container.</p>     *     *  <p>All of the values described previously are the     *  <i>measured</i> widths and heights of Grid.     *  The user can override the measured values by explicitly     *  supplying a value for the following properties:</p>     *     *  <ul>     *    <li><code>minHeight</code></li>     *    <li><code>minWidth</code></li>     *    <li><code>maxHeight</code></li>     *    <li><code>maxWidth</code></li>     *    <li><code>height</code></li>     *    <li><code>width</code></li>     *  </ul>     *     *  <p>If you override this method, your implementation must call the      *  <code>super.measure()</code> method or set the     *  <code>measuredHeight</code> and <code>measuredWidth</code> properties.     *  You may also optionally set the following properties:</p>     *      *  <ul>     *    <li><code>measuredMinWidth</code></li>     *    <li><code>measuredMinHeight</code></li>     *  </ul>     *      *  <p>These properties correspond to the layout properties listed previously      *  and, therefore, are not documented separately.</p>
		 */
		protected function measure () : void;
		/**
		 *  Sets the size and position of each child of the Grid.     *     *  <p>You should not call this method directly; it is an advanced      *  method for use in subclassing.     *  The Flex LayoutManager calls the <code>updateDisplayList</code>     *  method at the appropriate time.     *  At application startup, the Flex LayoutManager calls     *  the <code>updateDisplayList()</code> method on every component,     *  starting with the root and working downward.</p>     *     *  <p>The Grid container follows the same layout rules     *  as the VBox container.       *  The positions and sizes of the GridRow containers     *  are calculated the same way that a VBox container     *  determines the positions and sizes of its children.     *  Similarly, a GridRow container positions its GridItem containers     *  using a similar layout algorithm of an HBox container.</p>     *     *  <p>The only difference is that the GridRow containers     *  all coordinate with one another, so they all choose     *  the same positions and sizes for their children     *  (so that the columns of the Grid container align). </p>     *     *  <p>If you override this method, your implementation should call     *  the <code>super.updateDisplayList()</code> method     *  and call the <code>move()</code> and the <code>setActualSize()</code>     *  methods on each of the children.     *  For the purposes of performing layout, you should get the size     *  of this container from the <code>unscaledWidth</code>     *  and <code>unscaledHeight</code> properties, not the     *  <code>width</code> and <code>height</code> properties.     *  The <code>width</code> and <code>height</code> properties do not     *  take into account the values of the <code>scaleX</code>     *  and <code>scaleY</code> properties for this container.</p>     *     *  @param unscaledWidth Specifies the width of the component, in pixels,     *  in the component's coordinates, regardless of the value of the     *  <code>scaleX</code> property of the component.     *     *  @param unscaledHeight Specifies the height of the component, in pixels,     *  in the component's coordinates, regardless of the value of the     *  <code>scaleY</code> property of the component.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		private function distributeItemHeight (item:GridItem, rowIndex:Number, verticalGap:Number, rowHeights:Array) : void;
		/**
		 *  @private
		 */
		private function distributeItemWidth (item:GridItem, colIndex:int, horizontalGap:Number, columnWidths:Array) : void;
	}
}
