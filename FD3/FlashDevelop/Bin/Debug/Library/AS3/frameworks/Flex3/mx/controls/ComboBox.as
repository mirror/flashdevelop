/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListBase;
	import mx.core.IFactory;
	import mx.controls.listClasses.BaseListData;
	import flash.events.Event;
	public class ComboBox extends ComboBase implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer {
		/**
		 * The data property lets you pass a value
		 *  to the component when you use it in an item renderer or item editor.
		 *  You typically use data binding to bind a field of the data
		 *  property to a property of this component.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * The set of items this component displays. This property is of type
		 *  Object because the derived classes can handle a variety of data
		 *  types such as Arrays, XML, ICollectionViews, and other classes.  All
		 *  are converted into an ICollectionView and that ICollectionView is
		 *  returned if you get the value of this property; you will not get the
		 *  value you set if it was not an ICollectionView.
		 */
		public function set dataProvider(value:Object):void;
		/**
		 * A reference to the List control that acts as the drop-down in the ComboBox.
		 */
		public function get dropdown():ListBase;
		/**
		 * The IFactory that creates a ListBase-derived instance to use
		 *  as the drop-down.
		 *  The default value is an IFactory for List
		 */
		public function get dropdownFactory():IFactory;
		public function set dropdownFactory(value:IFactory):void;
		/**
		 * The set of styles to pass from the ComboBox to the dropDown.
		 *  Styles in the dropDownStyleName style will override these styles.
		 */
		protected function get dropDownStyleFilters():Object;
		/**
		 * Width of the drop-down list, in pixels.
		 */
		public function get dropdownWidth():Number;
		public function set dropdownWidth(value:Number):void;
		/**
		 * IFactory that generates the instances that displays the data for the
		 *  drop-down list of the control.  You can use this property to specify
		 *  a custom item renderer for the drop-down list.
		 */
		public function get itemRenderer():IFactory;
		public function set itemRenderer(value:IFactory):void;
		/**
		 * Name of the field in the items in the dataProvider
		 *  Array to display as the label in the TextInput portion and drop-down list.
		 *  By default, the control uses a property named label
		 *  on each Array object and displays it.
		 */
		public function get labelField():String;
		public function set labelField(value:String):void;
		/**
		 * User-supplied function to run on each item to determine its label.
		 *  By default the control uses a property named label
		 *  on each dataProvider item to determine its label.
		 *  However, some data sets do not have a label property,
		 *  or do not have another property that can be used for displaying
		 *  as a label.
		 */
		public function get labelFunction():Function;
		public function set labelFunction(value:Function):void;
		/**
		 * When a component is used as a drop-in item renderer or drop-in item
		 *  editor, Flex initializes the listData property of the
		 *  component with the appropriate data from the List control. The
		 *  component can then use the listData property and the
		 *  data property to display the appropriate information
		 *  as a drop-in item renderer or drop-in item editor.
		 */
		public function get listData():BaseListData;
		public function set listData(value:BaseListData):void;
		/**
		 * The prompt for the ComboBox control. A prompt is
		 *  a String that is displayed in the TextInput portion of the
		 *  ComboBox when selectedIndex = -1.  It is usually
		 *  a String like "Select one...".  If there is no
		 *  prompt, the ComboBox control sets selectedIndex to 0
		 *  and displays the first item in the dataProvider.
		 */
		public function get prompt():String;
		public function set prompt(value:String):void;
		/**
		 * Maximum number of rows visible in the ComboBox control list.
		 *  If there are fewer items in the
		 *  dataProvider, the ComboBox shows only as many items as
		 *  there are in the dataProvider.
		 */
		public function get rowCount():int;
		public function set rowCount(value:int):void;
		/**
		 * Index of the selected item in the drop-down list.
		 *  Setting this property sets the current index and displays
		 *  the associated label in the TextInput portion.
		 */
		public function set selectedIndex(value:int):void;
		/**
		 * Contains a reference to the selected item in the
		 *  dataProvider.
		 *  If the data is an object or class instance, modifying
		 *  properties in the object or instance modifies the dataProvider
		 *  and thus its views.  Setting the selectedItem itself causes the
		 *  ComboBox to select that item (display it in the TextInput portion and set
		 *  the selectedIndex) if it exists in the dataProvider.
		 */
		public function set selectedItem(value:Object):void;
		/**
		 * The String displayed in the TextInput portion of the ComboBox. It
		 *  is calculated from the data by using the labelField
		 *  or labelFunction.
		 */
		public function get selectedLabel():String;
		/**
		 * Constructor.
		 */
		public function ComboBox();
		/**
		 * Determines default values of the height and width to use for each
		 *  entry in the drop-down list, based on the maximum size of the label
		 *  text in the first numItems items in the data provider.
		 *
		 * @param count             <int> The number of items to check to determine the value.
		 * @return                  <Object> An Object containing two properties: width and height.
		 */
		protected override function calculatePreferredSizeFromData(count:int):Object;
		/**
		 * Hides the drop-down list.
		 *
		 * @param trigger           <Event (default = null)> 
		 */
		public function close(trigger:Event = null):void;
		/**
		 * Returns a string representing the item parameter.
		 *
		 * @param item              <Object> 
		 */
		public function itemToLabel(item:Object):String;
		/**
		 * Makes sure the control is at least 40 pixels wide,
		 *  and tall enough to fit one line of text
		 *  in the TextInput portion of the control but at least
		 *  22 pixels high.
		 */
		protected override function measure():void;
		/**
		 * Displays the drop-down list.
		 */
		public function open():void;
	}
}
