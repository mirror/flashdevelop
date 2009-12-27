package mx.controls.dataGridClasses
{
	import mx.controls.listClasses.ListBase;
	import mx.controls.listClasses.ListBaseContentHolder;

	/**
	 *  The DataGridLockedRowContentHolder class defines a container in a DataGrid control
 *  of all of the control's item renderers and item editors.
 *  Flex uses it to mask areas of the renderers that extend outside
 *  of the control, and to block certain styles, such as <code>backgroundColor</code>, 
 *  from propagating to the renderers so that highlights and 
 *  alternating row colors can show through the control.
 *
 *  @see mx.controls.DataGrid
	 */
	public class DataGridLockedRowContentHolder extends ListBaseContentHolder
	{
		/**
		 * The measured height of the DataGrid control.
		 */
		public function get measuredHeight () : Number;

		/**
		 *  Constructor.
     *
     *  @param parentList The DataGrid control.
		 */
		public function DataGridLockedRowContentHolder (parentList:ListBase);
	}
}
