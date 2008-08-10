/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	public class FlexNativeMenuEvent extends Event {
		/**
		 * The index of the associated menu item within its parent menu or submenu.
		 *  This is -1 for events that aren't associated with an individual item.
		 */
		public var index:int;
		/**
		 * The specific item in the dataProvider.
		 *  This is null for events that aren't associated with an individual item.
		 */
		public var item:Object;
		/**
		 * The label text of the associated menu item.
		 *  This is null for events that aren't associated with an individual item.
		 */
		public var label:String;
		/**
		 * The specific NativeMenu instance associated with the event,
		 *  such as the menu displayed.
		 */
		public var nativeMenu:NativeMenu;
		/**
		 * The specific NativeMenuItem instance associated with the event,
		 *  such as the item clicked.  This is null for events that aren't
		 *  associated with an individual item.
		 */
		public var nativeMenuItem:NativeMenuItem;
		/**
		 * Constructor.
		 *  Normally called by the FlexNativeMenu object.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = true)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param nativeMenu        <NativeMenu (default = null)> The specific NativeMenu instance associated with the event.
		 * @param nativeMenuItem    <NativeMenuItem (default = null)> The specific NativeMenuItem instance associated with the event.
		 * @param item              <Object (default = null)> The item in the dataProvider of the associated menu item.
		 * @param label             <String (default = null)> The label text of the associated menu item.
		 * @param index             <int (default = -1)> The index in the menu of the associated menu item.
		 */
		public function FlexNativeMenuEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, nativeMenu:NativeMenu = null, nativeMenuItem:NativeMenuItem = null, item:Object = null, label:String = null, index:int = -1);
		/**
		 * The FlexNativeMenuEvent.ITEM_CLICK event type constant indicates that the
		 *  user selected a menu item.
		 */
		public static const ITEM_CLICK:String = "itemClick";
		/**
		 * The FlexNativeMenuEvent.MENU_SHOW type constant indicates that
		 *  the mouse pointer rolled a menu or submenu opened.
		 */
		public static const MENU_SHOW:String = "menuShow";
	}
}
