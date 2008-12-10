package mx.containers
{
	import flash.events.Event;
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;

	/**
	 *  Horizontal alignment of each child inside its tile cell. *  Possible values are <code>"left"</code>, <code>"center"</code>, and *  <code>"right"</code>. *  If the value is <code>"left"</code>, the left edge of each child *  is at the left edge of its cell. *  If the value is <code>"center"</code>, each child is centered horizontally *  within its cell. *  If the value is <code>"right"</code>, the right edge of each child *  is at the right edge of its cell. * *  @default "left"
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 
	/**
	 *  Number of pixels between children in the horizontal direction. * *  @default 8
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the container's bottom border and its content area. * *  @default 0
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the container's top border and its content area. * *  @default 0
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 
	/**
	 *  Vertical alignment of each child inside its tile cell. *  Possible values are <code>"top"</code>, <code>"middle"</code>, and *  <code>"bottom"</code>. *  If the value is <code>"top"</code>, the top edge of each child *  is at the top edge of its cell. *  If the value is <code>"middle"</code>, each child is centered vertically *  within its cell. *  If the value is <code>"bottom"</code>, the bottom edge of each child *  is at the bottom edge of its cell. * *  @default "top"
	 */
	[Style(name="verticalAlign", type="String", enumeration="bottom,middle,top", inherit="no")] 
	/**
	 *  Number of pixels between children in the vertical direction. * *  @default 6
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  A Tile container lays out its children *  in a grid of equal-sized cells. *  You can specify the size of the cells by using the *  <code>tileWidth</code> and <code>tileHeight</code> properties, *  or let the Tile container determine the cell size *  based on the largest child. *  A Tile container's <code>direction</code> property *  determines whether its cells are laid out horizontally or *  vertically, beginning from the upper-left corner of the *  Tile container. * *  <p>A Tile container has the following default sizing characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Direction</td> *           <td>horizontal</td> *        </tr> *        <tr> *           <td>Default size of all cells</td> *           <td>Height is the default or explicit height of the tallest child.<br/> *               Width is the default or explicit width of the widest child.<br/> *               All cells have the same default size.</td> *        </tr> *        <tr> *           <td>Default size of Tile container</td> *           <td>Flex computes the square root of the number of children, and rounds up to the nearest  *               integer. For example, if there are 26 children, the square root is 5.1, which is rounded up to 6.  *               Flex then lays out the Tile container in a 6 by 6 grid.<br/> *               Default height of the Tile container is equal to  *               (tile cell default height) <strong>x</strong> (rounded square root of the number of children), *               plus any gaps between children and any padding.<br/> *               Default width is equal to *               (tile cell default width) <strong>x</strong> (rounded square root of the number of children), *               plus any gaps between children and any padding.</td> *        </tr> *        <tr> *           <td>Minimum size of Tile container</td> *           <td>The default size of a single cell. Flex always allocates enough space to display at least  *               one cell.</td> *        </tr> *        <tr> *           <td>Default padding</td> *           <td>0 pixels for the top, bottom, left, and right values.</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:Tile&gt;</code> tag inherits all of the tag attributes *  of its superclass, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:Tile *    <b>Properties</b> *    direction="horizontal|vertical" *    tileHeight="NaN" *    tileWidth="NaN" *  *    <b>Sttles</b> *    horizontalAlign="left|center|right" *    horizontalGap="8" *    paddingBottom="0" *    paddingTop="0" *    verticalAlign="top|middle|bottom" *    verticalGap="6" *    &gt; *      ... *      <i>child tags</i> *     ... *  &lt;/mx:Tile&gt; *  </pre> * *  @includeExample examples/TileLayoutExample.mxml
	 */
	public class Tile extends Container
	{
		/**
		 *  @private     *  Cached value from findCellSize() call in measure(),     *  so that updateDisplayList() doesn't also have to call findCellSize().
		 */
		local var cellWidth : Number;
		/**
		 *  @private     *  Cached value from findCellSize() call in measure(),     *  so that updateDisplaylist() doesn't also have to call findCellSize().
		 */
		local var cellHeight : Number;
		/**
		 *  @private     *  Storage for the direction property.
		 */
		private var _direction : String;
		/**
		 *  @private     *  Storage for the tileHeight property.
		 */
		private var _tileHeight : Number;
		/**
		 *  @private     *  Storage for the tileWidth property.
		 */
		private var _tileWidth : Number;

		/**
		 *  Determines how children are placed in the container.     *  Possible MXML values  are <code>"horizontal"</code> and     *  <code>"vertical"</code>.     *  In ActionScript, you can set the direction using the values     *  TileDirection.HORIZONTAL or TileDirection.VERTICAL.     *  The default value is <code>"horizontal"</code>.     *  (If the container is a Legend container, which is a subclass of Tile,     *  the default value is <code>"vertical"</code>.)     *     *  <p>The first child is always placed at the upper-left of the     *  Tile container.     *  If the <code>direction</code> is <code>"horizontal"</code>,     *  the children are placed left-to-right in the topmost row,     *  and then left-to-right in the second row, and so on.     *  If the value is <code>"vertical"</code>, the children are placed     *  top-to-bottom in the leftmost column, and then top-to-bottom     *  in the second column, and so on.</p>     *     *  @default "horizontal"     *      *  @see TileDirection
		 */
		public function get direction () : String;
		/**
		 *  @private
		 */
		public function set direction (value:String) : void;
		/**
		 *  Height of each tile cell, in pixels.      *  If this property is <code>NaN</code>, the default, the height     *  of each cell is determined by the height of the tallest child.     *  If you set this property, the specified value overrides     *  this calculation.     *     *  @default NaN
		 */
		public function get tileHeight () : Number;
		/**
		 *  @private
		 */
		public function set tileHeight (value:Number) : void;
		/**
		 *  Width of each tile cell, in pixels.     *  If this property is <code>NaN</code>, the defualt, the width     *  of each cell is determined by the width of the widest child.     *  If you set this property, the specified value overrides     *  this calculation.     *     *  @default NaN
		 */
		public function get tileWidth () : Number;
		/**
		 *  @private
		 */
		public function set tileWidth (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function Tile ();
		/**
		 *  Calculates the default minimum and maximum sizes of the     *  Tile container.     *  For more information about the <code>measure()</code> method,     *  see the <code>UIComponent.measure()</code> method.     *       *  <p>This method first calculates the size of each tile cell.     *  For a description of how the cell size is determined, see the     *  <code>tileWidth</code> and <code>tileHeight</code> properties.</p>     *      *  <p>The measured size of a Tile container with children     *  is sufficient to display the cells in an N-by-N grid     *  with an equal number of rows and columns, plus room for     *  the Tile container's padding and borders.     *  However, there are various special cases, as in the following     *  examples:</p>     *     *  <ul>     *  <li>If a horizontal Tile container has an     *  explicit width set, that value determines how many     *  cells will fit horizontally, and the height required to fit all the     *  children is calculated, producing an M-by-N grid.</li>     *     *  <li>If a vertical Tile container has an     *  explicit height set, that value determines how many     *  cells will fit vertically, and the height required to fit all the     *  children is calculated, producing an N-by-M grid.</li>     *  </ul>     *     *  <p>If there are no children, the measured size is just     *  large enough for its padding and borders.</p>     *       *  <p>The minimum measured size of a Tile container     *  with children is just large enough for a single tile cell,     *  plus padding and borders.     *  If there are no children, the minimum measured size is just     *  large enough for its padding and borders.</p>     *      *  @see mx.core.UIComponent#measure()
		 */
		protected function measure () : void;
		/**
		 *  Sets the positions and sizes of this container's children.     *  For more information about the <code>updateDisplayList()</code>     *  method, see the <code>UIComponent.updateDisplayList()</code> method.     *       *  <p>This method positions the children in a checkboard-style grid of     *  equal-sized cells within the content area of the Tile     *  container (i.e., the area inside its padding).     *  For a description of how the cell size is determined,     *  see the <code>tileWidth</code> and     *  <code>tileHeight</code>properties.</p>     *       *  <p>The separation between the cells is determined by the     *  <code>horizontalGap</code> and <code>verticalGap</code> styles.     *  The placement of each child within its cell is determined by the     *  <code>horizontalAlign</code> and <code>verticalAlign</code> styles.</p>     *       *  <p>The flow of the children is determined by the     *  <code>direction</code> property.     *  The first cell is always placed at the upper left of the content area.     *  If <code>direction</code> is set to <code>"horizontal"</code>, the     *  cells are placed left-to-right in the topmost row, and then     *  left-to-right in the second row, and so on.     *  If <code>direction</code> is set to <code>"vertical"</code>, the cells     *  are placed top-to-bottom in the leftmost column, and then top-to-bottom     *  in the second column, and so on.</p>     *       *  <p>If a child has a <code>percentWidth</code> or     *  <code>percentHeight</code> value, it is resized in that direction     *  to fill the specified percentage of its tile cell.</p>     *     *  @param unscaledWidth Specifies the width of the component, in pixels,     *  in the component's coordinates, regardless of the value of the     *  <code>scaleX</code> property of the component.     *     *  @param unscaledHeight Specifies the height of the component, in pixels,     *  in the component's coordinates, regardless of the value of the     *  <code>scaleY</code> property of the component.        *      *  @see mx.core.UIComponent#updateDisplayList()
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private     *  Calculate and store the cellWidth and cellHeight.
		 */
		function findCellSize () : void;
		/**
		 *  @private     *  Assigns the actual size of the specified child,     *  based on its measurement properties and the cell size.
		 */
		private function setChildSize (child:IUIComponent) : void;
		/**
		 *  @private     *  Compute how much adjustment must occur in the x direction     *  in order to align a component of a given width into the cell.
		 */
		function calcHorizontalOffset (width:Number, horizontalAlign:String) : Number;
		/**
		 *  @private     *  Compute how much adjustment must occur in the y direction     *  in order to align a component of a given height into the cell.
		 */
		function calcVerticalOffset (height:Number, verticalAlign:String) : Number;
	}
}
