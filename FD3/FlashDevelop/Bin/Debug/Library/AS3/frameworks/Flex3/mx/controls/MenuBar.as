/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.UIComponent;
	import mx.managers.IFocusManagerComponent;
	import mx.controls.menuClasses.IMenuDataDescriptor;
	import mx.core.IFactory;
	public class MenuBar extends UIComponent implements IFocusManagerComponent {
		/**
		 * The object that accesses and manipulates data in the data provider.
		 *  The MenuBar control delegates to the data descriptor for information
		 *  about its data. This data is then used to parse and move about the
		 *  data source. The data descriptor defined for the MenuBar is used for
		 *  all child menus and submenus.
		 */
		public function get dataDescriptor():IMenuDataDescriptor;
		public function set dataDescriptor(value:IMenuDataDescriptor):void;
		/**
		 * The hierarchy of objects that are displayed as MenuBar items and menus.
		 *  The top-level children all become MenuBar items, and their children
		 *  become the items in the menus and submenus.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * A flag that indicates that the current data provider has a root node; for example,
		 *  a single top node in a hierarchical structure. XML and Object
		 *  are examples of types that have a root node, while Lists and Arrays do
		 *  not.
		 */
		public function get hasRoot():Boolean;
		/**
		 * The name of the field in the data provider that determines the
		 *  icon to display for each menu item. By default, the MenuBar does not
		 *  try to display icons along with the text in a menu item. By specifying
		 *  an icon field, you can define a graphic that is created
		 *  and displayed as an icon for a menu item.
		 */
		public function get iconField():String;
		public function set iconField(value:String):void;
		/**
		 * The name of the field in the data provider that determines the
		 *  text to display for each menu item. If the data provider is an Array of
		 *  Strings, Flex uses each string value as the label. If the data
		 *  provider is an E4X XML object, you must set this property explicitly.
		 *  For example, use
		 */
		public function get labelField():String;
		public function set labelField(value:String):void;
		/**
		 * The function that determines the text to display for each menu item.
		 *  The label function must find the appropriate field or fields in the
		 *  data provider and return a displayable string.
		 *  If you omit this property, Flex uses the contents of the field or
		 *  attribute specified by the labelField property.
		 *  If you specify this property, Flex ignores any labelField
		 *  property value.
		 *  The labelFunction property is good for handling formatting
		 *  and localization.
		 */
		public var labelFunction:Function;
		/**
		 * The item renderer used by the MenuBar control for
		 *  the top-level menu bar of the MenuBar control.
		 */
		public function get menuBarItemRenderer():IFactory;
		public function set menuBarItemRenderer(value:IFactory):void;
		/**
		 * An Array that contains the MenuBarItem objects that render
		 *  each item in the top-level menu bar of a MenuBar control. By default,
		 *  this property contains instances of the MenuBarItem class.
		 *  Items should not be added directly to the menuBarItems array. To
		 *  add new menubar items, add them directly to the MenuBar control's
		 *  data provider.
		 */
		public var menuBarItems:Array;
		/**
		 * The set of styles to pass from the MenuBar to the menuBar items.
		 */
		protected function get menuBarItemStyleFilters():Object;
		/**
		 * An Array containing the Menu objects corresponding to the
		 *  pop-up submenus of this MenuBar control.
		 *  Each MenuBar item can have a corresponding Menu object in the Array,
		 *  even if the item does not have a pop-up submenu.
		 *  Flex does not initially populate the menus array;
		 *  instead, it creates the menus dynamically, as needed.
		 *  Items should not be added directly to the menus Array. To
		 *  add new drop-down menus, add directly to the MenuBar
		 *  control's data provider.
		 */
		public var menus:Array;
		/**
		 * The index in the MenuBar control of the currently open Menu
		 *  or the last opened Menu if none are currently open.
		 */
		public function get selectedIndex():int;
		public function set selectedIndex(value:int):void;
		/**
		 * A Boolean flag that specifies whether to display the data provider's
		 *  root node.
		 *  If the data provider has a root node, and the showRoot property
		 *  is set to false, the items on the MenuBar control correspond to
		 *  the immediate descendants of the root node.
		 *  This flag has no effect on data providers without root nodes,
		 *  like Lists and Arrays.
		 */
		public function get showRoot():Boolean;
		public function set showRoot(value:Boolean):void;
		/**
		 * Constructor
		 */
		public function MenuBar();
		/**
		 * Returns a reference to the Menu object at the specified MenuBar item index,
		 *  where 0 is the Menu contained at the leftmost MenuBar item index.
		 *
		 * @param index             <int> Index of the Menu instance to return.
		 * @return                  <Menu> Reference to the Menu contained at the specified index.
		 */
		public function getMenuAt(index:int):Menu;
		/**
		 * Returns the class for an icon, if any, for a data item,
		 *  based on the iconField property.
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
		 * Calculates the preferred width and height of the MenuBar based on the
		 *  default widths of the MenuBar items.
		 */
		protected override function measure():void;
		/**
		 * Updates the MenuBar control's background skin.
		 *  This method is called when MenuBar children are created or when
		 *  any styles on the MenuBar changes.
		 */
		protected function updateBackground():void;
	}
}
