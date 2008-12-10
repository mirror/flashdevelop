package mx.controls.menuClasses
{
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	import mx.controls.Menu;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListData;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.FlexVersion;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;

	/**
	 *  Dispatched when the <code>data</code> property changes. * *  <p>When you use a component as an item renderer, *  the <code>data</code> property contains the data to display. *  You can listen for this event and update the component *  when the <code>data</code> property changes.</p> * *  @eventType mx.events.FlexEvent.DATA_CHANGE
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 
	/**
	 *  Text color of the menu item label. *   *  @default 0x0B333C
	 */
	[Style(name="color", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Color of the menu item if it is disabled. *   *  @default 0xAAB3B3
	 */
	[Style(name="disabledColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The MenuItemRenderer class defines the default item renderer *  for menu items in any menu control. *  *  By default, the item renderer draws the text associated *  with each menu item, the separator characters, and icons. * *  <p>You can override the default item renderer *  by creating a custom item renderer.</p> * *  @see mx.controls.Menu *  @see mx.controls.MenuBar *  @see mx.core.IDataRenderer *  @see mx.controls.listClasses.IDropInListItemRenderer
	 */
	public class MenuItemRenderer extends UIComponent implements IDataRenderer
	{
		/**
		 *  The internal IFlexDisplayObject that displays the branch icon	 *  in this renderer.	 *  	 *  @default null
		 */
		protected var branchIcon : IFlexDisplayObject;
		/**
		 *  @private	 *  Storage for the data property.
		 */
		private var _data : Object;
		/**
		 *  @private	 *  Storage for the icon property.
		 */
		private var _icon : IFlexDisplayObject;
		/**
		 *  The internal UITextField that displays the text in this renderer.	 * 	 *  @default null
		 */
		protected var label : IUITextField;
		/**
		 *  @private	 *  Storage for the listData property.
		 */
		private var _listData : ListData;
		/**
		 *  @private	 *  Storage for the menu property.
		 */
		private var _menu : Menu;
		/**
		 *  The internal IFlexDisplayObject that displays the separator icon in this renderer	 *  	 *  @default null
		 */
		protected var separatorIcon : IFlexDisplayObject;
		/**
		 *  The internal IFlexDisplayObject that displays the type icon in this renderer for	 *  check and radio buttons.	 *  	 *  @default null
		 */
		protected var typeIcon : IFlexDisplayObject;

		/**
		 *  @private     *  The baselinePosition of a MenuItemRenderer is calculated     *  for its label.
		 */
		public function get baselinePosition () : Number;
		/**
		 *  The implementation of the <code>data</code> property	 *  as defined by the IDataRenderer interface.	 *	 *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  @private
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  The internal IFlexDisplayObject that displays the icon in this renderer.	 *  	 *  @default null
		 */
		protected function get icon () : IFlexDisplayObject;
		/**
		 *  @private
		 */
		protected function set icon (value:IFlexDisplayObject) : void;
		/**
		 *  The implementation of the <code>listData</code> property	 *  as defined by the IDropInListItemRenderer interface.	 *	 *  @see mx.controls.listClasses.IDropInListItemRenderer
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;
		/**
		 *  Contains a reference to the associated Menu control.	 * 	 *  @default null
		 */
		public function get menu () : Menu;
		/**
		 *  @private
		 */
		public function set menu (value:Menu) : void;
		/**
		 *  The width of the icon
		 */
		public function get measuredIconWidth () : Number;
		/**
		 *  The width of the type icon (radio/check)
		 */
		public function get measuredTypeIconWidth () : Number;
		/**
		 *  The width of the branch icon
		 */
		public function get measuredBranchIconWidth () : Number;

		/**
		 *  Constructor.
		 */
		public function MenuItemRenderer ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private     *  Creates the title text field and adds it as a child of this component.     *      *  @param childIndex The index of where to add the child.	 *  If -1, the text field is appended to the end of the list.
		 */
		function createLabel (childIndex:int) : void;
		/**
		 *  @private     *  Removes the title text field from this component.
		 */
		function removeLabel () : void;
		/**
		 *  @private
		 */
		function getLabel () : IUITextField;
	}
}
