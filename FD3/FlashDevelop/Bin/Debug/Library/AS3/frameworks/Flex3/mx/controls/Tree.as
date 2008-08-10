/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.IIMESupport;
	import mx.controls.treeClasses.ITreeDataDescriptor;
	import mx.events.DragEvent;
	import flash.events.Event;
	import mx.controls.treeClasses.TreeListData;
	public class Tree extends List implements IIMESupport {
		/**
		 * Tree delegates to the data descriptor for information about the data.
		 *  This data is then used to parse and move about the data source.
		 */
		public function get dataDescriptor():ITreeDataDescriptor;
		public function set dataDescriptor(value:ITreeDataDescriptor):void;
		/**
		 * An object that contains the data to be displayed.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * Indicates that items can be moved instead of just copied
		 *  from the Tree control as part of a drag-and-drop operation.
		 */
		public function get dragMoveEnabled():Boolean;
		public function set dragMoveEnabled(value:Boolean):void;
		/**
		 * The item that is currently displayed in the top row of the tree.
		 *  Based on how the branches have been opened and closed and scrolled,
		 *  the top row might hold, for example, the ninth item in the list of
		 *  currently viewable items which in turn represents
		 *  some great-grandchild of the root.
		 *  Setting this property is analogous to setting the verticalScrollPosition of the List control.
		 *  If the item isn't currently viewable, for example, because it
		 *  is under a nonexpanded item, setting this property has no effect.
		 */
		public function get firstVisibleItem():Object;
		public function set firstVisibleItem(value:Object):void;
		/**
		 * Indicates that the current dataProvider has a root item; for example,
		 *  a single top node in a hierarchical structure. XML and Object
		 *  are examples of types that have a root. Lists and arrays do not.
		 */
		public function get hasRoot():Boolean;
		/**
		 * An object that specifies the icons for the items.
		 */
		public var itemIcons:Object;
		/**
		 * The maximum value for the maxHorizontalScrollPosition property for the Tree control.
		 *  Unlike the maxHorizontalScrollPosition property
		 *  in the List control, this property is modified by the Tree control as
		 *  items open and close and as items in the tree otherwise become
		 *  visible or are hidden (for example, by scrolling).
		 */
		public function get maxHorizontalScrollPosition():Number;
		public function set maxHorizontalScrollPosition(value:Number):void;
		/**
		 * The items that have been opened or set opened.
		 */
		public function get openItems():Object;
		public function set openItems(value:Object):void;
		/**
		 * Sets the visibility of the root item.
		 *  If the dataProvider data has a root node, and this is set to
		 *  false, the Tree control does not display the root item.
		 *  Only the decendants of the root item are displayed.
		 *  This flag has no effect on non-rooted dataProviders, such as List and Array.
		 */
		public function get showRoot():Boolean;
		public function set showRoot(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function Tree();
		/**
		 * Handles DragEvent.DRAG_COMPLETE events.  This method
		 *  removes the item from the data provider.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected override function dragCompleteHandler(event:DragEvent):void;
		/**
		 * Handles DragEvent.DRAG_DROP events.  This method  hides
		 *  the drop feedback by calling the hideDropFeedback() method.
		 *
		 * @param event             <DragEvent> The DragEvent object.
		 */
		protected override function dragDropHandler(event:DragEvent):void;
		/**
		 * Opens or closes all the tree items below the specified item.
		 *  If you set dataProvider and then immediately call
		 *  expandChildrenOf() you may not see the correct behavior.
		 *  You should either wait for the component to validate
		 *  or call the validateNow() method.
		 *
		 * @param item              <Object> The starting item.
		 * @param open              <Boolean> Toggles an open or close operation.
		 *                            Specify true to open the items, and false to close them.
		 */
		public function expandChildrenOf(item:Object, open:Boolean):void;
		/**
		 * Opens or closes a branch item.
		 *  When a branch item opens, it restores the open and closed states
		 *  of its child branches if they were already opened.
		 *  If you set dataProvider and then immediately call
		 *  expandItem() you may not see the correct behavior.
		 *  You should either wait for the component to validate
		 *  or call validateNow().
		 *
		 * @param item              <Object> Item to affect.
		 * @param open              <Boolean> Specify true to open, false to close.
		 * @param animate           <Boolean (default = false)> Specify true to animate the transition. (Note:
		 *                            If a branch has over 20 children, it does not animate the first time it opens,
		 *                            for performance reasons.)
		 * @param dispatchEvent     <Boolean (default = false)> Controls whether the tree fires an open event
		 *                            after the open animation is complete.
		 * @param cause             <Event (default = null)> The event, if any, that initiated the item open action.
		 */
		public function expandItem(item:Object, open:Boolean, animate:Boolean = false, dispatchEvent:Boolean = false, cause:Event = null):void;
		/**
		 * Returns the known parent of a child item. This method returns a value
		 *  only if the item was or is currently visible. Top level items have a
		 *  parent with the value null.
		 *
		 * @param item              <Object> item for which to get the parent.
		 * @return                  <*> The parent of the item.
		 */
		public function getParentItem(item:Object):*;
		/**
		 * Initializes a TreeListData object that is used by the tree item renderer.
		 *
		 * @param item              <Object> The item to be rendered.
		 * @param treeListData      <TreeListData> The TreeListDataItem to use in rendering the item.
		 */
		protected function initListData(item:Object, treeListData:TreeListData):void;
		/**
		 * Returns true if the specified item branch is open (is showing its children).
		 *
		 * @param item              <Object> Item to inspect.
		 * @return                  <Boolean> True if open, false if not.
		 */
		public function isItemOpen(item:Object):Boolean;
		/**
		 * Creates a new TreeListData instance and populates the fields based on
		 *  the input data provider item.
		 *
		 * @param data              <Object> The data provider item used to populate the ListData.
		 * @param uid               <String> The UID for the item.
		 * @param rowNum            <int> The index of the item in the data provider.
		 * @return                  <BaseListData> A newly constructed ListData object.
		 */
		protected override function makeListData(data:Object, uid:String, rowNum:int):BaseListData;
		/**
		 * Sets the associated icon for the item.  Calling this method overrides the
		 *  iconField and iconFunction properties for
		 *  this item if it is a leaf item. Branch items don't use the
		 *  iconField and iconFunction properties.
		 *  They use the folderOpenIcon and folderClosedIcon properties.
		 *
		 * @param item              <Object> Item to affect.
		 * @param iconID            <Class> Linkage ID for the closed (or leaf) icon.
		 * @param iconID2           <Class> Linkage ID for the open icon.
		 */
		public function setItemIcon(item:Object, iconID:Class, iconID2:Class):void;
	}
}
