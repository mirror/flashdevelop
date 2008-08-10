/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.listClasses {
	import mx.core.IUIComponent;
	public class ListData extends BaseListData {
		/**
		 * A Class representing the icon for the item in the List control computed
		 *  from the list class's itemToIcon() method
		 */
		public var icon:Class;
		/**
		 * The value of the labelField property in the list class.
		 *  This is the value normally used to calculate which property should
		 *  be taken from the item in the data provider for the text displayed
		 *  in the item renderer, but is also used by DateField and other
		 *  components to indicate which field to take from the data provider item
		 *  that contains a Date or other non-text property.
		 */
		public var labelField:String;
		/**
		 * Constructor.
		 *
		 * @param text              <String> Text representation of the item data.
		 * @param icon              <Class> A Class or String object representing the icon
		 *                            for the item in the List control.
		 * @param labelField        <String> The name of the field of the data provider
		 *                            containing the label data of the List component.
		 * @param uid               <String> A unique identifier for the item.
		 * @param owner             <IUIComponent> A reference to the List control.
		 * @param rowIndex          <int (default = 0)> The index of the item in the data provider
		 *                            for the List control.
		 * @param columnIndex       <int (default = 0)> The index of the column in the currently visible columns of the
		 *                            control.
		 */
		public function ListData(text:String, icon:Class, labelField:String, uid:String, owner:IUIComponent, rowIndex:int = 0, columnIndex:int = 0);
	}
}
