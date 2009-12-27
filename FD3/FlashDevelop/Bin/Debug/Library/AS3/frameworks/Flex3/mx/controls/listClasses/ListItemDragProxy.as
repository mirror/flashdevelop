package mx.controls.listClasses
{
	import flash.display.DisplayObject;
	import mx.core.mx_internal;
	import mx.core.UIComponent;

include "../../core/Version.as"
	/**
	 *  The default drag proxy used when dragging from a list-based control
 *  (except for the DataGrid class).
 *  A drag proxy is a component that parents the objects
 *  or copies of the objects being dragged
 *
 *  @see mx.controls.dataGridClasses.DataGridDragProxy
	 */
	public class ListItemDragProxy extends UIComponent
	{
		/**
		 *  Constructor.
		 */
		public function ListItemDragProxy ();

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
