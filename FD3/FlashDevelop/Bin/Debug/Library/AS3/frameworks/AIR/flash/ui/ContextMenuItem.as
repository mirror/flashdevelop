/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.ui {
	import flash.display.NativeMenuItem;
	public final  class ContextMenuItem extends NativeMenuItem {
		/**
		 * Specifies the menu item caption (text) displayed in the context menu.
		 *  See the ContextMenuItem class overview for caption value restrictions.
		 */
		public function get caption():String;
		public function set caption(value:String):void;
		/**
		 * Indicates whether a separator bar should appear above the specified menu item.
		 */
		public function get separatorBefore():Boolean;
		public function set separatorBefore(value:Boolean):void;
		/**
		 * Indicates whether the specified menu item is visible when the Flash Player
		 *  context menu is displayed.
		 */
		public function get visible():Boolean;
		public function set visible(value:Boolean):void;
		/**
		 * Creates a new ContextMenuItem object that can be added to the ContextMenu.customItems
		 *  array.
		 *
		 * @param caption           <String> Specifies the text associated with the menu item.
		 *                            See the ContextMenuItem class overview for caption value restrictions.
		 * @param separatorBefore   <Boolean (default = false)> Specifies whether a separator bar appears above the
		 *                            menu item in the context menu. The default value is false.
		 * @param enabled           <Boolean (default = true)> Specifies whether the menu item is enabled or disabled in the
		 *                            context menu. The default value is true (enabled). This parameter is optional.
		 * @param visible           <Boolean (default = true)> Specifies whether the menu item is visible or invisible. The
		 *                            default value is true (visible).
		 */
		public function ContextMenuItem(caption:String, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true);
	}
}
