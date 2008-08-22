/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	import mx.core.IFlexDisplayObject;
	public interface IToolTipManagerClient extends IFlexDisplayObject, IBitmapDrawable, IEventDispatcher {
		/**
		 * The text of this component's tooltip.
		 */
		public function get toolTip():String;
		public function set toolTip(value:String):void;
	}
}
