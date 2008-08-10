/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.advancedDataGridClasses {
	import mx.controls.listClasses.IListItemRenderer;
	public class AdvancedDataGridHeaderInfo {
		/**
		 * The actual column index at which the header starts,
		 *  relative to the currently displayed columns.
		 */
		public var actualColNum:int;
		/**
		 * An Array of all of the child AdvancedDataGridHeaderInfo instances
		 *  of this AdvancedDataGridHeaderInfo instance,
		 *  if this column is part of a column group.
		 */
		public var children:Array;
		/**
		 * A reference to the AdvancedDataGridColumn instance
		 *  corresponding to this AdvancedDataGridHeaderInfo instance.
		 */
		public var column:AdvancedDataGridColumn;
		/**
		 * Number of actual columns spanned by the column header when using column groups.
		 */
		public var columnSpan:int;
		/**
		 * The depth of this AdvancedDataGridHeaderInfo instance
		 *  in the columns hierarchy of the AdvancedDataGrid control,
		 *  if this column is part of a column group.
		 */
		public var depth:int;
		/**
		 * A reference to IListItemRenderer instance used to render the column header.
		 */
		public var headerItem:IListItemRenderer;
		/**
		 * The index of this AdvancedDataGridHeaderInfo instance
		 *  in the AdvancedDataGrid control.
		 */
		public var index:int;
		/**
		 * A function that gets created if the
		 *  column grouping requires extracting data from nested objects.
		 */
		public var internalLabelFunction:Function;
		/**
		 * The parent AdvancedDataGridHeaderInfo instance
		 *  of this AdvancedDataGridHeaderInfo instance
		 *  if this column is part of a column group.
		 */
		public var parent:AdvancedDataGridHeaderInfo;
		/**
		 * Contains true if the column is currently visible.
		 */
		public var visible:Boolean;
		/**
		 * An Array of the currently visible child AdvancedDataGridHeaderInfo instances.
		 *  if this column is part of a column group.
		 */
		public var visibleChildren:Array;
		/**
		 * The index of this column in the list of visible children of its parent
		 *  AdvancedDataGridHeaderInfo instance,
		 *  if this column is part of a column group.
		 */
		public var visibleIndex:int;
		/**
		 * Constructor.
		 *
		 * @param column            <AdvancedDataGridColumn> A reference to the AdvancedDataGridColumn instance
		 *                            that this AdvancedDataGridHeaderInfo instance corresponds to.
		 * @param parent            <AdvancedDataGridHeaderInfo> The parent AdvancedDataGridHeaderInfo instance
		 *                            of this AdvancedDataGridHeaderInfo instance.
		 * @param index             <int> The index of this AdvancedDataGridHeaderInfo instance
		 *                            in the AdvancedDataGrid control.
		 * @param depth             <int> The depth of this AdvancedDataGridHeaderInfo instance
		 *                            in the columns hierarchy of the AdvancedDataGrid control.
		 * @param children          <Array (default = null)> An Array of all of the child AdvancedDataGridHeaderInfo instances
		 *                            of this AdvancedDataGridHeaderInfo instance.
		 * @param internalLabelFunction<Function (default = null)> A function that gets created if the column grouping
		 *                            requires extracting data from nested objects.
		 * @param headerItem        <IListItemRenderer (default = null)> A reference to IListItemRenderer instance used to
		 *                            render the column header.
		 */
		public function AdvancedDataGridHeaderInfo(column:AdvancedDataGridColumn, parent:AdvancedDataGridHeaderInfo, index:int, depth:int, children:Array = null, internalLabelFunction:Function = null, headerItem:IListItemRenderer = null);
	}
}
