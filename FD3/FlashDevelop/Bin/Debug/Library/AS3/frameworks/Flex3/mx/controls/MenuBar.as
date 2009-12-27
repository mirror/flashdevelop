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
	import flash.xml.XMLNode;
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	import mx.collections.XMLListCollection;
	import mx.collections.errors.ItemPendingError;
	import mx.containers.ApplicationControlBar;
	import mx.controls.menuClasses.IMenuBarItemRenderer;
	import mx.controls.menuClasses.IMenuDataDescriptor;
	import mx.controls.menuClasses.MenuBarItem;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.core.ClassFactory;
	import mx.core.EventPriority;
	import mx.core.FlexVersion;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.events.InterManagerRequest;
	import mx.events.MenuEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleManager;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when selection changes as a result of user 
 *  interaction.  
 *  This event is also dispatched when the user changes 
 *  the current menu selection in a pop-up submenu. 
 *  When the event occurs on the menu bar, 
 *  the <code>menu</code> property of the MenuEvent object is <code>null</code>.
 *  When it occurs in a pop-up submenu, the <code>menu</code> property 
 *  contains a reference to the Menu object that represents the 
 *  the pop-up submenu.
 *
 *  @eventType mx.events.MenuEvent.CHANGE
	 */
	[Event(name="change", type="mx.events.MenuEvent")] 

	/**
	 *  Dispatched when the user selects an item in a pop-up submenu.
 *
 *  @eventType mx.events.MenuEvent.ITEM_CLICK
	 */
	[Event(name="itemClick", type="mx.events.MenuEvent")] 

	/**
	 *  Dispatched when a pop-up submenu closes.
 *
 *  @eventType mx.events.MenuEvent.MENU_HIDE
	 */
	[Event(name="menuHide", type="mx.events.MenuEvent")] 

	/**
	 *  Dispatched when a pop-up submenu opens, or the 
 *  user selects a menu bar item with no drop-down menu.
 *
 *  @eventType mx.events.MenuEvent.MENU_SHOW
	 */
	[Event(name="menuShow", type="mx.events.MenuEvent")] 

	/**
	 *  Dispatched when the mouse pointer rolls out of a menu item.
 *
 *  @eventType mx.events.MenuEvent.ITEM_ROLL_OUT
	 */
	[Event(name="itemRollOut", type="mx.events.MenuEvent")] 

	/**
	 *  Dispatched when the mouse pointer rolls over a menu item.
 *
 *  @eventType mx.events.MenuEvent.ITEM_ROLL_OVER
	 */
	[Event(name="itemRollOver", type="mx.events.MenuEvent")] 

