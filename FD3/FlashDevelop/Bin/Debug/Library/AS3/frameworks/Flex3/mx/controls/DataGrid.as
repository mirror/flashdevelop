package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.ItemResponder;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.dataGridClasses.DataGridBase;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.controls.dataGridClasses.DataGridDragProxy;
	import mx.controls.dataGridClasses.DataGridHeader;
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListBaseContentHolder;
	import mx.controls.listClasses.ListBaseSeekPending;
	import mx.controls.listClasses.ListRowInfo;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.core.ContextualClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.EventPriority;
	import mx.core.FlexShape;
	import mx.core.FlexSprite;
	import mx.core.FlexVersion;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IIMESupport;
	import mx.core.IInvalidating;
	import mx.core.IPropertyChangeNotifier;
	import mx.core.IRectangularBorder;
	import mx.core.IUIComponent;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.DataGridEvent;
	import mx.events.DataGridEventReason;
	import mx.events.DragEvent;
	import mx.events.IndexChangedEvent;
	import mx.events.ListEvent;
	import mx.events.SandboxMouseEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.skins.halo.ListDropIndicator;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleManager;
	import mx.utils.ObjectUtil;
	import mx.utils.StringUtil;

	/**
	 *  Dispatched when the user releases the mouse button while over an item 
 *  renderer, tabs to the DataGrid control or within the DataGrid control, 
 *  or in any other way attempts to edit an item.
 *
 *  @eventType mx.events.DataGridEvent.ITEM_EDIT_BEGINNING
	 */
	[Event(name="itemEditBeginning", type="mx.events.DataGridEvent")] 

	/**
	 *  Dispatched when the <code>editedItemPosition</code> property has been set
 *  and the item can be edited.
 *
 *  @eventType mx.events.DataGridEvent.ITEM_EDIT_BEGIN
	 */
	[Event(name="itemEditBegin", type="mx.events.DataGridEvent")] 

	/**
	 *  Dispatched when the item editor has just been instantiated.
 *
 *  @eventType mx.events.DataGridEvent.ITEM_EDITOR_CREATE
	 */
	[Event(name="itemEditorCreate", type="mx.events.DataGridEvent")] 

	/**
	 *  Dispatched when an item editing session ends for any reason.
 *
 *  @eventType mx.events.DataGridEvent.ITEM_EDIT_END
	 */
	[Event(name="itemEditEnd", type="mx.events.DataGridEvent")] 

	/**
	 *  Dispatched when an item renderer gets focus, which can occur if the user
 *  clicks on an item in the DataGrid control or navigates to the item using
 *  a keyboard.  Only dispatched if the item is editable.
 *
 *  @eventType mx.events.DataGridEvent.ITEM_FOCUS_IN
	 */
	[Event(name="itemFocusIn", type="mx.events.DataGridEvent")] 

	/**
	 *  Dispatched when an item renderer loses focus, which can occur if the user
 *  clicks another item in the DataGrid control or clicks outside the control,
 *  or uses the keyboard to navigate to another item in the DataGrid control
 *  or outside the control.
 *  Only dispatched if the item is editable.
 *
 *  @eventType mx.events.DataGridEvent.ITEM_FOCUS_OUT
	 */
	[Event(name="itemFocusOut", type="mx.events.DataGridEvent")] 

	/**
	 *  Dispatched when a user changes the width of a column, indicating that the 
 *  amount of data displayed in that column may have changed.
 *  If <code>horizontalScrollPolicy</code> is <code>"off"</code>, other
 *  columns shrink or expand to compensate for the columns' resizing,
 *  and they also dispatch this event.
 *
 *  @eventType mx.events.DataGridEvent.COLUMN_STRETCH
	 */
	[Event(name="columnStretch", type="mx.events.DataGridEvent")] 

	/**
	 *  Dispatched when the user releases the mouse button on a column header
 *  to request the control to sort
 *  the grid contents based on the contents of the column.
 *  Only dispatched if the column is sortable and the data provider supports 
 *  sorting. The DataGrid control has a default handler for this event that implements
 *  a single-column sort.  Multiple-column sort can be implemented by calling the 
 *  <code>preventDefault()</code> method to prevent the single column sort and setting 
 *  the <code>sort</code> property of the data provider.
 * <p>
 * <b>Note</b>: The sort arrows are defined by the default event handler for
 * the headerRelease event. If you call the <code>preventDefault()</code> method
 * in your event handler, the arrows are not drawn.
 * </p>
 *
 *  @eventType mx.events.DataGridEvent.HEADER_RELEASE
	 */
	[Event(name="headerRelease", type="mx.events.DataGridEvent")] 

	/**
	 *  Dispatched when the user releases the mouse button on a column header after 
 *  having dragged the column to a new location resulting in shifting the column
 *  to a new index.
 *
 *  @eventType mx.events.IndexChangedEvent.HEADER_SHIFT
	 */
	[Event(name="headerShift", type="mx.events.IndexChangedEvent")] 

