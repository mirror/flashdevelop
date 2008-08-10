/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.menuClasses {
	import mx.controls.MenuBar;
	public interface IMenuBarItemRenderer extends <a href="../../../mx/core/IDataRenderer.html">IDataRenderer</a> , <a href="../../../mx/core/IUIComponent.html">IUIComponent</a> , <a href="../../../mx/styles/ISimpleStyleClient.html">ISimpleStyleClient</a> , <a href="../../../mx/controls/listClasses/IListItemRenderer.html">IListItemRenderer</a> , <a href="../../../flash/events/IEventDispatcher.html">IEventDispatcher</a> , <a href="../../../mx/core/IFlexDisplayObject.html">IFlexDisplayObject</a> , <a href="../../../mx/managers/ILayoutManagerClient.html">ILayoutManagerClient</a> , <a href="../../../mx/core/IFlexDisplayObject.html">IFlexDisplayObject</a> , <a href="../../../flash/display/IBitmapDrawable.html">IBitmapDrawable</a>  {
		/**
		 * Contains a reference to the item renderer's MenuBar control.
		 */
		public function get menuBar():MenuBar;
		public function set menuBar(value:MenuBar):void;
		/**
		 * Contains the index of this item renderer relative to
		 *  other item renderers in the MenuBar control.
		 *  The index of the first item renderer,
		 *  the left most renderer, is 0 and increases by 1 as you
		 *  move to the right in the MenuBar control.
		 */
		public function get menuBarItemIndex():int;
		public function set menuBarItemIndex(value:int):void;
		/**
		 * Contains the current state of this item renderer.
		 *  The possible values are "itemUpSkin",
		 *  "itemDownSkin", and "itemOverSkin".
		 */
		public function get menuBarItemState():String;
		public function set menuBarItemState(value:String):void;
	}
}
