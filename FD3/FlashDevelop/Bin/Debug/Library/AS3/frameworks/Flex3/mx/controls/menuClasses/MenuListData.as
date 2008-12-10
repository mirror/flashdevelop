package mx.controls.menuClasses
{
	import mx.controls.listClasses.ListData;
	import mx.controls.listClasses.ListBase;
	import mx.core.IUIComponent;

	/**
	 *  The MenuListData class defines the data type of the <code>listData</code> property  *  implemented by drop-in item renderers or drop-in item editors for the Menu and  *  MenuBar control.  All drop-in item renderers and drop-in item editors must implement the  *  IDropInListItemRenderer interface, which defines the <code>listData</code> property. * *  @see mx.controls.listClasses.IDropInListItemRenderer
	 */
	public class MenuListData extends ListData
	{
		/**
		 *  The max icon width for all MenuItemListRenderers
		 */
		public var maxMeasuredIconWidth : Number;
		/**
		 *  The max type icon width for all MenuItemListRenderers
		 */
		public var maxMeasuredTypeIconWidth : Number;
		/**
		 *  The max branch icon width for all MenuItemListRenderers
		 */
		public var maxMeasuredBranchIconWidth : Number;
		/**
		 *  Whether the left icons should layout in two separate columns	 *  (one for icons and one for type icons, like check and radio)
		 */
		public var useTwoColumns : Boolean;

		/**
		 *  Constructor.	 *	 *  @param text Text representation of the item data.	 *	 * 	@param icon A Class or String object representing the icon 	 *  for the item in the List control.	 *	 *  @param labelField The name of the field of the data provider 	 *  containing the label data of the List component.	 * 	 *  @param uid A unique identifier for the item.	 *	 *  @param owner A reference to the Menu control.	 *	 *  @param rowIndex The index of the item in the data provider for the Menu control.	 * 	 *  @param columnIndex The index of the column in the currently visible columns of the      *  control.	 *
		 */
		public function MenuListData (text:String, icon:Class, labelField:String, uid:String, owner:IUIComponent, rowIndex:int = 0, columnIndex:int = 0);
	}
}
