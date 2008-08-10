/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.events {
	import flash.events.Event;
	import mx.controls.menuClasses.IMenuBarItemRenderer;
	public class MenuShowEvent extends Event {
		/**
		 * The item renderer of the associated menu item where the event occurred.
		 */
		public var itemRenderer:IMenuBarItemRenderer;
		/**
		 * Constructor.
		 *  Normally called by the Menu object.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param itemRenderer      <IMenuBarItemRenderer (default = null)> The IMenuBarItemRenderer of the associated menu item.
		 */
		public function MenuShowEvent(type:String, itemRenderer:IMenuBarItemRenderer = null);
		/**
		 * The MenuShowEvent.MENU_SHOW constant defines the value of the
		 *  type property of the event object for a menuShow event.
		 */
		public static const MENU_SHOW:String = "menuShow";
	}
}
