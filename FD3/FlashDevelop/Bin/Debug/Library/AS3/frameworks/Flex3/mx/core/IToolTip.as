/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	public interface IToolTip extends IUIComponent, IFlexDisplayObject, IBitmapDrawable,IEventDispatcher {
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
