/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.advancedDataGridClasses {
	import mx.core.UITextField;
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.managers.ILayoutManagerClient;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.styles.IStyleClient;
	import mx.controls.listClasses.BaseListData;
	import mx.styles.CSSStyleDeclaration;
	import mx.events.ToolTipEvent;
	public class AdvancedDataGridItemRenderer extends UITextField implements IDataRenderer, IDropInListItemRenderer, ILayoutManagerClient, IListItemRenderer, IStyleClient {
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
		 *  property of this property.
		 */
		public function get listData():BaseListData;
		public function set listData(value:BaseListData):void;
		/**
		 * Storage for the inline inheriting styles on this object.
		 *  This CSSStyleDeclaration is created the first time that
		 *  the setStyle() method
		 *  is called on this component to set an inheriting style.
		 */
		public function get styleDeclaration():CSSStyleDeclaration;
		public function set styleDeclaration(value:CSSStyleDeclaration):void;
		/**
		 * Constructor.
		 */
		public function AdvancedDataGridItemRenderer();
		/**
		 * Deletes a style property from this component instance.
		 *
		 * @param styleProp         <String> The name of the style property.
		 */
		public function clearStyle(styleProp:String):void;
		/**
		 * Finds the type selectors for this UIComponent instance.
		 *  The algorithm walks up the superclass chain.
		 *  For example, suppose that class MyButton extends Button.
		 *  A MyButton instance will first look for a MyButton type selector
		 *  then, it will look for a Button type selector.
		 *  then, it will look for a UIComponent type selector.
		 *  (The superclass chain is considered to stop at UIComponent, not Object.)
		 *
		 * @return                  <Array> An Array of type selectors for this UIComponent instance.
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
		 * Propagates style changes to the children.
		 *  You typically never need to call this method.
		 *
		 * @param styleProp         <String> String specifying the name of the style property.
		 * @param recursive         <Boolean> Recursivly notify all children of this component.
		 */
		public function notifyStyleChangeInChildren(styleProp:String, recursive:Boolean):void;
		/**
		 * Builds or rebuilds the CSS style cache for this component
		 *  and, if the recursive parameter is true,
		 *  for all descendants of this component as well.
		 *
		 * @param recursive         <Boolean> Recursivly regenerates the style cache for
		 *                            all children of this component.
		 */
		public function regenerateStyleCache(recursive:Boolean):void;
		/**
		 * For each effect event, registers the EffectManager
		 *  as one of the event listeners.
		 *  You typically never need to call this method.
		 *
		 * @param effects           <Array> The names of the effect events.
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
		 *  method on this ILayoutManagerClient instance,
		 *  this function is called when it's time to update the display list.
		 */
		public function validateDisplayList():void;
		/**
		 * If Flex calls the LayoutManager.invalidateProperties()
		 *  method on this ILayoutManagerClient,
		 *  this function is called when it's time to commit property values.
		 */
		public function validateProperties():void;
		/**
		 * If Flex calls the LayoutManager.invalidateSize()
		 *  method on this ILayoutManagerClient,
		 *  this function is called when it's time to do measurements.
		 *
		 * @param recursive         <Boolean (default = false)> If true, call this method
		 *                            on the object's children.
		 */
		public function validateSize(recursive:Boolean = false):void;
	}
}
