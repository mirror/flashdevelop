/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.ui {
	import flash.display.NativeMenu;
	import flash.display.Stage;
	public final  class ContextMenu extends NativeMenu {
		/**
		 * An object that has the following properties of the ContextMenuBuiltInItems class: forwardAndBack, loop,
		 *  play, print, quality,
		 *  rewind, save, and zoom.
		 *  Setting these properties to false removes the corresponding menu items from the
		 *  specified ContextMenu object. These properties are enumerable and are set to true by
		 *  default.
		 */
		public function get builtInItems():ContextMenuBuiltInItems;
		public function set builtInItems(value:ContextMenuBuiltInItems):void;
		/**
		 * An array of ContextMenuItem objects. Each object in the array represents a context menu item that you
		 *  have defined. Use this property to add, remove, or modify these custom menu items.
		 */
		public function get customItems():Array;
		public function set customItems(value:Array):void;
		/**
		 * Creates a ContextMenu object.
		 */
		public function ContextMenu();
		/**
		 * Pops up this menu at the specified location.
		 *
		 * @param stage             <Stage> The Stage object on which to display this menu.
		 * @param stageX            <Number> The number of horizontal pixels, relative to the origin
		 *                            of stage, at which to display this menu.
		 * @param stageY            <Number> The number of vertical pixels, relative to the origin
		 *                            of stage, at which to display this menu.
		 */
		public override function display(stage:Stage, stageX:Number, stageY:Number):void;
		/**
		 * Hides all built-in menu items (except Settings) in the specified ContextMenu object. If the debugger version of Flash
		 *  Player is running, the Debugging menu item appears, although it is dimmed for SWF files that
		 *  do not have remote debugging enabled.
		 */
		public function hideBuiltInItems():void;
	}
}
