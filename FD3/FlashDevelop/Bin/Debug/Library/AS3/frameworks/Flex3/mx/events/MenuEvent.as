/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import mx.controls.MenuBar;
	import mx.controls.Menu;
	import mx.controls.listClasses.IListItemRenderer;
	public class MenuEvent extends ListEvent {
		/**
		 * The index of the associated menu item within its parent menu or submenu.
		 *  This is -1 for the menuShow and menuHide events.
		 */
		public var index:int;
		/**
		 * The specific item in the dataProvider.
		 *  This is null for the menuShow and menuHide events.
		 */
		public var item:Object;
		/**
		 * The label text of the associated menu item.
		 *  This is null for the menuShow and menuHide events.
		 */
		public var label:String;
		/**
		 * The specific Menu instance associated with the event,
		 *  such as the menu or submenu that was hidden or opened.
		 *  This property is null if a MenuBar item is dispatching
		 *  the event.
		 */
		public var menu:Menu;
		/**
		 * The MenuBar instance that is the parent of the selected Menu control,
		 *  or null when the target Menu control is not parented by a
		 *  MenuBar control.
		 */
		public var menuBar:MenuBar;
		/**
		 * Constructor.
		 *  Normally called by the Menu object.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = true)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param menuBar           <MenuBar (default = null)> The MenuBar instance that is the parent
		 *                            of the selected Menu control, or null when the target Menu control
		 *                            is not parented by a MenuBar control.
		 * @param menu              <Menu (default = null)> The specific Menu instance associated with the event,
		 *                            such as the menu or submenu that was hidden or opened. This property
		 *                            is null if a MenuBar item dispatches the event.
		 * @param item              <Object (default = null)> The item in the dataProvider of the associated menu item.
		 * @param itemRenderer      <IListItemRenderer (default = null)> The ListItemRenderer of the associated menu item.
		 * @param label             <String (default = null)> The label text of the associated menu item.
		 * @param index             <int (default = -1)> The index in the menu of the associated menu item.
		 */
		public function MenuEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, menuBar:MenuBar = null, menu:Menu = null, item:Object = null, itemRenderer:IListItemRenderer = null, label:String = null, index:int = -1);
		/**
		 * The MenuEvent.CHANGE event type constant indicates that selection
		 *  changed as a result of user interaction.
		 */
		public static const CHANGE:String = "change";
		/**
		 * The MenuEvent.ITEM_CLICK event type constant indicates that the
		 *  user selected a menu item.
		 */
		public static const ITEM_CLICK:String = "itemClick";
		/**
		 * The MenuEvent.ITEM_ROLL_OUT type constant indicates that
		 *  the mouse pointer rolled out of a menu item.
		 */
		public static const ITEM_ROLL_OUT:String = "itemRollOut";
		/**
		 * The MenuEvent.ITEM_ROLL_OVER type constant indicates that
		 *  the mouse pointer rolled over a menu item.
		 */
		public static const ITEM_ROLL_OVER:String = "itemRollOver";
		/**
		 * The MenuEvent.MENU_HIDE event type constant indicates that
		 *  a menu or submenu closed.
		 */
		public static const MENU_HIDE:String = "menuHide";
		/**
		 * The MenuEvent.MENU_SHOW type constant indicates that
		 *  the mouse pointer rolled a menu or submenu opened.
		 */
		public static const MENU_SHOW:String = "menuShow";
	}
}
