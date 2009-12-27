package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.xml.XMLNode;
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.ItemResponder;
	import mx.collections.IViewCursor;
	import mx.collections.XMLListCollection;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListRowInfo;
	import mx.controls.listClasses.ListBaseSelectionDataPending;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.controls.treeClasses.HierarchicalCollectionView;
	import mx.controls.treeClasses.HierarchicalViewCursor;
	import mx.controls.treeClasses.ITreeDataDescriptor;
	import mx.controls.treeClasses.ITreeDataDescriptor2;
	import mx.controls.treeClasses.TreeItemRenderer;
	import mx.controls.treeClasses.TreeListData;
	import mx.core.ClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.EventPriority;
	import mx.core.FlexSprite;
	import mx.core.FlexShape;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.IIMESupport;
	import mx.core.IInvalidating;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.Tween;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.events.ListEventReason;
	import mx.events.ScrollEvent;
	import mx.events.TreeEvent;
	import mx.managers.DragManager;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.styles.StyleManager;
	import mx.events.DragEvent;

	/**
	 *  Dispatched when a branch is closed or collapsed.
 *
 *  @eventType mx.events.TreeEvent.ITEM_CLOSE
	 */
	[Event(name="itemClose", type="mx.events.TreeEvent")] 

	/**
	 *  Dispatched when a branch is opened or expanded.
 *
 *  @eventType mx.events.TreeEvent.ITEM_OPEN
	 */
	[Event(name="itemOpen", type="mx.events.TreeEvent")] 

	/**
	 *  Dispatched when a branch open or close is initiated.
 *
 *  @eventType mx.events.TreeEvent.ITEM_OPENING
	 */
	[Event(name="itemOpening", type="mx.events.TreeEvent")] 

