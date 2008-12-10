package mx.controls.listClasses
{
	import mx.core.mx_internal;

	/**
	 *  Records used by list classes to keep track of what is selected. *  Each selected item is represented by an instance of this class.  * *  @see mx.controls.listClasses.ListBase#selectedData
	 */
	public class ListBaseSelectionData
	{
		/**
		 *  @private     *  The next ListBaseSelectionData in a linked list	 *  of ListBaseSelectionData.     *  ListBaseSelectionData instances are linked together and keep track	 *  of the order in which the user selects items.	 *  This order is reflected in selectedIndices and selectedItems.
		 */
		local var nextSelectionData : ListBaseSelectionData;
		/**
		 *  @private     *  The previous ListBaseSelectionData in a linked list	 *  of ListBaseSelectionData.     *  ListBaseSelectionData instances are linked together and keep track	 *  of the order in which the user selects items.	 *  This order is reflected in selectedIndices and selectedItems.
		 */
		local var prevSelectionData : ListBaseSelectionData;
		/**
		 *  If true, then the index property is an approximate value and not the exact value.
		 */
		public var approximate : Boolean;
		/**
		 *  The data Object that is selected (selectedItem)
		 */
		public var data : Object;
		/**
		 *  The index in the data provider of the selected item. (may be approximate)
		 */
		public var index : int;

		/**
		 *  Constructor.	 *	 *  @param data The data Object that is selected	 *	 *  @param index The index in the data provider of the selected item. (may be approximate) 	 *	 *  @param approximate If true, then the index property is an approximate value and not the exact value.
		 */
		public function ListBaseSelectionData (data:Object, index:int, approximate:Boolean);
	}
}
