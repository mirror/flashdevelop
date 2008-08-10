/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.dataGridClasses {
	import mx.core.UITextField;
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.managers.ILayoutManagerClient;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.styles.IStyleClient;
	import mx.controls.listClasses.BaseListData;
	import mx.styles.CSSStyleDeclaration;
	import mx.events.ToolTipEvent;
	public class DataGridItemRenderer extends UITextField implements IDataRenderer, IDropInListItemRenderer, ILayoutManagerClient, IListItemRenderer, IStyleClient {
		/**
		 * The implementation of the data property as
		 *  defined by the IDataRenderer interface.
		 *  The value is ignored.  Only the listData property is used.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * The implementation of the listData property as
		 *  defined by the IDropInListItemRenderer interface.
		 *  The text of the renderer is set to the label
		 *  property of the listData.
		 */
		public function get listData():BaseListData;
		public function set listData(value:BaseListData):void;
		/**
		 * Storage for the inline inheriting styles on this object.
		 *  This CSSStyleDeclaration is created the first time that setStyle()
		 *  is called on this component to set an inheriting style.
		 */
		public function get styleDeclaration():CSSStyleDeclaration;
		public function set styleDeclaration(value:CSSStyleDeclaration):void;
		/**
		 * Constructor.
		 */
		public function DataGridItemRenderer();
		/**
		 * Deletes a style property from this component instance.
		 *
		 * @param styleProp         <String> The name of the style property.
		 */
		public function clearStyle(styleProp:String):void;
		/**
		 * Returns an Array of CSSStyleDeclaration objects for the type selector
		 *  that applies to this component, or null if none exist.
		 *
		 * @return                  <Array> Array of CSSStyleDeclaration objects.
		 */
		public function getClassStyleDeclarations():Array;
		/**
		 * Gets a style property that has been set anywhere in this
		 *  component's style lookup chain.
		 *
		 * @param styleProp         <String> Name of the style property.
		 * @return                  <*> Style value.
		 */
		public override function getStyle(styleProp:String):*;
		/**
		 * Sets up the inheritingStyles
		 *  and nonInheritingStyles objects
		 *  and their proto chains so that the getStyle() method can work.
		 */
		public function initProtoChain():void;
		/**
		 * Propagates style changes to the children of this component.
		 *
		 * @param styleProp         <String> Name of the style property.
		 * @param recursive         <Boolean> Whether to propagate the style changes to the children's children.
		 */
		public function notifyStyleChangeInChildren(styleProp:String, recursive:Boolean):void;
		/**
		 * Sets up the internal style cache values so that the getStyle()
		 *  method functions.
		 *  If this object already has children, then reinitialize the children's
		 *  style caches.
		 *
		 * @param recursive         <Boolean> Regenerate the proto chains of the children.
		 */
		public function regenerateStyleCache(recursive:Boolean):void;
		/**
		 * Registers the EffectManager as one of the event listeners for each effect event.
		 *
		 * @param effects           <Array> An Array of Strings of effect names.
		 */
		public function registerEffects(effects:Array):void;
		/**
		 * Sets a style property on this component instance.
		 *
		 * @param styleProp         <String> Name of the style property.
		 * @param newValue          <*> New value for the style.
		 */
		public override function setStyle(styleProp:String, newValue:*):void;
		/**
		 * The event handler to position the tooltip.
		 *
		 * @param event             <ToolTipEvent> The event object.
		 */
		protected function toolTipShowHandler(event:ToolTipEvent):void;
		/**
		 * If Flex calls LayoutManager.invalidateDisplayList()
		 *  method on this ILayoutManagerClient, then
		 *  this function is called when it's time to update the display list.
		 */
		public function validateDisplayList():void;
		/**
		 * If Flex calls the LayoutManager.invalidateProperties()
		 *  method on this ILayoutManagerClient, then
		 *  this function is called when it's time to commit property values.
		 */
		public function validateProperties():void;
		/**
		 * If Flex calls the LayoutManager.invalidateSize()
		 *  method on this ILayoutManagerClient, then
		 *  this function is called when it's time to do measurements.
		 *
		 * @param recursive         <Boolean (default = false)> If true, call this method
		 *                            on the object's children.
		 */
		public function validateSize(recursive:Boolean = false):void;
	}
}
