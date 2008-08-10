/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.BaseListData;
	public class Image extends SWFLoader implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer {
		/**
		 * The data property lets you pass a value to the component
		 *  when you use it in an item renderer or item editor.
		 *  You typically use data binding to bind a field of the data
		 *  property to a property of this component.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * When a component is used as a drop-in item renderer or drop-in
		 *  item editor, Flex initializes the listData property
		 *  of the component with the appropriate data from the List control.
		 *  The component can then use the listData property
		 *  to initialize the other properties of the drop-in
		 *  item renderer
		 */
		public function get listData():BaseListData;
		public function set listData(value:BaseListData):void;
		/**
		 * Constructor.
		 */
		public function Image();
	}
}
