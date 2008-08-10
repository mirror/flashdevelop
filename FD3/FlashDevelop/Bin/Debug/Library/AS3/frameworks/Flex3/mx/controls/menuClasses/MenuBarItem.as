/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.menuClasses {
	import mx.core.UIComponent;
	import mx.core.IFontContextComponent;
	import mx.controls.MenuBar;
	public class MenuBarItem extends UIComponent implements IMenuBarItemRenderer, IFontContextComponent {
		/**
		 * The implementation of the data property
		 *  as defined by the IDataRenderer interface.
		 *  All item renderers must implement the IDataRenderer interface.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * The object that provides the data for the Menu that is popped up
		 *  when this MenuBarItem is selected.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * The IFlexDisplayObject that displays the icon in this MenuBarItem.
		 */
		protected var icon:IFlexDisplayObject;
		/**
		 * The UITextField that displays the text in this MenuBarItem.
		 */
		protected var label:IUITextField;
		/**
		 * Contains a reference to the item renderer's MenuBar control.
		 */
		public function get menuBar():MenuBar;
		public function set menuBar(value:MenuBar):void;
		/**
		 * Contains the index of this item renderer relative to
		 *  other item renderers in the MenuBar control.
		 *  The index of the first item renderer,
		 *  the left most renderer, is 0 and increases by 1 as you
		 *  move to the right in the MenuBar control.
		 */
		public function get menuBarItemIndex():int;
		public function set menuBarItemIndex(value:int):void;
		/**
		 * Contains the current state of this item renderer.
		 *  The possible values are "itemUpSkin",
		 *  "itemDownSkin", and "itemOverSkin".
		 */
		public function get menuBarItemState():String;
		public function set menuBarItemState(value:String):void;
		/**
		 * Constructor.
		 */
		public function MenuBarItem();
	}
}
