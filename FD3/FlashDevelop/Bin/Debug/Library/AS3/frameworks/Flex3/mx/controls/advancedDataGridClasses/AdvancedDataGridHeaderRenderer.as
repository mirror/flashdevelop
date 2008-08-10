/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.advancedDataGridClasses {
	import mx.core.UIComponent;
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.BaseListData;
	import mx.core.IFactory;
	import flash.events.MouseEvent;
	import mx.events.ToolTipEvent;
	public class AdvancedDataGridHeaderRenderer extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer {
		/**
		 * The implementation of the data property
		 *  as defined by the IDataRenderer interface.
		 *  When set, it stores the value and invalidates the component
		 *  to trigger a relayout of the component.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
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
		 * Specifies a custom sort item renderer.
		 *  By default, the AdvancedDataGridHeaderRenderer class uses
		 *  AdvancedDataGridSortItemRenderer as the sort item renderer.
		 */
		public function get sortItemRenderer():IFactory;
		public function set sortItemRenderer(value:IFactory):void;
		/**
		 * Constructor.
		 */
		public function AdvancedDataGridHeaderRenderer();
		/**
		 * Returns the sort information for this column from the AdvancedDataGrid control
		 *  so that the control can display the column's number in the sort sequence,
		 *  and whether the sort is ascending or descending.
		 *  The sorting information is represented by an instance of the SortInfo class,
		 *  where each column in the AdvancedDataGrid control has an associated
		 *  SortInfo instance.
		 *
		 * @return                  <SortInfo> A SortInfo instance.
		 */
		protected function getFieldSortInfo():SortInfo;
		/**
		 * Indicates if the mouse pointer was over the text part or icon part
		 *  of the header when the mouse event occurred.
		 *
		 * @param event             <MouseEvent> The mouse event.
		 * @return                  <String> AdvancedDataGrid.HEADERTEXTPART if the mouse was over the header text,
		 *                            and AdvancedDataGrid.HEADERICONPART if the mouse was over the header icon.
		 */
		public function mouseEventToHeaderPart(event:MouseEvent):String;
		/**
		 * Positions the tooltip in the header.
		 *
		 * @param event             <ToolTipEvent> Event object.
		 */
		protected function toolTipShowHandler(event:ToolTipEvent):void;
	}
}
