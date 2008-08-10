/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.listClasses {
	import mx.core.ScrollControlBase;
	import mx.core.IDataRenderer;
	import mx.managers.IFocusManagerComponent;
	import mx.effects.IEffectTargetHost;
	import mx.core.IUIComponent;
	import flash.geom.Point;
	import mx.core.IFactory;
	import flash.display.Sprite;
	import mx.events.DragEvent;
	import flash.events.Event;
	import mx.events.EffectEvent;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import mx.events.CollectionEvent;
	public class ListBase extends ScrollControlBase implements IDataRenderer, IFocusManagerComponent, IListItemRenderer, IDropInListItemRenderer, IEffectTargetHost {
		/**
		 * A copy of the value normally stored in collection
		 *  used while running data changes effects. This value should be
		 *  null when a data change effect is not running.
		 */
		protected var actualCollection:ICollectionView;
		/**
		 * A copy of the value normally stored in iterator
		 *  used while running data changes effects.
		 */
		protected var actualIterator:IViewCursor;
		/**
		 * A flag that indicates whether drag-selection is enabled.
		 *  Drag-Selection is the ability to select an item by dragging
		 *  into it as opposed to normal selection where you can't have
		 *  the mouse button down when you mouse over the item you want
		 *  to select.  This feature is used in ComboBox dropdowns
		 *  to support pressing the mouse button when the mouse is over the
		 *  dropdown button then dragging the mouse into the dropdown to select
		 *  an item.
		 */
		public var allowDragSelection:Boolean = false;
		/**
		 * If false, renderers cannot invalidate size of List
		 */
		protected function set allowItemSizeChangeNotification(value:Boolean):void;
		/**
		 * A flag that indicates whether you can allow more than one item to be
		 *  selected at the same time.
		 *  If true, users can select multiple items.
		 *  There is no option to disallow discontiguous selection.
		 *  Standard complex selection options are always in effect
		 *  (shift-click, control-click).
		 */
		public function get allowMultipleSelection():Boolean;
		public function set allowMultipleSelection(value:Boolean):void;
		/**
		 * A bookmark to the item that is the anchor.  A bookmark allows the
		 *  component to quickly seek to a position in the collection of items.
		 *  This property is used when selecting a set of items between the anchor
		 *  and the caret or highlighted item, and when finding the selected item
		 *  after a Sort or Filter is applied.
		 */
		protected var anchorBookmark:CursorBookmark;
		/**
		 * The offset of the item in the data provider that is the selection
		 *  anchor point.
		 */
		protected var anchorIndex:int = -1;
		/**
		 * The effect that plays when changes occur in the data
		 *  provider for the control, set through the itemsChangeEffect
		 *  style.
		 */
		protected var cachedItemsChangeEffect:IEffect = null;
		/**
		 * A bookmark to the item under the caret.  A bookmark allows the
		 *  component to quickly seek to a position in the collection of items.
		 */
		protected var caretBookmark:CursorBookmark;
		/**
		 * The offset of the item in the data provider that is the selection
		 *  caret point.
		 */
		protected var caretIndex:int = -1;
		/**
		 * The DisplayObject that contains the graphics that indicate
		 *  which renderer is the caret.
		 */
		protected var caretIndicator:Sprite;
		/**
		 * The renderer for the item under the caret.  In the selection
		 *  model, there is an anchor, a caret and a highlighted item.  When
		 *  the mouse is being used for selection, the item under the mouse is
		 *  highlighted as the mouse rolls over the item.
		 *  When the mouse is clicked with no modifier keys (SHIFT or CTRL), the
		 *  set of selected items is cleared and the item under the highlight is
		 *  selected and becomes the anchor.  The caret is unused in mouse
		 *  selection.  If there is an anchor and another item is selected while
		 *  using the SHIFT key, the old set of selected items is cleared, and
		 *  all items between the item and the anchor are selected.  Clicking
		 *  items while using the CTRL key toggles the selection of individual
		 *  items and does not move the anchor.
		 */
		protected var caretItemRenderer:IListItemRenderer;
		/**
		 * The UID of the item under the caret.
		 */
		protected var caretUID:String;
		/**
		 * An ICollectionView that represents the data provider.
		 *  When you set the dataProvider property,
		 *  Flex wraps the data provider as necessary to
		 *  support the ICollectionView interface and
		 *  sets this property to the result.
		 *  The ListBase class then uses this property to access
		 *  data in the provider.
		 *  When you  get the dataProvider property,
		 *  Flex returns this value.
		 */
		protected var collection:ICollectionView;
		/**
		 * The number of columns to be displayed in a TileList control or items
		 *  in a HorizontalList control.
		 *  For the DataGrid it is the number of visible columns.
		 *  Note: Setting this property has no effect on a DataGrid control,
		 *  which bases the number of columns on the control width and the
		 *  individual column widths.
		 */
		public function get columnCount():int;
		public function set columnCount(value:int):void;
		/**
		 * The width of the control's columns.
		 *  This property is used by TileList and HorizontalList controls;
		 *  It has no effect on DataGrid controls, where you set the individual
		 *  DataGridColumn widths.
		 */
		public function get columnWidth():Number;
		public function set columnWidth(value:Number):void;
		/**
		 * The item in the data provider this component should render when
		 *  this component is used as an item renderer or item editor.
		 *  The list class sets this property on each renderer or editor
		 *  and the component displays the data.  ListBase-derived classes
		 *  support this property for complex situations like having a
		 *  List of DataGrids or a DataGrid where one column is a List.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * A flag that indicates that the a data change effect has
		 *  just completed.
		 *  The component usually responds by cleaning up various
		 *  internal data structures on the next
		 *  updateDisplayList() call.
		 */
		protected var dataEffectCompleted:Boolean = false;
		/**
		 * A dictionary mapping item renderers to the ItemWrappers
		 *  used to supply their data. Only applicable if a data
		 *  effect is running.
		 */
		protected var dataItemWrappersByRenderer:Dictionary;
		/**
		 * Set of data to be viewed.
		 *  This property lets you use most types of objects as data providers.
		 *  If you set the dataProvider property to an Array,
		 *  it will be converted to an ArrayCollection. If you set the property to
		 *  an XML object, it will be converted into an XMLListCollection with
		 *  only one item. If you set the property to an XMLList, it will be
		 *  converted to an XMLListCollection.
		 *  If you set the property to an object that implements the
		 *  IList or ICollectionView interface, the object will be used directly.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * Name of the field in the data provider items to display as the
		 *  data tip. By default, the list looks for a property named
		 *  label on each item and displays it.
		 *  However, if the data objects do not contain a label
		 *  property, you can set the dataTipField property to
		 *  use a different property in the data object. An example would be
		 *  "FullName" when viewing a
		 *  set of people's names retrieved from a database.
		 */
		public function get dataTipField():String;
		public function set dataTipField(value:String):void;
		/**
		 * User-supplied function to run on each item to determine its dataTip.
		 *  By default, the list looks for a property named label
		 *  on each data provider item and displays it.
		 *  However, some items do not have a label property
		 *  nor do they have another property that can be used for displaying
		 *  in the rows. An example is a data set that has lastName and firstName
		 *  fields, but you want to display full names. You can supply a
		 *  dataTipFunction that finds the appropriate
		 *  fields and return a displayable string. The
		 *  dataTipFunction is also good for handling formatting
		 *  and localization.
		 */
		public function get dataTipFunction():Function;
		public function set dataTipFunction(value:Function):void;
		/**
		 * The default number of columns to display.  This value
		 *  is used if the calculation for the number of
		 *  columns results in a value less than 1 when
		 *  trying to calculate the columnCount based on size or
		 *  content.
		 */
		protected var defaultColumnCount:int = 4;
		/**
		 * The default number of rows to display.  This value
		 *  is used  if the calculation for the number of
		 *  columns results in a value less than 1 when
		 *  trying to calculate the rowCount based on size or
		 *  content.
		 */
		protected var defaultRowCount:int = 4;
		/**
		 * A flag that indicates whether you can drag items out of
		 *  this control and drop them on other controls.
		 *  If true, dragging is enabled for the control.
		 *  If the dropEnabled property is also true,
		 *  you can drag items and drop them within this control
		 *  to reorder the items.
		 */
		public function get dragEnabled():Boolean;
		public function set dragEnabled(value:Boolean):void;
		/**
		 * Gets an instance of a class that displays the visuals
		 *  during a drag and drop operation.
		 */
		protected function get dragImage():IUIComponent;
		/**
		 * Gets the offset of the drag image for drag and drop.
		 */
		protected function get dragImageOffsets():Point;
		/**
		 * A flag that indicates whether items can be moved instead
		 *  of just copied from the control as part of a drag-and-drop
		 *  operation.
		 *  If true, and the dragEnabled property
		 *  is true, items can be moved.
		 *  Often the data provider cannot or should not have items removed
		 *  from it, so a MOVE operation should not be allowed during
		 *  drag-and-drop.
		 */
		public function get dragMoveEnabled():Boolean;
		public function set dragMoveEnabled(value:Boolean):void;
		/**
		 * A flag that indicates whether dragged items can be dropped onto the
		 *  control.
		 */
		public function get dropEnabled():Boolean;
		public function set dropEnabled(value:Boolean):void;
		/**
		 * The column count requested by explicitly setting the
		 *  columnCount property.
		 */
		protected var explicitColumnCount:int = -1;
		/**
		 * The column width requested by explicitly setting the
		 *  columnWidth.
		 */
		protected var explicitColumnWidth:Number;
		/**
		 * The row count requested by explicitly setting
		 *  rowCount.
		 */
		protected var explicitRowCount:int = -1;
		/**
		 * The row height requested by explicitly setting
		 *  rowHeight.
		 */
		protected var explicitRowHeight:Number;
		/**
		 * A map of item renderers by factory.
		 *  This property is a Dictionary indexed by itemRenderers
		 *  where the values are IFactory
		 */
		protected var factoryMap:Dictionary;
		/**
		 * A stack of unused item renderers.
		 *  Most list classes recycle renderers they've already created
		 *  as they scroll out of the displayable area; doing so
		 *  saves time during scrolling.
		 *  The recycled renderers are stored here.
		 */
		protected var freeItemRenderers:Array;
		/**
		 * A map of free item renderers by factory.
		 *  This property is a Dictionary indexed by factories
		 *  where the values are Dictionaries of itemRenderers
		 */
		protected var freeItemRenderersByFactory:Dictionary;
		/**
		 * The DisplayObject that contains the graphics that indicates
		 *  which renderer is highlighted.
		 */
		protected var highlightIndicator:Sprite;
		/**
		 * The renderer that is currently rolled over or under the caret.
		 */
		protected var highlightItemRenderer:IListItemRenderer;
		/**
		 * The UID of the item that is current rolled over or under the caret.
		 */
		protected var highlightUID:String;
		/**
		 * The name of the field in the data provider object that determines what to
		 *  display as the icon. By default, the list class does not try to display
		 *  icons with the text in the rows.  However, by specifying an icon
		 *  field, you can specify a graphic that is created and displayed as an
		 *  icon in the row.  This property is ignored by DataGrid.
		 */
		public function get iconField():String;
		public function set iconField(value:String):void;
		/**
		 * A user-supplied function to run on each item to determine its icon.
		 *  By default the list does not try to display icons with the text
		 *  in the rows.  However, by specifying an icon function, you can specify
		 *  a Class for a graphic that will be created and displayed as an icon
		 *  in the row.  This property is ignored by DataGrid.
		 */
		public function get iconFunction():Function;
		public function set iconFunction(value:Function):void;
		/**
		 * The custom item renderer for the control.
		 *  You can specify a drop-in, inline, or custom item renderer.
		 */
		public function get itemRenderer():IFactory;
		public function set itemRenderer(value:IFactory):void;
		/**
		 * A flag that indicates whether the columnWidth
		 *  and rowHeight properties need to be calculated.
		 *  This property is set if a style changes that can affect the
		 *  measurements of the renderer, or if the data provider is changed.
		 */
		protected var itemsNeedMeasurement:Boolean = true;
		/**
		 * A flag that indicates that the size of the renderers may have changed.
		 *  The component usually responds by re-applying the data items to all of
		 *  the renderers on the next updateDisplayList() call.
		 *  There is an assumption that re-applying the items will invalidate the
		 *  item renderers and cause them to re-measure.
		 */
		protected var itemsSizeChanged:Boolean = false;
		/**
		 * The main IViewCursor used to fetch items from the
		 *  data provider and pass the items to the renderers.
		 *  At the end of any sequence of code, it must always
		 *  be positioned at the topmost visible item being displayed.
		 */
		protected var iterator:IViewCursor;
		/**
		 * A flag that indicates that a page fault as occurred and that
		 *  the iterator's position is not valid (not positioned at the topmost
		 *  item being displayed).
		 *  If the component gets a page fault (an ItemPending error),
		 *  it sets iteratorValid to false.  Code that
		 *  normally handles the rendering of items checks this flag and does not
		 *  run until the page of data comes in from the server.
		 */
		protected var iteratorValid:Boolean = true;
		/**
		 * A flag that indicates if keyboard selection was interrupted by
		 *  a page fault.  The component responds by suspending the rendering
		 *  of items until the page of data arrives.
		 *  The finishKeySelection() method will be called
		 *  when the paged data arrives
		 */
		protected var keySelectionPending:Boolean = false;
		/**
		 * The name of the field in the data provider items to display as the label.
		 *  By default the list looks for a property named label
		 *  on each item and displays it.
		 *  However, if the data objects do not contain a label
		 *  property, you can set the labelField property to
		 *  use a different property in the data object. An example would be
		 *  "FullName" when viewing a set of people names fetched from a database.
		 */
		public function get labelField():String;
		public function set labelField(value:String):void;
		/**
		 * A user-supplied function to run on each item to determine its label.
		 *  By default, the list looks for a property named label
		 *  on each data provider item and displays it.
		 *  However, some data sets do not have a label property
		 *  nor do they have another property that can be used for displaying.
		 *  An example is a data set that has lastName and firstName fields
		 *  but you want to display full names.
		 */
		public function get labelFunction():Function;
		public function set labelFunction(value:Function):void;
		/**
		 * The most recently calculated index where the drag item
		 *  should be added to the drop target.
		 */
		protected var lastDropIndex:int;
		/**
		 * The most recent seek that caused a page fault.
		 *  If there are multiple page faults, only the most recent one
		 *  is of interest, as that is where to position the iterator
		 *  and start rendering rows again.
		 */
		protected var lastSeekPending:ListBaseSeekPending;
		/**
		 * An internal display object that parents all of the item renderers,
		 *  selection and highlighting indicators and other supporting graphics.
		 *  This is roughly equivalent to the contentPane in the
		 *  Container class, and is used for managing scrolling.
		 */
		protected var listContent:ListBaseContentHolder;
		/**
		 * The set of styles to pass from the ListBase to the listContent.
		 */
		protected function get listContentStyleFilters():Object;
		/**
		 * When a component is used as a drop-in item renderer or drop-in
		 *  item editor, Flex initializes the listData property
		 *  of the component with the additional data from the list control.
		 *  The component can then use the listData property
		 *  and the data property to display the appropriate
		 *  information as a drop-in item renderer or drop-in item editor.
		 */
		public function get listData():BaseListData;
		public function set listData(value:BaseListData):void;
		/**
		 * An Array of Arrays that contains
		 *  the itemRenderer instances that render each data provider item.
		 *  This is a two-dimensional row major array
		 *  (array of rows that are arrays of columns).
		 */
		protected function get listItems():Array;
		/**
		 * A flag that indicates whether menu-style selection
		 *  should be used.
		 *  In a Menu, dragging from
		 *  one renderer into another selects the new one
		 *  and un-selects the old.
		 */
		public var menuSelectionMode:Boolean = false;
		/**
		 * The collection view that temporarily preserves previous
		 *  data provider state to facilitate running data change effects.
		 */
		protected var modifiedCollectionView:ModifiedCollectionView;
		/**
		 * The custom item renderer for the control.
		 *  You can specify a drop-in, inline, or custom item renderer.
		 */
		public function get nullItemRenderer():IFactory;
		public function set nullItemRenderer(value:IFactory):void;
		/**
		 * The target number of extra columns of item renderers used in the
		 *  layout of the control. Half of these columns are created to
		 *  the left of the visible onscreen columns; half are created
		 *  to the right.
		 *  Typically this property will be set indirectly when you set the
		 *  offscreenExtraRowsOrColumns property.
		 */
		protected var offscreenExtraColumns:int = 0;
		/**
		 * The number of offscreen columns currently to the left of the
		 *  leftmost visible column.
		 *  This value will be <= offscreenExtraColumns / 2.
		 */
		protected var offscreenExtraColumnsLeft:int = 0;
		/**
		 * The number of offscreen columns currently to the right of the
		 *  right visible column.
		 *  This value will be <= offscreenExtraColumns / 2.
		 */
		protected var offscreenExtraColumnsRight:int = 0;
		/**
		 * The target number of extra rows of item renderers to be used in
		 *  the layout of the control. Half of these rows are created
		 *  above the visible onscreen rows; half are created below.
		 *  Typically this property is set indirectly when you set the
		 *  offscreenExtraRowsOrColumns property.
		 */
		protected var offscreenExtraRows:int = 0;
		/**
		 * The number of offscreen rows currently below the bottom visible
		 *  item renderer. This value will be <= offscreenExtraRows / 2.
		 */
		protected var offscreenExtraRowsBottom:int = 0;
		/**
		 * The target number of extra rows or columns of item renderers to be used
		 *  in the layout of the control. Half of these rows/columns are created
		 *  above or to the left of the visible onscreen rows/columns;
		 *  half are created below or to the right.
		 */
		public function get offscreenExtraRowsOrColumns():int;
		public function set offscreenExtraRowsOrColumns(value:int):void;
		/**
		 * A flag indicating that the number of offscreen rows or columns
		 *  may have changed.
		 */
		protected var offscreenExtraRowsOrColumnsChanged:Boolean = false;
		/**
		 * The number of offscreen rows currently above the topmost visible
		 *  row. This value will be <= offscreenExtraRows / 2.
		 *  It is used when computing the relationship of listItems and
		 *  rowInfo Arrays to items in the data provider (in conjunction
		 *  with verticalScrollPosition property).
		 */
		protected var offscreenExtraRowsTop:int = 0;
		/**
		 * A flag that indicates that the renderer changed.
		 *  The component usually responds by destroying all existing renderers
		 *  and redrawing all of the renderers on the next
		 *  updateDisplayList() call.
		 */
		protected var rendererChanged:Boolean = false;
		/**
		 * A hash map of currently unused item renderers that may be
		 *  used again in the near future. Used when running data effects.
		 *  The map is indexed by the data provider item's UID.
		 */
		protected var reservedItemRenderers:Object;
		/**
		 * Number of rows to be displayed.
		 *  If the height of the component has been explicitly set,
		 *  this property might not have any effect.
		 */
		public function get rowCount():int;
		public function set rowCount(value:int):void;
		/**
		 * The height of the rows in pixels.
		 *  Unless the variableRowHeight property is
		 *  true, all rows are the same height.
		 *  If not specified, the row height is based on
		 *  the font size and other properties of the renderer.
		 */
		public function get rowHeight():Number;
		public function set rowHeight(value:Number):void;
		/**
		 * An array of ListRowInfo objects that cache row heights and
		 *  other tracking information for the rows in listItems.
		 */
		protected function get rowInfo():Array;
		/**
		 * A hash map of item renderers to their respective ListRowInfo object.
		 *  The ListRowInfo object is indexed by the DisplayObject name of the
		 *  item renderer.
		 */
		protected var rowMap:Object;
		/**
		 * A flag that indicates if a data effect should be initiated
		 *  the next time the display is updated.
		 */
		protected var runDataEffectNextUpdate:Boolean = false;
		/**
		 * A flag indicating if a data change effect is currently running
		 */
		protected var runningDataEffect:Boolean = false;
		/**
		 * A flag that indicates whether the list shows selected items
		 *  as selected.
		 *  If true, the control supports selection.
		 *  The Menu class, which subclasses ListBase, sets this property to
		 *  false by default, because it doesn't show the chosen
		 *  menu item as selected.
		 */
		public function get selectable():Boolean;
		public function set selectable(value:Boolean):void;
		/**
		 * A hash table of ListBaseSelectionData objects that track which
		 *  items are currently selected.  The table is indexed by the UID
		 *  of the items.
		 */
		protected var selectedData:Object;
		/**
		 * The index in the data provider of the selected item.
		 */
		public function get selectedIndex():int;
		public function set selectedIndex(value:int):void;
		/**
		 * An array of indices in the data provider of the selected items.  The
		 *  items are in the reverse order that the user selected the items.
		 */
		public function get selectedIndices():Array;
		public function set selectedIndices(value:Array):void;
		/**
		 * A reference to the selected item in the data provider.
		 */
		public function get selectedItem():Object;
		public function set selectedItem(value:Object):void;
		/**
		 * An array of references to the selected items in the data provider.  The
		 *  items are in the reverse order that the user selected the items.
		 */
		public function get selectedItems():Array;
		public function set selectedItems(value:Array):void;
		/**
		 * A hash table of selection indicators.  This table allows the component
		 *  to quickly find and remove the indicators when the set of selected
		 *  items is cleared.  The table is indexed by the item's UID.
		 */
		protected var selectionIndicators:Object;
		/**
		 * The layer in listContent where all selection
		 *  and highlight indicators are drawn.
		 */
		protected var selectionLayer:Sprite;
		/**
		 * A hash table of selection tweens.  This allows the component to
		 *  quickly find and clean up any tweens in progress if the set
		 *  of selected items is cleared.  The table is indexed by the item's UID.
		 */
		protected var selectionTweens:Object;
		/**
		 * A flag that indicates whether to show caret.
		 *  This property is usually set
		 *  to false when mouse activity is detected and set back to
		 *  true when the keyboard is used for selection.
		 */
		protected var showCaret:Boolean;
		/**
		 * A flag that indicates whether dataTips are displayed for text in the rows.
		 *  If true, dataTips are displayed.  DataTips
		 *  are tooltips designed to show the text that is too long for the row.
		 *  If you set a dataTipFunction, dataTips are shown regardless of whether the
		 *  text is too long for the row.
		 */
		public function get showDataTips():Boolean;
		public function set showDataTips(value:Boolean):void;
		/**
		 * A hash map of item renderers that are not subject
		 *  to the layout algorithms of the list
		 */
		protected var unconstrainedRenderers:Dictionary;
		/**
		 * The selected item, or the data or label field of the selected item.
		 *  If the selected item is a Number or String
		 *  the value is the item.  If the item is an object, the value is
		 *  the data property if it exists, or the label property if it exists.
		 */
		public function get value():Object;
		/**
		 * A flag that indicates whether the individual rows can have different
		 *  height.  This property is ignored by TileList and HorizontalList.
		 *  If true, individual rows can have different height values.
		 */
		public function get variableRowHeight():Boolean;
		public function set variableRowHeight(value:Boolean):void;
		/**
		 * A hash table of data provider item renderers currently in view.
		 *  The table is indexed by the data provider item's UID and is used
		 *  to quickly get the renderer used to display a particular item.
		 */
		protected function get visibleData():Object;
		/**
		 * A flag that indicates whether text in the row should be word wrapped.
		 *  If true, enables word wrapping for text in the rows.
		 *  Only takes effect if the variableRowHeight property is also
		 *  true.
		 */
		public function get wordWrap():Boolean;
		public function set wordWrap(value:Boolean):void;
		/**
		 * A flag that indicates whether the value of the wordWrap
		 *  property has changed since the last time the display list was updated.
		 *  This property is set when you change the wordWrap
		 *  property value, and is reset
		 *  to false by the updateDisplayList() method.
		 *  The component usually responds by re-applying the data items to all of
		 *  the renderers on the next updateDisplayList() call.
		 *  This is different from itemsSizeChanged because it further indicates
		 *  that re-applying the data items to the renderers may not invalidate them
		 *  since the only thing that changed was whether or not the renderer should
		 *  factor in wordWrap into its size calculations
		 */
		protected var wordWrapChanged:Boolean = false;
		/**
		 * Constructor.
		 */
		public function ListBase();
		/**
		 * Adds an item renderer if a data change effect is running.
		 *  The item renderer should correspond to a recently added
		 *  data item in the data provider's collection that isn't
		 *  yet being displayed.
		 *
		 * @param target            <Object> The item renderer to add to the control's layout.
		 */
		public function addDataEffectItem(target:Object):void;
		/**
		 * Adds the selected items to the DragSource object as part of a
		 *  drag-and-drop operation.
		 *  Override this method to add other data to the drag source.
		 *
		 * @param ds                <Object> The DragSource object to which to add the data.
		 */
		protected function addDragData(ds:Object):void;
		/**
		 * Adds a renderer to the recycled renderer list,
		 *  making it invisible and cleaning up references to it.
		 *  If a data effect is running, the renderer is reserved for
		 *  future use for that data. Otherwise it is added to the
		 *  general freeItemRenderers stack.
		 *
		 * @param item              <IListItemRenderer> IListItemRenderer
		 */
		protected function addToFreeItemRenderers(item:IListItemRenderer):void;
		/**
		 * Add a blank row to the beginning of the
		 *  arrays that store references to the rows
		 */
		protected function addToRowArrays():void;
		/**
		 * Called from updateDisplayList() to adjust the size and position of
		 *  listContent.
		 *
		 * @param unscaledWidth     <Number (default = -1)> 
		 * @param unscaledHeight    <Number (default = -1)> 
		 */
		protected function adjustListContent(unscaledWidth:Number = -1, unscaledHeight:Number = -1):void;
		/**
		 * Sets up the effect for applying the selection indicator.
		 *  The default is a basic alpha tween.
		 *
		 * @param indicator         <Sprite> A Sprite that contains the graphics depicting selection
		 * @param uid               <String> The UID of the item being selected which can be used to index
		 *                            into a table and track more than one selection effect
		 * @param itemRenderer      <IListItemRenderer> The item renderer that is being shown as selected
		 */
		protected function applySelectionEffect(indicator:Sprite, uid:String, itemRenderer:IListItemRenderer):void;
		/**
		 * Returns the index where the dropped items should be added
		 *  to the drop target.
		 *
		 * @param event             <DragEvent (default = null)> A DragEvent that contains information about
		 *                            the position of the mouse.  If null the
		 *                            method should return the dropIndex value from the
		 *                            last valid event.
		 * @return                  <int> Index where the dropped items should be added.
		 */
		public function calculateDropIndex(event:DragEvent = null):int;
		/**
		 * Calculates the y position of the drop indicator
		 *  when performing a drag-and-drop operation.
		 *
		 * @param rowCount          <Number> The number of visible rows in the control.
		 * @param rowNum            <int> The row number in the control where the drop indicator should appear.
		 * @return                  <Number> The y axis coordinate of the drop indicator.
		 */
		protected function calculateDropIndicatorY(rowCount:Number, rowNum:int):Number;
		/**
		 * Clears the caret indicator into the given Sprite
		 *
		 * @param indicator         <Sprite> A Sprite that should contain the graphics
		 *                            for that make a renderer look highlighted
		 * @param itemRenderer      <IListItemRenderer> The item renderer that is being highlighted
		 */
		protected function clearCaretIndicator(indicator:Sprite, itemRenderer:IListItemRenderer):void;
		/**
		 * Clears the highlight indicator in the given Sprite
		 *
		 * @param indicator         <Sprite> A Sprite that should contain the graphics
		 *                            for that make a renderer look highlighted
		 * @param itemRenderer      <IListItemRenderer> The item renderer that is being highlighted
		 */
		protected function clearHighlightIndicator(indicator:Sprite, itemRenderer:IListItemRenderer):void;
		/**
		 * Removes all selection and highlight and caret indicators.
		 */
		protected function clearIndicators():void;
		/**
		 * Clears the set of selected items and removes all graphics
		 *  depicting the selected state of those items.
		 *
		 * @param transition        <Boolean (default = false)> true if the graphics should
		 *                            have a fadeout effect.
		 */
		protected function clearSelected(transition:Boolean = false):void;
		/**
		 * Empty the visibleData hash table
		 */
		protected function clearVisibleData():void;
		/**
		 * Handles CollectionEvents dispatched from the data provider
		 *  as the data changes.
		 *  Updates the renderers, selected indices and scrollbars as needed.
		 *
		 * @param event             <Event> The CollectionEvent.
		 */
		protected function collectionChangeHandler(event:Event):void;
		/**
		 * Calculates the column width and row height and number of rows and
		 *  columns based on whether properties like columnCount
		 *  columnWidth, rowHeight and
		 *  rowCount were explicitly set.
		 */
		protected override function commitProperties():void;
		/**
		 * Configures the ScrollBars based on the number of rows and columns and
		 *  viewable rows and columns.
		 *  This method is called from the updateDisplayList() method
		 *  after the rows and columns have been updated.
		 *  The method should figures out what parameters to pass into the
		 *  setScrollBarProperties() to properly set the ScrollBars up.
		 */
		protected function configureScrollBars():void;
		/**
		 * Makes a deep copy of the object by calling the
		 *  ObjectUtil.copy() method, and replaces
		 *  the copy's uid property (if present) with a
		 *  new value by calling the UIDUtil.createUID() method.
		 *
		 * @param item              <Object> The item to copy
		 */
		protected function copyItemWithUID(item:Object):Object;
		/**
		 * Makes a copy of the selected items in the order they were
		 *  selected.
		 *
		 * @param useDataField      <Boolean (default = true)> true if the array should
		 *                            be filled with the actual items or false
		 *                            if the array should be filled with the indexes of the items
		 * @return                  <Array> array of selected items
		 */
		protected function copySelectedItems(useDataField:Boolean = true):Array;
		/**
		 * Create objects that are children of this ListBase, in this case
		 *  the listContent object that will hold all the item
		 *  renderers.
		 *  Note that the item renderers are not created immediately, but later
		 *  when Flex calls the updateDisplayList() method.
		 */
		protected override function createChildren():void;
		/**
		 * Creates an item renderer given the data object
		 *
		 * @param data              <Object> data object
		 * @return                  <IListItemRenderer> The item renderer
		 */
		public function createItemRenderer(data:Object):IListItemRenderer;
		/**
		 * Recycle a row that we don't need anymore
		 *  and remove its indicators
		 *
		 * @param i                 <int> The index of the row
		 * @param numCols           <int> The number of columns in the row
		 */
		protected function destroyRow(i:int, numCols:int):void;
		/**
		 * Handles DragEvent.DRAG_COMPLETE events.  This method
		 *  removes the item from the data provider.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected function dragCompleteHandler(event:DragEvent):void;
		/**
		 * Handles DragEvent.DRAG_DROP events.  This method  hides
		 *  the drop feedback by calling the hideDropFeedback() method.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected function dragDropHandler(event:DragEvent):void;
		/**
		 * Handles DragEvent.DRAG_ENTER events.  This method
		 *  determines if the DragSource object contains valid elements and uses
		 *  the showDropFeedback() method to set up the UI feedback.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected function dragEnterHandler(event:DragEvent):void;
		/**
		 * Handles DragEvent.DRAG_EXIT events.  This method hides
		 *  the UI feeback by calling the hideDropFeedback() method.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected function dragExitHandler(event:DragEvent):void;
		/**
		 * Handles DragEvent.DRAG_OVER events.  This method
		 *  determines if the DragSource object contains valid elements and uses
		 *  the showDropFeedback() method to set up the UI feeback.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected function dragOverHandler(event:DragEvent):void;
		/**
		 * Interval function that scrolls the list up or down
		 *  if the mouse goes above or below the list.
		 */
		protected function dragScroll():void;
		/**
		 * The default handler for the dragStart event.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected function dragStartHandler(event:DragEvent):void;
		/**
		 * Draws the caret indicator into the given Sprite
		 *  at the position, width and height specified using the
		 *  color specified.
		 *
		 * @param indicator         <Sprite> A Sprite that should contain the graphics
		 *                            for that make a renderer look highlighted
		 * @param x                 <Number> The suggested x position for the indicator
		 * @param y                 <Number> The suggested y position for the indicator
		 * @param width             <Number> The suggested width for the indicator
		 * @param height            <Number> The suggested height for the indicator
		 * @param color             <uint> The suggested color for the indicator
		 * @param itemRenderer      <IListItemRenderer> The item renderer that is being highlighted
		 */
		protected function drawCaretIndicator(indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void;
		/**
		 * Draws the highlight indicator into the given Sprite
		 *  at the position, width and height specified using the
		 *  color specified.
		 *
		 * @param indicator         <Sprite> A Sprite that should contain the graphics
		 *                            for that make a renderer look highlighted
		 * @param x                 <Number> The suggested x position for the indicator
		 * @param y                 <Number> The suggested y position for the indicator
		 * @param width             <Number> The suggested width for the indicator
		 * @param height            <Number> The suggested height for the indicator
		 * @param color             <uint> The suggested color for the indicator
		 * @param itemRenderer      <IListItemRenderer> The item renderer that is being highlighted
		 */
		protected function drawHighlightIndicator(indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void;
		/**
		 * Draws the renderer with indicators
		 *  that it is highlighted, selected, or the caret.
		 *
		 * @param item              <IListItemRenderer> The renderer.
		 * @param selected          <Boolean (default = false)> true if the renderer should be drawn in
		 *                            its selected state.
		 * @param highlighted       <Boolean (default = false)> true if the renderer should be drawn in
		 *                            its highlighted state.
		 * @param caret             <Boolean (default = false)> true if the renderer should be drawn as if
		 *                            it is the selection caret.
		 * @param transition        <Boolean (default = false)> true if the selection state should fade in
		 *                            via an effect.
		 */
		protected function drawItem(item:IListItemRenderer, selected:Boolean = false, highlighted:Boolean = false, caret:Boolean = false, transition:Boolean = false):void;
		/**
		 * Draws any alternating row colors, borders and backgrounds for the rows.
		 */
		protected function drawRowBackgrounds():void;
		/**
		 * Draws the selection indicator into the given Sprite
		 *  at the position, width and height specified using the
		 *  color specified.
		 *
		 * @param indicator         <Sprite> A Sprite that should contain the graphics
		 *                            for that make a renderer look highlighted
		 * @param x                 <Number> The suggested x position for the indicator
		 * @param y                 <Number> The suggested y position for the indicator
		 * @param width             <Number> The suggested width for the indicator
		 * @param height            <Number> The suggested height for the indicator
		 * @param color             <uint> The suggested color for the indicator
		 * @param itemRenderer      <IListItemRenderer> The item renderer that is being highlighted
		 */
		protected function drawSelectionIndicator(indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void;
		/**
		 * Tries to find the next item in the data provider that
		 *  starts with the character in the eventCode parameter.
		 *  You can override this to do fancier typeahead lookups.  The search
		 *  starts at the selectedIndex location; if it reaches
		 *  the end of the data provider it starts over from the beginning.
		 *
		 * @param eventCode         <int> The key that was pressed on the keyboard
		 * @return                  <Boolean> true if a match was found
		 */
		protected function findKey(eventCode:int):Boolean;
		/**
		 * Finds an item in the list based on a String,
		 *  and moves the selection to it.  The search
		 *  starts at the selectedIndex location; if it reaches
		 *  the end of the data provider it starts over from the beginning.
		 *
		 * @param str               <String> The String to match.
		 * @return                  <Boolean> true if a match is found.
		 */
		public function findString(str:String):Boolean;
		/**
		 * Cleans up after a data change effect has finished running
		 *  by restoring the original collection and iterator and removing
		 *  any cached values used by the effect. This method is called by
		 *  the Flex framework; you do not need to call it from your code.
		 *
		 * @param event             <EffectEvent> the EffectEvent
		 */
		protected function finishDataChangeEffect(event:EffectEvent):void;
		/**
		 * Sets selected items based on the caretIndex and
		 *  anchorIndex properties.
		 *  Called by the keyboard selection handlers
		 *  and by the updateDisplayList method in case the
		 *  keyboard selection handler
		 *  got a page fault while scrolling to get more items.
		 */
		protected function finishKeySelection():void;
		/**
		 * Return the appropriate factory, using the default factory if none specified.
		 *
		 * @param data              <Object> The data to be presented by the item renderer.
		 * @return                  <IFactory> if data is null, the default item renderer,
		 *                            otherwis it returns the custom item renderer.
		 */
		public function getItemRendererFactory(data:Object):IFactory;
		/**
		 * Returns true or false
		 *  to indicates whether the effect should play on the target.
		 *  The EffectTargetFilter class calls this method when you set
		 *  the filter property on a data effect.
		 *  For example, you set filter property
		 *  to addItem or removeItem.
		 *
		 * @param target            <Object> An item renderer
		 * @param semanticProperty  <String> The semantic property of the renderer
		 *                            whose value will be returned.
		 * @return                  <Object> true or false
		 *                            to indicates whether the effect should play on the target.
		 */
		public function getRendererSemanticValue(target:Object, semanticProperty:String):Object;
		/**
		 * Retrieves an already-created item renderer not currently in use.
		 *  If a data effect is running, it first tries to retrieve from the
		 *  reservedItemRenderers map. Otherwise (or if no reserved renderer
		 *  is found) it retrieves from the freeItemRenderers stack.
		 *
		 * @param data              <Object> Object The data to be presented by the item renderer
		 */
		protected function getReservedOrFreeItemRenderer(data:Object):IListItemRenderer;
		/**
		 * Hides the drop indicator under the mouse pointer that indicates that a
		 *  drag and drop operation is allowed.
		 *
		 * @param event             <DragEvent> A DragEvent object that contains information about the
		 *                            mouse location.
		 */
		public function hideDropFeedback(event:DragEvent):void;
		/**
		 * The column for the data provider item at the given index.
		 *
		 * @param index             <int> The offset into the data provider
		 * @return                  <int> The column the item would be displayed at in the component,
		 *                            -1 if not displayable in listContent container
		 */
		protected function indexToColumn(index:int):int;
		/**
		 * Get an item renderer for the index of an item in the data provider,
		 *  if one exists.  Since item renderers only exist for items
		 *  within the set of viewable rows
		 *  items, you cannot use this method for items that are not visible.
		 *
		 * @param index             <int> The offset into the data provider for an item
		 * @return                  <IListItemRenderer> The item renderer that is displaying the item, or
		 *                            null if the item is not currently displayed.
		 */
		public function indexToItemRenderer(index:int):IListItemRenderer;
		/**
		 * The row for the data provider item at the given index.
		 *
		 * @param index             <int> The offset into the data provider.
		 * @return                  <int> The row the item would be displayed at in the component,
		 *                            -1 if not displayable in listContent container
		 */
		protected function indexToRow(index:int):int;
		/**
		 * Computes the offset into the data provider of the item
		 *  at colIndex, rowIndex.
		 *  The 9th row 3rd column in a TileList could be different items
		 *  in the data provider based on the direction the tiles are laid
		 *  out and the number of rows and columns in the TileList.
		 *
		 * @param rowIndex          <int> The 0-based index of the row, including rows
		 *                            scrolled off the top.  Thus, if verticalScrollPosition
		 *                            is 2 then the first visible row has a rowIndex of 2.
		 * @param colIndex          <int> The 0-based index of the column, including
		 *                            columns scrolled off the left.  If
		 *                            horizontalScrollPosition is 2 then the first column
		 *                            on the left has a columnIndex of 2.
		 * @return                  <int> The offset into the data provider.
		 */
		public function indicesToIndex(rowIndex:int, colIndex:int):int;
		/**
		 * Initiates a data change effect when there have been changes
		 *  in the data provider.
		 *
		 * @param unscaledWidth     <Number> 
		 * @param unscaledHeight    <Number> 
		 */
		protected function initiateDataChangeEffect(unscaledWidth:Number, unscaledHeight:Number):void;
		/**
		 * Refresh all rows on next update.
		 */
		public function invalidateList():void;
		/**
		 * Determines if the item renderer for a data provider item
		 *  is highlighted (is rolled over via the mouse or
		 *  or under the caret via keyboard navigation).
		 *
		 * @param data              <Object> The data provider item
		 * @return                  <Boolean> true if the item is highlighted
		 */
		public function isItemHighlighted(data:Object):Boolean;
		/**
		 * Determines if the item renderer for a data provider item
		 *  is selectable.
		 *
		 * @param data              <Object> The data provider item
		 * @return                  <Boolean> true if the item is selectable
		 */
		public function isItemSelectable(data:Object):Boolean;
		/**
		 * Determines if the item renderer for a data provider item
		 *  is selected.
		 *
		 * @param data              <Object> The data provider item
		 * @return                  <Boolean> true if the item is selected
		 */
		public function isItemSelected(data:Object):Boolean;
		/**
		 * Determines if an item is being displayed by a renderer.
		 *
		 * @param item              <Object> A data provider item.
		 * @return                  <Boolean> true if the item is being displayed.
		 */
		public function isItemVisible(item:Object):Boolean;
		/**
		 * Returns true if an item renderer is no longer being positioned
		 *  by the list's layout algorithm while a data change effect is
		 *  running as a result of a call to unconstrainRenderer().
		 *
		 * @param item              <Object> An item renderer
		 */
		protected function isRendererUnconstrained(item:Object):Boolean;
		/**
		 * Determines whether a renderer contains (or owns) a display object.
		 *  Ownership means that the display object isn't actually parented
		 *  by the renderer but is associated with it in some way.  Popups
		 *  should be owned by the renderers so that activity in the popup
		 *  is associated with the renderer and not seen as activity in another
		 *  component.
		 *
		 * @param renderer          <IListItemRenderer> The renderer that might contain or own the
		 *                            display object.
		 * @param object            <DisplayObject> The display object that might be associated with the
		 *                            renderer.
		 * @return                  <Boolean> true if the display object is contained
		 *                            or owned by the renderer.
		 */
		public function itemRendererContains(renderer:IListItemRenderer, object:DisplayObject):Boolean;
		/**
		 * Returns the index of the item in the data provider of the item
		 *  being rendered by this item renderer.  Since item renderers
		 *  only exist for items that are within the set of viewable
		 *  rows, you cannot
		 *  use this method for items that are not visible.
		 *
		 * @param itemRenderer      <IListItemRenderer> The item renderer that is displaying the
		 *                            item for which you want to know the data provider index.
		 * @return                  <int> The index of the item in the data provider
		 */
		public function itemRendererToIndex(itemRenderer:IListItemRenderer):int;
		/**
		 * Returns a Point containing the columnIndex and rowIndex of an
		 *  item renderer.  Since item renderers are only created for items
		 *  within the set of viewable rows
		 *  you cannot use this method to get the indices for items
		 *  that are not visible.  Also note that item renderers
		 *  are recycled so the indices you get for an item may change
		 *  if that item renderer is reused to display a different item.
		 *  Usually, this method is called during mouse and keyboard handling
		 *  when the set of data displayed by the item renderers hasn't yet
		 *  changed.
		 *
		 * @param item              <IListItemRenderer> An item renderer
		 * @return                  <Point> A Point.  The x property is the columnIndex
		 *                            and the y property is the rowIndex.
		 */
		protected function itemRendererToIndices(item:IListItemRenderer):Point;
		/**
		 * Returns the dataTip string the renderer would display for the given
		 *  data object based on the dataTipField and dataTipFunction properties.
		 *  If the method cannot convert the parameter to a string, it returns a
		 *  single space.
		 *
		 * @param data              <Object> Object to be rendered.
		 * @return                  <String> String displayable string based on the data.
		 */
		public function itemToDataTip(data:Object):String;
		/**
		 * Returns the class for an icon, if any, for a data item,
		 *  based on the iconField and iconFunction properties.
		 *  The field in the item can return a string as long as that
		 *  string represents the name of a class in the application.
		 *  The field in the item can also be a string that is the name
		 *  of a variable in the document that holds the class for
		 *  the icon.
		 *
		 * @param data              <Object> The item from which to extract the icon class
		 * @return                  <Class> The icon for the item, as a class reference or
		 *                            null if none.
		 */
		public function itemToIcon(data:Object):Class;
		/**
		 * Returns the item renderer for a given item in the data provider,
		 *  if there is one.  Since item renderers only exist for items
		 *  that are within the set of viewable rows, this method
		 *  returns null if the item is not visible.
		 *  For DataGrid, this will return the first column's renderer.
		 *
		 * @param item              <Object> The data provider item
		 * @return                  <IListItemRenderer> The item renderer or null if the item is not
		 *                            currently displayed.
		 */
		public function itemToItemRenderer(item:Object):IListItemRenderer;
		/**
		 * Returns the string the renderer would display for the given data object
		 *  based on the labelField and labelFunction properties.
		 *  If the method cannot convert the parameter to a string, it returns a
		 *  single space.
		 *
		 * @param data              <Object> Object to be rendered.
		 * @return                  <String> The string to be displayed based on the data.
		 */
		public function itemToLabel(data:Object):String;
		/**
		 * Determines the UID for a data provider item.  All items
		 *  in a data provider must either have a unique ID (UID)
		 *  or one will be generated and associated with it.  This
		 *  means that you cannot have an object or scalar value
		 *  appear twice in a data provider.  For example, the following
		 *  data provider is not supported because the value "foo"
		 *  appears twice and the UID for a string is the string itself
		 *  Simple dynamic objects can appear twice if they are two
		 *  separate instances.  The following is supported because
		 *  each of the instances will be given a different UID because
		 *  they are different objects.
		 *  Note that the following is not supported because the same instance
		 *  appears twice.
		 *
		 * @param data              <Object> The data provider item
		 * @return                  <String> The UID as a string
		 */
		protected function itemToUID(data:Object):String;
		/**
		 * Make enough rows and columns to fill the area
		 *  described by left, top, right, bottom.
		 *  Renderers are created and inserted into the listItems
		 *  array starting at (firstColumn, firstRow)(
		 *  and moving downwards.
		 *
		 * @param left              <Number> Horizontal pixel offset of area to fill.
		 * @param top               <Number> Vertical pixel offset of area to fill.
		 * @param right             <Number> Horizontal pixel offset of area to fill
		 *                            (from left side of component).
		 * @param bottom            <Number> Vertical pixel offset of area to fill
		 *                            (from top of component).
		 * @param firstColumn       <int> Offset into listItems to store
		 *                            the first renderer to be created.
		 * @param firstRow          <int> Offset into listItems to store
		 *                            the first renderer to be created.
		 * @param byCount           <Boolean (default = false)> If true, make rowsNeeded number of rows
		 *                            and ignore bottom parameter
		 * @param rowsNeeded        <uint (default = 0)> Number of rows to create if byCount
		 *                            is true;
		 * @return                  <Point> A Point containing the number of rows and columns created.
		 */
		protected function makeRowsAndColumns(left:Number, top:Number, right:Number, bottom:Number, firstColumn:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0):Point;
		/**
		 * Calculates the measured width and height of the component based
		 *  on the rowCount,
		 *  columnCount, rowHeight and
		 *  columnWidth properties.
		 */
		protected override function measure():void;
		/**
		 * Measures a set of items from the data provider using the
		 *  current item renderer and returns the sum of the heights
		 *  of those items.
		 *
		 * @param index             <int (default = -1)> The data provider item at which to start calculating
		 *                            the height.
		 * @param count             <int (default = 0)> The number of items to use in calculating the height.
		 * @return                  <Number> the sum of the height of the measured items.
		 */
		public function measureHeightOfItems(index:int = -1, count:int = 0):Number;
		/**
		 * Measures a set of items from the data provider using
		 *  the current item renderer and returns the
		 *  maximum width found.  This method is used to calculate the
		 *  width of the component.  The various ListBase-derived classes
		 *  have slightly different implementations.  DataGrid measures
		 *  its columns instead of data provider items, and TileList
		 *  just measures the first item and assumes all items are the
		 *  same size.
		 *
		 * @param index             <int (default = -1)> The data provider item at which to start measuring
		 *                            the width.
		 * @param count             <int (default = 0)> The number of items to measure in calculating the width.
		 * @return                  <Number> The widest of the measured items.
		 */
		public function measureWidthOfItems(index:int = -1, count:int = 0):Number;
		/**
		 * Handles MouseEvent.MOUSE_CLICK events from any mouse
		 *  targets contained in the list including the renderers.  This method
		 *  determines which renderer was clicked
		 *  and dispatches a ListEvent.ITEM_CLICK event.
		 *
		 * @param event             <MouseEvent> The MouseEvent object.
		 */
		protected function mouseClickHandler(event:MouseEvent):void;
		/**
		 * Handles MouseEvent.MOUSE_DOUBLE_CLICK events from any
		 *  mouse targets contained in the list including the renderers.
		 *  This method determines which renderer was clicked
		 *  and dispatches a ListEvent.ITEM_DOUBLE_CLICK event.
		 *
		 * @param event             <MouseEvent> The MouseEvent object.
		 */
		protected function mouseDoubleClickHandler(event:MouseEvent):void;
		/**
		 * Handles MouseEvent.MOUSE_DOWN events from any mouse
		 *  targets contained in the list including the renderers.  This method
		 *  finds the renderer that was pressed and prepares to receive
		 *  a MouseEvent.MOUSE_UP event.
		 *
		 * @param event             <MouseEvent> The MouseEvent object.
		 */
		protected function mouseDownHandler(event:MouseEvent):void;
		/**
		 * Determines which item renderer is under the mouse.  Item
		 *  renderers can be made of multiple mouse targets, or have
		 *  visible areas that are not mouse targets.  This method
		 *  checks both targets and position to determine which
		 *  item renderer the mouse is over from the user's perspective,
		 *  which can differ from the information provided by the
		 *  mouse event.
		 *
		 * @param event             <MouseEvent> A MouseEvent that contains the position of
		 *                            the mouse and the object it is over
		 * @return                  <IListItemRenderer> The item renderer the mouse is over or
		 *                            null if none.
		 */
		protected function mouseEventToItemRenderer(event:MouseEvent):IListItemRenderer;
		/**
		 * Handles MouseEvent.MOUSE_MOVE events from any mouse
		 *  targets contained in the list including the renderers.  This method
		 *  watches for a gesture that constitutes the beginning of a
		 *  drag drop and send a DragEvent.DRAG_START event.
		 *  It also checks to see if the mouse is over a non-target area of a
		 *  renderer so that Flex can try to make it look like that renderer was
		 *  the target.
		 *
		 * @param event             <MouseEvent> The MouseEvent object.
		 */
		protected function mouseMoveHandler(event:MouseEvent):void;
		/**
		 * Handles MouseEvent.MOUSE_OUT events from any mouse targets
		 *  contained in the list including the renderers.  This method
		 *  finds out which renderer the mouse has left
		 *  and removes the highlights.
		 *
		 * @param event             <MouseEvent> The MouseEvent object.
		 */
		protected function mouseOutHandler(event:MouseEvent):void;
		/**
		 * Handles MouseEvent.MOUSE_OVER events from any mouse
		 *  targets contained in the list, including the renderers.
		 *  This method finds out which renderer the mouse is over
		 *  and shows it as highlighted.
		 *
		 * @param event             <MouseEvent> The MouseEvent object.
		 */
		protected function mouseOverHandler(event:MouseEvent):void;
		/**
		 * Handles MouseEvent.MOUSE_DOWN events from any mouse
		 *  targets contained in the list including the renderers.  This method
		 *  finds the renderer that was pressed and prepares to receive
		 *  a MouseEvent.MOUSE_UP event.
		 *
		 * @param event             <MouseEvent> The MouseEvent object.
		 */
		protected function mouseUpHandler(event:MouseEvent):void;
		/**
		 * Handles mouseWheel events by changing scroll positions.
		 *  This is a copy of the version in the ScrollControlBase class,
		 *  modified to change the horizontalScrollPosition if the target is run horizontally.
		 *
		 * @param event             <MouseEvent> The MouseEvent object.
		 */
		protected override function mouseWheelHandler(event:MouseEvent):void;
		/**
		 * Move the selection and highlight indicators horizontally
		 *
		 * @param uid               <String> UID used to find the indicators
		 * @param moveBlockDistance <Number> The distance to move horizontally
		 */
		protected function moveIndicatorsHorizontally(uid:String, moveBlockDistance:Number):void;
		/**
		 * Move the selection and highlight indicators vertically
		 *
		 * @param uid               <String> UID used to find the indicators
		 * @param moveBlockDistance <Number> The distance to move vertically
		 */
		protected function moveIndicatorsVertically(uid:String, moveBlockDistance:Number):void;
		/**
		 * Move a row vertically, and update the rowInfo record
		 *
		 * @param i                 <int> The index of the row
		 * @param numCols           <int> The number of columns in the row
		 * @param moveBlockDistance <Number> The distance to move
		 */
		protected function moveRowVertically(i:int, numCols:int, moveBlockDistance:Number):void;
		/**
		 * Moves the selection in a horizontal direction in response
		 *  to the user selecting items using the left-arrow or right-arrow
		 *  keys and modifiers such as  the Shift and Ctrl keys.  This method
		 *  might change the horizontalScrollPosition,
		 *  verticalScrollPosition, and caretIndex
		 *  properties, and call the finishKeySelection()method
		 *  to update the selection.
		 *
		 * @param code              <uint> The key that was pressed (e.g. Keyboard.LEFT)
		 * @param shiftKey          <Boolean> true if the shift key was held down when
		 *                            the keyboard key was pressed.
		 * @param ctrlKey           <Boolean> true if the ctrl key was held down when
		 *                            the keyboard key was pressed
		 */
		protected function moveSelectionHorizontally(code:uint, shiftKey:Boolean, ctrlKey:Boolean):void;
		/**
		 * Moves the selection in a vertical direction in response
		 *  to the user selecting items using the up-arrow or down-arrow
		 *  Keys and modifiers such as the Shift and Ctrl keys.  This method
		 *  might change the horizontalScrollPosition,
		 *  verticalScrollPosition, and caretIndex
		 *  properties, and call the finishKeySelection()method
		 *  to update the selection
		 *
		 * @param code              <uint> The key that was pressed (e.g. Keyboard.DOWN)
		 * @param shiftKey          <Boolean> true if the shift key was held down when
		 *                            the keyboard key was pressed.
		 * @param ctrlKey           <Boolean> true if the ctrl key was held down when
		 *                            the keyboard key was pressed
		 */
		protected function moveSelectionVertically(code:uint, shiftKey:Boolean, ctrlKey:Boolean):void;
		/**
		 * Prepare the data effect for the collection event
		 *
		 * @param ce                <CollectionEvent> 
		 */
		protected function prepareDataEffect(ce:CollectionEvent):void;
		/**
		 * Called by updateDisplayList() to remove existing item renderers
		 *  and clean up various caching structures when renderer changes.
		 */
		protected function purgeItemRenderers():void;
		/**
		 * Update the keys in the visibleData hash table
		 */
		protected function reKeyVisibleData():void;
		/**
		 * Removes an item renderer if a data change effect is running.
		 *  The item renderer must correspond to data that has already
		 *  been removed from the data provider collection.
		 *  This function will be called by a RemoveItemAction
		 *  effect as part of a data change effect to specify the point
		 *  at which a data item ceases to displayed by the control using
		 *  an item renderer.
		 *
		 * @param target            <Object> The item renderer to remove from the control's layout.
		 */
		public function removeDataEffectItem(target:Object):void;
		/**
		 * Remove a row from the arrays that store references to the row
		 *
		 * @param i                 <int> The index of the row
		 */
		protected function removeFromRowArrays(i:int):void;
		/**
		 * Cleans up selection highlights and other associated graphics
		 *  for a given item in the data provider.
		 *
		 * @param uid               <String> The UID of the data provider item
		 */
		protected function removeIndicators(uid:String):void;
		/**
		 * Remove the requested number of rows from the beginning of the
		 *  arrays that store references to the rows
		 *
		 * @param modDeltaPos       <int> The number of rows to remove
		 */
		protected function restoreRowArrays(modDeltaPos:int):void;
		/**
		 * Adjusts the renderers in response to a change
		 *  in scroll position.
		 *
		 * @param pos               <int> The new scroll position.
		 * @param deltaPos          <int> The change in position.  It is always
		 *                            a positive number.
		 * @param scrollUp          <Boolean> true if scroll position
		 *                            is getting smaller.
		 */
		protected function scrollHorizontally(pos:int, deltaPos:int, scrollUp:Boolean):void;
		/**
		 * Returns the data provider index for the item at the first visible
		 *  row and column for the given scroll positions.
		 *
		 * @param horizontalScrollPosition<int> The horizontalScrollPosition
		 *                            property value corresponding to the scroll position.
		 * @param verticalScrollPosition<int> The verticalScrollPosition
		 *                            property value corresponding to the scroll position.
		 * @return                  <int> The data provider index.
		 */
		protected function scrollPositionToIndex(horizontalScrollPosition:int, verticalScrollPosition:int):int;
		/**
		 * Ensures that the data provider item at the given index is visible.
		 *  If the item is visible, the verticalScrollPosition
		 *  property is left unchanged even if the item is not the first visible
		 *  item. If the item is not currently visible, the
		 *  verticalScrollPosition
		 *  property is changed make the item the first visible item, unless there
		 *  aren't enough rows to do so because the
		 *  verticalScrollPosition value is limited by the
		 *  maxVerticalScrollPosition property.
		 *
		 * @param index             <int> The index of the item in the data provider.
		 * @return                  <Boolean> true if verticalScrollPosition changed.
		 */
		public function scrollToIndex(index:int):Boolean;
		/**
		 * Adjusts the renderers in response to a change
		 *  in scroll position.
		 *
		 * @param pos               <int> The new scroll position.
		 * @param deltaPos          <int> The change in position.  It is always
		 *                            a positive number.
		 * @param scrollUp          <Boolean> true if scroll position
		 *                            is getting smaller.
		 */
		protected function scrollVertically(pos:int, deltaPos:int, scrollUp:Boolean):void;
		/**
		 * The default failure handler when a seek fails due to a page fault.
		 *
		 * @param data              <Object> 
		 * @param info              <ListBaseSeekPending> 
		 */
		protected function seekPendingFailureHandler(data:Object, info:ListBaseSeekPending):void;
		/**
		 * The default result handler when a seek fails due to a page fault.
		 *  This method checks to see if it has the most recent page fault result:
		 *  if not it simply exits; if it does, it sets the iterator to
		 *  the correct position.
		 *
		 * @param data              <Object> 
		 * @param info              <ListBaseSeekPending> 
		 */
		protected function seekPendingResultHandler(data:Object, info:ListBaseSeekPending):void;
		/**
		 * Seek to a position, and handle ItemPendingError if necessary
		 *
		 * @param index             <int> Index into the collection
		 * @return                  <Boolean> FALSE if ItemPendingError thrown
		 */
		protected function seekPositionSafely(index:int):Boolean;
		/**
		 * Updates the set of selected items given that the item renderer provided
		 *  was clicked by the mouse and the keyboard modifiers are in the given
		 *  state.  This method also updates the display of the item renderers based
		 *  on their updated selected state.
		 *
		 * @param item              <IListItemRenderer> The item renderer that was clicked
		 * @param shiftKey          <Boolean> true if the shift key was held down when
		 *                            the mouse was clicked.
		 * @param ctrlKey           <Boolean> true if the ctrl key was held down when
		 *                            the mouse was clicked.
		 * @param transition        <Boolean (default = true)> true if the graphics for the selected
		 *                            state should be faded in using an effect.
		 * @return                  <Boolean> true if the set of selected items changed.
		 *                            Clicking on an already-selected item doesn't always change the set
		 *                            of selected items.
		 */
		protected function selectItem(item:IListItemRenderer, shiftKey:Boolean, ctrlKey:Boolean, transition:Boolean = true):Boolean;
		/**
		 * Sets the rowCount property without causing
		 *  invalidation or setting the explicitRowCount
		 *  property, which permanently locks in the number of rows.
		 *
		 * @param v                 <int> The row count.
		 */
		protected function setRowCount(v:int):void;
		/**
		 * Sets the rowHeight property without causing invalidation or
		 *  setting of explicitRowHeight which
		 *  permanently locks in the height of the rows.
		 *
		 * @param v                 <Number> The row height, in pixels.
		 */
		protected function setRowHeight(v:Number):void;
		/**
		 * Shift a row in the arrays that reference rows
		 *
		 * @param oldIndex          <int> Old index in the arrays
		 * @param newIndex          <int> New index in the arrays
		 * @param numCols           <int> The number of columns in the row
		 * @param shiftItems        <Boolean> TRUE if we actually move the item
		 *                            FALSE if we simply change the items rowIndex
		 */
		protected function shiftRow(oldIndex:int, newIndex:int, numCols:int, shiftItems:Boolean):void;
		/**
		 * Displays a drop indicator under the mouse pointer to indicate that a
		 *  drag and drop operation is allowed and where the items will
		 *  be dropped.
		 *
		 * @param event             <DragEvent> A DragEvent object that contains information as to where
		 *                            the mouse is.
		 */
		public function showDropFeedback(event:DragEvent):void;
		/**
		 * Determine the height of the requested set of rows
		 *
		 * @param startRowIdx       <int> index of first row
		 * @param endRowIdx         <int> index of last row
		 * @return                  <Number> total height of rows.
		 */
		protected function sumRowHeights(startRowIdx:int, endRowIdx:int):Number;
		/**
		 * Remove all remaining rows from the end of the
		 *  arrays that store references to the rows
		 *
		 * @param numRows           <int> The row index to truncate from
		 */
		protected function truncateRowArrays(numRows:int):void;
		/**
		 * Find an item renderer based on its UID if it is visible
		 *
		 * @param uid               <String> The UID of the item
		 * @return                  <IListItemRenderer> The item renderer
		 */
		protected function UIDToItemRenderer(uid:String):IListItemRenderer;
		/**
		 * Called by an UnconstrainItemAction effect
		 *  as part of a data change effect if the item renderers corresponding
		 *  to certain data items need to move outside the normal positions
		 *  of item renderers in the control.
		 *  The control does not attempt to position the item render for the
		 *  duration of the effect.
		 *
		 * @param item              <Object> The item renderer that is a target of the effect.
		 */
		public function unconstrainRenderer(item:Object):void;
		/**
		 * Adds or removes item renderers if the number of displayable items
		 *  changed.
		 *  Refreshes the item renderers if they might have changed.
		 *  Applies the selection if it was changed programmatically.
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
		 * Refreshes all rows now.  Calling this method can require substantial
		 *  processing, because can be expensive at it completely redraws all renderers
		 *  in the list and won't return until complete.
		 */
		protected function updateList():void;
	}
}
