/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.olapDataGridClasses {
	import mx.core.UIComponent;
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.BaseListData;
	public class OLAPDataGridGroupRenderer extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer {
		/**
		 * The implementation of the data property as
		 *  defined by the IDataRenderer interface.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
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
		public function OLAPDataGridGroupRenderer();
	}
}
