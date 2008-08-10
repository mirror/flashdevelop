/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.managers.IFocusManagerContainer;
	import mx.controls.menuClasses.IMenuDataDescriptor;
	import flash.display.DisplayObjectContainer;
	public class Menu extends List implements IFocusManagerContainer {
		/**
		 * The object that accesses and manipulates data in the data provider.
		 *  The Menu control delegates to the data descriptor for information
		 *  about its data. This data is then used to parse and move about the
		 *  data source. The data descriptor defined for the root menu is used
		 *  for all submenus.
		 *  The default value is an internal instance of the
		 *  DefaultDataDescriptor class.
		 */
		public function get dataDescriptor():IMenuDataDescriptor;
		public function set dataDescriptor(value:IMenuDataDescriptor):void;
		/**
		 * A flag that indicates that the current data provider has a root node; for example,
		 *  a single top node in a hierarchical structure. XML and Object
		 *  are examples of types that have a root node, while Lists and Arrays do
		 *  not.
		 */
		public function get hasRoot():Boolean;
		/**
		 * The parent menu in a hierarchical chain of menus, where the current
		 *  menu is a submenu of the parent.
		 */
		public function get parentMenu():Menu;
		public function set parentMenu(value:Menu):void;
		/**
		 * A Boolean flag that specifies whether to display the data provider's
		 *  root node.
		 *  If the dataProvider object has a root node, and showRoot is set to
		 *  false, the Menu control does not display the root node;
		 *  only the descendants of the root node will be displayed.
		 *  This flag has no effect on data providers without root nodes,
		 *  like Lists and Arrays.
		 */
		public function get showRoot():Boolean;
		public function set showRoot(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function Menu();
		/**
		 * Creates and returns an instance of the Menu class. The Menu control's
		 *  content is determined by the method's mdp argument. The
		 *  Menu control is placed in the parent container specified by the
		 *  method's parent argument.
		 *  This method does not show the Menu control. Instead,
		 *  this method just creates the Menu control and allows for modifications
		 *  to be made to the Menu instance before the Menu is shown. To show the
		 *  Menu, call the Menu.show() method.
		 *
		 * @param parent            <DisplayObjectContainer> A container that the PopUpManager uses to place the Menu
		 *                            control in. The Menu control may not actually be parented by this object.
		 * @param mdp               <Object> The data provider for the Menu control.
		 * @param showRoot          <Boolean (default = true)> A Boolean flag that specifies whether to display the
		 *                            root node of the data provider.
		 * @return                  <Menu> An instance of the Menu class.
		 */
		public static function createMenu(parent:DisplayObjectContainer, mdp:Object, showRoot:Boolean = true):Menu;
		/**
		 * Hides the Menu control and any of its submenus if the Menu control is
		 *  visible.
		 */
		public function hide():void;
		/**
		 * Creates a new MenuListData instance and populates the fields based on
		 *  the input data provider item.
		 *
		 * @param data              <Object> The data provider item used to populate the ListData.
		 * @param uid               <String> The UID for the item.
		 * @param rowNum            <int> The index of the item in the data provider.
		 * @return                  <BaseListData> A newly constructed ListData object.
		 */
		protected override function makeListData(data:Object, uid:String, rowNum:int):BaseListData;
		/**
		 * Calculates the preferred width and height of the Menu based on the
		 *  widths and heights of its menu items. This method does not take into
		 *  account the position and size of submenus.
		 */
		protected override function measure():void;
		/**
		 * Sets the dataProvider of an existing Menu control and places the Menu
		 *  control in the specified parent container.
		 *  This method does not show the Menu control; you must use the
		 *  Menu.show() method to display the Menu control.
		 *  The Menu.createMenu() method uses this method.
		 *
		 * @param menu              <Menu> Menu control to popup.
		 * @param parent            <DisplayObjectContainer> A container that the PopUpManager uses to place the Menu
		 *                            control in. The Menu control may not actually be parented by this object.
		 *                            If you omit this property, the method sets the Menu control's parent to
		 *                            the application.
		 * @param mdp               <Object> dataProvider object set on the popped up Menu. If you omit this
		 *                            property, the method sets the Menu data provider to a new, empty XML object.
		 */
		public static function popUpMenu(menu:Menu, parent:DisplayObjectContainer, mdp:Object):void;
		/**
		 * Toggles the menu item. The menu item type identifier must be a
		 *  check box or radio button, otherwise this method has no effect.
		 *
		 * @param item              <Object> The menu item to toggle
		 * @param toggle            <Boolean> Boolean value that indicates whether the item is
		 *                            toggled.
		 */
		protected function setMenuItemToggled(item:Object, toggle:Boolean):void;
		/**
		 * Shows the Menu control. If the Menu control is not visible, this method
		 *  places the Menu in the upper-left corner of the parent application at
		 *  the given coordinates, resizes the Menu control as needed, and makes
		 *  the Menu control visible.
		 *  The x and y arguments of the show() method specify the
		 *  coordinates of the upper-left corner of the Menu control relative to the
		 *  parent application, which is not necessarily the direct parent of the
		 *  Menu control.
		 *  For example, if the Menu control is in an HBox container which is
		 *  nested within a Panel container, the x and y coordinates are
		 *  relative to the Application container, not to the HBox container.
		 *
		 * @param xShow             <Object (default = null)> Horizontal location of the Menu control's upper-left
		 *                            corner (optional).
		 * @param yShow             <Object (default = null)> Vertical location of the Menu control's upper-left
		 *                            corner (optional).
		 */
		public function show(xShow:Object = null, yShow:Object = null):void;
	}
}
