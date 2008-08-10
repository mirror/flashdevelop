/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.treeClasses {
	import mx.core.UIComponent;
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.IFontContextComponent;
	import mx.controls.listClasses.BaseListData;
	public class TreeItemRenderer extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer, IFontContextComponent {
		/**
		 * The implementation of the data property as
		 *  defined by the IDataRenderer interface.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * The internal IFlexDisplayObject that displays the disclosure icon
		 *  in this renderer.
		 */
		protected var disclosureIcon:IFlexDisplayObject;
		/**
		 * The internal IFlexDisplayObject that displays the icon in this renderer.
		 */
		protected var icon:IFlexDisplayObject;
		/**
		 * The internal UITextField that displays the text in this renderer.
		 */
		protected var label:IUITextField;
		/**
		 * The implementation of the listData property as
		 *  defined by the IDropInListItemRenderer interface.
		 */
		public function get listData():BaseListData;
		public function set listData(value:BaseListData):void;
		/**
		 * Constructor.
		 */
		public function TreeItemRenderer();
	}
}
