/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.listClasses {
	import mx.core.UIComponent;
	import mx.core.IDataRenderer;
	import mx.core.IFontContextComponent;
	import mx.events.ToolTipEvent;
	public class TileListItemRenderer extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer, IFontContextComponent {
		/**
		 * The implementation of the data property as
		 *  defined by the IDataRenderer interface.  It simply stores
		 *  the value and invalidates the component
		 *  to trigger a relayout of the component.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
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
		public function TileListItemRenderer();
		/**
		 * Positions the tooltip.
		 *
		 * @param event             <ToolTipEvent> Event object.
		 */
		protected function toolTipShowHandler(event:ToolTipEvent):void;
	}
}
