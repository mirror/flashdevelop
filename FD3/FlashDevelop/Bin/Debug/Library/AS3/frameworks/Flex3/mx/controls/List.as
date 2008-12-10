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
	import mx.collections.CursorBookmark;
	import mx.collections.IList;
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListBase;
	import mx.controls.listClasses.ListBaseContentHolder;
	import mx.controls.listClasses.ListBaseSeekPending;
	import mx.controls.listClasses.ListData;
	import mx.controls.listClasses.ListItemRenderer;
	import mx.controls.listClasses.ListRowInfo;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.core.ClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.EventPriority;
	import mx.core.FlexShape;
	import mx.core.FlexSprite;
	import mx.core.FlexVersion;
	import mx.core.IChildList;
	import mx.core.IFactory;
	import mx.core.IIMESupport;
	import mx.core.IInvalidating;
	import mx.core.IPropertyChangeNotifier;
	import mx.core.IRawChildrenContainer;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.ListEvent;
	import mx.events.ListEventReason;
	import mx.events.SandboxMouseEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.styles.StyleManager;
	import mx.collections.ItemWrapper;
	import mx.collections.ModifiedCollectionView;
	import mx.core.IUIComponent;

	/**
	 *  Dispatched when the user releases the mouse button while over an item, *  tabs to the List or within the List, or in any other way *  attempts to edit an item. * *  @eventType mx.events.ListEvent.ITEM_EDIT_BEGINNING
	 */
	[Event(name="itemEditBeginning", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when the <code>editedItemPosition</code> property is set *  and the item can be edited. * *  @eventType mx.events.ListEvent.ITEM_EDIT_BEGIN
	 */
	[Event(name="itemEditBegin", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when an item editing session is ending for any reason. * *  @eventType mx.events.ListEvent.ITEM_EDIT_END
	 */
	[Event(name="itemEditEnd", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when an item renderer gets focus, which can occur if the user *  clicks on an item in the List control or navigates to the item using a  *  keyboard. *  Only dispatched if the list item is editable. * *  @eventType mx.events.ListEvent.ITEM_FOCUS_IN
	 */
	[Event(name="itemFocusIn", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when an item renderer loses the focus, which can occur if the  *  user clicks another item in the List control or outside the list,  *  or uses the keyboard to navigate to another item in the List control *  or outside the List control. *  Only dispatched if the list item is editable. * *  @eventType mx.events.ListEvent.ITEM_FOCUS_OUT
	 */
	[Event(name="itemFocusOut", type="mx.events.ListEvent")] 

	/**
	 *  The List control displays a vertical list of items. *  Its functionality is very similar to that of the SELECT *  form element in HTML. *  If there are more items than can be displayed at once, it *  can display a vertical scroll bar so the user can access *  all items in the list. *  An optional horizontal scroll bar lets the user view items *  when the full width of the list items is unlikely to fit. *  The user can select one or more items from the list, depending *  on the value of the <code>allowMultipleSelection</code> property. * *  <p>The List control has the following default sizing  *     characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>Wide enough to fit the widest label in the first seven  *               visible items (or all visible items in the list, if  *               there are less than seven); seven rows high, where  *               each row is 20 pixels high.</td> *        </tr> *        <tr> *           <td>Minimum size</td> *           <td>0 pixels.</td> *        </tr> *        <tr> *           <td>Maximum size</td> *           <td>5000 by 5000.</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:List&gt;</code> tag inherits all the tag attributes *  of its superclass, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:List *    <b>Properties</b> *    editable="false|true" *    editedItemPosition="<i>No default</i>" *    editorDataField="text" *    editorHeightOffset="0" *    editorUsesEnterKey="false|true" *    editorWidthOffset="0" *    editorXOffset="0" *    editorYOffset="0" *    imeMode="null"     *    itemEditor="TextInput" *    itemEditorInstance="<i>Current item editor</i>" *    rendererIsEditor="false|true" *     *    <b>Styles</b> *    backgroundDisabledColor="0xDDDDDD" *     *    <b>Events</b> *    itemEditBegin="<i>No default</i>" *    itemEditEnd="<i>No default</i>" *    itemEditBeginning="<i>No default</i>" *    itemFocusIn="<i>No default</i>" *    itemFocusOut="<i>No default</i>" *  /&gt; *  </pre> * *  @includeExample examples/SimpleList.mxml * *  @see mx.events.ListEvent
	 */
	public class List extends ListBase implements IIMESupport
	{
		/**
		 *  @private     *  Placeholder for mixin by ListAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  A reference to the currently active instance of the item editor,      *  if it exists.     *     *  <p>To access the item editor instance and the new item value when an      *  item is being edited, you use the <code>itemEditorInstance</code>      *  property. The <code>itemEditorInstance</code> property     *  is not valid until after the event listener for     *  the <code>itemEditBegin</code> event executes. Therefore, you typically     *  only access the <code>itemEditorInstance</code> property from within      *  the event listener for the <code>itemEditEnd</code> event.</p>     *     *  <p>The <code>itemEditor</code> property defines the     *  class of the item editor     *  and, therefore, the data type of the item editor instance.</p>     *     *  <p>You do not set this property in MXML.</p>
		 */
		public var itemEditorInstance : IListItemRenderer;
		/**
		 *  @private     *  true if we want to block editing on mouseUp
		 */
		private var dontEdit : Boolean;
		/**
		 *  @private     *  true if we want to block editing on mouseUp
		 */
		private var losingFocus : Boolean;
		/**
		 *  @private     *  true if we're in the endEdit call.  Used to handle     *  some timing issues with collection updates
		 */
		private var inEndEdit : Boolean;
		private var actualRowIndex : int;
		private var actualColIndex : int;
		/**
		 *  cache of measuring objects by factory
		 */
		protected var measuringObjects : Dictionary;
		/**
		 *  A flag that indicates whether or not the user can edit     *  items in the data provider.     *  If <code>true</code>, the item renderers in the control are editable.     *  The user can click on an item renderer to open an editor.     *     *  @default false
		 */
		public var editable : Boolean;
		/**
		 *  The class factory for the item editor to use for the control, if the      *  <code>editable</code> property is set to <code>true</code>.      *     *  @default new ClassFactory(mx.controls.TextInput)
		 */
		public var itemEditor : IFactory;
		/**
		 *  The name of the property of the item editor that contains the new     *  data for the list item.     *  For example, the default <code>itemEditor</code> is     *  TextInput, so the default value of the <code>editorDataField</code> property is     *  <code>"text"</code>, which specifies the <code>text</code> property of the     *  the TextInput control.
		 */
		public var editorDataField : String;
		/**
		 *  The height of the item editor, in pixels, relative to the size of the      *  item renderer. This property can be used to make the editor overlap     *  the item renderer by a few pixels to compensate for a border around the     *  editor.       *  <p>Changing these values while the editor is displayed     *  will have no effect on the current editor, but will affect the next     *  item renderer that opens an editor.</p>     *     *  @default 0
		 */
		public var editorHeightOffset : Number;
		/**
		 *  The width of the item editor, in pixels, relative to the size of the      *  item renderer. This property can be used to make the editor overlap     *  the item renderer by a few pixels to compensate for a border around the     *  editor.     *  <p>Changing these values while the editor is displayed     *  will have no effect on the current editor, but will affect the next     *  item renderer that opens an editor.</p>     *     *  @default 0
		 */
		public var editorWidthOffset : Number;
		/**
		 *  The x location of the upper-left corner of the item editor,     *  in pixels, relative to the upper-left corner of the item.     *  This property can be used to make the editor overlap     *  the item renderer by a few pixels to compensate for a border around the     *  editor.     *  <p>Changing these values while the editor is displayed     *  will have no effect on the current editor, but will affect the next     *  item renderer that opens an editor.</p>     *      *  @default 0
		 */
		public var editorXOffset : Number;
		/**
		 *  The y location of the upper-left corner of the item editor,     *  in pixels, relative to the upper-left corner of the item.     *  This property can be used to make the editor overlap     *  the item renderer by a few pixels to compensate for a border around the     *  editor.     *  <p>Changing these values while the editor is displayed     *  will have no effect on the current editor, but will affect the next     *  item renderer that opens an editor.</p>     *     *  @default 0
		 */
		public var editorYOffset : Number;
		/**
		 *  A flag that indicates whether the item editor uses Enter key.     *  If this property is set to <code>true</code>, the item editor uses the Enter key and the     *  List will not look for the Enter key and move the editor in     *  response.     *  <p>Changing this value while the editor is displayed     *  will have no effect on the current editor, but will affect the next     *  item renderer that opens an editor.</p>     *     *  @default false
		 */
		public var editorUsesEnterKey : Boolean;
		/**
		 *  @private
		 */
		private var bEditedItemPositionChanged : Boolean;
		/**
		 *  @private     *  undefined means we've processed it     *  null means don't put up an editor     *  {} is the coordinates for the editor
		 */
		private var _proposedEditedItemPosition : *;
		/**
		 *  @private     *  the last editedItemPosition.  We restore editing     *  to this point if we get focus from the TAB key
		 */
		private var lastEditedItemPosition : *;
		/**
		 *  @private
		 */
		private var _editedItemPosition : Object;
		/**
		 *  @private     *  Storage for the lockedRowCount property.
		 */
		local var _lockedRowCount : int;
		/**
		 *  Specifies whether the item renderer is also an item      *  editor. If this property is <code>true</code>, Flex     *  ignores the <code>itemEditor</code> property.     *     *  @default false
		 */
		public var rendererIsEditor : Boolean;
		/**
		 *  @private     *  Storage for the imeMode property.
		 */
		private var _imeMode : String;

		/**
		 *  A reference to the item renderer     *  in the DataGrid control whose item is currently being edited.     *     *  <p>From within an event listener for the <code>itemEditBegin</code>     *  and <code>itemEditEnd</code> events,     *  you can access the current value of the item being edited     *  using the <code>editedItemRenderer.data</code> property.</p>
		 */
		public function get editedItemRenderer () : IListItemRenderer;
		/**
		 *  @private     *  The baselinePosition of a List is calculated the same as for ListBase.
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private     *  The maximum value of <code>horizontalScrollPosition</code> in pixels.     *  The default value is NaN.     *  If this value is NaN, the first time the List is layed out     *  it sets <code>horizontalScrollPosition</code> to twice the width.     *  You can calculate the exact value of     *  <code>maxHorizontalScrollPosition</code> by calling     *  the <code>measureWidthOfItems()</code> method on the widest string,     *  and then subtracting the width of the List and the width of its borders.     *     *  <p>For example if the fifth item is the widest,     *  you set <code>maxHorizontalScrollPosition</code> like this:</p>     *  <pre>list.maxHorizontalScrollPosition = list.measureWidthOfItems(5, 1) - (list.width -     *  list.viewMetrics.left - list.viewMetrics.right)</pre>
		 */
		public function set maxHorizontalScrollPosition (value:Number) : void;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  The column and row index of the item renderer for the     *  data provider item being edited, if any.     *     *  <p>This Object has two fields, <code>columnIndex</code> and      *  <code>rowIndex</code>,     *  the zero-based column and item indexes of the item.     *  For a List control, the <code>columnIndex</code> property is always 0;     *  for example: <code>{columnIndex:0, rowIndex:3}</code>.</p>     *     *  <p>Setting this property scrolls the item into view and     *  dispatches the <code>itemEditBegin</code> event to     *  open an item editor on the specified item,     *  </p>
		 */
		public function get editedItemPosition () : Object;
		/**
		 *  @private
		 */
		public function set editedItemPosition (value:Object) : void;
		/**
		 *  The index of the first row in the control that scrolls.     *  Rows above this one remain fixed in view.     *      *  @default 0     *  @private
		 */
		public function get lockedRowCount () : int;
		/**
		 *  @private
		 */
		public function set lockedRowCount (value:int) : void;
		/**
		 *  Specifies the IME (input method editor) mode.     *  The IME enables users to enter text in Chinese, Japanese, and Korean.     *  Flex sets the specified IME mode when the control gets focus,     *  and sets it back to the previous value when the control loses focus.     *     * <p>The flash.system.IMEConversionMode class defines constants for the     *  valid values for this property.     *  You can also specify <code>null</code> to specify no IME.</p>     *       *  @see flash.system.IME     *  @see flash.system.IMEConversionMode     *       *  @default null
		 */
		public function get imeMode () : String;
		/**
		 *  @private
		 */
		public function set imeMode (value:String) : void;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  @private
		 */
		public function set itemRenderer (value:IFactory) : void;

		/**
		 *  Constructor.
		 */
		public function List ();
		/**
		 *  @private     *  Called by the initialize() method of UIComponent     *  to hook in the accessibility code.
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private     *  The measuredWidth is widest of the items in the first set of rows it will display.     *  If the rowCount property has been set it will measure that many rows, otherwise     *  it will measure 7 rows and use the widest.     *  The measuredHeight is based on the height of one line of text or 20 pixels, whichever     *  is greater.  Thus the measuredHeight will depend on fonts related styles like fontSize.     *  Then that height is multiplied by 7 or rowCount if it has been specified.     *
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function configureScrollBars () : void;
		/**
		 *  @private     *  Makes verticalScrollPosition smaller until it is 0 or there     *  are no empty rows.  This is needed if we're scrolled to the     *  bottom and something is deleted or the rows resize so more     *  rows can be shown.
		 */
		private function adjustVerticalScrollPositionDownward (rowCount:int) : Boolean;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		protected function adjustListContent (unscaledWidth:Number = -1, unscaledHeight:Number = -1) : void;
		/**
		 *  @private
		 */
		protected function drawRowBackgrounds () : void;
		/**
		 *  Draws a row background      *  at the position and height specified. This creates a Shape as a     *  child of the input Sprite and fills it with the appropriate color.     *  This method also uses the <code>backgroundAlpha</code> style property      *  setting to determine the transparency of the background color.     *      *  @param s A Sprite that will contain a display object     *  that contains the graphics for that row.     *     *  @param rowIndex The row's index in the set of displayed rows. The     *  header does not count; the top most visible row has a row index of 0.     *  This is used to keep track of the objects used for drawing     *  backgrounds so that a particular row can reuse the same display object     *  even though the index of the item that the row is rendering has changed.     *     *  @param y The suggested y position for the background.     *      *  @param height The suggested height for the indicator.     *      *  @param color The suggested color for the indicator.     *      *  @param dataIndex The index of the item for that row in the     *  data provider. For example, this can be used to color the 10th item differently.
		 */
		protected function drawRowBackground (s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int) : void;
		/**
		 *  @private
		 */
		protected function makeRowsAndColumns (left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0) : Point;
		/**
		 *  Positions the item editor instance at the suggested position     *  with the suggested dimensions. The Tree control overrides this     *  method and adjusts the position to compensate for indentation     *  of the renderer.     *     *  @param x The suggested x position for the indicator.     *  @param y The suggested y position for the indicator.     *  @param w The suggested width for the indicator.     *  @param h The suggested height for the indicator.
		 */
		protected function layoutEditor (x:int, y:int, w:int, h:int) : void;
		/**
		 *  @private
		 */
		protected function scrollHandler (event:Event) : void;
		/**
		 *  @private     *  List scrolls horizontally by pixels.
		 */
		protected function scrollHorizontally (pos:int, deltaPos:int, scrollUp:Boolean) : void;
		/**
		 *  Creates a new ListData instance and populates the fields based on     *  the input data provider item.     *       *  @param data The data provider item used to populate the ListData.     *  @param uid The UID for the item.     *  @param rowNum The index of the item in the data provider.     *       *  @return A newly constructed ListData object.
		 */
		protected function makeListData (data:Object, uid:String, rowNum:int) : BaseListData;
		/**
		 *  @private
		 */
		function setupRendererFromData (item:IListItemRenderer, wrappedData:Object) : void;
		/**
		 *  @private
		 */
		public function measureWidthOfItems (index:int = -1, count:int = 0) : Number;
		/**
		 *  @private
		 */
		public function measureHeightOfItems (index:int = -1, count:int = 0) : Number;
		/**
		 *  @private
		 */
		protected function mouseEventToItemRenderer (event:MouseEvent) : IListItemRenderer;
		/**
		 *  @private
		 */
		function getMeasuringRenderer (data:Object) : IListItemRenderer;
		/**
		 *  @private
		 */
		function purgeMeasuringRenderers () : void;
		/**
		 *  Get the appropriate renderer, using the default renderer if none is specified.     *      *  @param data The object from which the item renderer is created.     *       *  @return The renderer.
		 */
		public function createItemRenderer (data:Object) : IListItemRenderer;
		/**
		 *  @private     *      *  Determines whether editing is prevented for a specific location
		 */
		private function editingTemporarilyPrevented (coord:Object) : Boolean;
		/**
		 *  @private
		 */
		private function setEditedItemPosition (coord:Object) : void;
		/**
		 *  @private     *  focus an item in the grid - harder than it looks
		 */
		private function commitEditedItemPosition (coord:Object) : void;
		/**
		 *  Creates the item editor for the item renderer at the     *  <code>editedItemPosition</code> using the editor     *  specified by the <code>itemEditor</code> property.     *     *  <p>This method sets the editor instance as the      *  <code>itemEditorInstance</code> property.</p>     *     *  <p>You can call this method only from within the event listener     *  for the <code>itemEditBegin</code> event. To create an editor      *  at other times, set the <code>editedItemPosition</code> property      *  to generate the <code>itemEditBegin</code> event.</p>     *     *  @param colIndex The column index. Flex sets the value of this property to 0 for a List control.     *     *  @param rowIndex The index in the data provider of the item to be      *  edited.
		 */
		public function createItemEditor (colIndex:int, rowIndex:int) : void;
		/**
		 *  @private     *  Determines the next item to navigate to by using the Tab key.     *  If the item to be focused falls out of range (the end or beginning     *  of the grid), moves the focus outside the grid.
		 */
		private function findNextItemRenderer (shiftKey:Boolean) : Boolean;
		/**
		 *  Closes an item editor that is currently open on an item.      *  You typically call this method only from within the event listener      *  for the <code>itemEditEnd</code> event, after     *  you call the <code>preventDefault()</code> method to prevent     *  the default event listener from executing.
		 */
		public function destroyItemEditor () : void;
		/**
		 *  Stops the editing of an item in the data provider.     *  When the user finished editing an item, the control calls this method.       *  It dispatches the <code>itemEditEnd</code> event to start the process     *  of copying the edited data from     *  the <code>itemEditorInstance</code> to the data provider and hiding the      *  <code>itemEditorInstance</code>.     *       *  @param reason A constant defining the reason for the event      *  (such as "CANCELLED", "NEW_ROW", or "OTHER").      *  The value must be a member of the ListEventReason class.     *       *  @return Returns <code>true</code> if <code>preventDefault()</code> is not called.     *  Otherwise, <code>false</code>.     *       *  @see mx.events.ListEventReason
		 */
		protected function endEdit (reason:String) : Boolean;
		/**
		 *  Determines if the item renderer for a data provider item      *  is editable.     *     *  @param data The data provider item     *  @return <code>true</code> if the item is editable
		 */
		public function isItemEditable (data:Object) : Boolean;
		/**
		 *  @private
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  @private     *  when the grid gets focus, focus an item
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 *  @private     *  when the grid loses focus, close the editor
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
		 */
		private function editorMouseDownHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function editorKeyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private     *  find the next item down from the currently edited item, and focus it.
		 */
		private function findNextEnterItemRenderer (event:KeyboardEvent) : void;
		/**
		 *  @private     *  This gets called when the focus is changed by using the mouse.
		 */
		private function mouseFocusChangeHandler (event:MouseEvent) : void;
		/**
		 *  @private     *  This gets called when the focus is changed by pressing the Tab key.
		 */
		private function keyFocusChangeHandler (event:FocusEvent) : void;
		/**
		 *  @private     *  Hides the itemEditorInstance if it loses focus.
		 */
		private function itemEditorFocusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		private function itemEditorItemEditBeginningHandler (event:ListEvent) : void;
		/**
		 *  @private     *  create the editor for the item.
		 */
		private function itemEditorItemEditBeginHandler (event:ListEvent) : void;
		/**
		 *  @private     *  save off the data and get rid of the editor
		 */
		private function itemEditorItemEditEndHandler (event:ListEvent) : void;
		/**
		 *  @private
		 */
		protected function drawHighlightIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function drawCaretIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function drawSelectionIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		protected function mouseWheelHandler (event:MouseEvent) : void;
		/**
		 *  @private     *  Catches any events from the model. Optimized for editing one item.     *  @param eventObj
		 */
		protected function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function callSetupRendererFromData (item:IListItemRenderer, data:Object) : void;
		/**
		 *  @private
		 */
		function callMakeListData (data:Object, uid:String, rowNum:int) : BaseListData;
	}
}
