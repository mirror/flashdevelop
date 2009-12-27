package mx.controls.listClasses
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.collections.ItemResponder;
	import mx.collections.ItemWrapper;
	import mx.collections.ListCollectionView;
	import mx.collections.ModifiedCollectionView;
	import mx.collections.XMLListCollection;
	import mx.collections.errors.CursorError;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.core.DragSource;
	import mx.core.EdgeMetrics;
	import mx.core.EventPriority;
	import mx.core.FlexShape;
	import mx.core.FlexSprite;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.IInvalidating;
	import mx.core.IRawChildrenContainer;
	import mx.core.IUIComponent;
	import mx.core.IUID;
	import mx.core.IUITextField;
	import mx.core.ScrollControlBase;
	import mx.core.ScrollPolicy;
	import mx.core.SpriteAsset;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.effects.IEffect;
	import mx.effects.IEffectInstance;
	import mx.effects.IEffectTargetHost;
	import mx.effects.Tween;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.DragEvent;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.events.SandboxMouseEvent;
	import mx.events.PropertyChangeEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.events.ScrollEventDirection;
	import mx.events.TweenEvent;
	import mx.managers.DragManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.skins.halo.ListDropIndicator;
	import mx.styles.StyleManager;
	import mx.utils.ObjectUtil;
	import mx.utils.UIDUtil;
	import mx.events.MoveEvent;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when the <code>selectedIndex</code> or <code>selectedItem</code> property
 *  changes as a result of user interaction.
 *
 *  @eventType mx.events.ListEvent.CHANGE
	 */
	[Event(name="change", type="mx.events.ListEvent")] 

	/**
	 *  Dispatched when the <code>data</code> property changes.
 *
 *  <p>When you use a component as an item renderer,
 *  the <code>data</code> property contains the data to display.
 *  You can listen for this event and update the component
 *  when the <code>data</code> property changes.</p>
 * 
 *  @eventType mx.events.FlexEvent.DATA_CHANGE
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 

	/**
	 *  Dispatched when the user rolls the mouse pointer over an item in the control.
 *
 *  @eventType mx.events.ListEvent.ITEM_ROLL_OVER
	 */
	[Event(name="itemRollOver", type="mx.events.ListEvent")] 

	/**
	 *  Dispatched when the user rolls the mouse pointer out of an item in the control.
 *
 *  @eventType mx.events.ListEvent.ITEM_ROLL_OUT
	 */
	[Event(name="itemRollOut", type="mx.events.ListEvent")] 

	/**
	 *  Dispatched when the user clicks on an item in the control.
 *
 *  @eventType mx.events.ListEvent.ITEM_CLICK
	 */
	[Event(name="itemClick", type="mx.events.ListEvent")] 

	/**
	 *  Dispatched when the user double-clicks on an item in the control.
 *
 *  @eventType mx.events.ListEvent.ITEM_DOUBLE_CLICK
	 */
	[Event(name="itemDoubleClick", type="mx.events.ListEvent")] 

