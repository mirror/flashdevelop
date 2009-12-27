package mx.controls.listClasses
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IToolTip;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.InterManagerRequest;
	import mx.events.ToolTipEvent;
	import mx.managers.ISystemManager;

	/**
	 *  Dispatched when the <code>data</code> property changes.
 *
 *  <p>When you use a component as an item renderer,
 *  the <code>data</code> property contains the data to display.
 *  You can listen for this event and update the component
 *  when the <code>data</code> property changes.</p>
 * 
 *  @eventType mx.events.FlexEvent.DATA_CHANGE
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 

	/**
	 *  Text color of a component label.
 *  @default 0x0B333C
	 */
	[Style(name="color", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Text color of the component if it is disabled.
 *  
 *  @default 0xAAB3B3
	 */
	[Style(name="disabledColor", type="uint", format="Color", inherit="yes")] 

include "../../core/Version.as"
	/**
	 *  The ListItemRenderer class defines the default item renderer
 *  for a List control. 
 *  By default, the item renderer draws the text associated
 *  with each item in the list, and an optional icon.
 *
 *  <p>You can override the default item renderer
 *  by creating a custom item renderer.</p>
 *
 *  @see mx.controls.List
 *  @see mx.core.IDataRenderer
 *  @see mx.controls.listClasses.IDropInListItemRenderer
	 */
	public class ListItemRenderer extends UIComponent implements IDataRenderer
	{
		/**
		 *  @private
		 */
		private var listOwner : ListBase;
		/**
		 *  @private
     *  Storage for the data property.
		 */
		private var _data : Object;
		/**
		 *  The internal IFlexDisplayObject that displays the icon in this renderer.
		 */
		protected var icon : IFlexDisplayObject;
		/**
		 *  The internal UITextField that displays the text in this renderer.
		 */
		protected var label : IUITextField;
		/**
		 *  @private
     *  Storage for the listData property.
		 */
		private var _listData : ListData;

		/**
		 *  @private
     *  The baselinePosition of a ListItemRenderer is calculated
     *  for its label.
		 */
		public function get baselinePosition () : Number;

		/**
		 *  The implementation of the <code>data</code> property
     *  as defined by the IDataRenderer interface.
     *  When set, it stores the value and invalidates the component 
     *  to trigger a relayout of the component.
     *
     *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;

		/**
		 *  @inheritDoc
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;

		/**
		 *  The implementation of the <code>listData</code> property
     *  as defined by the IDropInListItemRenderer interface.
     *
     *  @see mx.controls.listClasses.IDropInListItemRenderer
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;

		/**
		 *  Constructor.
		 */
		public function ListItemRenderer ();

		/**
		 *  @private
		 */
		protected function createChildren () : void;

		/**
		 *  @private
     *  Apply the data and listData.
     *  Create an instance of the icon if specified,
     *  and set the text into the text field.
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
		 *  Positions the ToolTip object.
     *
     *  @param The Event object.
		 */
		protected function toolTipShowHandler (event:ToolTipEvent) : void;

		/**
		 *  @private
		 */
		function getLabel () : IUITextField;
	}
}
