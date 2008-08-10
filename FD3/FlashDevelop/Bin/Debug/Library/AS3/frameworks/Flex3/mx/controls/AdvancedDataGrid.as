/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.IFactory;
	import mx.collections.IHierarchicalCollectionView;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridBaseSelectionData;
	import flash.display.Sprite;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.events.DragEvent;
	import flash.events.Event;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import flash.events.KeyboardEvent;
	public class AdvancedDataGrid extends AdvancedDataGridBaseEx {
		/**
		 * The column index of the current anchor.
		 *  Use this property in conjunction with the ListBase.anchorIndex property
		 *  to determine the column and row
		 *  indices of the cell where the anchor is located.
		 */
		protected var anchorColumnIndex:int = -1;
		/**
		 * The column name of the item under the caret.
		 *  Used in conjunction with the caretIndex property to determine
		 *  the column/row indices of the cell where the caret is located.
		 */
		protected var caretColumnIndex:int = -1;
		/**
		 * A hash table of selection tweens.  This allows the component to
		 *  quickly find and clean up any tweens in progress if the set
		 *  of selected items is cleared.  The table is indexed by the item's UID
		 *  and column number.
		 */
		protected var cellSelectionTweens:Object;
		/**
		 * Controls the creation and visibility of disclosure icons
		 *  in the navigation tree.
		 *  If false, disclosure icons are not displayed.
		 */
		public function get displayDisclosureIcon():Boolean;
		public function set displayDisclosureIcon(value:Boolean):void;
		/**
		 * If true, expand the navigation tree to show all items.
		 *  If a new branch is added, it will be shown expanded.
		 */
		public function get displayItemsExpanded():Boolean;
		public function set displayItemsExpanded(value:Boolean):void;
		/**
		 * The data provider element that corresponds to the
		 *  item that is currently displayed in the top row of the AdvancedDataGrid control.
		 *  For example, based on how the branches have been opened, closed, and scrolled,
		 *  the top row might be the ninth item in the list of
		 *  currently viewable items, which represents
		 *  some great-grandchild of the root node.
		 *  Setting this property is analogous to setting the verticalScrollPosition of the List control.
		 */
		public function get firstVisibleItem():Object;
		public function set firstVisibleItem(value:Object):void;
		/**
		 * An Array that defines the hierarchy of AdvancedDataGridColumn instances when performing column grouping.
		 *  If you specify both the columns and groupedColumns properties,
		 *  the control uses the groupedColumns property and ignores
		 *  the columns property.
		 */
		public function get groupedColumns():Array;
		public function set groupedColumns(value:Array):void;
		/**
		 * A user-supplied callback function to run on each group item
		 *  to determine its branch icon in the navigation tree.
		 *  You can specify icons by using the itemIcons or setItemIcon properties
		 *  if you have predetermined icons for data items.
		 *  Use this callback function to determine the icon dynamically after examining the data.
		 */
		public function get groupIconFunction():Function;
		public function set groupIconFunction(value:Function):void;
		/**
		 * Specifies the item renderer used to display the branch nodes
		 *  in the navigation tree that correspond to groups.
		 *  By default, it is an instance of the AdvancedDataGridGroupItemRenderer class.
		 */
		public function get groupItemRenderer():IFactory;
		public function set groupItemRenderer(value:IFactory):void;
		/**
		 * A callback function to run on each item to determine its label
		 *  in the navigation tree.
		 *  By default, the control looks for a property named label
		 *  on each data provider item and displays it.
		 *  However, some data sets do not have a label property,
		 *  or have another property that can be used for displaying.
		 *  An example is a data set that has lastName and firstName fields
		 *  but you want to display full names.
		 */
		public function get groupLabelFunction():Function;
		public function set groupLabelFunction(value:Function):void;
		/**
		 * The height of the grouped row, in pixels.
		 */
		public function get groupRowHeight():Number;
		public function set groupRowHeight(value:Number):void;
		/**
		 * The IHierarchicalCollectionView instance used by the control.
		 */
		public function get hierarchicalCollectionView():IHierarchicalCollectionView;
		public function set hierarchicalCollectionView(value:IHierarchicalCollectionView):void;
		/**
		 * The column index of the item that is currently rolled over or under the cursor.
		 *  Use in conjunction with the highlightedIndex property
		 *  to determine the column and row indices
		 *  of the currently highlighted cell.
		 */
		protected var highlightColumnIndex:int = -1;
		/**
		 * An object that specifies the icons for the items.
		 */
		public var itemIcons:Object;
		/**
		 * The index of the first column in the control that scrolls.
		 *  Columns to the left of this one remain fixed in view.
		 */
		public function set lockedColumnCount(value:int):void;
		/**
		 * The index of the first row in the control that scrolls.
		 *  Rows above this one remain fixed in view.
		 */
		public function get lockedRowCount():int;
		public function set lockedRowCount(value:int):void;
		/**
		 */
		protected var movingSelectionLayer:Sprite;
		/**
		 * Array of AdvancedDataGridRendererProvider instances.
		 *  You can use several renderer providers to specify custom item renderers
		 *  used for particular data, at a particular depth of the navigation tree,
		 *  or with column spanning or row spanning.
		 */
		public function get rendererProviders():Array;
		public function set rendererProviders(value:Array):void;
		/**
		 * Contains an Array of cell locations as row and column indices.
		 *  Changing the value of the selectionMode property
		 *  sets this property to null.
		 */
		public function get selectedCells():Array;
		public function set selectedCells(value:Array):void;
		/**
		 * The column of the selected cell.
		 *  Used in conjunction with selectedIndex property to determine
		 *  the column and row indices of the selected cell.
		 */
		protected var selectedColumnIndex:int = -1;
		/**
		 * The column in which the tree is displayed.
		 */
		public function get treeColumn():AdvancedDataGridColumn;
		public function set treeColumn(value:AdvancedDataGridColumn):void;
		/**
		 * The tree column number.
		 */
		protected function get treeColumnIndex():int;
		/**
		 * The tween object that animates rows
		 *  Users can add event listeners to this Object to get
		 *  notified when the tween starts, updates and ends.
		 */
		protected var tween:Object;
		/**
		 * A hash table of data provider item renderers currently in view. The
		 *  table is indexed by the data provider item's UID and column number and is
		 *  used to quickly get the renderer used to display a particular item.
		 */
		protected var visibleCellRenderers:Object;
		/**
		 * Constructor.
		 */
		public function AdvancedDataGrid();
		/**
		 * Adds cell selection information to the control, as if you used the mouse to select the cell.
		 *
		 * @param uid               <String> The UID of the selected cell.
		 * @param columnIndex       <int> The column index of the selected cell.
		 * @param selectionData     <AdvancedDataGridBaseSelectionData> An AdvancedDataGridBaseSelectionData instance defining the
		 *                            information about the selected cell.
		 */
		protected function addCellSelectionData(uid:String, columnIndex:int, selectionData:AdvancedDataGridBaseSelectionData):void;
		/**
		 * @param o                 <Sprite> 
		 * @param columnIndex       <int> 
		 */
		protected function addIndicatorToSelectionLayer(o:Sprite, columnIndex:int):void;
		/**
		 * Sets up the effect for applying the selection indicator.
		 *  The default is a basic alpha tween.
		 *
		 * @param indicator         <Sprite> A Sprite that contains the graphics depicting selection.
		 * @param uid               <String> The UID of the item being selected which can be used to index
		 *                            into a table and track more than one selection effect.
		 * @param columnIndex       <int> The column index of the selected cell.
		 * @param itemRenderer      <IListItemRenderer> The item renderer that is being shown as selected.
		 */
		protected function applyCellSelectionEffect(indicator:Sprite, uid:String, columnIndex:int, itemRenderer:IListItemRenderer):void;
		/**
		 * Applies styles from the AdvancedDatagrid control to an item renderer.
		 *  The item renderer should implement the IStyleClient and IDataRenderer interfaces,
		 *  and be a subclass of the DisplayObject class.
		 *
		 * @param givenItemRenderer <IListItemRenderer> The item renderer.
		 */
		protected function applyUserStylesForItemRenderer(givenItemRenderer:IListItemRenderer):void;
		/**
		 * Returns true if the Object has at least one property,
		 *  which means that the dictionary has at least one key.
		 *
		 * @param o                 <Object> The Object to inspect.
		 * @return                  <Boolean> true if the Object has at least one property.
		 */
		protected function atLeastOneProperty(o:Object):Boolean;
		/**
		 * Clears information on cell selection.
		 */
		protected function clearCellSelectionData():void;
		/**
		 * Removes all selection and highlight and caret indicators.
		 */
		protected override function clearIndicators():void;
		/**
		 * Clears the selectedCells property.
		 *
		 * @param transition        <Boolean (default = false)> Specify true to animate the transition.
		 */
		protected function clearSelectedCells(transition:Boolean = false):void;
		/**
		 * Collapses all the nodes of the navigation tree.
		 */
		public function collapseAll():void;
		/**
		 */
		protected override function createChildren():void;
		/**
		 * Handler for the DragEvent.DRAG_COMPLETE event.
		 *  By default, only the DragManager.MOVE drag action is supported.
		 *  To support the DragManager.COPY
		 *  drag action, you must write an event handler for the
		 *  DragEvent.DRAG_DROP event that
		 *  implements the copy of the AdvancedDataGrid data based on its structure.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected override function dragCompleteHandler(event:DragEvent):void;
		/**
		 * Handler for the DragEvent.DRAG_DROP event.
		 *  This method  hides
		 *  the drop feedback by calling the hideDropFeedback() method.
		 *  By default, only the DragManager.MOVE drag action is supported.
		 *  To support the DragManager.COPY
		 *  drag action, you must write an event handler for the
		 *  DragEvent.DRAG_DROP event that
		 *  implements the copy of the AdvancedDataGrid data based on its structure.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected override function dragDropHandler(event:DragEvent):void;
		/**
		 * Draws a vertical line between columns.
		 *  This implementation draws a line
		 *  directly into the given Sprite.  The Sprite has been cleared
		 *  before lines are drawn into it.
		 *
		 * @param s                 <Sprite> A Sprite that contains a DisplayObject
		 *                            that contains the graphics for that row.
		 * @param colIndex          <int> The column's index in the set of displayed columns.
		 *                            The left most visible column has a column index of 0.
		 * @param color             <uint> The color for the indicator.
		 * @param x                 <Number> The x position for the background
		 */
		protected override function drawVerticalLine(s:Sprite, colIndex:int, color:uint, x:Number):void;
		/**
		 * Expands all the nodes of the navigation tree in the control.
		 */
		public function expandAll():void;
		/**
		 * Opens or closes all the nodes of the navigation tree below the specified item.
		 *
		 * @param item              <Object> An Object defining the branch node. This Object contains the
		 *                            data provider element for the branch node.
		 * @param open              <Boolean> Specify true to open the items,
		 *                            and false to close them.
		 */
		public function expandChildrenOf(item:Object, open:Boolean):void;
		/**
		 * Opens or closes a branch node of the navigation tree.
		 *  When a branch item opens, it restores the open and closed states
		 *  of its child branches if they were already opened.
		 *
		 * @param item              <Object> An Object defining the branch node. This Object contains the
		 *                            data provider element for the branch node.
		 * @param open              <Boolean> Specify true to open the branch node,
		 *                            and false to close it.
		 * @param animate           <Boolean (default = false)> Specify true to animate the transition. (Note:
		 *                            If a branch has over 20 children, to improve performance
		 *                            it does not animate the first time it opens.)
		 * @param dispatchEvent     <Boolean (default = false)> Specifies whether the control dispatches an open event
		 *                            after the open animation is complete (true), or not (false).
		 * @param cause             <Event (default = null)> The event, if any, that initiated the item action.
		 */
		public function expandItem(item:Object, open:Boolean, animate:Boolean = false, dispatchEvent:Boolean = false, cause:Event = null):void;
		/**
		 * Sets selected items based on the caretIndex and
		 *  anchorIndex properties.
		 *  Called by the keyboard selection handlers
		 *  and by the updateDisplayList() method in case the
		 *  keyboard selection handler
		 *  got a page fault while scrolling to get more items.
		 */
		protected override function finishKeySelection():void;
		/**
		 * Returns the parent of a child item. This method returns a value
		 *  only if the item was or is currently visible. Top-level items have a
		 *  parent with the value null.
		 *
		 * @param item              <Object> An Object defining the child item. This Object contains the
		 *                            data provider element for the child.
		 * @return                  <*> The parent of the item.
		 */
		public function getParentItem(item:Object):*;
		/**
		 * Initializes an AdvancedDataGridListData object that is used by the AdvancedDataGrid item renderer.
		 *
		 * @param item              <Object> The item to be rendered.
		 *                            This Object contains the data provider element for the item.
		 * @param adgListData       <AdvancedDataGridListData> The AdvancedDataGridListDataItem to use in rendering the item.
		 */
		protected function initListData(item:Object, adgListData:AdvancedDataGridListData):void;
		/**
		 * Returns true if the specified branch node is open.
		 *
		 * @param item              <Object> Branch node to inspect.
		 *                            This Object contains the data provider element for the branch node.
		 * @return                  <Boolean> true if open, and false if not.
		 */
		public function isItemOpen(item:Object):Boolean;
		/**
		 * Moves the cell and row selection indicators up or down by the given offset
		 *  as the control scrolls its display.
		 *  This assumes all the selection indicators in this row are at
		 *  the same y position.
		 *
		 * @param uid               <String> The UID of the row.
		 * @param offset            <int> scroll offset.
		 * @param absolute          <Boolean> true if offset contains the new scroll position,
		 *                            and false if it contains a value relative to the current scroll position.
		 */
		protected override function moveIndicators(uid:String, offset:int, absolute:Boolean):void;
		/**
		 * Removes cell selection information from the control.
		 *
		 * @param uid               <String> The UID of the selected cell.
		 * @param columnIndex       <int> The column index of the selected cell.
		 */
		protected function removeCellSelectionData(uid:String, columnIndex:int):void;
		/**
		 * Updates the list of selected cells, assuming that the specified item renderer was
		 *  clicked by the mouse, and the keyboard modifiers are in the specified state.
		 *
		 * @param item              <IListItemRenderer> The item renderer for the cell.
		 * @param shiftKey          <Boolean> true to specify that the Shift key is pressed,
		 *                            and false if not.
		 * @param ctrlKey           <Boolean> true to specify that the Control key is pressed,
		 *                            and false if not.
		 * @param transition        <Boolean (default = true)> Specify true to animate the transition.
		 * @return                  <Boolean> Returns true if the operation succeeded.
		 */
		protected function selectCellItem(item:IListItemRenderer, shiftKey:Boolean, ctrlKey:Boolean, transition:Boolean = true):Boolean;
		/**
		 * Updates the set of selected items given that the item renderer provided
		 *  was clicked by the mouse and the keyboard modifiers are in the given
		 *  state. This method also updates the display of the item renderers based
		 *  on their updated selected state.
		 *
		 * @param item              <IListItemRenderer> The item renderer that was clicked.
		 * @param shiftKey          <Boolean> true if the Shift key was held down when
		 *                            the mouse was clicked.
		 * @param ctrlKey           <Boolean> true if the Control key was held down when
		 *                            the mouse was clicked.
		 * @param transition        <Boolean (default = true)> true if the graphics for the selected
		 *                            state should be faded in using an effect.
		 * @return                  <Boolean> true if the set of selected items changed.
		 *                            Clicking an already selected item doesn't always change the set
		 *                            of selected items.
		 */
		protected override function selectItem(item:IListItemRenderer, shiftKey:Boolean, ctrlKey:Boolean, transition:Boolean = true):Boolean;
		/**
		 * Sets the associated icon in the navigation tree for the item.
		 *  Calling this method overrides the
		 *  iconField and iconFunction properties for
		 *  this item if it is a leaf item. Branch items don't use the
		 *  iconField and iconFunction properties.
		 *  They use the folderOpenIcon and folderClosedIcon properties.
		 *
		 * @param item              <Object> An Object defining the item in the navigation tree.
		 *                            This Object contains the data provider element for the item.
		 * @param iconID            <Class> The closed (or leaf) icon.
		 * @param iconID2           <Class> The open icon.
		 */
		public function setItemIcon(item:Object, iconID:Class, iconID2:Class):void;
		/**
		 * Handler for keyboard navigation for the navigation tree.
		 *
		 * @param event             <KeyboardEvent> The keyboard event.
		 * @return                  <Boolean> true if the keyboard navigation is handled correctly.
		 */
		protected function treeNavigationHandler(event:KeyboardEvent):Boolean;
		/**
		 * Indicates that the mouse is over the header part of the header.
		 *  Used as a return value by
		 *  the AdvancedDataGridHeaderRenderer.mouseEventToHeaderPart method.
		 */
		public static const HEADER_ICON_PART:String = "headerIconPart";
		/**
		 * Indicates mouse is over the text part of the header.
		 *  Used as a return value by mouseEventToHeaderPart.
		 */
		public static const HEADER_TEXT_PART:String = "headerTextPart";
	}
}