include "../styles/metadata/FocusStyles.as"
include "../styles/metadata/LeadingStyle.as"
include "../styles/metadata/SkinStyles.as"
include "../styles/metadata/TextStyles.as"
	/**
	 *  Alpha level of the color defined by the <code>backgroundColor</code>
 *  property.
 *  Valid values range from 0.0 to 1.0.
 *  @default 1.0
	 */
	[Style(name="backgroundAlpha", type="Number", inherit="no", deprecatedReplacement="menuStyleName", deprecatedSince="3.0")] 

	/**
	 *  Background color of the component.
 *  The default value is <code>undefined</code>, which means it is not 
 *  set and the component has a transparent background.
 *
 *  <p>The default skins of most Flex controls are partially transparent. 
 *  As a result, the background color of a container partially "bleeds through" 
 *  to controls that are in that container. 
 *  You can avoid this by setting the alpha values of the control's 
 *  <code>fillAlphas</code> property to 1, as the following example shows:
 *  </p>
 *  <pre>
 *  &lt;mx:<i>Container</i> backgroundColor="0x66CC66"/&gt;
 *      &lt;mx:<i>ControlName</i> ... fillAlphas="[1,1]"/&gt;
 *  &lt;/mx:<i>Container</i>&gt;
 *  </pre>
	 */
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no", deprecatedReplacement="menuStyleName", deprecatedSince="3.0")] 

	/**
	 *  The background skin of the MenuBar control. 
 *   
 *  @default mx.skins.halo.MenuBarBackgroundSkin
	 */
	[Style(name="backgroundSkin", type="Class", inherit="no")] 

	/**
	 *  The default skin for a MenuBar item
 * 
 *  @default mx.skins.halo.ActivatorSkin
	 */
	[Style(name="itemSkin", type="Class", inherit="no", states="up, over, down")] 

	/**
	 *  The skin when a MenuBar item is not selected.
 * 
 *  @default mx.skins.halo.ActivatorSkin
	 */
	[Style(name="itemUpSkin", type="Class", inherit="no")] 

	/**
	 *  The skin when focus is over a MenuBar item either. 
 * 
 *  @default mx.skins.halo.ActivatorSkin
	 */
	[Style(name="itemOverSkin", type="Class", inherit="no")] 

	/**
	 *  The skin when a MenuBar item is selected. 
 * 
 *  @default mx.skins.halo.ActivatorSkin
	 */
	[Style(name="itemDownSkin", type="Class", inherit="no")] 

	/**
	 *  Name of the CSSStyleDeclaration that specifies the styles for
 *  the Menu controls displayed by this MenuBar control. 
 *  By default, the Menu controls use the MenuBar control's
 *  inheritable styles. 
 *  
 *  <p>You can use this class selector to set the values of all the style properties 
 *  of the Menu class, including <code>backgroundAlpha</code> and <code>backgroundColor</code>.</p>
 * 
 *  @default undefined
	 */
	[Style(name="menuStyleName", type="String", inherit="no")] 

	/**
	 *  @copy mx.controls.Menu#style:rollOverColor
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  @copy mx.controls.Menu#style:selectionColor
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 

	[DefaultProperty("dataProvider")] 

include "../core/Version.as"
	/**
	 *  A MenuBar control defines a horizontal, top-level menu bar that contains
 *  one or more menus. Clicking on a top-level menu item opens a pop-up submenu
 *  that is an instance of the Menu control.
 *
 *  <p>The top-level menu bar of the MenuBar control is generally always visible. 
 *  It is not intended for use as a pop-up menu. The individual submenus
 *  pop up as the user selects them with the mouse or keyboard. Open submenus 
 *  disappear when a menu item is selected, or if the menu is dismissed by the
 *  user clicking outside the menu.</p>
 *
 *  <p>For information and an example on the attributes that you can use 
 *  in the data provider for the MenuBar control, see the Menu control.</p>
 *
 *  <p>The MenuBar control has the following sizing characteristics:
 *  </p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>The width is determined from the menu text, with a 
 *               minimum value of 27 pixels for the width. The default 
 *               value for the height is 22 pixels.</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *  <p>
 *  The <code>&lt;mx:MenuBar&gt</code> tag inherits all of the tag attributes of its superclass, and
 *  adds the following tag attributes:
 *  </p>
 *  
 *  <pre>
 *  &lt;mx:MenuBar
 *    <b>Properties</b>
 *    dataDescriptor="<i>mx.controls.treeClasses.DefaultDataDescriptor</i>"
 *    dataProvider="<i>undefined</i>"
 *    iconField="icon"
 *    labelField="label"
 *    labelFunction="<i>undefined</i>"
 *    menuBarItemRenderer="<i>mx.controls.menuClasses.MenuBarItem</i>"
 *    menuBarItems="[]"
 *    menus="[]"
 *    selectedIndex="-1"
 *    showRoot="true"
 *  
 *    <b>Styles</b>
 *    backgroundSkin="mx.skins.halo.MenuBarBackgroundSkin"
 *    borderColor="0xAAB3B3"
 *    color="0x0B333C"
 *    cornerRadius="0"
 *    disabledColor="0xAAB3B3"
 *    fillAlphas="[0.6,0.4]"
 *    fillColors="[0xFFFFFF, 0xCCCCCC]"
 *    focusAlpha="0.5"
 *    focusRoundedCorners="tl tr bl br"
 *    fontAntiAliasType="advanced|normal"
 *    fontFamily="Verdana"
 *    fontGridFitType="pixel|none|subpixel"
 *    fontSharpness="0"
 *    fontSize="10"
 *    fontStyle="normal|italic"
 *    fontThickness="0"
 *    fontWeight="normal|bold"
 *    highlightAlphas="[0.3,0.0]"
 *    itemDownSkin="mx.skins.halo.ActivatorSkin"
 *    itemOverSkin="mx.skins.halo.ActivatorSkin"
 *    itemUpSkin="mx.skins.halo.ActivatorSkin"
 *    leading="2"
 *    menuStyleName="<i>No default</i>"
 *    rollOverColor="0xB2E1FF"
 *    selectionColor="0x7FCEFF"
 *    textAlign="left"
 *    textDecoration="none"
 *    textIndent="0"
 *  
 *    <b>Events</b>
 *    itemClick="<i>No default"</i>
 *    itemRollOut="<i>No default"</i>
 *    itemRollOver="<i>No default"</i>
 *    menuHide="<i>No default"</i>
 *    menuShow="<i>No default"</i>
 *  /&gt;
 *  </pre>
 *  </p>
 *
 *  @see mx.controls.Menu
 *  @see mx.controls.PopUpMenuButton
 *  @see mx.controls.menuClasses.IMenuBarItemRenderer
 *  @see mx.controls.menuClasses.MenuBarItem
 *  @see mx.controls.menuClasses.IMenuDataDescriptor
 *  @see mx.controls.treeClasses.DefaultDataDescriptor
 *
 *  @includeExample examples/MenuBarExample.mxml
 *
	 */
	public class MenuBar extends UIComponent implements IFocusManagerComponent
	{
		/**
		 *  @private
		 */
		private static const MARGIN_WIDTH : int = 10;
		/**
		 *  @private
     *  Placeholder for mixin by MenuBarAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
     *  Storage variable for the original dataProvider
		 */
		var _rootModel : ICollectionView;
		/**
		 *  @private
		 */
		private var isDown : Boolean;
		/**
		 *  @private
		 */
		private var inKeyDown : Boolean;
		/**
		 *  @private
		 */
		private var background : IFlexDisplayObject;
		/**
		 *  @private
     *  This menu bar could be inside an ApplicationControlBar (ACB).
		 */
		private var isInsideACB : Boolean;
		/**
		 *  @private
		 */
		private var supposedToLoseFocus : Boolean;
		/**
		 *  @private
		 */
		private var dataProviderChanged : Boolean;
		/**
		 *  @private
		 */
		private var iconFieldChanged : Boolean;
		/**
		 *  @private
		 */
		private var menuBarItemRendererChanged : Boolean;
		/**
		 *  @private
		 */
		var _dataDescriptor : IMenuDataDescriptor;
		/**
		 *  @private
     *  Flag to indicate if the model has a root
		 */
		var _hasRoot : Boolean;
		/**
		 *  @private
     *  Storage for iconField property.
		 */
		private var _iconField : String;
		/**
		 *  @private
		 */
		private var _labelField : String;
		/**
		 *  The function that determines the text to display for each menu item.
     *  The label function must find the appropriate field or fields in the 
     *  data provider and return a displayable string.
     * 
     *  If you omit this property, Flex uses the contents of the field or
     *  attribute specified by the <code>labelField</code> property.
     *  If you specify this property, Flex ignores any <code>labelField</code>
     *  property value.
     *
     *  The <code>labelFunction</code> property is good for handling formatting
     *  and localization.
     *
     *  <p>The label function must take a single argument which is the item
     *  in the data provider and return a String.</p>
     *  <pre>
     *  <code>myLabelFunction(item:Object):String</code> </pre>
     *
     *  @default "undefined"
		 */
		public var labelFunction : Function;
		/**
		 *  @private
     *  Storage for the menuBarItemRenderer property.
		 */
		private var _menuBarItemRenderer : IFactory;
		/**
		 *  An Array that contains the MenuBarItem objects that render 
     *  each item in the top-level menu bar of a MenuBar control. By default, 
     *  this property contains instances of the MenuBarItem class. 
     * 
     *  Items should not be added directly to the <code>menuBarItems</code> array. To 
     *  add new menubar items, add them directly to the MenuBar control's 
     *  data provider. 
     * 
     *  @default [ ]
     * 
     *  @see mx.controls.menuClasses.MenuBarItem
		 */
		public var menuBarItems : Array;
		private static var _menuBarItemStyleFilters : Object;
		/**
		 *  An Array containing the Menu objects corresponding to the 
     *  pop-up submenus of this MenuBar control.
     *  Each MenuBar item can have a corresponding Menu object in the Array,
     *  even if the item does not have a pop-up submenu.
     *  Flex does not initially populate the <code>menus</code> array;
     *  instead, it creates the menus dynamically, as needed. 
     * 
     *  Items should not be added directly to the <code>menus</code> Array. To 
     *  add new drop-down menus, add directly to the MenuBar 
     *  control's data provider.
     * 
     *  @default [ ]
		 */
		public var menus : Array;
		/**
		 *  @private
     *  The index of the currently open menu item, or -1 if none is open.
		 */
		private var openMenuIndex : int;
		/**
		 *  @private
     *  Storage variable for showRoot flag.
		 */
		var _showRoot : Boolean;
		/**
		 *  @private
		 */
		var showRootChanged : Boolean;

		/**
		 *  @private
     *  The baselinePosition of a MenuBar is calculated
     *  for its first MenuBarItem.
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
		 *  The object that accesses and manipulates data in the data provider. 
     *  The MenuBar control delegates to the data descriptor for information 
     *  about its data. This data is then used to parse and move about the 
     *  data source. The data descriptor defined for the MenuBar is used for
     *  all child menus and submenus. 
     * 
     *  <p>When you specify this property as an attribute in MXML, you must
     *  use a reference to the data descriptor, not the string name of the
     *  descriptor. Use the following format for setting the property:</p>
     *
     * <pre>&lt;mx:MenuBar id="menubar" dataDescriptor="{new MyCustomDataDescriptor()}"/&gt;</pre>
     *
     *  <p>Alternatively, you can specify the property in MXML as a nested
     *  subtag, as the following example shows:</p>
     *
     *  <pre>&lt;mx:MenuBar&gt;
     *  &lt;mx:dataDescriptor&gt;
     *     &lt;myCustomDataDescriptor&gt;
     *  &lt;/mx:dataDescriptor&gt;
     *  ...</pre>
     *
     *  <p>The default value is an internal instance of the
     *  DefaultDataDescriptor class.</p>
		 */
		public function get dataDescriptor () : IMenuDataDescriptor;
		/**
		 *  @private
		 */
		public function set dataDescriptor (value:IMenuDataDescriptor) : void;

		/**
		 *  The hierarchy of objects that are displayed as MenuBar items and menus. 
     *  The top-level children all become MenuBar items, and their children 
     *  become the items in the menus and submenus. 
     * 
     *  The MenuBar control handles the source data object as follows:
     *  <p>
     *  <ul>
     *  <li>A String containing valid XML text is converted to an XML object.</li>
     *  <li>An XMLNode is converted to an XML object.</li>
     *  <li>An XMLList is converted to an XMLListCollection.</li>
     *  <li>Any object that implements the ICollectionView interface is cast to
     *  an ICollectionView.</li>
     *  <li>An Array is converted to an ArrayCollection.</li>
     *  <li>Any other type object is wrapped in an Array with the object as its sole
     *  entry.</li>
     *  </ul>
     *  </p>
     * 
     *  @default "undefined"
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;

		/**
		 *  @copy mx.controls.Menu#hasRoot
		 */
		public function get hasRoot () : Boolean;

		/**
		 *  The name of the field in the data provider that determines the 
     *  icon to display for each menu item. By default, the MenuBar does not 
     *  try to display icons along with the text in a menu item. By specifying 
     *  an icon field, you can define a graphic that is created 
     *  and displayed as an icon for a menu item. 
     *
     *  <p>The MenuItemRenderer examines 
     *  the data provider for a property of the name defined 
     *  by the <code>iconField</code> property.  If the value of the property is a Class, it 
     *  instantiates that class and expects it to be an instance of 
     *  IFlexDisplayObject. If the value of the property is a String, it 
     *  looks to see if a Class exists with that name in the application, and if 
     *  it cannot find one, it looks for a property on the document 
     *  with that name and expects that property to map to a Class.</p>
     *
     *  @default "icon"
		 */
		public function get iconField () : String;
		/**
		 *  @private
		 */
		public function set iconField (value:String) : void;

		/**
		 *  The name of the field in the data provider that determines the 
     *  text to display for each menu item. If the data provider is an Array of 
     *  Strings, Flex uses each string value as the label. If the data 
     *  provider is an E4X XML object, you must set this property explicitly. 
     *  For example, use @label to specify the label attribute in an E4X XML Object 
     *  as the text to display for each menu item. 
     * 
     *  Setting the <code>labelFunction</code> property overrides this property.
     *
     *  @default "label"
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;

		/**
		 *  The item renderer used by the MenuBar control for 
     *  the top-level menu bar of the MenuBar control. 
     * 
     *  <p>You can define an item renderer for the pop-up submenus 
     *  of the MenuBar control. 
     *  Because each pop-up submenu is an instance of the Menu control, 
     *  you use the class MenuItemRenderer to define an item renderer 
     *  for the pop-up submenus. 
     *  To set the item renderer for a pop-up submenu, access the Menu object using 
     *  the <code>menus</code> property. </p>
     *
     *  @default "mx.controls.menuClasses.MenuBarItem"
     * 
     *  @see mx.controls.menuClasses.MenuBarItem
		 */
		public function get menuBarItemRenderer () : IFactory;
		/**
		 * @private
		 */
		public function set menuBarItemRenderer (value:IFactory) : void;

		/**
		 *  The set of styles to pass from the MenuBar to the menuBar items.
     *  @see mx.styles.StyleProxy
     *  @review
		 */
		protected function get menuBarItemStyleFilters () : Object;

		/**
		 *  The index in the MenuBar control of the currently open Menu 
     *  or the last opened Menu if none are currently open.    
     *  
     *  @default -1
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;

		/**
		 *  A Boolean flag that specifies whether to display the data provider's 
     *  root node.
     *
     *  If the data provider has a root node, and the <code>showRoot</code> property 
     *  is set to <code>false</code>, the items on the MenuBar control correspond to
     *  the immediate descendants of the root node.  
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
		 *  Constructor.
		 */
		public function MenuBar ();

		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;

		/**
		 *  @private
		 */
		protected function createChildren () : void;

		/**
		 *  Updates the MenuBar control's background skin. 
     * 
     *  This method is called when MenuBar children are created or when 
     *  any styles on the MenuBar changes.
		 */
		protected function updateBackground () : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  Calculates the preferred width and height of the MenuBar based on the
     *  default widths of the MenuBar items.
		 */
		protected function measure () : void;

		/**
		 *  @private
     *  Sizes and positions the items on the MenuBar.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		protected function focusInHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;

		/**
		 *  @private
		 */
		private function collectionChangeHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function eventHandler (event:Event) : void;

		/**
		 *  @private
     *
     *  Adds a menu to the MenuBar control at the specified location.
     *  An index of 0 inserts the menu at the leftmost spot in the MenuBar.
     *
     *  @param index Index where the menu should be inserted.
     *  @param arg1 May be either:a String, which is the item's label; or an xmlNode.
     *  @param arg2 May be: undefined; a menu; or an xml/xmlNode.
		 */
		private function addMenuAt (index:int, arg1:Object, arg2:Object = null) : void;

		/**
		 *  @copy mx.controls.listClasses.ListBase#itemToLabel()
		 */
		public function itemToLabel (data:Object) : String;

		/**
		 *  Returns the class for an icon, if any, for a data item,  
     *  based on the <code>iconField</code> property.
     *  The field in the item can return a string as long as that
     *  string represents the name of a class in the application.
     *  The field in the item can also be a string that is the name
     *  of a variable in the document that holds the class for
     *  the icon.
     *  
     *  @param data The item from which to extract the icon class
     *  @return The icon for the item, as a class reference or 
     *  <code>null</code> if none.
		 */
		public function itemToIcon (data:Object) : Class;

		/**
		 *  @private
		 */
		private function insertMenuBarItem (index:int, mdp:Object) : void;

		/**
		 *  Returns a reference to the Menu object at the specified MenuBar item index,  
     *  where 0 is the Menu contained at the leftmost MenuBar item index. 
     *
     *  @param index Index of the Menu instance to return.
     *
     *  @return Reference to the Menu contained at the specified index.
		 */
		public function getMenuAt (index:int) : Menu;

		/**
		 *  @private
     *  Show a menuBarItem's menu
		 */
		private function showMenu (index:Number) : void;

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
		 */
		private function removeMenuBarItemAt (index:int) : void;

		/**
		 *  @private
		 */
		private function removeAll () : void;

		/**
		 *  @private
		 */
		private function mouseOverHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function mouseDownHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function mouseUpHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function mouseOutHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
	}
}
