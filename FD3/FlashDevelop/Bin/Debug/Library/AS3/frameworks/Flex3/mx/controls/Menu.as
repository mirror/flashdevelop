package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.clearInterval;
	import flash.utils.setTimeout;
	import flash.xml.XMLNode;
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.XMLListCollection;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.menuClasses.IMenuBarItemRenderer;
	import mx.controls.menuClasses.IMenuDataDescriptor;
	import mx.controls.menuClasses.IMenuItemRenderer;
	import mx.controls.menuClasses.MenuItemRenderer;
	import mx.controls.menuClasses.MenuListData;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.core.Application;
	import mx.core.ClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.EventPriority;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.Tween;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.InterManagerRequest;
	import mx.events.ListEvent;
	import mx.events.MenuEvent;
	import mx.events.SandboxMouseEvent;
	import mx.managers.IFocusManagerContainer;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;

	/**
	 *  Dispatched when selection changes as a result
 *  of user interaction. 
 *
 *  @eventType mx.events.MenuEvent.CHANGE
	 */
	[Event(name="change", type="mx.events.MenuEvent")] 

	/**
	 *  Dispatched when a menu item is selected. 
 *
 *  @eventType mx.events.MenuEvent.ITEM_CLICK
	 */
	[Event(name="itemClick", type="mx.events.MenuEvent")] 

	/**
	 *  Dispatched when a menu or submenu is dismissed.
 *
 *  @eventType mx.events.MenuEvent.MENU_HIDE
	 */
	[Event(name="menuHide", type="mx.events.MenuEvent")] 

	/**
	 *  Dispatched when a menu or submenu opens. 
 *
 *  @eventType mx.events.MenuEvent.MENU_SHOW
	 */
	[Event(name="menuShow", type="mx.events.MenuEvent")] 

	/**
	 *  Dispatched when a user rolls the mouse out of a menu item.
 *
 *  @eventType mx.events.MenuEvent.ITEM_ROLL_OUT
	 */
	[Event(name="itemRollOut", type="mx.events.MenuEvent")] 

	/**
	 *  Dispatched when a user rolls the mouse over a menu item.
 *
 *  @eventType mx.events.MenuEvent.ITEM_ROLL_OVER
	 */
	[Event(name="itemRollOver", type="mx.events.MenuEvent")] 

	/**
	 *  The colors used for menu or submenu menu items in an alternating pattern. 
 *  The value can be an Array of two or more colors.
 *  This style is only used if <code>backgroundColor</code> is not specified. 
 * 
 *  @default "undefined"
	 */
	[Style(name="alternatingItemColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 

	/**
	 *  Number of pixels between children (icons and label) in the horizontal direction.
 * 
 *  @default 6
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  The gap to the left of the label in a menu item.  If the icons (custom 
 *  icon and type icon) do not fit in this gap, the gap is expanded to 
 *  fit them properly.
 *  The default value is 18.
	 */
	[Style(name="leftIconGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  The gap to the right of the label in a menu item.  If the branch icon 
 *  does not fit in this gap, the gap is expanded to fit it properly.
 *  The default value is 15.
	 */
	[Style(name="rightIconGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  The duration of the menu or submenu opening transition, in milliseconds.
 *  The value 0 specifies no transition.
 *  
 *  @default 250
	 */
	[Style(name="openDuration", type="Number", format="Time", inherit="no")] 

	/**
	 *  The color of the menu item background when a user rolls the mouse over it. 
 *  
 *  @default 0xB2E1FF
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The color of the menu item background when a menu item is selected.
 *  
 *  @default 0x7FCEFF
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The reference to an <code>easingFunction</code> equation which is used to 
 *  control programmatic tweening.
 * 
 *  @default "undefined"
	 */
	[Style(name="selectionEasingFunction", type="Function", inherit="no")] 

	/**
	 *  The offset of the first line of text from the left side of the menu or 
 *  submenu menu item. 
 * 
 *  @default 0
	 */
	[Style(name="textIndent", type="Number", format="Length", inherit="yes")] 

	/**
	 *  The color of the menu item text when a user rolls the mouse over the 
 *  menu item.
 * 
 *  @default 0x2B333C
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The color of the menu item text when the menu item is selected.
 * 
 *  @default 0x2B333C
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The icon for all enabled menu items that have submenus. 
 * 
 *  The default value is the "MenuBranchEnabled" symbol in the Assets.swf file.
	 */
	[Style(name="branchIcon", type="Class", inherit="no")] 

	/**
	 *  The icon for all disabled menu items that have submenus. 
 * 
 *  The default value is the "MenuBranchDisabled" symbol in the Assets.swf file.
	 */
	[Style(name="branchDisabledIcon", type="Class", inherit="no")] 

	/**
	 *  The icon for all enabled menu items whose type identifier is a check box. 
 *  
 *  The default value is the "MenuCheckEnabled" symbol in the Assets.swf file.
	 */
	[Style(name="checkIcon", type="Class", inherit="no")] 

	/**
	 *  The icon for all dsiabled menu items whose type identifier is a check box. 
 *  
 *  The default value is the "MenuCheckDisabled" symbol in the Assets.swf file.
	 */
	[Style(name="checkDisabledIcon", type="Class", inherit="no")] 

	/**
	 *  The icon for all enabled menu items whose type identifier is a radio 
 *  button. 
 *  
 *  The default value is the "MenuRadioEnabled" symbol in the Assets.swf file.
	 */
	[Style(name="radioIcon", type="Class", inherit="no")] 

	/**
	 *  The icon for all disabled menu items whose type identifier is a radio 
 *  button. 
 * 
 *  The default value is the "MenuRadioDisabled" symbol in the Assets.swf file.
	 */
	[Style(name="radioDisabledIcon", type="Class", inherit="no")] 

	/**
	 *  The skin for all menu items which are identified as separators. 
 *  
 *  The default value is the "MenuSeparator" symbol in the Assets.swf file.
	 */
	[Style(name="separatorSkin", type="Class", inherit="no")] 

	[Exclude(name="allowMultipleSelection", kind="property")] 

	[Exclude(name="horizontalScrollBarStyleName", kind="property")] 

	[Exclude(name="horizontalScrollPolicy", kind="property")] 

	[Exclude(name="horizontalScrollPosition", kind="property")] 

	[Exclude(name="liveScrolling", kind="property")] 

	[Exclude(name="maxHorizontalScrollPosition", kind="property")] 

	[Exclude(name="maxVerticalScrollPosition", kind="property")] 

	[Exclude(name="scrollTipFunction", kind="property")] 

	[Exclude(name="showScrollTips", kind="property")] 

	[Exclude(name="verticalScrollBarStyleName", kind="property")] 

	[Exclude(name="verticalScrollPolicy", kind="property")] 

	[Exclude(name="verticalScrollPosition", kind="property")] 

include "../core/Version.as"
	/**
	 *  The Menu control creates a pop-up menu of individually selectable choices,
 *  similar to the File or Edit menu found in most software applications. The 
 *  popped up menu can have as many levels of submenus as needed. 
 *  After a Menu control has opened, it remains visible until it is closed by 
 *  any of the following actions:
 * 
 *  <ul>
 *   <li>A call to the <code>Menu.hide()</code> method.</li>
 *   <li>When a user selects an enabled menu item.</li>
 *   <li>When a user clicks outside of the Menu control.</li>
 *   <li>When a user selects another component in the application.</li>
 *  </ul>
 *
 *  <p>The Menu class has no corresponding MXML tag. You must create it using ActionScript.</p>
 *
 *  <p>The Menu control has the following sizing characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>The width is determined from the Menu text. The 
 *               default height is the number of menu rows multiplied 
 *               by 19 pixels per row (the default row height).</td>
 *        </tr>
 *     </table>
 *
*  <p>The data provider for Menu items can specify several attributes that determine how 
 *  the item is displayed and behaves, as the following XML data provider shows:</p>
 *  <pre>
 *   &lt;mx:XML format=&quot;e4x&quot; id=&quot;myMenuData&quot;&gt;
 *     &lt;root&gt;
 *        &lt;menuitem label=&quot;MenuItem A&quot; icon=&quot;myTopIcon&quot;&gt;
 *            &lt;menuitem label=&quot;SubMenuItem A-1&quot; enabled=&quot;False&quot;/&gt;
 *            &lt;menuitem label=&quot;SubMenuItem A-2&quot;/&gt;
 *        &lt;/menuitem&gt;
 *        &lt;menuitem label=&quot;MenuItem B&quot; type=&quot;check&quot; toggled=&quot;true&quot;/&gt;
 *        &lt;menuitem label=&quot;MenuItem C&quot; type=&quot;check&quot; toggled=&quot;false&quot; icon=&quot;myTopIcon&quot;/&gt;
 *        &lt;menuitem type=&quot;separator&quot;/&gt; 
 *        &lt;menuitem label=&quot;MenuItem D&quot; icon=&quot;myTopIcon&quot;&gt;
 *            &lt;menuitem label=&quot;SubMenuItem D-1&quot; type=&quot;radio&quot; groupName=&quot;one&quot;/&gt;
 *            &lt;menuitem label=&quot;SubMenuItem D-2&quot; type=&quot;radio&quot; groupName=&quot;one&quot; toggled=&quot;true&quot;/&gt;
 *            &lt;menuitem label=&quot;SubMenuItem D-3&quot; type=&quot;radio&quot; groupName=&quot;one&quot;/&gt;
 *        &lt;/menuitem&gt;
 *    &lt;/root&gt;
 * &lt;/mx:XML&gt;</pre>
 * 
 *  <p>The following table lists the attributes you can specify, 
 *  their data types, their purposes, and how the data provider must represent 
 *  them if the menu uses the DefaultDataDescriptor class to parse the data provider:</p>
 * 
 *  <table class="innertable">
 *  <tr>
 *    <th>Attribute</th>
 *    <th>Type</th>
 *    <th>Description</th>
 *  </tr>
 *  <tr>
 *    <td><code>enabled</code></td>
 *    <td>Boolean</td>
 *    <td>Specifies whether the user can select the menu item (<code>true</code>), 
 *      or not (<code>false</code>). If not specified, Flex treats the item as if 
 *      the value were <code>true</code>.
 *      If you use the default data descriptor, data providers must use an <code>enabled</code> 
 *      XML attribute or object field to specify this characteristic.</td>
 *  </tr>
 *  <tr>
 *    <td><code>groupName</code></td>
 *    <td>String</td>
 *    <td> (Required, and meaningful, for <code>radio</code> type only) The identifier that 
 *      associates radio button items in a radio group. If you use the default data descriptor, 
 *      data providers must use a <code>groupName</code> XML attribute or object field to 
 *      specify this characteristic.</td>
 *  </tr>
 *  <tr>
 *    <td><code>icon</code></td>
 *    <td>Class</td>
 *    <td>Specifies the class identifier of an image asset. This item is not used for 
 *      the <code>check</code>, <code>radio</code>, or <code>separator</code> types. 
 *      You can use the <code>checkIcon</code> and <code>r
	 */
	public class Menu extends List implements IFocusManagerContainer
	{
		/**
		 *  @private
     *  Placeholder for mixin by MenuAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
     *  internal measuring stick
		 */
		private var hiddenItem : IListItemRenderer;
		/**
		 *  @private
     *  The maximum width for icons.  Used so they 
     *  can align properly across all MenuItemRenderers
		 */
		private var maxMeasuredIconWidth : Number;
		/**
		 *  @private
     *  The maximum width for type icons (checkbox, radiobox).
     *  Used so they can align properly across all MenuItemRenderers
		 */
		private var maxMeasuredTypeIconWidth : Number;
		/**
		 *  @private
     *  The maximum width for branch icons.  Used so they 
     *  can align properly across all MenuItemRenderers
		 */
		private var maxMeasuredBranchIconWidth : Number;
		/**
		 *  @private
     *  Whether the left icons should layout into two separate columns
     *  (one for icons and one for type icons, like check and radio)
		 */
		private var useTwoColumns : Boolean;
		/**
		 *  @private
     *  The menu bar that eventually spawned this menu
		 */
		var sourceMenuBar : MenuBar;
		/**
		 *  @private
     *  the IMenuBarItemRenderer instance in the menubar 
     *  that spawned this menu
		 */
		var sourceMenuBarItem : IMenuBarItemRenderer;
		/**
		 *  @private
     *  Where to add this menu on the display list.
		 */
		var parentDisplayObject : DisplayObject;
		/**
		 *  @private
     *  Whether the menu was opened from the left or the right.
     *  This really only applies to submenus and helps with cascading submenus.
		 */
		private var isDirectionLeft : Boolean;
		private var anchorRow : IListItemRenderer;
		private var subMenu : Menu;
		var popupTween : Tween;
		var supposedToLoseFocus : Boolean;
		/**
		 *  @private
     *  When this timer fires, we'll open a submenu
		 */
		var openSubMenuTimer : int;
		/**
		 *  @private
     *  When this timer fires, we'll hide this menu
		 */
		var closeTimer : int;
		/**
		 *  @private
     *  Storage variable for the original dataProvider
		 */
		var _rootModel : ICollectionView;
		/**
		 *  @private
     *  Storage variable for dataProvider passed to parent
		 */
		var _listDataProvider : ICollectionView;
		/**
		 *  @private
		 */
		var _parentMenu : Menu;
		/**
		 *  @private
		 */
		var _dataDescriptor : IMenuDataDescriptor;
		/**
		 *  @private
		 */
		var dataProviderChanged : Boolean;
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
		 *  The parent menu in a hierarchical chain of menus, where the current 
     *  menu is a submenu of the parent.
     * 
     *  @return The parent Menu control.
		 */
		public function get parentMenu () : Menu;
		/**
		 *  @private
		 */
		public function set parentMenu (value:Menu) : void;

		/**
		 *  The object that accesses and manipulates data in the data provider. 
     *  The Menu control delegates to the data descriptor for information 
     *  about its data. This data is then used to parse and move about the 
     *  data source. The data descriptor defined for the root menu is used 
     *  for all submenus. 
     * 
     *  The default value is an internal instance of the
     *  DefaultDataDescriptor class.
		 */
		public function get dataDescriptor () : IMenuDataDescriptor;
		/**
		 *  @private
		 */
		public function set dataDescriptor (value:IMenuDataDescriptor) : void;

		/**
		 *  @private
     *  Convert user data to collection.
     *
     *  @see mx.controls.listClasses.ListBase
     *  @see mx.controls.List
     *  @see mx.controls.Tree
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  @private
		 */
		public function get dataProvider () : Object;

		/**
		 *  A Boolean flag that specifies whether to display the data provider's 
     *  root node.
     *
     *  If the dataProvider object has a root node, and showRoot is set to 
     *  <code>false</code>, the Menu control does not display the root node; 
     *  only the descendants of the root node will be displayed.  
     * 
     *  This flag has no effect on data providers without root nodes, 
     *  like Lists and Arrays. 
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
		 *  A flag that indicates that the current data provider has a root node; for example, 
     *  a single top node in a hierarchical structure. XML and Object 
     *  are examples of types that have a root node, while Lists and Arrays do 
     *  not.
     * 
     *  @default false
     *  @see #showRoot
		 */
		public function get hasRoot () : Boolean;

		/**
		 *  @private
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;

		/**
		 *  @private
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;

		/**
		 *  For autotesting, get the current set of submenus
		 */
		function get subMenus () : Array;

		/**
		 *  Creates and returns an instance of the Menu class. The Menu control's 
     *  content is determined by the method's <code>mdp</code> argument. The 
     *  Menu control is placed in the parent container specified by the 
     *  method's <code>parent</code> argument.
     * 
     *  This method does not show the Menu control. Instead, 
     *  this method just creates the Menu control and allows for modifications
     *  to be made to the Menu instance before the Menu is shown. To show the 
     *  Menu, call the <code>Menu.show()</code> method.
     *
     *  @param parent A container that the PopUpManager uses to place the Menu 
     *  control in. The Menu control may not actually be parented by this object.
     * 
     *  @param mdp The data provider for the Menu control. 
     *  @see mx.controls.Menu@dataProvider 
     * 
     *  @param showRoot A Boolean flag that specifies whether to display the 
     *  root node of the data provider.
     *  @see mx.controls.Menu@showRoot 
     * 
     *  @return An instance of the Menu class. 
     *
     *  @see mx.controls.Menu#popUpMenu()
		 */
		public static function createMenu (parent:DisplayObjectContainer, mdp:Object, showRoot:Boolean = true) : Menu;

		/**
		 *  Sets the dataProvider of an existing Menu control and places the Menu 
     *  control in the specified parent container.
     *  
     *  This method does not show the Menu control; you must use the 
     *  <code>Menu.show()</code> method to display the Menu control. 
     * 
     *  The <code>Menu.createMenu()</code> method uses this method.
     *
     *  @param menu Menu control to popup. 
     * 
     *  @param parent A container that the PopUpManager uses to place the Menu 
     *  control in. The Menu control may not actually be parented by this object.
     *  If you omit this property, the method sets the Menu control's parent to 
     *  the application. 
     * 
     *  @param mdp dataProvider object set on the popped up Menu. If you omit this 
     *  property, the method sets the Menu data provider to a new, empty XML object.
		 */
		public static function popUpMenu (menu:Menu, parent:DisplayObjectContainer, mdp:Object) : void;

		/**
		 *  Constructor.
     *
     *  <p>Applications do not normally call the Menu constructor directly.
     *  Instead, Applications will call the <code>Menu.createMenu()</code>
     *  method.</p>
		 */
		public function Menu ();

		/**
		 *  @private
		 */
		private function parentHideHandler (event:FlexEvent) : void;

		/**
		 *  @private
		 */
		private function parentRowHeightHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function parentIconFieldHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function parentIconFunctionHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function parentLabelFieldHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function parentLabelFunctionHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function parentItemRendererHandler (event:Event) : void;

		/**
		 *  @private
     *  Called by the initialize() method of UIComponent
     *  to hook in the accessibility code.
		 */
		protected function initializeAccessibility () : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  Calculates the preferred width and height of the Menu based on the
     *  widths and heights of its menu items. This method does not take into 
     *  account the position and size of submenus.
		 */
		protected function measure () : void;

		/**
		 *  @private
		 */
		public function measureWidthOfItems (index:int = -1, count:int = 0) : Number;

		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
     *  Relying on UIComponent description.
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		protected function drawItem (item:IListItemRenderer, selected:Boolean = false, highlighted:Boolean = false, caret:Boolean = false, transition:Boolean = false) : void;

		/**
		 *  @private
		 */
		protected function configureScrollBars () : void;

		function clearHighlight (item:IListItemRenderer) : void;

		/**
		 *  @private
     *  Determines if the itemrenderer is a separator. If so, return null to prevent separators
     *  from highlighting and emitting menu-level events.
		 */
		protected function mouseEventToItemRenderer (event:MouseEvent) : IListItemRenderer;

		/**
		 *  @private
		 */
		public function setFocus () : void;

		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		public function dispatchEvent (event:Event) : Boolean;

		/**
		 *  Toggles the menu item. The menu item type identifier must be a
     *  check box or radio button, otherwise this method has no effect.
     *
     *  @param item The menu item to toggle.
     *  @param toggle Boolean value that indicates whether the item is 
     *  toggled.
		 */
		protected function setMenuItemToggled (item:Object, toggle:Boolean) : void;

		/**
		 *  Creates a new MenuListData instance and populates the fields based on
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
		 *  Shows the Menu control. If the Menu control is not visible, this method 
     *  places the Menu in the upper-left corner of the parent application at 
     *  the given coordinates, resizes the Menu control as needed, and makes 
     *  the Menu control visible.
     * 
     *  The x and y arguments of the <code>show()</code> method specify the 
     *  coordinates of the upper-left corner of the Menu control relative to the 
     *  sandbox root, which is not necessarily the direct parent of the 
     *  Menu control. 
     * 
     *  For example, if the Menu control is in an HBox container which is 
     *  nested within a Panel container, the x and y coordinates are 
     *  relative to the Application container, not to the HBox container.
     *
     *  @param x Horizontal location of the Menu control's upper-left 
     *  corner (optional).
     * 
     *  @param y Vertical location of the Menu control's upper-left 
     *  corner (optional).
		 */
		public function show (xShow:Object = null, yShow:Object = null) : void;

		/**
		 *  @private
		 */
		function onTweenUpdate (value:Object) : void;

		/**
		 *  @private
		 */
		function onTweenEnd (value:Object) : void;

		/**
		 *  Hides the Menu control and any of its submenus if the Menu control is
     *  visible.
		 */
		public function hide () : void;

		/**
		 *  @private
		 */
		protected function collectionChangeHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function mouseDownOutsideHandler (event:Event) : void;

		/**
		 *  @private
     *  Removes the root menu from the display list.  This is called only for
     *  menus created using "createMenu".
     * 
     *  MJM private static?
		 */
		private static function menuHideHandler (event:MenuEvent) : void;

		/**
		 *  @private
     *  Handle mouse release on an item.
     *
     *  For separators or items with sub-menu, do nothing.
     *  For check items, toggle state, then fire change event.
     *  For radio items, toggle state if untoggled, then fire change event.
     *  For normal items, fire change event.
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  Extend the behavior from ScrollSelectList to handle row presses over
     *  separators, branch items, and disabled row items.
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  Notify listeners when the mouse leaves
		 */
		protected function mouseOutHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  Extend the behavior from ScrollSelectList to pop up submenus
		 */
		protected function mouseOverHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  ListBase uses the mouseClickHandler dispatch the ListEvent.ITEM_CLICK event.
     *  In Menu we chose to do that in the mouseUpHandler so we will do nothing
     *  in the mouseClickHandler.
		 */
		protected function mouseClickHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		private function moveSelBy (oldIndex:Number, incr:Number) : void;

		/**
		 *  @private
		 */
		function openSubMenu (row:IListItemRenderer) : void;

		/**
		 *  @private
		 */
		private function closeSubMenu (menu:Menu) : void;

		function deleteDependentSubMenus () : void;

		function hideAllMenus () : void;

		private function isMouseOverMenu (event:MouseEvent) : Boolean;

		private function isMouseOverMenuBarItem (event:MouseEvent) : Boolean;

		/**
		 * From any menu, walks up the parent menu chain and finds the root menu.
		 */
		function getRootMenu () : Menu;

		/**
		 * Given a row, find the row's index in the Menu.
		 */
		private function getRowIndex (row:IListItemRenderer) : int;
	}
}
