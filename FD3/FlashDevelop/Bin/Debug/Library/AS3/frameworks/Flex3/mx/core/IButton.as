/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	public interface IButton extends IUIComponent, IFlexDisplayObject, IBitmapDrawable, IEventDispatcher {
		/**
		 * Draws a thick border around the Button control
		 *  when the control is in its up state if emphasized
		 *  is set to true.
		 */
		public function get emphasized():Boolean;
		public function set emphasized(value:Boolean):void;
		/**
		 * Queues a function to be called later.
		 *
		 * @param method            <Function> Reference to a method to be executed later.
		 * @param args              <Array (default = null)> Array of Objects that represent the arguments to pass to the method.
		 */
		public function callLater(method:Function, args:Array = null):void;
	}
}