include "../../styles/metadata/FocusStyles.as"
include "../../styles/metadata/PaddingStyles.as"
	/**
	 *  The colors to use for the backgrounds of the items in the list. 
 *  The value is an array of two or more colors. 
 *  The backgrounds of the list items alternate among the colors in the array. 
 *
 *  <p>For DataGrid controls, all items in a row have the same background color, 
 *  and each row's background color is determined from the array of colors.</p>
 *
 *  <p>For the TileList control, which uses a single list to populate a 
 *  two-dimensional display, the style can result in a checkerboard appearance,
 *  stripes, or other patterns based on the number of columns and rows and
 *  the number of colors specified.  TileList cycles through the colors, placing
 *  the individual item background colors according to the 
 *  layout direction. If you have an even number of colors and an even number of
 *  columns for a TileList layed out horizontally, you will get striping.  If
 *  the number of columns is an odd number, you will get a checkerboard pattern.
 *  </p>
 *
 *  @default undefined
	 */
	[Style(name="alternatingItemColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 

	/**
	 *  The skin to use to indicate where a dragged item can be dropped.
 *  When a ListBase-derived component is a potential drop target in a
 *  drag-and-drop operation, a call to the <code>showDropFeedback()</code>
 *  method makes an instance of this class and positions it one pixel above
 *  the itemRenderer for the item where, if the drop occurs, is the item after
 *  the dropped item.
 *
 *  @default mx.controls.listClasses.ListDropIndicator
	 */
	[Style(name="dropIndicatorSkin", type="Class", inherit="no")] 

	/**
	 *  The number of pixels between the bottom of the row
 *  and the bottom of the renderer in the row.
 *
 *  @default 2
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 

	/**
	 *  The number of pixels between the top of the row
 *  and the top of the renderer in the row.
 *  
 *  @default 2
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  The color of the background of a renderer when the user rolls over it.
 *
 *  @default 0xEEFEE6
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The color of the background of a renderer when the user selects it.
 *
 *  @default 0x7FCEFF
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The color of the background of a renderer when the component is disabled.
 *
 *  @default 0xDDDDDD
	 */
	[Style(name="selectionDisabledColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The duration of the selection effect.
 *  When an item is selected an effect plays as the background is colored.
 *  Set to 0 to disable the effect.
 *  
 *  @default 250
 *
	 */
	[Style(name="selectionDuration", type="Number", format="Time", inherit="no")] 

	/**
	 *  The easingFunction for the selection effect.
 *  When an item is selected an effect plays as the background is colored.
 *  The default is a linear fade in of the color. An easingFunction can be used 
 *  for controlling the selection effect.
 *
 *  @default undefined
	 */
	[Style(name="selectionEasingFunction", type="Function", inherit="no")] 

	/**
	 *  The color of the text of a renderer when the user rolls over a it.
 *
 *  @default 0x2B333C
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The color of the text of a renderer when the user selects it.
 *
 *  @default 0x2B333C
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  A flag that controls whether items are highlighted as the mouse rolls 
 *  over them.
 *  If <code>true</code>, rows are highlighted as the mouse rolls over them.
 *  If <code>false</code>, rows are highlighted only when selected.
 *
 *  @default true
	 */
	[Style(name="useRollOver", type="Boolean", inherit="no")] 

	/**
	 *  The vertical alignment of a renderer in a row.
 *  Possible values are <code>"top"</code>, <code>"middle"</code>,
 *  and <code>"bottom"</code>.
 *  The DataGrid positions the renderers in a row based on this style
 *  and the <code>paddingTop</code> and <code>paddingBottom</code> styles.
 *  if the item in the columns for a row have different heights
 *  Other list classes do not use <code>verticalAlign</code> but
 *  the item renderers can examine this style property
 *  and adjust their layout based on it.
 *
 *  @default "top"
	 */
	[Style(name="verticalAlign", type="String", enumeration="bottom,middle,top", inherit="no")] 

include "../../core/Version.as"
	/**
	 *  The ListBase class is the base class for controls that represent lists
 *  of items that can have one or more selected and can scroll through the
 *  items.  Items are supplied using the <code>dataProvider</code> property
 *  and displayed via item renderers.
 *
 *  <p>In a model/view architecture, the ListBase-derived class represents
 *  the view, and the dataProvider object represents the model.</p>
 *
 *  @mxml
 *  
 *  <p>The ListBase class inherits all of the tag properties of its superclasses,
 *  and adds the following tag properties:</p>
 *  
 *  <pre>
 *  &lt;mx:<i>tagname</i>
 *    <b>Properties</b>
 *    allowDragSelection="false|true"
 *    allowMultipleSelection="false|true"
 *    columnCount="4"
 *    columnWidth="NaN"
 *    dataProvider="null"
 *    dataTipField="label"
 *    dataTipFunction="null"
 *    dragEnabled="false|true"
 *    dragMoveEnabled="false|true"
 *    dropEnabled="false|true"
 *    iconField="null"
 *    iconFunction="null"
 *    itemRenderer="null"
 *    labelField="label"
 *    labelFunction="null"
 *    menuSelectionMode="false|true"
 *    offscreenExtraRowsOrColumns="0"
 *    rowCount="-1"
 *    rowHeight="NaN"
 *    selectable="true|false"
 *    selectedIndex="-1"
 *    selectedIndices="null"
 *    selectedItem="null"
 *    selectedItems="null"
 *    showDataTips="false|true"
 *    variableRowHeight="false|true"
 *    wordWrap="false|true"
 * 
 *    <b>Styles</b>
 *    alternatingItemColors="undefined"
 *    itemsChangeEffect="undefined"
 *    dropIndicatorSkin="ListDropIndicator"
 *    focusAlpha="0.5"
 *    focusRoundedCorners="tl tr bl br"
 *    paddingBottom="2"
 *    paddingLeft="2"
 *    paddingRight="0"
 *    paddingTop="2"
 *    rollOverColor="0xEEFEE6"
 *    selectionColor="0x7FCEFF"
 *    selectionDisabledColor="0xDDDDDD"
 *    selectionDuration="250"
 *    selectionEasingFunction="undefined"
 *    textRollOverColor="0x2B333C"
 *    textSelectedColor="0x2B333C"
 *    useRollOver="true|false"
 *    verticalAlign="top|middle|bottom"
 * 
 *    <b>Events</b>
 *    change="<i>No default</i>"
 *    dataChange="<i>No default</i>"
 *    itemClick="<i>No default</i>"
 *    itemDoubleClick="<i>No default</i>"
 *    itemRollOut="<i>No default</i>"
 *    itemRollOver="<i>No default</i>"
 *   /&gt;
 *  </pre>
 *
 *  @see mx.collections.ICollectionView
	 */
	public class ListBase extends ScrollControlBase implements IDataRenderer
	{
		/**
		 *  @private
     *  Anything in this list of styles will trigger a full repaint.
		 */
		private var IS_ITEM_STYLE : Object;
		/**
		 *  @private
     *  Mouse movement threshold for determining when to start a drag.
		 */
		static const DRAG_THRESHOLD : int = 4;
		/**
		 *  @private
     *  Placeholder for mixin by ListBaseAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  An ICollectionView that represents the data provider.
     *  When you set the <code>dataProvider</code> property,
     *  Flex wraps the data provider as necessary to 
     *  support the ICollectionView interface and 
     *  sets this property to the result.
     *  The ListBase class then uses this property to access
     *  data in the provider.
     *  When you  get the <code>dataProvider</code> property, 
     *  Flex returns this value.
		 */
		protected var collection : ICollectionView;
		/**
		 *  The main IViewCursor used to fetch items from the
     *  data provider and pass the items to the renderers.
     *  At the end of any sequence of code, it must always
     *  be positioned at the topmost visible item being displayed.
		 */
		protected var iterator : IViewCursor;
		/**
		 *  A flag that indicates that a page fault as occurred and that
     *  the iterator's position is not valid (not positioned at the topmost
     *  item being displayed).
     *  If the component gets a page fault (an ItemPending error), 
     *  it sets <code>iteratorValid</code> to <code>false</code>. Code that
     *  normally handles the rendering of items checks this flag and does not 
     *  run until the page of data comes in from the server.
		 */
		protected var iteratorValid : Boolean;
		/**
		 *  The most recent seek that caused a page fault.
     *  If there are multiple page faults, only the most recent one
     *  is of interest, as that is where to position the iterator 
     *  and start rendering rows again.
		 */
		protected var lastSeekPending : ListBaseSeekPending;
		/**
		 *  An internal display object that parents all of the item renderers,
     *  selection and highlighting indicators and other supporting graphics.
     *  This is roughly equivalent to the <code>contentPane</code> in the 
     *  Container class, and is used for managing scrolling.
		 */
		protected var listContent : ListBaseContentHolder;
		private static var _listContentStyleFilters : Object;
		/**
		 *  The layer in <code>listContent</code> where all selection 
     *  and highlight indicators are drawn.
		 */
		protected var selectionLayer : Sprite;
		/**
		 *  A hash map of item renderers to their respective ListRowInfo object.
     *  The ListRowInfo object is indexed by the DisplayObject name of the
     *  item renderer.
		 */
		protected var rowMap : Object;
		/**
		 *  A map of item renderers by factory.
     *  This property is a Dictionary indexed by itemRenderers
     *  where the values are IFactory.
     *
		 */
		protected var factoryMap : Dictionary;
		/**
		 *  A stack of unused item renderers.
     *  Most list classes recycle renderers they've already created
     *  as they scroll out of the displayable area; doing so 
     *  saves time during scrolling.
     *  The recycled renderers are stored here.
		 */
		protected var freeItemRenderers : Array;
		/**
		 *  A map of free item renderers by factory.
     *  This property is a Dictionary indexed by factories
     *  where the values are Dictionaries of itemRenderers.
     *
		 */
		protected var freeItemRenderersByFactory : Dictionary;
		/**
		 *  A hash map of currently unused item renderers that may be
     *  used again in the near future. Used when running data effects.
     *  The map is indexed by the data provider item's UID.
		 */
		protected var reservedItemRenderers : Object;
		/**
		 *  A hash map of item renderers that are not subject
     *  to the layout algorithms of the list.
		 */
		protected var unconstrainedRenderers : Dictionary;
		/**
		 *  A dictionary mapping item renderers to the ItemWrappers
     *  used to supply their data. Only applicable if a data
     *  effect is running.
		 */
		protected var dataItemWrappersByRenderer : Dictionary;
		/**
		 *  A flag that indicates if a data effect should be initiated
     *  the next time the display is updated.
		 */
		protected var runDataEffectNextUpdate : Boolean;
		/**
		 *  A flag indicating if a data change effect is currently running.
		 */
		protected var runningDataEffect : Boolean;
		/**
		 *  The effect that plays when changes occur in the data
     *  provider for the control, set through the itemsChangeEffect
     *  style.
		 */
		protected var cachedItemsChangeEffect : IEffect;
		/**
		 *  The collection view that temporarily preserves previous
     *  data provider state to facilitate running data change effects.
		 */
		protected var modifiedCollectionView : ModifiedCollectionView;
		/**
		 *  A copy of the value normally stored in <code>collection</code>
     *  used while running data changes effects. This value should be
     *  null when a data change effect is not running.
		 */
		protected var actualCollection : ICollectionView;
		/**
		 *  The target number of extra rows of item renderers to be used in 
     *  the layout of the control. Half of these rows are created 
     *  above the visible onscreen rows; half are created below.
     * 
     *  Typically this property is set indirectly when you set the 
     *  <code>offscreenExtraRowsOrColumns</code> property.
     *
     *  @default 0
		 */
		protected var offscreenExtraRows : int;
		/**
		 *  The number of offscreen rows currently above the topmost visible
     *  row. This value will be &lt;= <code>offscreenExtraRows</code> / 2.
     *  It is used when computing the relationship of <code>listItems</code> and 
     *  <code>rowInfo</code> Arrays to items in the data provider (in conjunction
     *  with <code>verticalScrollPosition</code> property).
     *
     *  @default 0
		 */
		protected var offscreenExtraRowsTop : int;
		/**
		 *  The number of offscreen rows currently below the bottom visible
     *  item renderer. This value will be &lt;= <code>offscreenExtraRows</code> / 2.
     *
     *  @default 0
		 */
		protected var offscreenExtraRowsBottom : int;
		/**
		 *  The target number of extra columns of item renderers used in the 
     *  layout of the control. Half of these columns are created to  
     *  the left of the visible onscreen columns; half are created 
     *  to the right.
     * 
     *  Typically this property will be set indirectly when you set the 
     *  <code>offscreenExtraRowsOrColumns</code> property.
     *
     *  @default 0
		 */
		protected var offscreenExtraColumns : int;
		/**
		 *  The number of offscreen columns currently to the left of the 
     *  leftmost visible column. 
     *  This value will be &lt;= <code>offscreenExtraColumns</code> / 2.
     *
     *  @default 0
		 */
		protected var offscreenExtraColumnsLeft : int;
		/**
		 *  The number of offscreen columns currently to the right of the 
     *  right visible column. 
     *  This value will be &lt;= <code>offscreenExtraColumns</code> / 2.
     *
     *  @default 0
		 */
		protected var offscreenExtraColumnsRight : int;
		/**
		 *  A copy of the value normally stored in <code>iterator</code>
     *  used while running data changes effects.
		 */
		protected var actualIterator : IViewCursor;
		/**
		 *  @private
     *  A flag indicating whether layout code in makeRowsAndColumns()
     *  should be allowed to "steal" renderers. This is needed for
     *  data effects (preserving renderers across multiple layout passes)
     *  but specifically bad for incremental scrolling in the degenerate
     *  case where there are duplicate items in the data provider.
		 */
		var allowRendererStealingDuringLayout : Boolean;
		/**
		 *  The UID of the item that is current rolled over or under the caret.
		 */
		protected var highlightUID : String;
		/**
		 *  The renderer that is currently rolled over or under the caret.
		 */
		protected var highlightItemRenderer : IListItemRenderer;
		/**
		 *  The DisplayObject that contains the graphics that indicates
     *  which renderer is highlighted.
		 */
		protected var highlightIndicator : Sprite;
		/**
		 *  The UID of the item under the caret.
		 */
		protected var caretUID : String;
		/**
		 *  The renderer for the item under the caret.  In the selection
     *  model, there is an anchor, a caret and a highlighted item.  When
     *  the mouse is being used for selection, the item under the mouse is
     *  highlighted as the mouse rolls over the item.  
     *  When the mouse is clicked with no modifier keys (Shift or Ctrl), the
     *  set of selected items is cleared and the item under the highlight is
     *  selected and becomes the anchor. The caret is unused in mouse
     *  selection.  If there is an anchor and another item is selected while
     *  using the Shift key, the old set of selected items is cleared, and
     *  all items between the item and the anchor are selected.  Clicking
     *  items while using the Ctrl key toggles the selection of individual
     *  items and does not move the anchor.
     *
     *  <p>When selecting items using the keyboard, if the arrow keys are used
     *  with no modifier keys, the old selection is cleared and the new item
     *  is selected and becomes the anchor and the caret, and a caret indicator
     *  is shown around the selection highlight. If the user uses arrow keys
     *  with the Shift key, the old selection is cleared and the items between
     *  the anchor and the new item are selected. The caret moves to the new
     *  item. If arrow keys are used with the Ctrl key, just the caret moves.
     *  The user can use the Space key to toggle selection of the item under
     *  the caret.</p>
		 */
		protected var caretItemRenderer : IListItemRenderer;
		/**
		 *  The DisplayObject that contains the graphics that indicate
     *  which renderer is the caret.
		 */
		protected var caretIndicator : Sprite;
		/**
		 *  A hash table of ListBaseSelectionData objects that track which
     *  items are currently selected. The table is indexed by the UID
     *  of the items.
     *
     *  @see mx.controls.listClasses.ListBaseSelectionData
		 */
		protected var selectedData : Object;
		/**
		 *  A hash table of selection indicators. This table allows the component
     *  to quickly find and remove the indicators when the set of selected
     *  items is cleared. The table is indexed by the item's UID.
		 */
		protected var selectionIndicators : Object;
		/**
		 *  A hash table of selection tweens. This allows the component to
     *  quickly find and clean up any tweens in progress if the set
     *  of selected items is cleared. The table is indexed by the item's UID.
		 */
		protected var selectionTweens : Object;
		/**
		 *  A bookmark to the item under the caret. A bookmark allows the
     *  component to quickly seek to a position in the collection of items.
		 */
		protected var caretBookmark : CursorBookmark;
		/**
		 *  A bookmark to the item that is the anchor. A bookmark allows the
     *  component to quickly seek to a position in the collection of items.
     *  This property is used when selecting a set of items between the anchor
     *  and the caret or highlighted item, and when finding the selected item
     *  after a Sort or Filter is applied.
		 */
		protected var anchorBookmark : CursorBookmark;
		/**
		 *  A flag that indicates whether to show caret.  
     *  This property is usually set
     *  to <code>false</code> when mouse activity is detected and set back to 
     *  <code>true</code> when the keyboard is used for selection.
		 */
		protected var showCaret : Boolean;
		/**
		 *  The most recently calculated index where the drag item
     *  should be added to the drop target.
		 */
		protected var lastDropIndex : int;
		/**
		 *  A flag that indicates whether the <code>columnWidth</code> 
     *  and <code>rowHeight</code> properties need to be calculated.
     *  This property is set if a style changes that can affect the
     *  measurements of the renderer, or if the data provider is changed.
		 */
		protected var itemsNeedMeasurement : Boolean;
		/**
		 *  A flag that indicates that the size of the renderers may have changed.
     *  The component usually responds by re-applying the data items to all of
     *  the renderers on the next <code>updateDisplayList()</code> call.
     *  There is an assumption that re-applying the items will invalidate the
     *  item renderers and cause them to re-measure.
		 */
		protected var itemsSizeChanged : Boolean;
		/**
		 *  A flag that indicates that the renderer changed.
     *  The component usually responds by destroying all existing renderers
     *  and redrawing all of the renderers on the next 
     *  <code>updateDisplayList()</code> call.
		 */
		protected var rendererChanged : Boolean;
		/**
		 *  A flag that indicates that the a data change effect has
     *  just completed.
     *  The component usually responds by cleaning up various 
     *  internal data structures on the next 
     *  <code>updateDisplayList()</code> call.
		 */
		protected var dataEffectCompleted : Boolean;
		/**
		 *  A flag that indicates whether the value of the <code>wordWrap</code> 
     *  property has changed since the last time the display list was updated.
     *  This property is set when you change the <code>wordWrap</code> 
     *  property value, and is reset 
     *  to <code>false</code> by the <code>updateDisplayList()</code> method.
     *  The component usually responds by re-applying the data items to all of
     *  the renderers on the next <code>updateDisplayList()</code> call.
     *  This is different from itemsSizeChanged because it further indicates
     *  that re-applying the data items to the renderers may not invalidate them
     *  since the only thing that changed was whether or not the renderer should
     *  factor in wordWrap into its size calculations.
		 */
		protected var wordWrapChanged : Boolean;
		/**
		 *  A flag that indicates if keyboard selection was interrupted by 
     *  a page fault.  The component responds by suspending the rendering
     *  of items until the page of data arrives.
     *  The <code>finishKeySelection()</code> method will be called
     *  when the paged data arrives.
		 */
		protected var keySelectionPending : Boolean;
		/**
		 *  @private
     *  Cached style value.
		 */
		var cachedPaddingTop : Number;
		/**
		 *  @private
     *  Cached style value.
		 */
		var cachedPaddingBottom : Number;
		/**
		 *  @private
     *  Cached style value.
		 */
		var cachedVerticalAlign : String;
		/**
		 *  @private
		 */
		private var oldUnscaledWidth : Number;
		/**
		 *  @private
		 */
		private var oldUnscaledHeight : Number;
		/**
		 *  @private
		 */
		private var horizontalScrollPositionPending : Number;
		/**
		 *  @private
		 */
		private var verticalScrollPositionPending : Number;
		/**
		 *  @private
		 */
		private var mouseDownPoint : Point;
		/**
		 *  @private
		 */
		private var bSortItemPending : Boolean;
		private var bShiftKey : Boolean;
		private var bCtrlKey : Boolean;
		private var lastKey : uint;
		private var bSelectItem : Boolean;
		/**
		 *  @private
     *  true if we don't know for sure what index we're on in the database
		 */
		private var approximate : Boolean;
		var bColumnScrolling : Boolean;
		var listType : String;
		var bSelectOnRelease : Boolean;
		private var mouseDownItem : IListItemRenderer;
		var bSelectionChanged : Boolean;
		var bSelectedIndexChanged : Boolean;
		private var bSelectedItemChanged : Boolean;
		private var bSelectedItemsChanged : Boolean;
		private var bSelectedIndicesChanged : Boolean;
		/**
		 *  @private
     *  Dirty flag for the cache style value cachedPaddingTop.
		 */
		private var cachedPaddingTopInvalid : Boolean;
		/**
		 *  @private
     *  Dirty flag for the cache style value cachedPaddingBottom.
		 */
		private var cachedPaddingBottomInvalid : Boolean;
		/**
		 *  @private
     *  Dirty flag for the cache style value cachedVerticalAlign.
		 */
		private var cachedVerticalAlignInvalid : Boolean;
		/**
		 *  @private
     *  The first ListBaseSelectionData in a link list of ListBaseSelectionData.
     *  This represents the item that was most recently selected.  
     *  ListBaseSelectionData instances are linked together and keep track of the 
     *  order the user selects an item.  This order is reflected in selectedIndices 
     *  and selectedItems.
		 */
		private var firstSelectionData : ListBaseSelectionData;
		/**
		 *  @private
     *  The last ListBaseSelectionData in a link list of ListBaseSelectionData.
     *  This represents the item that was first selected.  
     *  ListBaseSelectionData instances are linked together and keep track of the 
     *  order the user selects an item.  This order is reflected in selectedIndices 
     *  and selectedItems.
		 */
		private var lastSelectionData : ListBaseSelectionData;
		/**
		 *  The first proposed selectedItem.  Because the loop where it is used
     *  can be called several times becaouse of IPEs, we have to store stuff like
     *  this outside the loop
		 */
		private var firstSelectedItem : Object;
		/**
		 *  A map of proposed selectedItems to the original order
     *  they were proposed.  Because the loop where it is used
     *  can be called several times becaouse of IPEs, we have to store stuff like
     *  this outside the loop
		 */
		private var proposedSelectedItemIndexes : Dictionary;
		/**
		 *  The renderer that is or was rolled over or under the caret.
     *  In DG, this is always column 0
		 */
		var lastHighlightItemRenderer : IListItemRenderer;
		/**
		 *  The renderer that is or was rolled over or under the caret.
     *  In DG, this is the actual item
		 */
		var lastHighlightItemRendererAtIndices : IListItemRenderer;
		/**
		 *  The last coordinate send in ITEM_ROLL_OVER
		 */
		private var lastHighlightItemIndices : Point;
		/**
		 *  Temporary array to manage order of selectedItems
		 */
		private var selectionDataArray : Array;
		var dragScrollingInterval : int;
		/**
		 *  @private
     *  An Array of Shapes that are used as clip masks for the list items
		 */
		var itemMaskFreeList : Array;
		/**
		 *  @private
     *  An array of item renderers being tracked for MoveEvents while 
     *  data change effects are running.
		 */
		private var trackedRenderers : Array;
		/**
		 *  @private
     *  A flag used to avoid tracking renderers for MoveEvents when
     *  running updateDisplayList.
		 */
		private var rendererTrackingSuspended : Boolean;
		/**
		 *  @private
     *  Whether the mouse button is pressed
		 */
		var isPressed : Boolean;
		/**
		 *  A separate IViewCursor used to find indices of items and
     *  other things. The collectionIterator can be at any
     *  place within the set of items.
		 */
		var collectionIterator : IViewCursor;
		var dropIndicator : IFlexDisplayObject;
		var lastDragEvent : DragEvent;
		/**
		 *  A flag that indicates whether drag-selection is enabled.
     *  Drag-Selection is the ability to select an item by dragging
     *  into it as opposed to normal selection where you can't have
     *  the mouse button down when you mouse over the item you want
     *  to select.  This feature is used in ComboBox dropdowns
     *  to support pressing the mouse button when the mouse is over the 
     *  dropdown button then dragging the mouse into the dropdown to select
     *  an item.
     *
     *  @default false
		 */
		public var allowDragSelection : Boolean;
		/**
		 *  @private
     *  Storage for the allowMultipleSelection property.
		 */
		private var _allowMultipleSelection : Boolean;
		/**
		 *  The offset of the item in the data provider that is the selection
     *  anchor point.
		 */
		protected var anchorIndex : int;
		/**
		 *  The offset of the item in the data provider that is the selection
     *  caret point.
     *
     *  @see mx.controls.listClasses.ListBase#caretItemRenderer
		 */
		protected var caretIndex : int;
		/**
		 *  @private
     *  Storage for the columnCount property.
		 */
		private var _columnCount : int;
		/**
		 *  @private
		 */
		private var columnCountChanged : Boolean;
		/**
		 *  @private
     *  Storage for the columnWidth property.
		 */
		private var _columnWidth : Number;
		/**
		 *  @private
		 */
		private var columnWidthChanged : Boolean;
		/**
		 *  @private
     *  Storage for the data property.
		 */
		private var _data : Object;
		/**
		 *  @private
     *  Storage for the dataTipField property.
		 */
		private var _dataTipField : String;
		/**
		 *  @private
     *  Storage for the dataTipFunction property.
		 */
		private var _dataTipFunction : Function;
		/**
		 *  The default number of columns to display.  This value
     *  is used if the calculation for the number of
     *  columns results in a value less than 1 when
     *  trying to calculate the columnCount based on size or
     *  content.
     *
     *  @default 4
		 */
		protected var defaultColumnCount : int;
		/**
		 *  The default number of rows to display.  This value
     *  is used  if the calculation for the number of
     *  columns results in a value less than 1 when
     *  trying to calculate the rowCount based on size or
     *  content.
     *
     *  @default 4
		 */
		protected var defaultRowCount : int;
		/**
		 *  @private
     *  Storage for the dragEnabled property.
		 */
		private var _dragEnabled : Boolean;
		/**
		 *  @private
     *  Storage for the dragMoveEnabled property.
		 */
		private var _dragMoveEnabled : Boolean;
		/**
		 *  @private
     *  Storage for the <code>dropEnabled</code> property.
		 */
		private var _dropEnabled : Boolean;
		/**
		 *  The column count requested by explicitly setting the
     *  <code>columnCount</code> property.
		 */
		protected var explicitColumnCount : int;
		/**
		 *  The column width requested by explicitly setting the 
     *  <code>columnWidth</code>.
		 */
		protected var explicitColumnWidth : Number;
		/**
		 *  The row count requested by explicitly setting
     *  <code>rowCount</code>.
		 */
		protected var explicitRowCount : int;
		/**
		 *  The row height requested by explicitly setting
     *  <code>rowHeight</code>.
		 */
		protected var explicitRowHeight : Number;
		/**
		 *  @private
     *  Storage for iconField property.
		 */
		private var _iconField : String;
		/**
		 *  @private
     *  Storage for iconFunction property.
		 */
		private var _iconFunction : Function;
		/**
		 *  @private
     *  Storage for the itemRenderer property.
		 */
		private var _itemRenderer : IFactory;
		/**
		 *  @private
     *  Storage for labelField property.
		 */
		private var _labelField : String;
		/**
		 *  @private
     *  Storage for labelFunction property.
		 */
		private var _labelFunction : Function;
		/**
		 *  @private
     *  Storage for the listData property.
		 */
		private var _listData : BaseListData;
		/**
		 *  A flag that indicates whether menu-style selection
     *  should be used.
     *  In a Menu, dragging from
     *  one renderer into another selects the new one
     *  and un-selects the old.
		 */
		public var menuSelectionMode : Boolean;
		/**
		 *  @private
     *  Storage for offscreenExtraRowsOrColumns property
		 */
		private var _offscreenExtraRowsOrColumns : int;
		/**
		 *  A flag indicating that the number of offscreen rows or columns
     *  may have changed.
		 */
		protected var offscreenExtraRowsOrColumnsChanged : Boolean;
		/**
		 *  @private
     *  Storage for the nullItemRenderer property.
		 */
		private var _nullItemRenderer : IFactory;
		/**
		 *  @private
     *  Storage for the rowCount property.
		 */
		private var _rowCount : int;
		/**
		 *  @private
		 */
		private var rowCountChanged : Boolean;
		/**
		 *  @private
     *  Storage for the rowHeight property.
		 */
		private var _rowHeight : Number;
		/**
		 *  @private
		 */
		private var rowHeightChanged : Boolean;
		/**
		 *  @private
     *  Storage for the selectable property.
		 */
		private var _selectable : Boolean;
		/**
		 *  @private
     *  Storage for the selectedIndex property.
		 */
		var _selectedIndex : int;
		private var _selectedIndices : Array;
		/**
		 *  @private
     *  Storage for the selectedItem property.
		 */
		private var _selectedItem : Object;
		private var _selectedItems : Array;
		/**
		 *  @private
     *  Storage for labelFunction property.
		 */
		private var _selectedItemsCompareFunction : Function;
		/**
		 *  @private
     *  Storage for the showDataTips property.
		 */
		private var _showDataTips : Boolean;
		/**
		 *  @private
     *  Storage for the variableRowHeight property.
		 */
		private var _variableRowHeight : Boolean;
		/**
		 *  @private
     *  Storage for the wordWrap property.
		 */
		private var _wordWrap : Boolean;

		/**
		 *  A hash table of data provider item renderers currently in view.
     *  The table is indexed by the data provider item's UID and is used
     *  to quickly get the renderer used to display a particular item.
		 */
		protected function get visibleData () : Object;

		/**
		 *  The set of styles to pass from the ListBase to the listContent.
     *  @see mx.styles.StyleProxy
		 */
		protected function get listContentStyleFilters () : Object;

		/**
		 *  An Array of Arrays that contains
     *  the itemRenderer instances that render each data provider item.
     *  This is a two-dimensional row major array
     *  (array of rows that are arrays of columns).
		 */
		protected function get listItems () : Array;

		/**
		 *  An array of ListRowInfo objects that cache row heights and 
     *  other tracking information for the rows in listItems.
		 */
		protected function get rowInfo () : Array;

		/**
		 *  diagnostics
		 */
		function get rendererArray () : Array;

		/**
		 *  @private
     *  The baseline position of a ListBase is calculated
     *  for the first item renderer.
     *  If there are no items, one is temporarily added
     *  to do the calculation.
		 */
		public function get baselinePosition () : Number;

		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;

		/**
		 *  @private
		 */
		public function get horizontalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set horizontalScrollPosition (value:Number) : void;

		function set $horizontalScrollPosition (value:Number) : void;

		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;

		/**
		 *  @private
		 */
		public function get verticalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set verticalScrollPosition (value:Number) : void;

		function set $verticalScrollPosition (value:Number) : void;

		/**
		 *  A flag that indicates whether you can allow more than one item to be
     *  selected at the same time.
     *  If <code>true</code>, users can select multiple items.
     *  There is no option to disallow discontiguous selection.
     *  Standard complex selection options are always in effect 
     *  (Shift-click, Ctrl-click).
     *
     *  @default false
		 */
		public function get allowMultipleSelection () : Boolean;
		/**
		 *  @private
		 */
		public function set allowMultipleSelection (value:Boolean) : void;

		/**
		 *  The number of columns to be displayed in a TileList control or items 
     *  in a HorizontalList control.
     *  For the DataGrid it is the number of visible columns.
     *  <b>Note</b>: Setting this property has no effect on a DataGrid control,
     *  which bases the number of columns on the control width and the
     *  individual column widths.
     * 
     *  @default 4
		 */
		public function get columnCount () : int;
		/**
		 *  @private
		 */
		public function set columnCount (value:int) : void;

		/**
		 *  The width of the control's columns.
     *  This property is used by TileList and HorizontalList controls;
     *  It has no effect on DataGrid controls, where you set the individual
     *  DataGridColumn widths.
     *  
     * @default 50
		 */
		public function get columnWidth () : Number;
		/**
		 *  @private
		 */
		public function set columnWidth (value:Number) : void;

		/**
		 *  The item in the data provider this component should render when
     *  this component is used as an item renderer or item editor.
     *  The list class sets this property on each renderer or editor
     *  and the component displays the data.  ListBase-derived classes
     *  support this property for complex situations like having a
     *  List of DataGrids or a DataGrid where one column is a List.
     *
     *  <p>The list classes use the <code>listData</code> property
     *  in addition to the <code>data</code> property to determine what
     *  to display.
     *  If the list class is in a DataGrid it expects the <code>dataField</code>
     *  property of the column to map to a property in the data
     *  and sets <code>selectedItem</code> value to that property.
     *  If it is in a List or TileList control, it expects the 
     *  <code>labelField</code> property of the list to map to a property 
     *  in the data, and sets <code>selectedItem</code> value to that property.
     *  Otherwise it sets the <code>selectedItem</code> to the data itself.</p>
     * 
     *  <p>This property uses the data provider but does not set it. 
     *  In all cases, you must set the data provider in some other way.</p>
     *
     *  <p>You do not set this property in MXML.</p>
     *
     *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;

		/**
		 *  Set of data to be viewed.
     *  This property lets you use most types of objects as data providers.
     *  If you set the <code>dataProvider</code> property to an Array, 
     *  it will be converted to an ArrayCollection. If you set the property to
     *  an XML object, it will be converted into an XMLListCollection with
     *  only one item. If you set the property to an XMLList, it will be 
     *  converted to an XMLListCollection.  
     *  If you set the property to an object that implements the 
     *  IList or ICollectionView interface, the object will be used directly.
     *
     *  <p>As a consequence of the conversions, when you get the 
     *  <code>dataProvider</code> property, it will always be
     *  an ICollectionView, and therefore not necessarily be the type of object
     *  you used to  you set the property.
     *  This behavior is important to understand if you want to modify the data 
     *  in the data provider: changes to the original data may not be detected, 
     *  but changes to the ICollectionView object that you get back from the 
     *  <code>dataProvider</code> property will be detected.</p>
     * 
     *  @default null
     *  @see mx.collections.ICollectionView
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;

		/**
		 *  Name of the field in the data provider items to display as the 
     *  data tip. By default, the list looks for a property named 
     *  <code>label</code> on each item and displays it.
     *  However, if the data objects do not contain a <code>label</code> 
     *  property, you can set the <code>dataTipField</code> property to
     *  use a different property in the data object. An example would be 
     *  "FullName" when viewing a
     *  set of people's names retrieved from a database.
     * 
     *  @default null
		 */
		public function get dataTipField () : String;
		/**
		 *  @private
		 */
		public function set dataTipField (value:String) : void;

		/**
		 *  User-supplied function to run on each item to determine its dataTip.  
     *  By default, the list looks for a property named <code>label</code> 
     *  on each data provider item and displays it.
     *  However, some items do not have a <code>label</code> property 
     *  nor do they have another property that can be used for displaying 
     *  in the rows. An example is a data set that has lastName and firstName 
     *  fields, but you want to display full names. You can supply a 
     *  <code>dataTipFunction</code> that finds the appropriate
     *  fields and return a displayable string. The 
     *  <code>dataTipFunction</code> is also good for handling formatting
     *  and localization.
     *
     *  <p>The dataTipFunction takes a single argument which is the item
     *  in the data provider and returns a String:</p>
     * 
     *  <blockquote>
     *  <code>myDataTipFunction(item:Object):String</code>
     *  </blockquote>
     * 
     *  @default null
		 */
		public function get dataTipFunction () : Function;
		/**
		 *  @private
		 */
		public function set dataTipFunction (value:Function) : void;

		/**
		 *  A flag that indicates whether you can drag items out of
     *  this control and drop them on other controls.
     *  If <code>true</code>, dragging is enabled for the control.
     *  If the <code>dropEnabled</code> property is also <code>true</code>,
     *  you can drag items and drop them within this control
     *  to reorder the items.
     *
     *  @default false
		 */
		public function get dragEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set dragEnabled (value:Boolean) : void;

		/**
		 *  Gets an instance of a class that displays the visuals
     *  during a drag and drop operation.
     *
     *  @default mx.controls.listClasses.ListItemDragProxy
		 */
		protected function get dragImage () : IUIComponent;

		/**
		 *  Gets the offset of the drag image for drag and drop.
		 */
		protected function get dragImageOffsets () : Point;

		/**
		 *  A flag that indicates whether items can be moved instead
     *  of just copied from the control as part of a drag-and-drop
     *  operation.
     *  If <code>true</code>, and the <code>dragEnabled</code> property
     *  is <code>true</code>, items can be moved.
     *  Often the data provider cannot or should not have items removed
     *  from it, so a MOVE operation should not be allowed during
     *  drag-and-drop.
     *
     *  @default false
		 */
		public function get dragMoveEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set dragMoveEnabled (value:Boolean) : void;

		/**
		 *  A flag that indicates whether dragged items can be dropped onto the 
     *  control.
     *
     *  <p>If you set this property to <code>true</code>,
     *  the control accepts all data formats, and assumes that
     *  the dragged data matches the format of the data in the data provider.
     *  If you want to explicitly check the data format of the data
     *  being dragged, you must handle one or more of the drag events,
     *  such as <code>dragOver</code>, and call the DragEvent's
     *  <code>preventDefault()</code> method to customize
     *  the way the list class accepts dropped data.</p>
     *
     *  <p>When you set <code>dropEnabled</code> to <code>true</code>, 
     *  Flex automatically calls the <code>showDropFeedback()</code> 
     *  and <code>hideDropFeedback()</code> methods to display the drop indicator.</p>
     *
     *  @default false
		 */
		public function get dropEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set dropEnabled (value:Boolean) : void;

		/**
		 *  The name of the field in the data provider object that determines what to 
     *  display as the icon. By default, the list class does not try to display 
     *  icons with the text in the rows. However, by specifying an icon 
     *  field, you can specify a graphic that is created and displayed as an 
     *  icon in the row.  This property is ignored by DataGrid.
     *
     *  <p>The renderers will look in the data provider object for a property of 
     *  the name supplied as the iconField.  If the value of the property is a 
     *  Class, it will instantiate that class and expect it to be an instance 
     *  of an IFlexDisplayObject. If the value of the property is a String, 
     *  it will look to see if a Class exists with that name in the application, 
     *  and if it can't find one, it will also look for a property on the 
     *  document with that name and expect that property to map to a Class.</p>
     *
     *  @default null
		 */
		public function get iconField () : String;
		/**
		 *  @private
		 */
		public function set iconField (value:String) : void;

		/**
		 *  A user-supplied function to run on each item to determine its icon.  
     *  By default the list does not try to display icons with the text 
     *  in the rows.  However, by specifying an icon function, you can specify 
     *  a Class for a graphic that will be created and displayed as an icon 
     *  in the row.  This property is ignored by DataGrid.
     *
     *  <p>The iconFunction takes a single argument which is the item
     *  in the data provider and returns a Class.</p>
     * 
     *  <blockquote>
     *  <code>iconFunction(item:Object):Class</code>
     *  </blockquote>
     * 
     *  @default null
		 */
		public function get iconFunction () : Function;
		/**
		 *  @private
		 */
		public function set iconFunction (value:Function) : void;

		/**
		 *  The custom item renderer for the control.
     *  You can specify a drop-in, inline, or custom item renderer.
     *
     *  <p>The default item renderer depends on the component class. 
     *  The TileList and HorizontalList class use 
     *  TileListItemRenderer, The List class uses ListItemRenderer.
     *  The DataGrid class uses DataGridItemRenderer from DataGridColumn.</p>
		 */
		public function get itemRenderer () : IFactory;
		/**
		 *  @private
		 */
		public function set itemRenderer (value:IFactory) : void;

		/**
		 *  The name of the field in the data provider items to display as the label. 
     *  By default the list looks for a property named <code>label</code> 
     *  on each item and displays it.
     *  However, if the data objects do not contain a <code>label</code> 
     *  property, you can set the <code>labelField</code> property to
     *  use a different property in the data object. An example would be 
     *  "FullName" when viewing a set of people names fetched from a database.
     *
     *  @default "label"
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;

		/**
		 *  A user-supplied function to run on each item to determine its label.  
     *  By default, the list looks for a property named <code>label</code> 
     *  on each data provider item and displays it.
     *  However, some data sets do not have a <code>label</code> property
     *  nor do they have another property that can be used for displaying.
     *  An example is a data set that has lastName and firstName fields
     *  but you want to display full names.
     *
     *  <p>You can supply a <code>labelFunction</code> that finds the 
     *  appropriate fields and returns a displayable string. The 
     *  <code>labelFunction</code> is also good for handling formatting and 
     *  localization. </p>
     *
     *  <p>For most components, the label function takes a single argument
     *  which is the item in the data provider and returns a String.</p>
     *  <pre>
     *  myLabelFunction(item:Object):String</pre>
     *
     *  <p>The method signature for the DataGrid and DataGridColumn classes is:</p>
     *  <pre>
     *  myLabelFunction(item:Object, column:DataGridColumn):String</pre>
     * 
     *  <p>where <code>item</code> contains the DataGrid item object, and
     *  <code>column</code> specifies the DataGrid column.</p>
     *
     *  @default null
		 */
		public function get labelFunction () : Function;
		/**
		 *  @private
		 */
		public function set labelFunction (value:Function) : void;

		/**
		 *  
     *  When a component is used as a drop-in item renderer or drop-in
     *  item editor, Flex initializes the <code>listData</code> property
     *  of the component with the additional data from the list control.
     *  The component can then use the <code>listData</code> property
     *  and the <code>data</code> property to display the appropriate
     *  information as a drop-in item renderer or drop-in item editor.
     *
     *  <p>You do not set this property in MXML or ActionScript;
     *  Flex sets it when the component is used as a drop-in item renderer
     *  or drop-in item editor.</p>
     *
     *  @see mx.controls.listClasses.IDropInListItemRenderer
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;

		/**
		 *  The target number of extra rows or columns of item renderers to be used 
     *  in the layout of the control. Half of these rows/columns are created 
     *  above or to the left of the visible onscreen rows/columns; 
     *  half are created below or to the right.
     * 
     *  <p>Whether rows or columns are created is dependent on the control and its
     *  properties. Generally rows will be used, except for TileBase components
     *  where <code>direction</code> is set to <code>TileBaseDirection.VERTICAL</code>.
     *  In that case, columns are created.</p>
     * 
     *  <p>You set this property to a non-zero value primarily 
     *  when applying data effects to the List or TileList controls. 
     *  Changes that affect 
     *  the data provider element corresponding to the currently visible items, or 
     *  changes that affect the data provider element for the specified number of 
     *  items before or after the visible items, trigger the data effect.
     *  Data provider elements outside this range may not be 
     *  animated perfectly by the data effect.</p>
     *
     *  <p>This property is useful because data effects work by first determining 
     *  a 'before' layout of the list-based control, then determining an 'after' layout, 
     *  and finally setting the properties of the effect to create an animation 
     *  from the before layout to the after layout. 
     *  Since many effects cause currently invisible items to become visible, 
     *  or currently visible items to become invisible, this property configures the control 
     *  to create the offscreen item renderers so that they already exist when the data effect plays. </p>
     *
     *  <p>A reasonable value for this property might be the number
     *  of rows visible onscreen. Setting it to a very large value may
     *  cause performance problems when used with a data provider that contains 
     *  a large number of elements.</p>
     *
     *  @default 0
		 */
		public function get offscreenExtraRowsOrColumns () : int;
		public function set offscreenExtraRowsOrColumns (value:int) : void;

		/**
		 *  The custom item renderer for the control.
     *  You can specify a drop-in, inline, or custom item renderer.
     *
     *  <p>The default item renderer depends on the component class. 
     *  The TileList and HorizontalList class use 
     *  TileListItemRenderer, The List class uses ListItemRenderer.
     *  The DataGrid class uses DataGridItemRenderer from DataGridColumn.</p>
		 */
		public function get nullItemRenderer () : IFactory;
		/**
		 *  @private
		 */
		public function set nullItemRenderer (value:IFactory) : void;

		/**
		 *  Number of rows to be displayed.
     *  If the height of the component has been explicitly set,
     *  this property might not have any effect.
     *
     *  <p>For a DataGrid control, the <code>rowCount</code> property includes the  
     *  header row. 
     *  So, for a DataGrid control with 3 body rows and a header row, 
     *  the <code>rowCount</code> property is 4.</p>
     * 
     *  @default 4
		 */
		public function get rowCount () : int;
		/**
		 *  @private
		 */
		public function set rowCount (value:int) : void;

		/**
		 *  The height of the rows in pixels.
     *  Unless the <code>variableRowHeight</code> property is
     *  <code>true</code>, all rows are the same height.  
     *  If not specified, the row height is based on
     *  the font size and other properties of the renderer.
		 */
		public function get rowHeight () : Number;
		/**
		 *  @private
		 */
		public function set rowHeight (value:Number) : void;

		/**
		 *  A flag that indicates whether the list shows selected items
     *  as selected.
     *  If <code>true</code>, the control supports selection.
     *  The Menu class, which subclasses ListBase, sets this property to
     *  <code>false</code> by default, because it doesn't show the chosen
     *  menu item as selected.
     *
     *  @default true
		 */
		public function get selectable () : Boolean;
		/**
		 *  @private
		 */
		public function set selectable (value:Boolean) : void;

		/**
		 *  The index in the data provider of the selected item.
     * 
     *  <p>The default value is -1 (no selected item).</p>
     *
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;

		/**
		 *  An array of indices in the data provider of the selected items. The
     *  items are in the reverse order that the user selected the items.
     *  @default [ ]
		 */
		public function get selectedIndices () : Array;
		/**
		 *  @private
		 */
		public function set selectedIndices (indices:Array) : void;

		/**
		 *  A reference to the selected item in the data provider.
     * 
     *  @default null
		 */
		public function get selectedItem () : Object;
		/**
		 *  @private
		 */
		public function set selectedItem (data:Object) : void;

		/**
		 *  An array of references to the selected items in the data provider. The
     *  items are in the reverse order that the user selected the items.
     *  @default [ ]
		 */
		public function get selectedItems () : Array;
		/**
		 *  @private
		 */
		public function set selectedItems (items:Array) : void;

		/**
		 *  A function used to compare selectedItems against items in the
     *  dataProvider.  If there is a match, the item in the dataProvider
     *  becomes part of the selection.
   	 *  By default, or if selectedItemsCompareFunction is set to null
     *  the default comparision function is used which uses
     *  strict equality (===).  Note that earlier releases of
     *  Flex used simple equality (==) so there could be behavioral
     *  differences in certain cases.
     *  A common compare function might simply compare UIDs of objects
     *  or test that a particular property matches.
     *
     *  <p>The compare function takes a two arguments, the first being the
     *  object in the dataProvider, the other an object in the list of
     *  selectedItems, and returns TRUE if the item should be selected.</p>
     *  <pre>
     *  myCompareFunction(itemInDataProvider:Object, itemInSelectedItems):Boolean</pre>
     *
     *  @default null (which will use strict equality)
		 */
		public function get selectedItemsCompareFunction () : Function;
		/**
		 *  @private
		 */
		public function set selectedItemsCompareFunction (value:Function) : void;

		/**
		 *  A flag that indicates whether dataTips are displayed for text in the rows.
     *  If <code>true</code>, dataTips are displayed. DataTips
     *  are tooltips designed to show the text that is too long for the row.
     *  If you set a dataTipFunction, dataTips are shown regardless of whether the
     *  text is too long for the row.
     * 
     *  @default false
		 */
		public function get showDataTips () : Boolean;
		/**
		 *  @private
		 */
		public function set showDataTips (value:Boolean) : void;

		/**
		 *  The selected item, or the data or label field of the selected item.
     *  If the selected item is a Number or String
     *  the value is the item. If the item is an object, the value is
     *  the data property if it exists, or the label property if it exists.
     *
     *  <p>Note: Using <code>selectedItem</code> is often preferable. This
     *  property exists for backward compatibility with older applications.</p>
		 */
		public function get value () : Object;

		/**
		 *  A flag that indicates whether the individual rows can have different
     *  height. This property is ignored by TileList and HorizontalList.
     *  If <code>true</code>, individual rows can have different height values.
     * 
     *  @default false
		 */
		public function get variableRowHeight () : Boolean;
		/**
		 *  @private
		 */
		public function set variableRowHeight (value:Boolean) : void;

		/**
		 *  A flag that indicates whether text in the row should be word wrapped.
     *  If <code>true</code>, enables word wrapping for text in the rows.
     *  Only takes effect if the <code>variableRowHeight</code> property is also 
     *  <code>true</code>.
     *
     *  @default false
		 */
		public function get wordWrap () : Boolean;
		/**
		 *  @private
		 */
		public function set wordWrap (value:Boolean) : void;

		/**
		 *  If false, renderers cannot invalidate size of List.
		 */
		protected function set allowItemSizeChangeNotification (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function ListBase ();

		private function makeRowsAndColumnsWithExtraRows (unscaledWidth:Number, unscaledHeight:Number) : void;

		private function makeRowsAndColumnsWithExtraColumns (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  Internal version for setting columnCount
     *  without invalidation or notification.
		 */
		function setColumnCount (value:int) : void;

		/**
		 *  Internal version of setting columnWidth
     *  without invalidation or notification.
		 */
		function setColumnWidth (value:Number) : void;

		/**
		 *  Sets the <code>rowCount</code> property without causing
     *  invalidation or setting the <code>explicitRowCount</code>
     *  property, which permanently locks in the number of rows.
     *
     *  @param v The row count.
		 */
		protected function setRowCount (v:int) : void;

		/**
		 *  Sets the <code>rowHeight</code> property without causing invalidation or 
     *  setting of <code>explicitRowHeight</code> which
     *  permanently locks in the height of the rows.
     *
     *  @param v The row height, in pixels.
		 */
		protected function setRowHeight (v:Number) : void;

		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;

		/**
		 *  Creates objects that are children of this ListBase; in this case,
     *  the <code>listContent</code> object that will hold all the item 
     *  renderers. The item renderers are not created immediately, but later
     *  when the <code>updateDisplayList()</code> method is called.
		 */
		protected function createChildren () : void;

		/**
		 *  Calculates the column width and row height and number of rows and
     *  columns based on whether properties like <code>columnCount</code>
     *  <code>columnWidth</code>, <code>rowHeight</code> and 
     *  <code>rowCount</code> were explicitly set.
     *
     *  @see mx.core.ScrollControlBase
		 */
		protected function commitProperties () : void;

		/**
		 *  Calculates the measured width and height of the component based 
     *  on the <code>rowCount</code>,
     *  <code>columnCount</code>, <code>rowHeight</code> and
     *  <code>columnWidth</code> properties.
     *
     *  @see mx.core.ScrollControlBase
		 */
		protected function measure () : void;

		/**
		 *  @private 
     *  This is a copy of the code in UIComponent, modified to
     *  start a data change effect if appropriate.
		 */
		public function validateDisplayList () : void;

		/**
		 *  Initiates a data change effect when there have been changes
     *  in the data provider.
     *  
     *  @param unscaledWidth The width of the control before external sizings are applied.
     *  
     *  @param unscaledHeight The height of the control before external sizings are applied.
		 */
		protected function initiateDataChangeEffect (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
     *  Sets up listeners for MoveEvents for a set of renderers. Listeners are only
     *  created for renderers representing selected items.
     * 
     *  This functionality is used by data change effects, to update selections
     *  when the item renderers move.
		 */
		private function initiateSelectionTracking (renderers:Array) : void;

		/**
		 *  @private
     *  Removes event listeners for MoveEvents set up by initiateSelectionTracking().
     *
		 */
		private function terminateSelectionTracking () : void;

		/**
		 *  @inheritDoc
		 */
		public function removeDataEffectItem (item:Object) : void;

		/**
		 *  @inheritDoc
		 */
		public function addDataEffectItem (item:Object) : void;

		/**
		 *  @inheritDoc
		 */
		public function unconstrainRenderer (item:Object) : void;

		/**
		 *  @inheritDoc
		 */
		public function getRendererSemanticValue (target:Object, semanticProperty:String) : Object;

		/**
		 *  Returns <code>true</code> if an item renderer is no longer being positioned
     *  by the list's layout algorithm while a data change effect is
     *  running as a result of a call to the <code>unconstrainRenderer()</code> method.
     * 
     *  @param item An item renderer.
     * 
     *  @return <code>true</code> if an item renderer is no longer being positioned
     *  by the list's layout algorithm.
		 */
		protected function isRendererUnconstrained (item:Object) : Boolean;

		/**
		 *  Cleans up after a data change effect has finished running
     *  by restoring the original collection and iterator and removing
     *  any cached values used by the effect. This method is called by
     *  the Flex framework; you do not need to call it from your code.
     * 
     *  @param event The EffectEvent.
		 */
		protected function finishDataChangeEffect (event:EffectEvent) : void;

		/**
		 * @private
     * 
     *  Initiates a somewhat expensive relayout of the control after finishing up
     *  a data change effect.
		 */
		private function cleanupAfterDataChangeEffect () : void;

		/**
		 *  Adds or removes item renderers if the number of displayable items 
     *  changed.
     *  Refreshes the item renderers if they might have changed.
     *  Applies the selection if it was changed programmatically.
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
     *
     *  @see mx.core.ScrollControlBase
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  Called from the <code>updateDisplayList()</code> method to adjust the size and position of
     *  listContent.
		 */
		protected function adjustListContent (unscaledWidth:Number = -1, unscaledHeight:Number = -1) : void;

		/**
		 *  @private
     *  
     *  Called by updateDisplayList() to make adjustments to vertical and
     *  horizontal scroll position.
		 */
		private function adjustScrollPosition () : void;

		/**
		 *  @private
     *  Set the value of offscreenExtraRows/offscreenExtraColumns based on
     *  the value of offscreenExtraRowsOrColumns
		 */
		function adjustOffscreenRowsAndColumns () : void;

		/**
		 *  Called by the <code>updateDisplayList()</code> method to remove existing item renderers
     *  and clean up various caching structures when the renderer changes.
		 */
		protected function purgeItemRenderers () : void;

		/**
		 *  @private
     *  
     *  Called by updateDisplayList() to remove existing item renderers
     *  and clean up various internal structures at the end of running
     *  a data change effect.
		 */
		private function partialPurgeItemRenderers () : void;

		/**
		 *  @private
     *  
     *  Called by updateDisplayList()
		 */
		private function reduceRows (rowIndex:int) : void;

		/**
		 *  @private
     * 
     *  Called from updateDisplayList()
		 */
		private function makeAdditionalRows (rowIndex:int) : void;

		/**
		 *  @private
     * 
     *  Called from updateDisplayList() to make adjustments to internal
     *  properties representing selections.
		 */
		private function adjustSelectionSettings (collectionHasItems:Boolean) : void;

		/**
		 *  @private
     *  
     *  Called from updateDisplayList() to seek to a cursorPosition while ignoring any errors
		 */
		private function seekPositionIgnoreError (iterator:IViewCursor, cursorPos:CursorBookmark) : void;

		/**
		 *  @private
     * 
     *  A convenience function to move the iterator to the next position and handle
     *  errors if necessary.
		 */
		private function seekNextSafely (iterator:IViewCursor, pos:int) : Boolean;

		private function seekPreviousSafely (iterator:IViewCursor, pos:int) : Boolean;

		/**
		 *  Seek to a position, and handle an ItemPendingError if necessary.
     *  @param index Index into the collection.
     *  @return <code>false</code> if an ItemPendingError is thrown.
		 */
		protected function seekPositionSafely (index:int) : Boolean;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  Measures a set of items from the data provider using
     *  the current item renderer and returns the
     *  maximum width found.  This method is used to calculate the
     *  width of the component.  The various ListBase-derived classes
     *  have slightly different implementations.  DataGrid measures
     *  its columns instead of data provider items, and TileList
     *  just measures the first item and assumes all items are the
     *  same size.
     *
     *  <p>This method is not implemented in the ListBase class
     *  and must be implemented in the child class.</p>
     *
     *  <p>A negative <code>index</code> value can be used to specify
     *  that the width calculation includes any headers.</p>
     *
     *  @param index The data provider item at which to start measuring
     *  the width.
     *
     *  @param count The number of items to measure in calculating the width.
     *
     *  @return The widest of the measured items.
		 */
		public function measureWidthOfItems (index:int = -1, count:int = 0) : Number;

		/**
		 *  Measures a set of items from the data provider using the
     *  current item renderer and returns the sum of the heights
     *  of those items.
     *
     *  <p>This method is not implemented in the ListBase class
     *  and must be implemented in the child class.</p>
     *
     *  <p>A negative <code>index</code> value can be used to specify
     *  that the height calculation includes any headers.</p>
     *
     *  @param index The data provider item at which to start calculating
     *  the height.
     *
     *  @param count The number of items to use in calculating the height.
     *
     *  @return the sum of the height of the measured items.
		 */
		public function measureHeightOfItems (index:int = -1, count:int = 0) : Number;

		/**
		 *  Returns the string the renderer would display for the given data object
     *  based on the labelField and labelFunction properties.
     *  If the method cannot convert the parameter to a string, it returns a
     *  single space.
     *
     *  @param data Object to be rendered.
     *
     *  @return The string to be displayed based on the data.
		 */
		public function itemToLabel (data:Object) : String;

		/**
		 *  Returns the dataTip string the renderer would display for the given
     *  data object based on the dataTipField and dataTipFunction properties.
     *  If the method cannot convert the parameter to a string, it returns a
     *  single space.
     *  <p>For use by developers creating subclasses of ListBase or its children.
     *  Not used by application developers.</p>
     *
     *  @param data Object to be rendered.
     *
     *  @return String displayable string based on the data.
		 */
		public function itemToDataTip (data:Object) : String;

		/**
		 *  Returns the class for an icon, if any, for a data item,  
     *  based on the iconField and iconFunction properties.
     *  The field in the item can return a string as long as that
     *  string represents the name of a class in the application.
     *  The field in the item can also be a string that is the name
     *  of a variable in the document that holds the class for
     *  the icon.
     *  
     *  @param data The item from which to extract the icon class.
     *  @return The icon for the item, as a class reference or 
     *  <code>null</code> if none.
		 */
		public function itemToIcon (data:Object) : Class;

		/**
		 *  Make enough rows and columns to fill the area
     *  described by left, top, right, bottom.
     *  Renderers are created and inserted into the <code>listItems</code>
     *  array starting at <code>(firstColumn, firstRow)(</code>
     *  and moving downwards.
     *
     *  <p>If <code>byCount</code> and <code>rowsNeeded</code> are specified,
     *  then just make that many rows and ignore the <code>bottom</code>
     *  and <code>right</code> parameters.</p>
     *
     *  @param left Horizontal pixel offset of area to fill.
     *
     *  @param top Vertical pixel offset of area to fill.
     *
     *  @param right Horizontal pixel offset of area to fill
     *  (from left side of component).
     *
     *  @param bottom Vertical pixel offset of area to fill
     *  (from top of component).
     *
     *  @param firstColumn Offset into <code>listItems</code> to store
     *  the first renderer to be created.
     *
     *  @param firstRow Offset into <code>listItems</code> to store
     *  the first renderer to be created.
     *
     *  @param byCount If true, make <code>rowsNeeded</code> number of rows
     *  and ignore <code>bottom</code> parameter.
     *
     *  @param rowsNeeded Number of rows to create if <code>byCount</code>
     *  is true.
     *
     *  @return A Point containing the number of rows and columns created.
		 */
		protected function makeRowsAndColumns (left:Number, top:Number, right:Number, bottom:Number, firstColumn:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0) : Point;

		/**
		 *  Computes the offset into the data provider of the item
     *  at colIndex, rowIndex.
     *  The 9th row 3rd column in a TileList could be different items
     *  in the data provider based on the direction the tiles are laid
     *  out and the number of rows and columns in the TileList.
     *
     *  @param rowIndex The 0-based index of the row, including rows
     *  scrolled off the top. Thus, if <code>verticalScrollPosition</code>
     *  is 2 then the first visible row has a rowIndex of 2.
     *
     *  @param colIndex The 0-based index of the column, including
     *  columns scrolled off the left. If 
     *  <code>horizontalScrollPosition</code> is 2 then the first column
     *  on the left has a columnIndex of 2.
     *
     *  @return The offset into the data provider.
		 */
		public function indicesToIndex (rowIndex:int, colIndex:int) : int;

		/**
		 *  The row for the data provider item at the given index.
     *
     *  @param index The offset into the data provider.
     *
     *  @return The row the item would be displayed at in the component;
     *  -1 if not displayable in listContent container.
		 */
		protected function indexToRow (index:int) : int;

		/**
		 *  The column for the data provider item at the given index.
     *
     *  @param index The offset into the data provider.
     *
     *  @return The column the item would be displayed at in the component;
     *  -1 if not displayable in listContent container.
		 */
		protected function indexToColumn (index:int) : int;

		/**
		 *  @private
     *  Used by accessibility.
		 */
		function indicesToItemRenderer (row:int, col:int) : IListItemRenderer;

		/**
		 *  Returns a Point containing the columnIndex and rowIndex of an
     *  item renderer. Because item renderers are only created for items
     *  within the set of viewable rows,
     *  you cannot use this method to get the indices for items
     *  that are not visible. Also note that item renderers
     *  are recycled so the indices you get for an item may change
     *  if that item renderer is reused to display a different item.
     *  Usually, this method is called during mouse and keyboard handling
     *  when the set of data displayed by the item renderers hasn't yet
     *  changed.
     *
     *  @param item An item renderer.
     *
     *  @return A Point. The <code>x</code> property is the columnIndex
     *  and the <code>y</code> property is the rowIndex.
		 */
		protected function itemRendererToIndices (item:IListItemRenderer) : Point;

		/**
		 *  Get an item renderer for the index of an item in the data provider,
     *  if one exists. Because item renderers only exist for items 
     *  within the set of viewable rows, you cannot use this method for items that are not visible.
     *
     *  @param index The offset into the data provider for an item.
     *
     *  @return The item renderer that is displaying the item, or 
     *  <code>null</code> if the item is not currently displayed.
		 */
		public function indexToItemRenderer (index:int) : IListItemRenderer;

		/**
		 *  Returns the index of the item in the data provider of the item
     *  being rendered by this item renderer. Because item renderers
     *  only exist for items that are within the set of viewable
     *  rows, you cannot use this method for items that are not visible.
     *
     *  @param itemRenderer The item renderer that is displaying the
     *  item for which you want to know the data provider index.
     *
     *  @return The index of the item in the data provider.
		 */
		public function itemRendererToIndex (itemRenderer:IListItemRenderer) : int;

		/**
		 *  Determines the UID for a data provider item.  All items
     *  in a data provider must either have a unique ID (UID)
     *  or one will be generated and associated with it.  This
     *  means that you cannot have an object or scalar value
     *  appear twice in a data provider. For example, the following
     *  data provider is not supported because the value "foo"
     *  appears twice and the UID for a string is the string itself:
     *
     *  <blockquote>
     *  <code>var sampleDP:Array = ["foo", "bar", "foo"]</code>
     *  </blockquote>
     *
     *  Simple dynamic objects can appear twice if they are two
     *  separate instances. The following is supported because
     *  each of the instances will be given a different UID because
     *  they are different objects:
     *
     *  <blockquote>
     *  <code>var sampleDP:Array = [{label: "foo"}, {label: "foo"}]</code>
     *  </blockquote>
     *
     *  Note that the following is not supported because the same instance
     *  appears twice.
     *
     *  <blockquote>
     *  <code>var foo:Object = {label: "foo"};
     *  sampleDP:Array = [foo, foo];</code>
     *  </blockquote>
     *
     *  @param data The data provider item.
     *
     *  @return The UID as a string.
		 */
		protected function itemToUID (data:Object) : String;

		/**
		 *  Find an item renderer based on its UID if it is visible.
     *  @param uid The UID of the item.
     *  @return The item renderer.
		 */
		protected function UIDToItemRenderer (uid:String) : IListItemRenderer;

		/**
		 *  Returns the item renderer for a given item in the data provider,
     *  if there is one.  Since item renderers only exist for items
     *  that are within the set of viewable rows, this method
     *  returns <code>null</code> if the item is not visible.
     *  For DataGrid, this will return the first column's renderer.
     *
     *  @param item The data provider item.
     *
     *  @return The item renderer or <code>null</code> if the item is not 
     *  currently displayed.
		 */
		public function itemToItemRenderer (item:Object) : IListItemRenderer;

		/**
		 *  Determines if an item is being displayed by a renderer.
     *
     *  @param item A data provider item.
     *  @return <code>true</code> if the item is being displayed.
		 */
		public function isItemVisible (item:Object) : Boolean;

		/**
		 *  Determines which item renderer is under the mouse.  Item
     *  renderers can be made of multiple mouse targets, or have 
     *  visible areas that are not mouse targets.  This method
     *  checks both targets and position to determine which
     *  item renderer the mouse is over from the user's perspective,
     *  which can differ from the information provided by the 
     *  mouse event.
     *  
     *  @param event A MouseEvent that contains the position of
     *  the mouse and the object it is over.
     *
     *  @return The item renderer the mouse is over or 
     *  <code>null</code> if none.
		 */
		protected function mouseEventToItemRenderer (event:MouseEvent) : IListItemRenderer;

		/**
		 *  @private
		 */
		function mouseEventToItemRendererOrEditor (event:MouseEvent) : IListItemRenderer;

		/**
		 *  @private
     *  Helper function for addClipMask().
     *  Returns true if all of the IListItemRenderers are UITextFields.
		 */
		function hasOnlyTextRenderers () : Boolean;

		/**
		 *  Determines whether a renderer contains (or owns) a display object.
     *  Ownership means that the display object isn't actually parented
     *  by the renderer but is associated with it in some way.  Popups
     *  should be owned by the renderers so that activity in the popup
     *  is associated with the renderer and not seen as activity in another
     *  component.
     *
     *  @param renderer The renderer that might contain or own the 
     *  display object.
     *
     *  @param object The display object that might be associated with the
     *  renderer.
     *
     *  @return <code>true</code> if the display object is contained
     *  or owned by the renderer.
		 */
		public function itemRendererContains (renderer:IListItemRenderer, object:DisplayObject) : Boolean;

		/**
		 *  Adds a renderer to the recycled renderer list,
     *  making it invisible and cleaning up references to it.
     *  If a data effect is running, the renderer is reserved for
     *  future use for that data. Otherwise it is added to the
     *  general freeItemRenderers stack.
     *
     *  @param item The renderer to add.
		 */
		protected function addToFreeItemRenderers (item:IListItemRenderer) : void;

		/**
		 *  Retrieves an already-created item renderer not currently in use.
     *  If a data effect is running, it first tries to retrieve from the
     *  reservedItemRenderers map. Otherwise (or if no reserved renderer
     *  is found) it retrieves from the freeItemRenderers stack.
     *
     *  @param data Object The data to be presented by the item renderer.
		 */
		protected function getReservedOrFreeItemRenderer (data:Object) : IListItemRenderer;

		/**
		 *  Return the appropriate factory, using the default factory if none specified.
     *
     *  @param data The data to be presented by the item renderer.
     *
     *  @return if <code>data</code> is null, the default item renderer, 
     *  otherwis it returns the custom item renderer.
		 */
		public function getItemRendererFactory (data:Object) : IFactory;

		/**
		 *  Draws any alternating row colors, borders and backgrounds for the rows.
		 */
		protected function drawRowBackgrounds () : void;

		/**
		 *  Draws the renderer with indicators
     *  that it is highlighted, selected, or the caret.
     *
     *  @param item The renderer.
     *  @param selected <code>true</code> if the renderer should be drawn in
     *  its selected state.
     *  @param highlighted <code>true</code> if the renderer should be drawn in
     *  its highlighted state.
     *  @param caret <code>true</code> if the renderer should be drawn as if
     *  it is the selection caret.
     *  @param transition <code>true</code> if the selection state should fade in
     *  via an effect.
		 */
		protected function drawItem (item:IListItemRenderer, selected:Boolean = false, highlighted:Boolean = false, caret:Boolean = false, transition:Boolean = false) : void;

		/**
		 *  Draws the highlight indicator into the given Sprite
     *  at the position, width and height specified using the
     *  color specified.
     * 
     *  @param indicator A Sprite that should contain the graphics
     *  for that make a renderer look highlighted.
     *  @param x The suggested x position for the indicator.
     *  @param y The suggested y position for the indicator.
     *  @param width The suggested width for the indicator.
     *  @param height The suggested height for the indicator.
     *  @param color The suggested color for the indicator.
     *  @param itemRenderer The item renderer that is being highlighted.
		 */
		protected function drawHighlightIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;

		/**
		 *  Clears the highlight indicator in the given Sprite.
     *
     *  @param indicator A Sprite that should contain the graphics
     *  for that make a renderer look highlighted.
     *  @param itemRenderer The item renderer that is being highlighted.
		 */
		protected function clearHighlightIndicator (indicator:Sprite, itemRenderer:IListItemRenderer) : void;

		/**
		 *  Draws the selection indicator into the given Sprite
     *  at the position, width and height specified using the
     *  color specified.
     * 
     *  @param indicator A Sprite that should contain the graphics
     *  for that make a renderer look highlighted.
     *  @param x The suggested x position for the indicator.
     *  @param y The suggested y position for the indicator.
     *  @param width The suggested width for the indicator.
     *  @param height The suggested height for the indicator.
     *  @param color The suggested color for the indicator.
     *  @param itemRenderer The item renderer that is being highlighted.
		 */
		protected function drawSelectionIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;

		/**
		 *  Draws the caret indicator into the given Sprite
     *  at the position, width and height specified using the
     *  color specified.
     * 
     *  @param indicator A Sprite that should contain the graphics
     *  for that make a renderer look highlighted.
     *  @param x The suggested x position for the indicator.
     *  @param y The suggested y position for the indicator.
     *  @param width The suggested width for the indicator.
     *  @param height The suggested height for the indicator.
     *  @param color The suggested color for the indicator.
     *  @param itemRenderer The item renderer that is being highlighted.
		 */
		protected function drawCaretIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;

		/**
		 *  Clears the caret indicator into the given Sprite.
     * 
     *  @param indicator A Sprite that should contain the graphics
     *  for that make a renderer look highlighted.
     *  @param itemRenderer The item renderer that is being highlighted.
		 */
		protected function clearCaretIndicator (indicator:Sprite, itemRenderer:IListItemRenderer) : void;

		/**
		 *  Removes all selection and highlight and caret indicators.
		 */
		protected function clearIndicators () : void;

		/**
		 *  Cleans up selection highlights and other associated graphics
     *  for a given item in the data provider.
     *
     *  @param uid The UID of the data provider item.
		 */
		protected function removeIndicators (uid:String) : void;

		/**
		 *  @private
		 */
		function clearHighlight (item:IListItemRenderer) : void;

		/**
		 *  Refresh all rows on the next update.
		 */
		public function invalidateList () : void;

		/**
		 *  Refreshes all rows. Calling this method can require substantial
     *  processing, because it completely redraws all renderers
     *  in the list and does not return until complete.
		 */
		protected function updateList () : void;

		/**
		 *  Empty the visibleData hash table.
		 */
		protected function clearVisibleData () : void;

		/**
		 *  Update the keys in the visibleData hash table.
		 */
		protected function reKeyVisibleData () : void;

		/**
		 *  @private
     *  By default, there's a single large clip mask applied to the entire
     *  listContent area of the List.  When the List contains a mixture of
     *  device text and vector graphics (e.g.: there are custom item renderers),
     *  that clip mask imposes a rendering overhead.
     *
     *  When graphical (non-text) item renderers are used, we optimize by only
     *  applying a clip mask to the list items in the last row ... and then
     *  only when it's needed.
     *
     *  This optimization breaks down when there's a horizontal scrollbar.
     *  Rather than attempting to apply clip masks to every item along the left
     *  and right edges, we give up and use the default clip mask that covers
     *  the entire List.
     *
     *  For Lists and DataGrids containing custom item renderers, this
     *  optimization yields a 25% improvement in scrolling speed.
		 */
		function addClipMask (layoutChanged:Boolean) : void;

		/**
		 *  @private
     *  Helper function for addClipMask().
     *  Creates a clip mask with the specified dimensions.
		 */
		function createItemMask (x:Number, y:Number, width:Number, height:Number, contentHolder:DisplayObjectContainer = null) : DisplayObject;

		/**
		 *  @private
     *
     *  Undo the effects of the addClipMask function (above)
		 */
		function removeClipMask () : void;

		/**
		 *  Determines if the item renderer for a data provider item 
     *  is highlighted (is rolled over via the mouse or under the caret due to keyboard navigation).
     *
     *  @param data The data provider item.
     *  @return <code>true</code> if the item is highlighted.
		 */
		public function isItemHighlighted (data:Object) : Boolean;

		/**
		 *  Determines if the item renderer for a data provider item 
     *  is selected.
     *
     *  @param data The data provider item.
     *  @return <code>true</code> if the item is selected.
		 */
		public function isItemSelected (data:Object) : Boolean;

		/**
		 *  Determines if the item renderer for a data provider item 
     *  is selectable.
     *
     *  @param data The data provider item.
     *  @return <code>true</code> if the item is selectable.
		 */
		public function isItemSelectable (data:Object) : Boolean;

		/**
		 *  @private
		 */
		private function calculateSelectedIndexAndItem () : void;

		/**
		 *  Updates the set of selected items given that the item renderer provided
     *  was clicked by the mouse and the keyboard modifiers are in the given
     *  state. This method also updates the display of the item renderers based
     *  on their updated selected state.
     *
     *  @param item The item renderer that was clicked.
     *  @param shiftKey <code>true</code> if the Shift key was held down when
     *  the mouse was clicked.
     *  @param ctrlKey <code>true</code> if the Ctrl key was held down when
     *  the mouse was clicked.
     *  @param transition <code>true</code> if the graphics for the selected 
     *  state should be faded in using an effect.
     *
     *  @return <code>true</code> if the set of selected items changed.
     *  Clicking on an already-selected item does not always change the set
     *  of selected items.
		 */
		protected function selectItem (item:IListItemRenderer, shiftKey:Boolean, ctrlKey:Boolean, transition:Boolean = true) : Boolean;

		/**
		 *  @private
		 */
		private function shiftSelectionLoop (incr:Boolean, index:int, stopData:Object, transition:Boolean, placeHolder:CursorBookmark) : void;

		/**
		 *  Clears the set of selected items and removes all graphics
     *  depicting the selected state of those items.
     *
     *  @param transition <code>true</code> if the graphics should
     *  have a fadeout effect.
		 */
		protected function clearSelected (transition:Boolean = false) : void;

		/**
		 *  Moves the selection in a horizontal direction in response
     *  to the user selecting items using the left arrow or right arrow
     *  keys and modifiers such as the Shift and Ctrl keys. This method
     *  might change the <code>horizontalScrollPosition</code>, 
     *  <code>verticalScrollPosition</code>, and <code>caretIndex</code>
     *  properties, and call the <code>finishKeySelection()</code> method
     *  to update the selection.
     *
     *  <p>Not implemented in ListBase because the default list
     *  is single column and therefore does not scroll horizontally.</p>
     *
     *  @param code The key that was pressed (for example, <code>Keyboard.LEFT</code>).
     *  @param shiftKey <code>true</code> if the Shift key was held down when
     *  the keyboard key was pressed.
     *  @param ctrlKey <code>true</code> if the Ctrl key was held down when
     *  the keyboard key was pressed.
		 */
		protected function moveSelectionHorizontally (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;

		/**
		 *  Moves the selection in a vertical direction in response
     *  to the user selecting items using the up arrow or down arrow
     *  Keys and modifiers such as the Shift and Ctrl keys. This method
     *  might change the <code>horizontalScrollPosition</code>, 
     *  <code>verticalScrollPosition</code>, and <code>caretIndex</code>
     *  properties, and call the <code>finishKeySelection()</code> method
     *  to update the selection.
     *
     *  @param code The key that was pressed (for example, <code>Keyboard.DOWN</code>).
     *  @param shiftKey <code>true</code> if the Shift key was held down when
     *  the keyboard key was pressed.
     *  @param ctrlKey <code>true</code> if the Ctrl key was held down when
     *  the keyboard key was pressed.
		 */
		protected function moveSelectionVertically (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;

		/**
		 *  Sets selected items based on the <code>caretIndex</code> and 
     *  <code>anchorIndex</code> properties.  
     *  Called by the keyboard selection handlers
     *  and by the <code>updateDisplayList()</code> method in case the 
     *  keyboard selection handler received a page fault while scrolling to get more items.
		 */
		protected function finishKeySelection () : void;

		/**
		 *  @private
		 */
		function commitSelectedIndex (value:int) : void;

		/**
		 *  @private
		 */
		function commitSelectedIndices (indices:Array) : void;

		/**
		 *  @private
		 */
		private function setSelectionIndicesLoop (index:int, indices:Array, firstTime:Boolean = false) : void;

		/**
		 *  @private
		 */
		private function commitSelectedItem (data:Object, clearFirst:Boolean = true) : void;

		/**
		 *  @private
		 */
		private function commitSelectedItems (items:Array) : void;

		/**
		 *  @private
		 */
		private function setSelectionDataLoop (items:Array, index:int, useFind:Boolean = true) : void;

		/**
		 *  @private
		 */
		private function clearSelectionData () : void;

		/**
		 *  Adds the selection data after the item in the list
     *  @private
		 */
		private function insertSelectionDataBefore (uid:String, selectionData:ListBaseSelectionData, nextSelectionData:ListBaseSelectionData) : void;

		/**
		 *  Adds the selection data after the item in the list
     *  @private
		 */
		private function insertSelectionDataAfter (uid:String, selectionData:ListBaseSelectionData, prevSelectionData:ListBaseSelectionData) : void;

		/**
		 *  @private
		 */
		private function removeSelectionData (uid:String) : void;

		/**
		 *  Sets up the effect for applying the selection indicator.
     *  The default is a basic alpha tween.
     *
     *  @param indicator A Sprite that contains the graphics depicting selection.
     *  
     *  @param uid The UID of the item being selected which can be used to index
     *  into a table and track more than one selection effect.
     *  
     *  @param itemRenderer The item renderer that is being shown as selected.
		 */
		protected function applySelectionEffect (indicator:Sprite, uid:String, itemRenderer:IListItemRenderer) : void;

		/**
		 *  @private
		 */
		private function onSelectionTweenUpdate (value:Number) : void;

		/**
		 *  Copies the selected items in the order that they were selected.
     *
     *  @param useDataField <code>true</code> if the array should
     *  be filled with the actual items or <code>false</code>
     *  if the array should be filled with the indexes of the items.
     *
     *  @return An array of selected items.
		 */
		protected function copySelectedItems (useDataField:Boolean = true) : Array;

		/**
		 *  Returns the data provider index for the item at the first visible
     *  row and column for the given scroll positions.
     *
     *  @param horizontalScrollPosition The <code>horizontalScrollPosition</code>
     *         property value corresponding to the scroll position.
     *  @param verticalScrollPosition The <code>verticalScrollPosition</code>
     *         property value corresponding to the scroll position.
     *
     *  @return The data provider index.
		 */
		protected function scrollPositionToIndex (horizontalScrollPosition:int, verticalScrollPosition:int) : int;

		/**
		 *  Ensures that the data provider item at the given index is visible.
     *  If the item is visible, the <code>verticalScrollPosition</code>
     *  property is left unchanged even if the item is not the first visible
     *  item. If the item is not currently visible, the 
     *  <code>verticalScrollPosition</code>
     *  property is changed make the item the first visible item, unless there
     *  aren't enough rows to do so because the 
     *  <code>verticalScrollPosition</code> value is limited by the 
     *  <code>maxVerticalScrollPosition</code> property.
     *
     *  @param index The index of the item in the data provider.
     *
     *  @return <code>true</code> if <code>verticalScrollPosition</code> changed.
		 */
		public function scrollToIndex (index:int) : Boolean;

		/**
		 *  Adjusts the renderers in response to a change
     *  in scroll position.
     *
     *  <p>The list classes attempt to optimize scrolling
     *  when the scroll position has changed by less than
     *  the number of visible rows.  In that situation
     *  some rows are unchanged and just need to be moved,
     *  other rows are removed and then new rows are added.
     *  If the scroll position changes too much, all old rows are removed
     *  and new rows are added by calling the <code>makeRowsAndColumns()</code>
     *  method for the entire viewable area.</p>
     *
     *  @param pos The new scroll position.
     *  @param deltaPos The change in position. This value is always a positive number.
     *  @param scrollUp <code>true</code> if the scroll position is getting smaller.
		 */
		protected function scrollVertically (pos:int, deltaPos:int, scrollUp:Boolean) : void;

		/**
		 *  Recycle a row that is no longer needed, and remove its indicators.
     *  
     *  @param i The index of the row to remove.
     *  @param numCols The number of columns in the row.
		 */
		protected function destroyRow (i:int, numCols:int) : void;

		/**
		 *  Move a row vertically, and update the rowInfo record.
     *  
     *  @param i The index of the row.
     *  @param numCols The number of columns in the row.
     *  @param moveBlockDistance The distance to move.
		 */
		protected function moveRowVertically (i:int, numCols:int, moveBlockDistance:Number) : void;

		/**
		 *  Shift a row in the arrays that reference rows.
     *  
     *  @param oldIndex Old index in the arrays.
     *  @param newIndex New index in the arrays.
     *  @param numCols The number of columns in the row.
     *  @param shiftItems <code>true</code> if we actually move the item. <code>false</code> if we simply change the item's rowIndex.
		 */
		protected function shiftRow (oldIndex:int, newIndex:int, numCols:int, shiftItems:Boolean) : void;

		/**
		 *  Move the selection and highlight indicators vertically.
     *  
     *  @param uid UID used to find the indicators.
     *  @param moveBlockDistance The distance to move vertically.
		 */
		protected function moveIndicatorsVertically (uid:String, moveBlockDistance:Number) : void;

		/**
		 *  Move the selection and highlight indicators horizontally.
     *  
     *  @param uid UID used to find the indicators.
     *  @param moveBlockDistance The distance to move horizontally.
		 */
		protected function moveIndicatorsHorizontally (uid:String, moveBlockDistance:Number) : void;

		/**
		 *  Determine the height of the requested set of rows.
     *  @param startRowIdx The index of first row.
     *  @param endRowIdx The index of last row.
     *  @return The total height of the rows.
		 */
		protected function sumRowHeights (startRowIdx:int, endRowIdx:int) : Number;

		/**
		 *  Remove all remaining rows from the end of the
     *  arrays that store references to the rows.
     *  
     *  @param numRows The row index to truncate from.
		 */
		protected function truncateRowArrays (numRows:int) : void;

		/**
		 *  Add a blank row to the beginning of the arrays that store references to the rows.
		 */
		protected function addToRowArrays () : void;

		/**
		 *  Remove the requested number of rows from the beginning of the 
     *  arrays that store references to the rows.
     *  
     *  @param modDeltaPos The number of rows to remove.
		 */
		protected function restoreRowArrays (modDeltaPos:int) : void;

		/**
		 *  Remove a row from the arrays that store references to the row.
     *  
     *  @param i The index of the row.
		 */
		protected function removeFromRowArrays (i:int) : void;

		/**
		 *  Adjusts the renderers in response to a change
     *  in scroll position.
     *
     *  <p>The list classes attempt to optimize scrolling
     *  when the scroll position has changed by less than
     *  the number of visible rows.  In that situation
     *  some rows are unchanged and just need to be moved,
     *  other rows are removed and then new rows are added.
     *  If the scroll position changes too much, all old rows are removed
     *  and new rows are added by calling the <code>makeRowsAndColumns()</code>
     *  method for the entire viewable area.</p>
     *
     *  <p>Not implemented in ListBase because the default list
     *  is single column and therefore doesn't scroll horizontally.</p>
     *
     *  @param pos The new scroll position.
     *  @param deltaPos The change in position. This value is always a positive number.
     *  @param scrollUp <code>true</code> if scroll position is getting smaller.
		 */
		protected function scrollHorizontally (pos:int, deltaPos:int, scrollUp:Boolean) : void;

		/**
		 *  Creates an item renderer given the data object.
     *  @param The data object.
     *  @return The item renderer.
		 */
		public function createItemRenderer (data:Object) : IListItemRenderer;

		/**
		 *  Configures the ScrollBars based on the number of rows and columns and
     *  viewable rows and columns.
     *  This method is called from the <code>updateDisplayList()</code> method
     *  after the rows and columns have been updated.
     *  The method should figures out what parameters to pass into the 
     *  <code>setScrollBarProperties()</code> method to properly set up the ScrollBars.
		 */
		protected function configureScrollBars () : void;

		/**
		 *  Interval function that scrolls the list up or down
     *  if the mouse goes above or below the list.
		 */
		protected function dragScroll () : void;

		/**
		 *  @private
     *  Stop the drag scrolling callback.
		 */
		function resetDragScrolling () : void;

		/**
		 *  Adds the selected items to the DragSource object as part of a
     *  drag-and-drop operation.
     *  Override this method to add other data to the drag source.
     * 
     * @param ds The DragSource object to which to add the data.
		 */
		protected function addDragData (ds:Object) : void;

		/**
		 *  Returns the index where the dropped items should be added 
     *  to the drop target.
     *
     *  @param event A DragEvent that contains information about
     *  the position of the mouse. If <code>null</code> the
     *  method should return the <code>dropIndex</code> value from the 
     *  last valid event.
     *
     *  @return Index where the dropped items should be added.
		 */
		public function calculateDropIndex (event:DragEvent = null) : int;

		/**
		 *  Calculates the y position of the drop indicator 
     *  when performing a drag-and-drop operation.
     *
     *  @param rowCount The number of visible rows in the control.
     *
     *  @param rowNum The row number in the control where the drop indicator should appear.
     *
     *  @return The y axis coordinate of the drop indicator.
		 */
		protected function calculateDropIndicatorY (rowCount:Number, rowNum:int) : Number;

		/**
		 *  Displays a drop indicator under the mouse pointer to indicate that a
     *  drag and drop operation is allowed and where the items will
     *  be dropped.
     *
     *  @param event A DragEvent object that contains information as to where
     *  the mouse is.
		 */
		public function showDropFeedback (event:DragEvent) : void;

		/**
		 *  Hides the drop indicator under the mouse pointer that indicates that a
     *  drag and drop operation is allowed.
     *
     *  @param event A DragEvent object that contains information about the
     *  mouse location.
		 */
		public function hideDropFeedback (event:DragEvent) : void;

		/**
		 *  The default failure handler when a seek fails due to a page fault.
     *  
     *  @param data The data that caused the error. 
     *  
     *  @param info Data about a seek operation that was interrupted by an ItemPendingError error.
		 */
		protected function seekPendingFailureHandler (data:Object, info:ListBaseSeekPending) : void;

		/**
		 *  The default result handler when a seek fails due to a page fault.
     *  This method checks to see if it has the most recent page fault result:
     *  if not it simply exits; if it does, it sets the iterator to
     *  the correct position.
     *  
     *  @param data The data that caused the error.
     *  
     *  @param info Data about a seek operation that was interrupted by an ItemPendingError error.
		 */
		protected function seekPendingResultHandler (data:Object, info:ListBaseSeekPending) : void;

		/**
		 *  @private
		 */
		private function findPendingFailureHandler (data:Object, info:ListBaseFindPending) : void;

		/**
		 *  @private
		 */
		private function findPendingResultHandler (data:Object, info:ListBaseFindPending) : void;

		/**
		 *  @private
		 */
		private function selectionPendingFailureHandler (data:Object, info:ListBaseSelectionPending) : void;

		/**
		 *  @private
		 */
		private function selectionPendingResultHandler (data:Object, info:ListBaseSelectionPending) : void;

		/**
		 *  @private
		 */
		private function selectionDataPendingFailureHandler (data:Object, info:ListBaseSelectionDataPending) : void;

		/**
		 *  @private
		 */
		function selectionDataPendingResultHandler (data:Object, info:ListBaseSelectionDataPending) : void;

		/**
		 *  @private
		 */
		private function selectionIndicesPendingFailureHandler (data:Object, info:ListBaseSelectionDataPending) : void;

		/**
		 *  @private
		 */
		private function selectionIndicesPendingResultHandler (data:Object, info:ListBaseSelectionDataPending) : void;

		/**
		 *  Tries to find the next item in the data provider that
     *  starts with the character in the <code>eventCode</code> parameter.
     *  You can override this to do fancier typeahead lookups. The search
     *  starts at the <code>selectedIndex</code> location; if it reaches
     *  the end of the data provider it starts over from the beginning.
     *
     *  @param eventCode The key that was pressed on the keyboard.
     *  @return <code>true</code> if a match was found.
		 */
		protected function findKey (eventCode:int) : Boolean;

		/**
		 *  Finds an item in the list based on a String,
     *  and moves the selection to it. The search
     *  starts at the <code>selectedIndex</code> location; if it reaches
     *  the end of the data provider it starts over from the beginning.
     *
     *  <p>For a DataGrid control, by default this method searches 
     *  the first column in the control. 
     *  To search a different column, set the <code>sort</code> property 
     *  of the collection used to populate the control to the specific field 
     *  or fields that you want to search. 
     *  Each field corresponds to a single column of the control.</p>
     *
     *  @param str The String to match.
     * 
     *  @return <code>true</code> if a match is found.
     *
     *  @see mx.collections.ListCollectionView
     *  @see mx.collections.ArrayCollection
     *  @see mx.collections.XMLListCollection
		 */
		public function findString (str:String) : Boolean;

		/**
		 *  @private
		 */
		private function findStringLoop (str:String, cursorPos:CursorBookmark, i:int, stopIndex:int) : Boolean;

		/**
		 *  @private
		 */
		private function adjustAfterSort () : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  Handles <code>mouseWheel</code> events by changing scroll positions.
     *  This is a copy of the version in the ScrollControlBase class,
     *  modified to change the horizontalScrollPosition if the target is run horizontally.
     *
     *  @param event The MouseEvent object.
     *
     *  @see mx.core.ScrollControlBase#mouseWheelHandler()
		 */
		protected function mouseWheelHandler (event:MouseEvent) : void;

		/**
		 *  Handles CollectionEvents dispatched from the data provider
     *  as the data changes.
     *  Updates the renderers, selected indices and scrollbars as needed.
     *
     *  @param event The CollectionEvent.
		 */
		protected function collectionChangeHandler (event:Event) : void;

		/**
		 *  @private
     *  Reconstructs an array of items for a pseudo-data provider. Used to
     *  leverage the data effects infrastructure after removeAll() has been
     *  called on the data provider.
     * 
     *  Subclasses may need to override this function, e.g. for TileLists
     *  with vertical layout.
		 */
		function reconstructDataFromListItems () : Array;

		/**
		 *  Prepares the data effect for the collection event.
		 */
		protected function prepareDataEffect (ce:CollectionEvent) : void;

		/**
		 *  @private
		 */
		protected function adjustAfterAdd (items:Array, location:int) : Boolean;

		/**
		 *  @private
		 */
		protected function adjustAfterRemove (items:Array, location:int, emitEvent:Boolean) : Boolean;

		/**
		 *  @private
		 */
		function setBookmarkPendingFailureHandler (data:Object, info:Object) : void;

		/**
		 *  @private
		 */
		function setBookmarkPendingResultHandler (data:Object, info:Object) : void;

		/**
		 *  Handles <code>MouseEvent.MOUSE_OVER</code> events from any mouse
     *  targets contained in the list, including the renderers.
     *  This method finds out which renderer the mouse is over
     *  and shows it as highlighted.
     *
     *  <p>The list classes also call this from a 
     *  <code>MouseEvent.MOUSE_MOVE</code> event.
     *  This event is used to detect movement in non-target areas of the
     *  renderers and in padded areas around the renderers.</p>
     *
     *  @param event The MouseEvent object.
		 */
		protected function mouseOverHandler (event:MouseEvent) : void;

		/**
		 *  Handles <code>MouseEvent.MOUSE_OUT</code> events from any mouse targets
     *  contained in the list including the renderers. This method
     *  finds out which renderer the mouse has left and removes the highlights.
     *
     *  @param event The MouseEvent object.
		 */
		protected function mouseOutHandler (event:MouseEvent) : void;

		/**
		 *  Handles <code>MouseEvent.MOUSE_MOVE</code> events from any mouse
     *  targets contained in the list including the renderers.  This method
     *  watches for a gesture that constitutes the beginning of a
     *  drag drop and send a <code>DragEvent.DRAG_START</code> event.
     *  It also checks to see if the mouse is over a non-target area of a
     *  renderer so that Flex can try to make it look like that renderer was 
     *  the target.
     *
     *  @param event The MouseEvent object.
		 */
		protected function mouseMoveHandler (event:MouseEvent) : void;

		/**
		 *  Handles <code>MouseEvent.MOUSE_DOWN</code> events from any mouse
     *  targets contained in the list including the renderers. This method
     *  finds the renderer that was pressed and prepares to receive
     *  a <code>MouseEvent.MOUSE_UP</code> event.
     *
     *  @param event The MouseEvent object.
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;

		private function mouseIsUp () : void;

		private function mouseLeaveHandler (event:Event) : void;

		/**
		 *  Handles <code>MouseEvent.MOUSE_DOWN</code> events from any mouse
     *  targets contained in the list including the renderers. This method
     *  finds the renderer that was pressed and prepares to receive
     *  a <code>MouseEvent.MOUSE_UP</code> event.
     *
     *  @param event The MouseEvent object.
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;

		/**
		 *  Handles <code>MouseEvent.MOUSE_CLICK</code> events from any mouse
     *  targets contained in the list including the renderers. This method
     *  determines which renderer was clicked
     *  and dispatches a <code>ListEvent.ITEM_CLICK</code> event.
     *
     *  @param event The MouseEvent object.
		 */
		protected function mouseClickHandler (event:MouseEvent) : void;

		/**
		 *  Handles <code>MouseEvent.MOUSE_DOUBLE_CLICK</code> events from any
     *  mouse targets contained in the list including the renderers.
     *  This method determines which renderer was clicked
     *  and dispatches a <code>ListEvent.ITEM_DOUBLE_CLICK</code> event.
     *
     *  @param event The MouseEvent object.
		 */
		protected function mouseDoubleClickHandler (event:MouseEvent) : void;

		/**
		 *  The default handler for the <code>dragStart</code> event.
     *
     *  @param event The DragEvent object.
		 */
		protected function dragStartHandler (event:DragEvent) : void;

		/**
		 *  Handles <code>DragEvent.DRAG_ENTER</code> events.  This method
     *  determines if the DragSource object contains valid elements and uses
     *  the <code>showDropFeedback()</code> method to set up the UI feedback.
     *
     *  @param event The DragEvent object.
		 */
		protected function dragEnterHandler (event:DragEvent) : void;

		/**
		 *  Handles <code>DragEvent.DRAG_OVER</code> events. This method
     *  determines if the DragSource object contains valid elements and uses
     *  the <code>showDropFeedback()</code> method to set up the UI feeback.
     *
     *  @param event The DragEvent object.
		 */
		protected function dragOverHandler (event:DragEvent) : void;

		/**
		 *  Handles <code>DragEvent.DRAG_EXIT</code> events. This method hides
     *  the UI feeback by calling the <code>hideDropFeedback()</code> method.
     *
     *  @param event The DragEvent object.
		 */
		protected function dragExitHandler (event:DragEvent) : void;

		/**
		 *  Handles <code>DragEvent.DRAG_DROP events</code>. This method  hides
     *  the drop feedback by calling the <code>hideDropFeedback()</code> method.
     *
     *  <p>If the action is a <code>COPY</code>, 
     *  then this method makes a deep copy of the object 
     *  by calling the <code>ObjectUtil.copy()</code> method, 
     *  and replaces the copy's <code>uid</code> property (if present) 
     *  with a new value by calling the <code>UIDUtil.createUID()</code> method.</p>
     * 
     *  @param event The DragEvent object.
     *
     *  @see mx.utils.ObjectUtil
     *  @see mx.utils.UIDUtil
		 */
		protected function dragDropHandler (event:DragEvent) : void;

		/**
		 *  Makes a deep copy of the object by calling the 
     *  <code>ObjectUtil.copy()</code> method, and replaces 
     *  the copy's <code>uid</code> property (if present) with a 
     *  new value by calling the <code>UIDUtil.createUID()</code> method.
     * 
     *  <p>This method is used for a drag and drop copy.</p>
     * 
     *  @param item The item to copy.
     *  
     *  @return The copy of the object.
     *
     *  @see mx.utils.ObjectUtil
     *  @see mx.utils.UIDUtil
		 */
		protected function copyItemWithUID (item:Object) : Object;

		/**
		 *  Handles <code>DragEvent.DRAG_COMPLETE</code> events.  This method
     *  removes the item from the data provider.
     *
     *  @param event The DragEvent object.
		 */
		protected function dragCompleteHandler (event:DragEvent) : void;

		/**
		 *  @private
		 */
		function selectionTween_updateHandler (event:TweenEvent) : void;

		/**
		 *  @private
		 */
		function selectionTween_endHandler (event:TweenEvent) : void;

		/**
		 *  @private
     *  Handles item renderers moving after initiateSelectionTracking() has been
     *  called. This is used during data effects to redraw selections after
     *  item renderers move.
     *
		 */
		private function rendererMoveHandler (event:MoveEvent) : void;

		/**
		 *  @private
		 */
		private function strictEqualityCompareFunction (a:Object, b:Object) : Boolean;

		/**
		 *  @private
     *  for automation delegate access
		 */
		function getListVisibleData () : Object;

		/**
		 *  @private
     *  for automation delegate access
		 */
		function getItemUID (data:Object) : String;

		/**
		 *  @private
     *  for automation delegate access
		 */
		function getItemRendererForMouseEvent (event:MouseEvent) : IListItemRenderer;

		/**
		 *  @private
     *  for automation delegate access
		 */
		function getListContentHolder () : ListBaseContentHolder;

		/**
		 *  @private
     *  for automation delegate access
		 */
		function getRowInfo () : Array;

		/**
		 *  @private
     *  for automation delegate access
		 */
		function convertIndexToRow (index:int) : int;

		/**
		 *  @private
     *  for automation delegate access
		 */
		function convertIndexToColumn (index:int) : int;

		/**
		 *  @private
     *  for automation delegate access
		 */
		function getCaretIndex () : int;

		/**
		 *  @private
     *  for automation delegate access
		 */
		function getIterator () : IViewCursor;
	}
}
