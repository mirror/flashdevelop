/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.events {
	import flash.events.Event;
	public class TextSelectionEvent extends Event {
		/**
		 * Index at which selection starts.
		 */
		public var beginIndex:int;
		/**
		 * Index at which selection ends.
		 */
		public var endIndex:int;
		/**
		 * Constructor.
		 *
		 * @param type              <String (default = "textSelectionChange")> 
		 * @param bubbles           <Boolean (default = false)> 
		 * @param cancelable        <Boolean (default = false)> 
		 * @param beginIndex        <int (default = -1)> 
		 * @param endIndex          <int (default = -1)> 
		 */
		public function TextSelectionEvent(type:String = "textSelectionChange", bubbles:Boolean = false, cancelable:Boolean = false, beginIndex:int = -1, endIndex:int = -1);
		/**
		 * The TextSelectionEvent.TEXT_SELECTION_CHANGE constant defines the value of the
		 *  type property of the event object for a textSelectionChange event.
		 */
		public static const TEXT_SELECTION_CHANGE:String = "textSelectionChange";
	}
}
