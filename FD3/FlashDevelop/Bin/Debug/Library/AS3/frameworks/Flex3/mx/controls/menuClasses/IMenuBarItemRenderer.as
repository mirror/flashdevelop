package mx.controls.menuClasses
{
	import mx.controls.MenuBar;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.IDataRenderer;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.styles.ISimpleStyleClient;

	/**
	 *  The IMenuBarItemRenderer interface defines the interface *  that an item renderer for the top-level menu bar of a  *  MenuBar control must implement. *  The item renderer defines the look of the individual buttons  *  in the top-level menu bar.  *  *  To implement this interface, you must define a  *  setter and getter method that implements the <code>menuBar</code>,  *  <code>menuBarItemIndex</code>, and <code>menuBarItemState</code> properties.  *  *  @see mx.controls.MenuBar  *  @see mx.controls.menuClasses.MenuBarItem
	 */
	public interface IMenuBarItemRenderer extends IDataRenderer
	{
		/**
		 *  Contains a reference to the item renderer's MenuBar control.
		 */
		public function get menuBar () : MenuBar;
		/**
		 *  @private
		 */
		public function set menuBar (value:MenuBar) : void;
		/**
		 *  Contains the index of this item renderer relative to     *  other item renderers in the MenuBar control.      *  The index of the first item renderer,     *  the left most renderer, is 0 and increases by 1 as you     *  move to the right in the MenuBar control.
		 */
		public function get menuBarItemIndex () : int;
		/**
		 *  @private
		 */
		public function set menuBarItemIndex (value:int) : void;
		/**
		 *  Contains the current state of this item renderer.      *  The possible values are <code>"itemUpSkin"</code>,      *  <code>"itemDownSkin"</code>, and <code>"itemOverSkin"</code>.
		 */
		public function get menuBarItemState () : String;
		/**
		 *  @private
		 */
		public function set menuBarItemState (value:String) : void;

	}
}
