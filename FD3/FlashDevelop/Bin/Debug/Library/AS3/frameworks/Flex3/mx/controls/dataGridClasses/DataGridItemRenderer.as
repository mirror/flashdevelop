package mx.controls.dataGridClasses
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedSuperclassName;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import mx.controls.DataGrid;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.IDataRenderer;
	import mx.core.IFlexDisplayObject;
	import mx.core.IToolTip;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.InterManagerRequest;
	import mx.events.ToolTipEvent;
	import mx.managers.ILayoutManagerClient;
	import mx.managers.ISystemManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	import mx.styles.StyleProtoChain;

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

include "../../core/Version.as"
	/**
	 *  The DataGridItemRenderer class defines the default item renderer for a DataGrid control. 
 *  By default, the item renderer 
 *  draws the text associated with each item in the grid.
 *
 *  <p>You can override the default item renderer by creating a custom item renderer.</p>
 *
 *  @see mx.controls.DataGrid
 *  @see mx.core.IDataRenderer
 *  @see mx.controls.listClasses.IDropInListItemRenderer
	 */
	public class DataGridItemRenderer extends UITextField implements IDataRenderer
	{
		/**
		 *  @private
		 */
		private var invalidatePropertiesFlag : Boolean;
		/**
		 *  @private
		 */
		private var invalidateSizeFlag : Boolean;
		/**
		 *  @private
		 */
		private var _data : Object;
		/**
		 *  @private
		 */
		private var _listData : DataGridListData;
		/**
		 *  @private
	 *  Storage for the styleDeclaration property.
		 */
		private var _styleDeclaration : CSSStyleDeclaration;

		/**
		 *  @private
		 */
		public function set nestLevel (value:int) : void;

		/**
		 *  The implementation of the <code>data</code> property as 
	 *  defined by the IDataRenderer interface.
	 *
	 *  The value is ignored.  Only the listData property is used.
	 *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;

		/**
		 *  The implementation of the <code>listData</code> property as 
	 *  defined by the IDropInListItemRenderer interface.
	 *  The text of the renderer is set to the <code>label</code>
	 *  property of the listData.
	 *
	 *  @see mx.controls.listClasses.IDropInListItemRenderer
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;

		/**
		 *  Storage for the inline inheriting styles on this object.
	 *  This CSSStyleDeclaration is created the first time that setStyle()
	 *  is called on this component to set an inheriting style.
		 */
		public function get styleDeclaration () : CSSStyleDeclaration;
		/**
		 *  @private
		 */
		public function set styleDeclaration (value:CSSStyleDeclaration) : void;

		/**
		 *  Constructor.
		 */
		public function DataGridItemRenderer ();

		/**
		 *  @private
		 */
		public function initialize () : void;

		/**
		 *  @private
		 */
		public function validateNow () : void;

		/**
		 *  @copy mx.core.UIComponent#getStyle()
		 */
		public function getStyle (styleProp:String) : *;

		/**
		 *  @copy mx.core.UIComponent#setStyle()
		 */
		public function setStyle (styleProp:String, newValue:*) : void;

		/**
		 *  If Flex calls the <code>LayoutManager.invalidateProperties()</code> 
	 *  method on this ILayoutManagerClient, then
	 *  this function is called when it's time to commit property values.
		 */
		public function validateProperties () : void;

		/**
		 *  If Flex calls the <code>LayoutManager.invalidateSize()</code>
	 *  method on this ILayoutManagerClient, then
	 *  this function is called when it's time to do measurements.
	 *
	 *  @param recursive If <code>true</code>, call this method
	 *  on the object's children.
		 */
		public function validateSize (recursive:Boolean = false) : void;

		/**
		 *  If Flex calls <code>LayoutManager.invalidateDisplayList()</code> 
	 *  method on this ILayoutManagerClient, then
	 *  this function is called when it's time to update the display list.
		 */
		public function validateDisplayList () : void;

		/**
		 *  @copy mx.core.UIComponent#clearStyle()
		 */
		public function clearStyle (styleProp:String) : void;

		/**
		 *  @inheritDoc
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;

		/**
		 *  Sets up the <code>inheritingStyles</code> 
	 *  and <code>nonInheritingStyles</code> objects
	 *  and their proto chains so that the <code>getStyle()</code> method can work.
		 */
		public function initProtoChain () : void;

		/**
		 *  @inheritDoc
		 */
		public function regenerateStyleCache (recursive:Boolean) : void;

		/**
		 *  @inheritDoc
		 */
		public function registerEffects (effects:Array) : void;

		/**
		 *  @inheritDoc
		 */
		public function getClassStyleDeclarations () : Array;

		/**
		 *  The event handler to position the tooltip.
	 *
	 *  @param event The event object.
		 */
		protected function toolTipShowHandler (event:ToolTipEvent) : void;
	}
}
