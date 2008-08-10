/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.menuClasses {
	import mx.core.UIComponent;
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.core.IFontContextComponent;
	import mx.core.IFlexDisplayObject;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.Menu;
	public class MenuItemRenderer extends UIComponent implements IDataRenderer, IListItemRenderer, IMenuItemRenderer, IDropInListItemRenderer, IFontContextComponent {
		/**
		 * The internal IFlexDisplayObject that displays the branch icon
		 *  in this renderer.
		 */
		protected var branchIcon:IFlexDisplayObject;
		/**
		 * The implementation of the data property
		 *  as defined by the IDataRenderer interface.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * The internal IFlexDisplayObject that displays the icon in this renderer.
		 */
		protected function get icon():IFlexDisplayObject;
		protected function set icon(value:IFlexDisplayObject):void;
		/**
		 * The internal UITextField that displays the text in this renderer.
		 */
		protected var label:IUITextField;
		/**
		 * The implementation of the listData property
		 *  as defined by the IDropInListItemRenderer interface.
		 */
		public function get listData():BaseListData;
		public function set listData(value:BaseListData):void;
		/**
		 * The width of the branch icon
		 */
		public function get measuredBranchIconWidth():Number;
		/**
		 * The width of the icon
		 */
		public function get measuredIconWidth():Number;
		/**
		 * The width of the type icon (radio/check)
		 */
		public function get measuredTypeIconWidth():Number;
		/**
		 * Contains a reference to the associated Menu control.
		 */
		public function get menu():Menu;
		public function set menu(value:Menu):void;
		/**
		 * The internal IFlexDisplayObject that displays the separator icon in this renderer
		 */
		protected var separatorIcon:IFlexDisplayObject;
		/**
		 * The internal IFlexDisplayObject that displays the type icon in this renderer for
		 *  check and radio buttons.
		 */
		protected var typeIcon:IFlexDisplayObject;
		/**
		 * Constructor.
		 */
		public function MenuItemRenderer();
	}
}