include "../styles/metadata/PaddingStyles.as"
	/**
	 *  Colors for rows in an alternating pattern.
 *  Value can be an Array of two of more colors.
 *  Used only if the <code>backgroundColor</code> property is not specified.
 * 
 *  @default undefined
	 */
	[Style(name="alternatingItemColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 

	/**
	 *  Array of colors used in the Tree control, in descending order.
 *
 *  @default undefined
	 */
	[Style(name="depthColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 

	/**
	 *  Specifies the default icon for a leaf item.
 *  In MXML, you can use the following syntax to set this property:
 *  <code>defaultLeafIcon="&#64;Embed(source='c.jpg');"</code>
 *
 *  The default value is the "TreeNodeIcon" symbol in the Assets.swf file.
	 */
	[Style(name="defaultLeafIcon", type="Class", format="EmbeddedFile", inherit="no")] 

	/**
	 *  Specifies the icon that is displayed next to a parent item that is open so that its
 *  children are displayed.
 *
 *  The default value is the "TreeDisclosureOpen" symbol in the Assets.swf file.
	 */
	[Style(name="disclosureOpenIcon", type="Class", format="EmbeddedFile", inherit="no")] 

	/**
	 *  Specifies the icon that is displayed next to a parent item that is closed so that its
 *  children are not displayed (the subtree is collapsed).
 *
 *  The default value is the "TreeDisclosureClosed" symbol in the Assets.swf file.
	 */
	[Style(name="disclosureClosedIcon", type="Class", format="EmbeddedFile", inherit="no")] 

	/**
	 *  Specifies the folder open icon for a branch item of the tree.
 *  In MXML, you can use the following syntax to set this property:
 *  <code>folderOpenIcon="&#64;Embed(source='a.jpg');"</code>
 *
 *  The default value is the "TreeFolderOpen" symbol in the Assets.swf file.
	 */
	[Style(name="folderOpenIcon", type="Class", format="EmbeddedFile", inherit="no")] 

	/**
	 *  Specifies the folder closed icon for a branch item of the tree.
 *  In MXML, you can use the following syntax to set this property:
 *  <code>folderClosedIcon="&#64;Embed(source='b.jpg');"</code>
 *
 *  The default value is the "TreeFolderClosed" symbol in the Assets.swf file.
	 */
	[Style(name="folderClosedIcon", type="Class", format="EmbeddedFile", inherit="no")] 

	/**
	 *  Indentation for each tree level, in pixels.
 *
 *  @default 17
	 */
	[Style(name="indentation", type="Number", inherit="no")] 

	/**
	 *  Length of an open or close transition, in milliseconds.
 *
 *  @default 250
	 */
	[Style(name="openDuration", type="Number", format="Time", inherit="no")] 

	/**
	 *  Easing function to control component tweening.
 *
 *  <p>The default value is <code>undefined</code>.</p>
	 */
	[Style(name="openEasingFunction", type="Function", inherit="no")] 

	/**
	 *  Color of the background when the user rolls over the link.
 *
 *  @default undefined
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Color of the background when the user selects the link.
 *
 *  @default undefined
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Specifies the disabled color of a list item.
 *
 *  @default 0xDDDDDD
 *
	 */
	[Style(name="selectionDisabledColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Reference to an <code>easingFunction</code> function used for controlling programmatic tweening.
 *
 *  <p>The default value is <code>undefined</code>.</p>
	 */
	[Style(name="selectionEasingFunction", type="Function", inherit="no")] 

	/**
	 *  Color of the text when the user rolls over a row.
 *
 *  @default 0x2B333C
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Color of the text when the user selects a row.
 *
 *  @default 0x2B333C
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 

	[DefaultProperty("dataProvider")] 

include "../core/Version.as"
	/**
	 *  The Tree control lets a user view hierarchical data arranged as an expandable tree.
 *  Each item in a tree can be a leaf or a branch.
 *  A leaf item is an end point in the tree.
 *  A branch item can contain leaf or branch items, or it can be empty.
 * 
 *  <p>By default, a leaf is represented by a text label next to a file icon.
 *  A branch is represented by a text label next to a folder icon, with a
 *  disclosure triangle that a user can open to expose children.</p>
 *  
 *  <p>The Tree class uses an ITreeDataDescriptor or ITreeDataDescriptor2 object to parse and
 *  manipulate the data provider.
 *  The default tree data descriptor, an object of the DefaultDataDescriptor class,
 *  supports XML and Object classes; an Object class data provider must have all children
 *  in <code>children</code> fields.
 *  </p>
 * 
 *  <p>The Tree control has the following default sizing 
 *     characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>Wide enough to accommodate the icon, label, and 
 *               expansion triangle, if any, of the widest node in the 
 *               first 7 displayed (uncollapsed) rows, and seven rows 
 *               high, where each row is 20 pixels in height. If a 
 *               scroll bar is required, the width of the scroll bar is 
 *               not included in the width calculations.</td>
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
 *  The &lt;mx:Tree&gt; tag inherits all the tag attributes of its superclass, and
 *  adds the following tag attributes:
 *  </p>
 *  <pre>
 *  &lt;mx:Tree
 *    <b>Properties</b>
 *    dataDescriptor="<i>Instance of DefaultDataDescriptor</i>"
 *    dataProvider="null"
 *    dragMoveEnabled="true|false"
 *    firstVisibleItem="<i>First item in the control</i>"
 *    hasRoot="false|true"
 *    itemIcons="null"
 *    maxHorizontalScrollPosition="0"
 *    openItems="null"
 *    showRoot="true|false"
 *    &nbsp;
 *    <b>Styles</b>
 *    alternatingItemColors="undefined"
 *    backgroundDisabledColor="0xDDDDDD"
 *    defaultLeafIcon="<i>'TreeNodeIcon' symbol in Assets.swf</i>"
 *    depthColors="undefined"
 *    disclosureClosedIcon="<i>'TreeDisclosureClosed' symbol in Assets.swf</i>"
 *    disclosureOpenIcon="<i>'TreeDisclosureOpen' symbol in Assets.swf</i>"
 *    folderClosedIcon="<i>'TreeFolderClosed' symbol in Assets.swf</i>"
 *    folderOpenIcon="<i>'TreeFolderOpen' symbol in Assets.swf</i>"
 *    indentation="17"
 *    openDuration="250"
 *    openEasingFunction="undefined"
 *    paddingLeft="2"
 *    paddingRight="0"
 *    rollOverColor="0xAADEFF"
 *    selectionColor="0x7FCDFE"
 *    selectionDisabledColor="0xDDDDDD"
 *    selectionEasingFunction="undefined"
 *    textRollOverColor="0x2B333C"
 *    textSelectedColor="0x2B333C"
 *    &nbsp;
 *    <b>Events</b>
 *    change="<i>No default</i>"
 *    itemClose="<i>No default</i>"
 *    itemOpen="<i>No default</i>"
 *    itemOpening="<i>No default</i>"
 *  /&gt;
 *  </pre>
 *
 *  @see mx.controls.treeClasses.ITreeDataDescriptor
 *  @see mx.controls.treeClasses.ITreeDataDescriptor2
 *  @see mx.controls.treeClasses.DefaultDataDescriptor
 *
 *  @includeExample examples/TreeExample.mxml
	 */
	public class Tree extends List implements IIMESupport
	{
		/**
		 *  @private
		 */
		private var IS_NEW_ROW_STYLE : Object;
		/**
		 *  @private
     *  Placeholder for mixin by TreeAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
     *  Item is currently in the process of opening
		 */
		private var opening : Boolean;
		/**
		 *  @private
     *  The tween object that animates rows
		 */
		private var tween : Object;
		/**
		 *  @private
		 */
		private var maskList : Array;
		/**
		 *  @private
		 */
		private var _userMaxHorizontalScrollPosition : Number;
		/**
		 *  @private
		 */
		private var eventPending : Object;
		/**
		 *  @private
		 */
		private var eventAfterTween : Object;
		/**
		 *  @private
		 */
		private var oldLength : int;
		/**
		 *  @private
		 */
		private var expandedItem : Object;
		/**
		 *  @private
		 */
		private var bSelectedItemRemoved : Boolean;
		/**
		 *  @private
     *  Used to slow the scrolling down a bit
		 */
		private var minScrollInterval : Number;
		/**
		 *  @private
		 */
		private var rowNameID : Number;
		/**
		 *  @private
		 */
		private var _editable : Boolean;
		/**
		 *  @private
		 */
		private var _itemEditor : IFactory;
		/**
		 *  @private
     *  Used to block giving focus to editor on focusIn
		 */
		private var dontEdit : Boolean;
		/**
		 *  @private
		 */
		private var lastUserInteraction : Event;
		/**
		 *  @private
     *  automation delegate access
		 */
		var _dropData : Object;
		/**
		 *  An object that specifies the icons for the items.
     *  Each entry in the object has a field name that is the item UID
     *  and a value that is an an object with the following format:
     *  <pre>
     *  {iconID: <i>Class</i>, iconID2: <i>Class</i>}
     *  </pre>
     *  The <code>iconID</code> field value is the class of the icon for
     *  a closed or leaf item and the <code>iconID2</code> is the class
     *  of the icon for an open item.
     *
     *  <p>This property is intended to allow initialization of item icons.
     *  Changes to this array after initialization are not detected
     *  automatically.
     *  Use the <code>setItemIcon()</code> method to change icons dynamically.</p>
     *
     *  @see #setItemIcon()
     *  @default undefined
		 */
		public var itemIcons : Object;
		/**
		 *  @private
		 */
		var isOpening : Boolean;
		/**
		 *  @private
     *  used by opening tween
     *  rowIndex is the row below the row that was picked
     *  and is the first one that will actually change
		 */
		private var rowIndex : int;
		/**
		 *  @private
     *  Number of rows that are or will be tweened
		 */
		private var rowsTweened : int;
		/**
		 *  @private
		 */
		private var rowList : Array;
		/**
		 *  @private
		 */
		var collectionLength : int;
		/**
		 *  A hook for accessibility
		 */
		var wrappedCollection : ICollectionView;
		/**
		 *  @private
		 */
		var collectionThrowsIPE : Boolean;
		/**
		 *  @private
		 */
		private var haveItemIndices : Boolean;
		/**
		 *  @private
		 */
		private var lastTreeSeekPending : TreeSeekPending;
		/**
		 *  @private
		 */
		private var bFinishArrowKeySelection : Boolean;
		private var proposedSelectedItem : Object;
		/**
		 *  @private
		 */
		private var dataProviderChanged : Boolean;
		/**
		 *  @private
     *  Storage for the dragMoveEnabled property.
     *  For Tree only, this initializes to true.
		 */
		private var _dragMoveEnabled : Boolean;
		/**
		 *  @private
		 */
		var _dataDescriptor : ITreeDataDescriptor;
		/**
		 *  @private
     *  Storage variable for showRoot flag.
		 */
		var _showRoot : Boolean;
		/**
		 *  @private
     *  Storage variable for changes to showRoot.
		 */
		var showRootChanged : Boolean;
		/**
		 *  @private
    *  Flag to indicate if the model has a root
		 */
		var _hasRoot : Boolean;
		/**
		 *  @private
     *  Storage variable for the original dataProvider
		 */
		var _rootModel : ICollectionView;
		/**
		 *  @private
     *  Used to hold a list of items that are opened or set opened.
		 */
		private var _openItems : Object;
		/**
		 *  @private
		 */
		private var openItemsChanged : Boolean;

		/**
		 *  An object that contains the data to be displayed.
     *  When you assign a value to this property, the Tree class handles
     *  the source data object as follows:
     *  <p>
     *  <ul><li>A String containing valid XML text is converted to an XMLListCollection.</li>
     *  <li>An XMLNode is converted to an XMLListCollection.</li>
     *  <li>An XMLList is converted to an XMLListCollection.</li>
     *  <li>Any object that implements the ICollectionView interface is cast to
     *  an ICollectionView.</li>
     *  <li>An Array is converted to an ArrayCollection.</li>
     *  <li>Any other type object is wrapped in an Array with the object as its sole
     *  entry.</li></ul>
     *  </p>
     *
     *  @default null
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  @private
		 */
		public function get dataProvider () : Object;

		/**
		 *  The maximum value for the <code>maxHorizontalScrollPosition</code> property for the Tree control.
     *  Unlike the <code>maxHorizontalScrollPosition</code> property
     *  in the List control, this property is modified by the Tree control as
     *  items open and close and as items in the tree otherwise become
     *  visible or are hidden (for example, by scrolling).
     *
     *  <p>If you set this property to the widest known item in the dataProvider,
     *  the Tree control modifies it so that even if that widest item
     *  is four levels down in the tree, the user can scroll to see it.
     *  As a result, although you read back the same value for the
     *  <code>maxHorizontalScrollPosition</code> property that you set,
     *  it isn't necessarily the actual value used by the Tree control.</p>
     *
     *  @default 0
     *
		 */
		public function get maxHorizontalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set maxHorizontalScrollPosition (value:Number) : void;

		/**
		 *  Indicates that items can be moved instead of just copied
     *  from the Tree control as part of a drag-and-drop operation.
     *
     *  @default true
		 */
		public function get dragMoveEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set dragMoveEnabled (value:Boolean) : void;

		/**
		 *  The item that is currently displayed in the top row of the tree.
     *  Based on how the branches have been opened and closed and scrolled,
     *  the top row might hold, for example, the ninth item in the list of
     *  currently viewable items which in turn represents
     *  some great-grandchild of the root.
     *  Setting this property is analogous to setting the verticalScrollPosition of the List control.
     *  If the item isn't currently viewable, for example, because it
     *  is under a nonexpanded item, setting this property has no effect.
     *
     *  <p>NOTE: In Flex 1.0 this property was typed as XMLNode although it really was
     *  either an XMLNode or TreeNode.  In 2.0, it is now the generic type Object and will
     *  return an object of the same type as the data contained in the dataProvider.</p>
     *
     *  <p>The default value is the first item in the Tree control.</p>
		 */
		public function get firstVisibleItem () : Object;
		/**
		 *  @private
		 */
		public function set firstVisibleItem (value:Object) : void;

		/**
		 *  Tree delegates to the data descriptor for information about the data.
     *  This data is then used to parse and move about the data source.
     *  <p>When you specify this property as an attribute in MXML you must
     *  use a reference to the data descriptor, not the string name of the
     *  descriptor. Use the following format for the property:</p>
     *
     * <pre>&lt;mx:Tree id="tree" dataDescriptor="{new MyCustomTreeDataDescriptor()}"/&gt;></pre>
     *
     *  <p>Alternatively, you can specify the property in MXML as a nested
     *  subtag, as the following example shows:</p>
     *
     * <pre>&lt;mx:Tree&gt;
     * &lt;mx:dataDescriptor&gt;
     * &lt;myCustomTreeDataDescriptor&gt;</pre>
     *
     * <p>The default value is an internal instance of the
     *  DefaultDataDescriptor class.</p>
     *
		 */
		public function set dataDescriptor (value:ITreeDataDescriptor) : void;
		/**
		 *  Returns the current ITreeDataDescriptor.
     *
     *   @default DefaultDataDescriptor
		 */
		public function get dataDescriptor () : ITreeDataDescriptor;

		/**
		 *  Sets the visibility of the root item.
     *
     *  If the dataProvider data has a root node, and this is set to 
     *  <code>false</code>, the Tree control does not display the root item. 
     *  Only the decendants of the root item are displayed.  
     * 
     *  This flag has no effect on non-rooted dataProviders, such as List and Array. 
     *
     *  @default true
     *  @see #hasRoot
		 */
		public function get showRoot () : Boolean;
		/**
		 *  @private
		 */
		public function set showRoot (value:Boolean) : void;

		/**
		 *  Indicates that the current dataProvider has a root item; for example, 
     *  a single top node in a hierarchical structure. XML and Object 
     *  are examples of types that have a root. Lists and arrays do not.
     * 
     *  @see #showRoot
		 */
		public function get hasRoot () : Boolean;

		/**
		 *  The items that have been opened or set opened.
     * 
     *  @default null
		 */
		public function get openItems () : Object;
		/**
		 *  @private
		 */
		public function set openItems (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function Tree ();

		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
     *  Position indicator bar that shows where an item will be placed in the list.
		 */
		public function showDropFeedback (event:DragEvent) : void;

		/**
		 *  @private
		 */
		public function calculateDropIndex (event:DragEvent = null) : int;

		/**
		 *  @private
		 */
		protected function addDragData (ds:Object) : void;

		/**
		 *  @private
     *
     *  see ListBase.as
		 */
		function addClipMask (layoutChanged:Boolean) : void;

		/**
		 *  @private
     *
     *  Undo the effects of the addClipMask function (above)
		 */
		function removeClipMask () : void;

		/**
		 *  Creates a new TreeListData instance and populates the fields based on
     *  the input data provider item. 
     *  
     *  @param data The data provider item used to populate the ListData.
     *  @param uid The UID for the item.
     *  @param rowNum The index of the item in the data provider.
     *  
     *  @return A newly constructed ListData object.
		 */
		protected function makeListData (data:Object, uid:String, rowNum:int) : BaseListData;

		/**
		 *  @private
		 */
		public function itemToIcon (item:Object) : Class;

		/**
		 *  @private
		 */
		protected function drawRowBackgrounds () : void;

		/**
		 *  Sets the associated icon for the item.  Calling this method overrides the
     *  <code>iconField</code> and <code>iconFunction</code> properties for
     *  this item if it is a leaf item. Branch items don't use the
     *  <code>iconField</code> and <code>iconFunction</code> properties.
     *  They use the <code>folderOpenIcon</code> and <code>folderClosedIcon</code> properties.
     *
     *  @param item Item to affect.
     *  @param iconID Linkage ID for the closed (or leaf) icon.
     *  @param iconID2 Linkage ID for the open icon.
     *
		 */
		public function setItemIcon (item:Object, iconID:Class, iconID2:Class) : void;

		/**
		 *   @private
     *  Returns <code>true</code> if the specified item is a branch item. The Tree 
     *  control delegates to the IDataDescriptor to determine if an item is a branch.
     *  @param item Item to inspect.
     *  @return True if a branch, false if not.
     *
		 */
		private function isBranch (item:Object) : Boolean;

		/**
		 * @private
    * wraps calls to the descriptor 
    * mx_internal for automation delegate access
		 */
		function getChildren (item:Object, view:Object) : ICollectionView;

		/**
		 *  Determines the number of parents from root to the specified item.
    *  Method starts with the Cursor.current item and will seek forward
    *  to a specific offset, returning the cursor to its original position.
    *
    *  @private
		 */
		function getItemDepth (item:Object, offset:int) : int;

		/**
		 *  @private
     *  Utility method to get the depth of the current item from the cursor.
		 */
		private function getCurrentCursorDepth () : int;

		/**
		 *  @private
     *  Gets the number of visible items from a starting item.
		 */
		private function getVisibleChildrenCount (item:Object) : int;

		/**
		 *  Returns <code>true</code> if the specified item branch is open (is showing its children).
     *  @param item Item to inspect.
     *  @return True if open, false if not.
     *
		 */
		public function isItemOpen (item:Object) : Boolean;

		/**
		 *  @private
		 */
		private function makeMask () : DisplayObject;

		/**
		 *  Opens or closes a branch item.
     *  When a branch item opens, it restores the open and closed states
     *  of its child branches if they were already opened.
     * 
     *  If you set <code>dataProvider</code> and then immediately call
     *  <code>expandItem()</code> you may not see the correct behavior. 
     *  You should either wait for the component to validate
     *  or call <code>validateNow()</code>.
     *
     *  @param item Item to affect.
     *
     *  @param open Specify <code>true</code> to open, <code>false</code> to close.
     *
     *  @param animate Specify <code>true</code> to animate the transition. (Note:
     *  If a branch has over 20 children, it does not animate the first time it opens,
     *  for performance reasons.)
     *
     *  @param dispatchEvent Controls whether the tree fires an <code>open</code> event
     *                       after the open animation is complete.
     *
     *  @param cause The event, if any, that initiated the item open action.
     *
		 */
		public function expandItem (item:Object, open:Boolean, animate:Boolean = false, dispatchEvent:Boolean = false, cause:Event = null) : void;

		/**
		 *  @private
		 */
		function onTweenUpdate (value:Object) : void;

		/**
		 *  @private
		 */
		function onTweenEnd (value:Object) : void;

		/**
		 *  @private
	 * 
	 *  Helper function that builds up the collectionChange ADD or 
	 *  REMOVE events that correlate to the nodes that were expanded 
	 *  or collapsed.
		 */
		private function buildUpCollectionEvents (open:Boolean) : Array;

		/**
		 *  @private
     *  Go through the open items and figure out which is deepest.
		 */
		private function getIndent () : Number;

		/**
		 *   Checks to see if item is visible in the list
     *  @private
		 */
		public function isItemVisible (item:Object) : Boolean;

		/**
		 *  @private
		 */
		public function getItemIndex (item:Object) : int;

		/**
		 *  @private
		 */
		private function getIndexItem (index:int) : Object;

		/**
		 *  Opens or closes all the tree items below the specified item.
     * 
     *  If you set <code>dataProvider</code> and then immediately call
     *  <code>expandChildrenOf()</code> you may not see the correct behavior. 
     *  You should either wait for the component to validate
     *  or call the <code>validateNow()</code> method.
     *  
     *  @param item The starting item.
     *
     *  @param open Toggles an open or close operation. 
     *  Specify <code>true</code> to open the items, and <code>false</code> to close them.
		 */
		public function expandChildrenOf (item:Object, open:Boolean) : void;

		/**
		 *  Returns the known parent of a child item. This method returns a value
     *  only if the item was or is currently visible. Top level items have a 
     *  parent with the value <code>null</code>. 
     * 
     *  @param The item for which to get the parent.
     * 
     *  @return The parent of the item.
		 */
		public function getParentItem (item:Object) : *;

		/**
		 *  @private
     *  Returns the stack of parents from a child item.
		 */
		private function getParentStack (item:Object) : Array;

		/**
		 *  @private
     *  Returns a stack of all open descendants of an item.
		 */
		private function getOpenChildrenStack (item:Object, stack:Array) : Array;

		/**
		 *  @private
     *  Finds the index distance between a parent and child
		 */
		private function getChildIndexInParent (parent:Object, child:Object) : int;

		/**
		 *  @private
     *  Collapses those items in the selected items array that have
     *  parent nodes already selected.
		 */
		private function collapseSelectedItems () : Array;

		/**
		 *  @private
		 */
		private function updateDropData (event:DragEvent) : void;

		/**
		 *  Initializes a TreeListData object that is used by the tree item renderer.
     * 
     *  @param item The item to be rendered.
     *  @param treeListData The TreeListDataItem to use in rendering the item.
		 */
		protected function initListData (item:Object, treeListData:TreeListData) : void;

		/**
		 *  @private
		 */
		protected function layoutEditor (x:int, y:int, w:int, h:int) : void;

		/**
		 *  @private
		 */
		protected function scrollHandler (event:Event) : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
     *  finish up left/right arrow key handling
		 */
		private function finishArrowKeySelection () : void;

		/**
		 *  @private
     *  Blocks mouse events on items that are tweening away and are invalid for input
		 */
		protected function mouseOverHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  Blocks mouse events on items that are tweening away and are invalid for input
		 */
		protected function mouseOutHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  Blocks mouse events on items that are tweening away and are invalid for input
		 */
		protected function mouseClickHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  Blocks mouse events on items that are tweening away and are invalid for input
		 */
		protected function mouseDoubleClickHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  Blocks mouse events on items that are tweening away and are invalid for input
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  Blocks mouse events on items that are tweening away and are invalid for input
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  Blocks mouse wheel handling while tween is running
		 */
		protected function mouseWheelHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		protected function dragEnterHandler (event:DragEvent) : void;

		/**
		 *  @private
		 */
		protected function dragOverHandler (event:DragEvent) : void;

		/**
		 *  @private
     *  The default failure handler when a seek fails due to a page fault.
		 */
		private function seekPendingDuringDragFailureHandler (data:Object, info:TreeSeekPending) : void;

		/**
		 *  @private
     *  The default result handler when a seek fails due to a page fault.
     *  This method re-attempts setting the drag feedback
		 */
		private function seekPendingDuringDragResultHandler (data:Object, info:TreeSeekPending) : void;

		/**
		 *  @private
		 */
		private function checkItemIndices (event:DragEvent) : void;

		/**
		 *  Handles <code>DragEvent.DRAG_DROP events</code>.  This method  hides
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
		 *  Handles <code>DragEvent.DRAG_COMPLETE</code> events.  This method
     *  removes the item from the data provider.
     *
     *  @param event The DragEvent object.
		 */
		protected function dragCompleteHandler (event:DragEvent) : void;

		/**
		 *  @private
     *  Delegates to the Descriptor to add a child to a parent
		 */
		function addChildItem (parent:Object, child:Object, index:Number) : Boolean;

		/**
		 *  @private
     *  Delegates to the Descriptor to remove a child from a parent
		 */
		function removeChildItem (parent:Object, child:Object, index:Number) : Boolean;

		/**
		 *  @private
		 */
		function dispatchTreeEvent (type:String, item:Object, renderer:IListItemRenderer, trigger:Event = null, opening:Boolean = true, animate:Boolean = true, dispatch:Boolean = true) : void;

		/**
		 *  @private
     *  Handler for CollectionEvents dispatched from the root dataProvider as the data changes.
		 */
		protected function collectionChangeHandler (event:Event) : void;

		/**
		 *  @private
		 */
		protected function adjustAfterRemove (items:Array, location:int, emitEvent:Boolean) : Boolean;

		/**
		 *
		 */
		function expandItemHandler (event:TreeEvent) : void;

		/**
		 *
		 */
		function selectionDataPendingResultHandler (data:Object, info:ListBaseSelectionDataPending) : void;
	}
	private class TreeSeekPending
	{
		public var event : DragEvent;
		public var retryFunction : Function;

		public function TreeSeekPending (event:DragEvent, retryFunction:Function);
	}
}