include "../styles/metadata/IconColorStyles.as"
	/**
	 *  A flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
	 */
	[Style(name="verticalGridLines", type="Boolean", inherit="no")] 

	/**
	 *  A flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
	 */
	[Style(name="horizontalGridLines", type="Boolean", inherit="no")] 

	/**
	 *  The color of the vertical grid lines.
 *  @default 0x666666
	 */
	[Style(name="verticalGridLineColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The color of the horizontal grid lines.
	 */
	[Style(name="horizontalGridLineColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  An array of two colors used to draw the header background gradient.
 *  The first color is the top color.
 *  The second color is the bottom color.
 *  @default [0xFFFFFF, 0xE6E6E6]
	 */
	[Style(name="headerColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 

	/**
	 *  The color of the row background when the user rolls over the row.
 *  @default 0xE3FFD6
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The color of the background for the row when the user selects 
 *  an item renderer in the row.
 *  @default 0xCDFFC1
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The name of a CSS style declaration for controlling other aspects of
 *  the appearance of the column headers.
 *  @default "dataGridStyles"
	 */
	[Style(name="headerStyleName", type="String", inherit="no")] 

	/**
	 *  The class to use as the skin for a column that is being resized.
 *  @default mx.skins.halo.DataGridColumnResizeSkin
	 */
	[Style(name="columnResizeSkin", type="Class", inherit="no")] 

	/**
	 *  The class to use as the skin that defines the appearance of the  
 *  background of the column headers in a DataGrid control.
 *  @default mx.skins.halo.DataGridHeaderSeparator
	 */
	[Style(name="headerBackgroundSkin", type="Class", inherit="no")] 

	/**
	 *  The class to use as the skin that defines the appearance of the 
 *  separator between column headers in a DataGrid control.
 *  @default mx.skins.halo.DataGridHeaderSeparator
	 */
	[Style(name="headerSeparatorSkin", type="Class", inherit="no")] 

	/**
	 *  The class to use as the skin that defines the appearance of the 
 *  separator between rows in a DataGrid control. 
 *  By default, the DataGrid control uses the 
 *  <code>drawHorizontalLine()</code> and <code>drawVerticalLine()</code> methods
 *  to draw the separators.
 *
 *  @default undefined
	 */
	[Style(name="horizontalSeparatorSkin", type="Class", inherit="no")] 

	/**
	 *  The class to use as the skin that defines the appearance of the 
 *  separator between the locked and unlocked rows in a DataGrid control.
 *  By default, the DataGrid control uses the 
 *  <code>drawHorizontalLine()</code> and <code>drawVerticalLine()</code> methods
 *  to draw the separators.
 *
 *  @default undefined
	 */
	[Style(name="horizontalLockedSeparatorSkin", type="Class", inherit="no")] 

	/**
	 *  The class to use as the skin that defines the appearance of the 
 *  separators between columns in a DataGrid control.
 *  By default, the DataGrid control uses the 
 *  <code>drawHorizontalLine()</code> and <code>drawVerticalLine()</code> methods
 *  to draw the separators.
 *
 *  @default undefined
	 */
	[Style(name="verticalSeparatorSkin", type="Class", inherit="no")] 

	/**
	 *  The class to use as the skin that defines the appearance of the 
 *  separator between the locked and unlocked columns in a DataGrid control.
 *  By default, the DataGrid control uses the 
 *  <code>drawHorizontalLine()</code> and <code>drawVerticalLine()</code> methods
 *  to draw the separators.
 *
 *  @default undefined
	 */
	[Style(name="verticalLockedSeparatorSkin", type="Class", inherit="no")] 

	/**
	 *  The class to use as the skin for the arrow that indicates the column sort 
 *  direction.
 *  @default mx.skins.halo.DataGridSortArrow
	 */
	[Style(name="sortArrowSkin", type="Class", inherit="no")] 

	/**
	 *  The class to use as the skin for the cursor that indicates that a column
 *  can be resized.
 *  The default value is the "cursorStretch" symbol from the Assets.swf file.
	 */
	[Style(name="stretchCursor", type="Class", inherit="no")] 

	/**
	 *  The class to use as the skin that indicates that 
 *  a column can be dropped in the current location.
 *
 *  @default mx.skins.halo.DataGridColumnDropIndicator
	 */
	[Style(name="columnDropIndicatorSkin", type="Class", inherit="no")] 

	/**
	 *  The name of a CSS style declaration for controlling aspects of the
 *  appearance of column when the user is dragging it to another location.
 *
 *  @default "headerDragProxyStyle"
	 */
	[Style(name="headerDragProxyStyleName", type="String", inherit="no")] 

	[Exclude(name="columnCount", kind="property")] 

	[Exclude(name="iconField", kind="property")] 

	[Exclude(name="iconFunction", kind="property")] 

	[Exclude(name="labelField", kind="property")] 

	[Exclude(name="offscreenExtraRowsOrColumns", kind="property")] 

	[Exclude(name="offscreenExtraRows", kind="property")] 

	[Exclude(name="offscreenExtraRowsTop", kind="property")] 

	[Exclude(name="offscreenExtraRowsBottom", kind="property")] 

	[Exclude(name="offscreenExtraColumns", kind="property")] 

	[Exclude(name="offscreenExtraColumnsLeft", kind="property")] 

	[Exclude(name="offscreenExtraColumnsRight", kind="property")] 

	[Exclude(name="offscreenExtraRowsOrColumnsChanged", kind="property")] 

	[Exclude(name="showDataTips", kind="property")] 

	[Exclude(name="cornerRadius", kind="style")] 

	[DefaultProperty("dataProvider")] 

include "../core/Version.as"
	/**
	 *  The <code>DataGrid</code> control is like a List except that it can 
 *  show more than one column of data making it suited for showing 
 *  objects with multiple properties.
 *  <p>
 *  The DataGrid control provides the following features:
 *  <ul>
 *  <li>Columns of different widths or identical fixed widths</li>
 *  <li>Columns that the user can resize at runtime </li>
 *  <li>Columns that the user can reorder at runtime </li>
 *  <li>Optional customizable column headers</li>
 *  <li>Ability to use a custom item renderer for any column to display 
 *      data 
 *  other than text</li>
 *  <li>Support for sorting the data by clicking on a column</li>
 *  </ul>
 *  </p>
 *  The DataGrid control is intended for viewing data, and not as a
 *  layout tool like an HTML table.
 *  The mx.containers package provides those layout tools.
 *  
 *  <p>The DataGrid control has the following default sizing 
 *     characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>If the columns are empty, the default width is 300 
 *               pixels. If the columns contain information but define 
 *               no explicit widths, the default width is 100 pixels 
 *               per column. The DataGrid width is sized to fit the 
 *               width of all columns, if possible. 
 *               The default number of displayed rows, including the 
 *               header is 7, and each row, by default, is 20 pixels 
 *               high.
 *           </td>
 *        </tr>
 *        <tr>
 *           <td>Minimum size</td>
 *           <td>0 pixels.</td>
 *        </tr>
 *        <tr>
 *           <td>Maximum size</td>
 *           <td>5000 by 5000.</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *  <p>
 *  The <code>&lt;mx:DataGrid&gt;</code> tag inherits all of the tag 
 *  attributes of its superclass, except for <code>labelField</code>, 
 *  <code>iconField</code>, and <code>iconFunction</code>, and adds the 
 *  following tag attributes:
 *  </p>
 *  <pre>
 *  &lt;mx:DataGrid
 *    <b>Properties</b>
 *    columns="<i>From dataProvider</i>"
 *    draggableColumns="true|false"
 *    editable="false|true"
 *    editedItemPosition="<code>null</code>"
 *    horizontalScrollPosition="null"
 *    imeMode="null"
 *    itemEditorInstance="null"
 *    minColumnWidth="<code>NaN</code>"
 *    resizableColumns="true|false"
 *    sortableColumns="true|false"
 *    
 *    <b>Styles</b>
 *    backgroundDisabledColor="0xEFEEEF"
 *    columnDropIndicatorSkin="DataGridColumnDropIndicator"
 *    columnResizeSkin="DataGridColumnResizeSkin"
 *    disabledIconColor="0x999999"
 *    headerColors="[#FFFFFF, #E6E6E6]"
 *    headerDragProxyStyleName="headerDragProxyStyle"
 *    headerSeparatorSkin="DataGridHeaderSeparator"
 *    headerStyleName="dataGridStyles"
 *    horizontalGridLineColor="<i>No default</i>"
 *    horizontalGridLines="false|true"
 *    horizontalLockedSeparatorSkin="undefined"
 *    horizontalSeparatorSkin="undefined"
 *    iconColor="0x111111"
 *    rollOverColor="#E3FFD6"
 *    selectionColor="#CDFFC1"
 *    sortArrowSkin="DataGridSortArrow"
 *    stretchCursor="<i>"cursorStretch" symbol from the Assets.swf file</i>"
 *    verticalGridLineColor="#666666"
 *    verticalGridLines="false|true"
 *    verticalLockedSeparatorSkin="undefined"
 *    verticalSeparatorSkin="undefined"
 *     
 *    <b>Events</b>
 *    columnStretch="<i>No default</i>"
 *    headerRelease="<i>No default</i>"
 *    headerShift="<i>No default</i>"
 *    itemEditBegin="<i>No default</i>"
 *    itemEditBeginning="<i>No default</i>" 
 *    itemEditEnd="<i>No default</i>"
 *    itemFocusIn="<i>No default</i>"
 *    itemFocusOut="<i>No default</i>"
 *  /&gt;
 *   
 *  <b>The following DataGrid code sample specifies the column order:</b>
 *  &lt;mx:DataGrid&gt;
 *    &lt;mx:dataProvider&gt;
 *        &lt;mx:Object Artist="Pavement" Price="11.99"
 *          Album="Slanted and Enchanted"/&gt;
 *
	 */
	public class DataGrid extends DataGridBase implements IIMESupport
	{
		/**
		 *  @private
     *  Placeholder for mixin by DataGridAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  A reference to the currently active instance of the item editor, 
     *  if it exists.
     *
     *  <p>To access the item editor instance and the new item value when an 
     *  item is being edited, you use the <code>itemEditorInstance</code> 
     *  property. The <code>itemEditorInstance</code> property
     *  is not valid until after the event listener for
     *  the <code>itemEditBegin</code> event executes. Therefore, you typically
     *  only access the <code>itemEditorInstance</code> property from within 
     *  the event listener for the <code>itemEditEnd</code> event.</p>
     *
     *  <p>The <code>DataGridColumn.itemEditor</code> property defines the
     *  class of the item editor
     *  and, therefore, the data type of the item editor instance.</p>
     *
     *  <p>You do not set this property in MXML.</p>
		 */
		public var itemEditorInstance : IListItemRenderer;
		/**
		 *  @private
     *  true if we want to skip updating the headers during adjustListContent
		 */
		private var skipHeaderUpdate : Boolean;
		/**
		 *  @private
     *  true if we want to block editing on mouseUp
		 */
		private var dontEdit : Boolean;
		/**
		 *  @private
     *  true if we want to block editing on mouseUp
		 */
		private var losingFocus : Boolean;
		/**
		 *  @private
     *  true if we're in the endEdit call.  Used to handle
     *  some timing issues with collection updates
		 */
		private var inEndEdit : Boolean;
		/**
		 *  @private
     *  true if we've disabled updates in the collection
		 */
		private var collectionUpdatesDisabled : Boolean;
		/**
		 *  @private
     *  The index of the column being sorted.
		 */
		var sortIndex : int;
		/**
		 *  @private
     *  The column being sorted.
		 */
		private var sortColumn : DataGridColumn;
		/**
		 *  @private
     *  The direction of the sort
		 */
		var sortDirection : String;
		/**
		 *  @private
     *  The index of the last column being sorted on.
		 */
		var lastSortIndex : int;
		/**
		 *  @private
		 */
		private var lastItemDown : IListItemRenderer;
		/**
		 *  @private
		 */
		private var lastItemFocused : DisplayObject;
		/**
		 *  @private
		 */
		private var displayWidth : Number;
		/**
		 *  @private
		 */
		private var lockedColumnWidth : Number;
		/**
		 *  @private
     *  The column that is being moved.
		 */
		var movingColumn : DataGridColumn;
		/**
		 *  @private
     *  The column that is being resized.
		 */
		var resizingColumn : DataGridColumn;
		/**
		 *  @private
     *  Columns with visible="true"
		 */
		private var displayableColumns : Array;
		/**
		 *  @private
     *  Whether we have auto-generated the set of columns
     *  Defaults to true so we'll run the auto-generation at init time if needed
		 */
		private var generatedColumns : Boolean;
		private var actualRowIndex : int;
		private var actualColIndex : int;
		private var actualContentHolder : ListBaseContentHolder;
		/**
		 *  @private
     *  Flag to indicate whether sorting is manual or programmatic.  If it's
     *  not manual, we try to draw the sort arrow on the right column header.
		 */
		private var manualSort : Boolean;
		/**
		 *  @private
		 */
		private var _imeMode : String;
		/**
		 *  @private
		 */
		private var _minColumnWidth : Number;
		/**
		 *  @private
		 */
		private var minColumnWidthInvalid : Boolean;
		/**
		 *  @private
		 */
		private var _columns : Array;
		/**
		 *  @private
     *  Storage for the draggableColumns property.
		 */
		private var _draggableColumns : Boolean;
		/**
		 *  A flag that indicates whether or not the user can edit
     *  items in the data provider.
     *  If <code>true</code>, the item renderers in the control are editable.
     *  The user can click on an item renderer to open an editor.
     *
     *  <p>You can turn off editing for individual columns of the
     *  DataGrid control using the <code>DataGridColumn.editable</code> property,
     *  or by handling the <code>itemEditBeginning</code> and
     *  <code>itemEditBegin</code> events</p>
     *
     *  @default false
		 */
		public var editable : Boolean;
		/**
		 *  @private
		 */
		private var bEditedItemPositionChanged : Boolean;
		/**
		 *  @private
     *  undefined means we've processed it
     *  null means don't put up an editor
     *  {} is the coordinates for the editor
		 */
		private var _proposedEditedItemPosition : *;
		/**
		 *  @private
     *  the last editedItemPosition and the last
     *  position where editing was attempted if editing
     *  was cancelled.  We restore editing
     *  to this point if we get focus from the TAB key
		 */
		private var lastEditedItemPosition : *;
		/**
		 *  @private
		 */
		private var _editedItemPosition : Object;
		/**
		 *  @private
		 */
		private var itemEditorPositionChanged : Boolean;
		/**
		 *  A flag that indicates whether the user can change the size of the
     *  columns.
     *  If <code>true</code>, the user can stretch or shrink the columns of 
     *  the DataGrid control by dragging the grid lines between the header cells.
     *  If <code>true</code>, individual columns must also have their 
     *  <code>resizable</code> properties set to <code>false</code> to 
     *  prevent the user from resizing a particular column.  
     *
     *  @default true
		 */
		public var resizableColumns : Boolean;
		/**
		 *  A flag that indicates whether the user can sort the data provider items
     *  by clicking on a column header cell.
     *  If <code>true</code>, the user can sort the data provider items by
     *  clicking on a column header cell. 
     *  The <code>DataGridColumn.dataField</code> property of the column
     *  or the <code>DataGridColumn.sortCompareFunction</code> property 
     *  of the column is used as the sort field.  
     *  If a column is clicked more than once
     *  the sort alternates between ascending and descending order.
     *  If <code>true</code>, individual columns can be made to not respond
     *  to a click on a header by setting the column's <code>sortable</code>
     *  property to <code>false</code>.
     *
     *  <p>When a user releases the mouse button over a header cell, the DataGrid
     *  control dispatches a <code>headerRelease</code> event if both
     *  this property and the column's sortable property are <code>true</code>.  
     *  If no handler calls the <code>preventDefault()</code> method on the event, the 
     *  DataGrid sorts using that column's <code>DataGridColumn.dataField</code> or  
     *  <code>DataGridColumn.sortCompareFunction</code> properties.</p>
     * 
     *  @default true
     *
     *  @see mx.controls.dataGridClasses.DataGridColumn#dataField
     *  @see mx.controls.dataGridClasses.DataGridColumn#sortCompareFunction
		 */
		public var sortableColumns : Boolean;
		private var _headerWordWrapPresent : Boolean;
		private var _originalExplicitHeaderHeight : Boolean;
		private var _originalHeaderHeight : Number;
		private var _focusPane : Sprite;
		var lockedColumnDropIndicator : IFlexDisplayObject;

		/**
		 *  A reference to the item renderer
     *  in the DataGrid control whose item is currently being edited.
     *
     *  <p>From within an event listener for the <code>itemEditBegin</code>
     *  and <code>itemEditEnd</code> events,
     *  you can access the current value of the item being edited
     *  using the <code>editedItemRenderer.data</code> property.</p>
		 */
		public function get editedItemRenderer () : IListItemRenderer;

		/**
		 *  @private
     *  The baselinePosition of a DataGrid is calculated
     *  for its first column header.
     *  If the headers aren't shown, it is calculated as for List.
		 */
		public function get baselinePosition () : Number;

		/**
		 *  @private
     *  Number of columns that can be displayed.
     *  Some may be offscreen depending on horizontalScrollPolicy
     *  and the width of the DataGrid.
		 */
		public function get columnCount () : int;

		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function set headerHeight (value:Number) : void;

		/**
		 *  The offset into the content from the left edge. 
     *  This can be a pixel offset in some subclasses or some other metric 
     *  like the number of columns in a DataGrid control. 
     *
     *  The DataGrid scrolls by columns so the value of the 
     *  <code>horizontalScrollPosition</code> property is always
     *  in the range of 0 to the index of the columns
     *  that will make the last column visible.  This is different from the
     *  List control that scrolls by pixels.  The DataGrid control always aligns the left edge
     *  of a column with the left edge of the DataGrid control.
		 */
		public function set horizontalScrollPosition (value:Number) : void;

		/**
		 *  @private
     *  Accomodates ScrollPolicy.AUTO.
     *  Makes sure column widths stay in synch.
     *
     *  @param policy on, off, or auto
		 */
		public function set horizontalScrollPolicy (value:String) : void;

		/**
		 *  @private
		 */
		public function set verticalScrollPosition (value:Number) : void;

		/**
		 *  Specifies the IME (input method editor) mode.
     *  The IME enables users to enter text in Chinese, Japanese, and Korean.
     *  Flex sets the specified IME mode when the control gets the focus,
     *  and sets it back to the previous value when the control loses the focus.
     *
     * <p>The flash.system.IMEConversionMode class defines constants for the
     *  valid values for this property.
     *  You can also specify <code>null</code> to specify no IME.</p>
     *
     *  @see flash.system.IMEConversionMode
     *
     *  @default null
		 */
		public function get imeMode () : String;
		/**
		 *  @private
		 */
		public function set imeMode (value:String) : void;

		/**
		 *  @private
     * 
     *  Defer creations of the class factory
     *  to give a chance for the moduleFactory to be set.
		 */
		public function get itemRenderer () : IFactory;

		/**
		 *  The minimum width of the columns, in pixels.  If not NaN,
     *  the DataGrid control applies this value as the minimum width for
     *  all columns.  Otherwise, individual columns can have
     *  their own minimum widths.
     *  
     *  @default NaN
		 */
		public function get minColumnWidth () : Number;
		/**
		 *  @private
		 */
		public function set minColumnWidth (value:Number) : void;

		/**
		 *  An array of DataGridColumn objects, one for each column that
     *  can be displayed.  If not explicitly set, the DataGrid control 
     *  attempts to examine the first data provider item to determine the
     *  set of properties and display those properties in alphabetic
     *  order.
     *
     *  <p>If you want to change the set of columns, you must get this array,
     *  make modifications to the columns and order of columns in the array,
     *  and then assign the new array to the columns property.  This is because
     *  the DataGrid control returned a new copy of the array of columns and therefore
     *  did not notice the changes.</p>
		 */
		public function get columns () : Array;
		/**
		 *  @private
		 */
		public function set columns (value:Array) : void;

		/**
		 *  A flag that indicates whether the user is allowed to reorder columns.
     *  If <code>true</code>, the user can reorder the columns
     *  of the DataGrid control by dragging the header cells.
     *
     *  @default true
		 */
		public function get draggableColumns () : Boolean;
		/**
		 *  @private
		 */
		public function set draggableColumns (value:Boolean) : void;

		/**
		 *  The column and row index of the item renderer for the
     *  data provider item being edited, if any.
     *
     *  <p>This Object has two fields, <code>columnIndex</code> and 
     *  <code>rowIndex</code>,
     *  the zero-based column and row indexes of the item.
     *  For example: {columnIndex:2, rowIndex:3}</p>
     *
     *  <p>Setting this property scrolls the item into view and
     *  dispatches the <code>itemEditBegin</code> event to
     *  open an item editor on the specified item renderer.</p>
     *
     *  @default null
		 */
		public function get editedItemPosition () : Object;
		/**
		 *  @private
		 */
		public function set editedItemPosition (value:Object) : void;

		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;

		/**
		 *  @private
		 */
		protected function get dragImage () : IUIComponent;

		function get vScrollBar () : ScrollBar;

		/**
		 *  diagnostics
		 */
		function get rendererArray () : Array;

		/**
		 *  diagnostics
		 */
		function get sortArrow () : IFlexDisplayObject;

		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;

		/**
		 *  Constructor.
		 */
		public function DataGrid ();

		/**
		 *  @private
     *
		 */
		protected function createChildren () : void;

		/**
		 *  @private
		 */
		public function invalidateDisplayList () : void;

		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;

		/**
		 *  @private
     *  Measures the DataGrid based on its contents,
     *  summing the total of the visible column widths.
		 */
		protected function measure () : void;

		/**
		 *  @private
     *  Sizes and positions the column headers, columns, and items based on the
     *  size of the DataGrid.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		protected function makeRowsAndColumns (left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0) : Point;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  @private
     *  Instead of measuring the items, we measure the visible columns instead.
		 */
		public function measureWidthOfItems (index:int = -1, count:int = 0) : Number;

		/**
		 *  @private
		 */
		function setupRendererFromData (c:DataGridColumn, item:IListItemRenderer, data:Object) : void;

		/**
		 *  @private
		 */
		public function measureHeightOfItems (index:int = -1, count:int = 0) : Number;

		/**
		 *  @private
		 */
		function measureHeightOfItemsUptoMaxHeight (index:int = -1, count:int = 0, maxHeight:Number = -1) : Number;

		/**
		 *  @private
		 */
		function calculateHeaderHeight () : Number;

		/**
		 *  @private
		 */
		protected function calculateRowHeight (data:Object, hh:Number, skipVisible:Boolean = false) : Number;

		/**
		 *  @private
		 */
		protected function scrollHandler (event:Event) : void;

		private function displayingPartialRow () : Boolean;

		/**
		 *  @private
		 */
		protected function configureScrollBars () : void;

		/**
		 *  @private
     *  Makes verticalScrollPosition smaller until it is 0 or there
     *  are no empty rows.  This is needed if we're scrolled to the
     *  bottom and something is deleted or the rows resize so more
     *  rows can be shown.
		 */
		private function adjustVerticalScrollPositionDownward (rowCount:int) : Boolean;

		/**
		 *  @private
		 */
		public function calculateDropIndex (event:DragEvent = null) : int;

		/**
		 *  @private
		 */
		protected function drawRowBackgrounds () : void;

		/**
		 *  @private
		 */
		protected function drawRowGraphics (contentHolder:ListBaseContentHolder) : void;

		/**
		 *  @private
		 */
		protected function mouseEventToItemRenderer (event:MouseEvent) : IListItemRenderer;

		/**
		 *  @private
     *  Move a column to a new position in the columns array, shifting all
     *  other columns left or right and updating the sortIndex and
     *  lastSortIndex variables accordingly.
		 */
		function shiftColumns (oldIndex:int, newIndex:int, trigger:Event = null) : void;

		/**
		 *  @private
     *  Searches the iterator to determine columns.
		 */
		private function generateCols () : void;

		/**
		 *  @private
		 */
		private function generateColumnsPendingResultHandler (data:Object, info:ListBaseSeekPending) : void;

		/**
		 *  @private
		 */
		private function calculateColumnSizes () : void;

		/**
		 *  @private
     *  If there is no horizontal scroll bar, changes the display width of other columns when
     *  one column's width is changed.
     *  @param col column whose width is changed
     *  @param w width of column
		 */
		function resizeColumn (col:int, w:Number) : void;

		/**
		 *  Draws a row background 
     *  at the position and height specified using the
     *  color specified.  This implementation creates a Shape as a
     *  child of the input Sprite and fills it with the appropriate color.
     *  This method also uses the <code>backgroundAlpha</code> style property 
     *  setting to determine the transparency of the background color.
     * 
     *  @param s A Sprite that will contain a display object
     *  that contains the graphics for that row.
     *
     *  @param rowIndex The row's index in the set of displayed rows.  The
     *  header does not count, the top most visible row has a row index of 0.
     *  This is used to keep track of the objects used for drawing
     *  backgrounds so a particular row can re-use the same display object
     *  even though the index of the item that row is rendering has changed.
     *
     *  @param y The suggested y position for the background
     * 
     *  @param height The suggested height for the indicator
     * 
     *  @param color The suggested color for the indicator
     * 
     *  @param dataIndex The index of the item for that row in the
     *  data provider.  This can be used to color the 10th item differently
     *  for example.
		 */
		protected function drawRowBackground (s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int) : void;

		/**
		 *  Draws a column background for a column with the suggested color.
     *  This implementation creates a Shape as a
     *  child of the input Sprite and fills it with the appropriate color.
     *
     *  @param s A Sprite that will contain a display object
     *  that contains the graphics for that column.
     *
     *  @param columnIndex The column's index in the set of displayed columns.  
     *  The left most visible column has a column index of 0.
     *  This is used to keep track of the objects used for drawing
     *  backgrounds so a particular column can re-use the same display object
     *  even though the index of the DataGridColumn for that column has changed.
     *
     *  @param color The suggested color for the indicator
     * 
     *  @param column The column of the DataGrid control that you are drawing the background for.
		 */
		protected function drawColumnBackground (s:Sprite, columnIndex:int, color:uint, column:DataGridColumn) : void;

		/**
		 *  Creates and sizes the horizontalSeparator skins. If none have been specified, then draws the lines using
     *  drawHorizontalLine().
		 */
		private function drawHorizontalSeparator (s:Sprite, rowIndex:int, color:uint, y:Number, useLockedSeparator:Boolean = false) : void;

		/**
		 *  Draws a line between rows.  This implementation draws a line
     *  directly into the given Sprite.  The Sprite has been cleared
     *  before lines are drawn into it.
     *
     *  @param s A Sprite that will contain a display object
     *  that contains the graphics for that row.
     *
     *  @param rowIndex The row's index in the set of displayed rows.  The
     *  header does not count, the top most visible row has a row index of 0.
     *  This is used to keep track of the objects used for drawing
     *  backgrounds so a particular row can re-use the same display object
     *  even though the index of the item that row is rendering has changed.
     *
     *  @param color The suggested color for the indicator
     * 
     *  @param y The suggested y position for the background
		 */
		protected function drawHorizontalLine (s:Sprite, rowIndex:int, color:uint, y:Number) : void;

		/**
		 *  Creates and sizes the verticalSeparator skins. If none have been specified, then draws the lines using
     *  drawVerticalLine().
		 */
		private function drawVerticalSeparator (s:Sprite, colIndex:int, color:uint, x:Number, useLockedSeparator:Boolean = false) : void;

		/**
		 *  Draw lines between columns.  This implementation draws a line
     *  directly into the given Sprite.  The Sprite has been cleared
     *  before lines are drawn into it.
     *
     *  @param s A Sprite that will contain a display object
     *  that contains the graphics for that row.
     *
     *  @param columnIndex The column's index in the set of displayed columns.  
     *  The left most visible column has a column index of 0.
     *
     *  @param color The suggested color for the indicator
     * 
     *  @param x The suggested x position for the background
		 */
		protected function drawVerticalLine (s:Sprite, colIndex:int, color:uint, x:Number) : void;

		/**
		 *  Draw lines between columns, and column backgrounds.
     *  This implementation calls the <code>drawHorizontalLine()</code>, 
     *  <code>drawVerticalLine()</code>,
     *  and <code>drawColumnBackground()</code> methods as needed.  
     *  It creates a
     *  Sprite that contains all of these graphics and adds it as a
     *  child of the listContent at the front of the z-order.
		 */
		protected function drawLinesAndColumnBackgrounds () : void;

		/**
		 *  Draw lines between columns, and column backgrounds.
     *  This implementation calls the <code>drawHorizontalLine()</code>, 
     *  <code>drawVerticalLine()</code>,
     *  and <code>drawColumnBackground()</code> methods as needed.  
     *  It creates a
     *  Sprite that contains all of these graphics and adds it as a
     *  child of the listContent at the front of the z-order.
     * 
     *  @param contentHolder A container of all of the DataGrid's item renderers and item editors.
     *  @param visibleColumns An array of the visible columns in the DataGrid.
     *  @param separators An object that defines the top, bottom, left, and right lines that separate the columns and rows.
		 */
		protected function drawLinesAndColumnGraphics (contentHolder:ListBaseContentHolder, visibleColumns:Array, separators:Object) : void;

		function _drawHeaderBackground (headerBG:UIComponent) : void;

		/**
		 *  Draws the background of the headers into the given 
     *  UIComponent.  The graphics drawn may be scaled horizontally
     *  if the component's width changes or this method will be
     *  called again to redraw at a different width and/or height
     *
     *  @param headerBG A UIComponent that will contain the header
     *  background graphics.
		 */
		protected function drawHeaderBackground (headerBG:UIComponent) : void;

		function _clearSeparators () : void;

		/**
		 *  Removes column header separators that the user normally uses
     *  to resize columns.
		 */
		protected function clearSeparators () : void;

		function _drawSeparators () : void;

		/**
		 *  Creates and displays the column header separators that the user 
     *  normally uses to resize columns.  This implementation uses
     *  the same Sprite as the lines and column backgrounds and adds
     *  instances of the <code>headerSeparatorSkin</code> and attaches mouse
     *  listeners to them in order to know when the user wants
     *  to resize a column.
		 */
		protected function drawSeparators () : void;

		/**
		 *  @private
     *  Update sortIndex and sortDirection based on sort info availabled in
     *  underlying data provider.
		 */
		private function updateSortIndexAndDirection () : void;

		function _placeSortArrow () : void;

		/**
		 *  Draws the sort arrow graphic on the column that is the current sort key.
     *  This implementation creates or reuses an instance of the skin specified
     *  by <code>sortArrowSkin</code> style property and places 
     *  it in the appropriate column header.  It
     *  also shrinks the size of the column header if the text in the header
     *  would be obscured by the sort arrow.
		 */
		protected function placeSortArrow () : void;

		/**
		 *  @private
		 */
		private function sortByColumn (index:int) : void;

		/**
		 *  @private
		 */
		private function setEditedItemPosition (coord:Object) : void;

		/**
		 *  @private
     *  focus an item renderer in the grid - harder than it looks
		 */
		private function commitEditedItemPosition (coord:Object) : void;

		private function scrollToEditedItem (rowIndex:int, colIndex:int) : void;

		/**
		 *  Creates the item editor for the item renderer at the
     *  <code>editedItemPosition</code> using the editor
     *  specified by the <code>itemEditor</code> property.
     *
     *  <p>This method sets the editor instance as the 
     *  <code>itemEditorInstance</code> property.</p>
     *
     *  <p>You may only call this method from within the event listener
     *  for the <code>itemEditBegin</code> event. 
     *  To create an editor at other times, set the
     *  <code>editedItemPosition</code> property to generate 
     *  the <code>itemEditBegin</code> event.</p>
     *
     *  @param colIndex The column index in the data provider of the item to be edited.
     *
     *  @param rowIndex The row index in the data provider of the item to be edited.
		 */
		public function createItemEditor (colIndex:int, rowIndex:int) : void;

		/**
		 *  @private
     *  Determines the next item renderer to navigate to using the Tab key.
     *  If the item renderer to be focused falls out of range (the end or beginning
     *  of the grid) then move focus outside the grid.
		 */
		private function findNextItemRenderer (shiftKey:Boolean) : Boolean;

		/**
		 *  This method closes an item editor currently open on an item renderer. 
     *  You typically only call this method from within the event listener 
     *  for the <code>itemEditEnd</code> event, after
     *  you have already called the <code>preventDefault()</code> method to 
     *  prevent the default event listener from executing.
		 */
		public function destroyItemEditor () : void;

		/**
		 *  @private
     *  dispatch an ITEM_EDIT_BEGINNING event;
		 */
		private function beginningEdit (columnIndex:int, rowIndex:int, itemRenderer:IListItemRenderer = null) : void;

		/**
		 *  @private
     *  When the user finished editing an item, this method is called.
     *  It dispatches the DataGridEvent.ITEM_EDIT_END event to start the process
     *  of copying the edited data from
     *  the itemEditorInstance to the data provider and hiding the itemEditorInstance.
     *  returns true if nobody called preventDefault.
		 */
		private function endEdit (reason:String) : Boolean;

		/**
		 *  Determines whether to allow editing of a dataprovider item on a per-row basis. 
     *  The default implementation of this method only checks the <code>editable</code> property 
     *  of the DataGrid and returns <code>false</code> if <code>editable</code> is <code>false</code>
     *  or if the dataprovider item is <code>null</code>.
     * 
     *  <p>This method can be overridden to allow fine-grained control of which dataprovider items 
     *  are editable. For example, if you want to disallow editing of grouping rows or summary rows
     *  you would override this method with custom logic to this behavior.</p>
     *
     *  @param data The data provider item. The default implementation of this method returns 
     *  <code>false</code> if the data object is <code>null</code>.
     * 
     *  @return The default behavior is to return <code>true</code> if the DataGrid's <code>editable</code> property is 
     *  <code>true</code> and the data object is not <code>null</code>.
		 */
		public function isItemEditable (data:Object) : Boolean;

		/**
		 *  @private
		 */
		function columnRendererChanged (c:DataGridColumn) : void;

		/**
		 *  @private
     *  Catches any events from the model. Optimized for editing one item.
     *  Creates columns when there are none. Inherited from list.
     *  @param eventObj
		 */
		protected function collectionChangeHandler (event:Event) : void;

		/**
		 *  @private
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  when the grid gets focus, focus an item renderer
		 */
		protected function focusInHandler (event:FocusEvent) : void;

		/**
		 *  @private
     *  when the grid loses focus, close the editor
		 */
		protected function focusOutHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		private function deactivateHandler (event:Event) : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
     *  used by ListBase.findString.  Shouldn't be used elsewhere
     *  because column's itemToLabel is preferred
		 */
		public function itemToLabel (data:Object) : String;

		/**
		 *  @private
		 */
		private function editorMouseDownHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function editorKeyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		private function editorStageResizeHandler (event:Event) : void;

		/**
		 *  @private
     *  find the next item renderer down from the currently edited item renderer, and focus it.
		 */
		private function findNextEnterItemRenderer (event:KeyboardEvent) : void;

		/**
		 *  @private
     *  This gets called when the tab key is hit.
		 */
		private function mouseFocusChangeHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  This gets called when the tab key is hit.
		 */
		private function keyFocusChangeHandler (event:FocusEvent) : void;

		/**
		 *  @private
     *  Hides the itemEditorInstance.
		 */
		private function itemEditorFocusOutHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		private function itemEditorItemEditBeginningHandler (event:DataGridEvent) : void;

		/**
		 *  @private
     *  focus an item renderer in the grid - harder than it looks
		 */
		private function itemEditorItemEditBeginHandler (event:DataGridEvent) : void;

		/**
		 *  @private
		 */
		private function itemEditorItemEditEndHandler (event:DataGridEvent) : void;

		protected function isComplexColumn (property:String) : Boolean;

		protected function deriveComplexFieldReference (data:Object, complexFieldNameComponents:Array) : Object;

		protected function getCurrentDataValue (data:Object, property:String) : String;

		protected function setNewValue (data:Object, property:String, value:Object, columnIndex:int) : Boolean;

		/**
		 *  @private
		 */
		private function headerReleaseHandler (event:DataGridEvent) : void;

		/**
		 *  @private
		 */
		protected function mouseWheelHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  if some drags from the same row as an editor we can be left
     *  with updates disabled
		 */
		protected function dragStartHandler (event:DragEvent) : void;

		/**
		 *  Called from the <code>updateDisplayList()</code> method to adjust the size and position of
     *  listContent.
     *  
     *  @param unscaledWidth The width of the listContent. This value ignores changes to the width from external components or settings.
     *  @param unscaledHeight The height of the listContent. This value ignores changes to the height from external components or settings.
		 */
		protected function adjustListContent (unscaledWidth:Number = -1, unscaledHeight:Number = -1) : void;

		private function lockedRowSeekPendingResultHandler (data:Object, info:ListBaseSeekPending) : void;

		/**
		 *  @inheritDoc
		 */
		protected function scrollPositionToIndex (horizontalScrollPosition:int, verticalScrollPosition:int) : int;

		/**
		 *  @inheritDoc
		 */
		protected function scrollVertically (pos:int, deltaPos:int, scrollUp:Boolean) : void;

		/**
		 *  @private
		 */
		public function showDropFeedback (event:DragEvent) : void;

		/**
		 *  @private
		 */
		public function hideDropFeedback (event:DragEvent) : void;
	}
}
