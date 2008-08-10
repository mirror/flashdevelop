/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import flash.geom.Rectangle;
	public interface IToolTip extends <a href="../../mx/core/IUIComponent.html">IUIComponent</a> , <a href="../../mx/core/IFlexDisplayObject.html">IFlexDisplayObject</a> , <a href="../../flash/display/IBitmapDrawable.html">IBitmapDrawable</a> , <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * A Rectangle that specifies the size and position
		 *  of the base drawing surface for this tooltip.
		 */
		public function get screen():Rectangle;
		/**
		 * The text that appears in the tooltip.
		 */
		public function get text():String;
		public function set text(value:String):void;
	}
}
