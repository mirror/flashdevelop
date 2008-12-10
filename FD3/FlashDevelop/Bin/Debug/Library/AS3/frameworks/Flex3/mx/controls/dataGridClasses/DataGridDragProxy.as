package mx.controls.dataGridClasses
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import mx.controls.DataGrid;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The DataGridDragProxy class defines the default drag proxy  *  used when dragging data from a DataGrid control.
	 */
	public class DataGridDragProxy extends UIComponent
	{
		/**
		 *  Constructor.
		 */
		public function DataGridDragProxy ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
	}
}
