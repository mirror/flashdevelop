/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.menuClasses {
	import mx.controls.listClasses.ListData;
	import mx.core.IUIComponent;
	public class MenuListData extends ListData {
		/**
		 * The max branch icon width for all MenuItemListRenderers
		 */
		public var maxMeasuredBranchIconWidth:Number;
		/**
		 * The max icon width for all MenuItemListRenderers
		 */
		public var maxMeasuredIconWidth:Number;
		/**
		 * The max type icon width for all MenuItemListRenderers
		 */
		public var maxMeasuredTypeIconWidth:Number;
		/**
		 * Whether the left icons should layout in two separate columns
		 *  (one for icons and one for type icons, like check and radio)
		 */
		public var useTwoColumns:Boolean;
		/**
		 * Constructor.
		 *
		 * @param text              <String> Text representation of the item data.
		 * @param icon              <Class> A Class or String object representing the icon
		 *                            for the item in the List control.
		 * @param labelField        <String> The name of the field of the data provider
		 *                            containing the label data of the List component.
		 * @param uid               <String> A unique identifier for the item.
		 * @param owner             <IUIComponent> A reference to the Menu control.
		 * @param rowIndex          <int (default = 0)> The index of the item in the data provider for the Menu control.
		 * @param columnIndex       <int (default = 0)> The index of the column in the currently visible columns of the
		 *                            control.
		 */
		public function MenuListData(text:String, icon:Class, labelField:String, uid:String, owner:IUIComponent, rowIndex:int = 0, columnIndex:int = 0);
	}
}
