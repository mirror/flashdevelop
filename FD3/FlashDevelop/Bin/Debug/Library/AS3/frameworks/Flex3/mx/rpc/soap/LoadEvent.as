/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.soap {
	import flash.xml.XMLDocument;
	public class LoadEvent {
		/**
		 * Deprecated: Please Use xml
		 */
		public function get document():XMLDocument;
		/**
		 * Creates a new WSDLLoadEvent.
		 *
		 * @param type              <String> The event type; indicates the action that triggered the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = true)> Specifies whether the behavior associated with the event can be prevented.
		 * @param wsdl              <WSDL (default = null)> Object that contains the WSDL document.
		 * @param location          <String (default = null)> URL of the WSDL document.
		 */
		public function LoadEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, wsdl:WSDL = null, location:String = null);
		/**
		 * Returns a copy of this LoadEvent.
		 */
		public override function clone():Event;
		/**
		 * Returns a String representation of this LoadEvent.
		 */
		public override function toString():String;
		/**
		 * The LOAD event type.
		 */
		public static const LOAD:String = "load";
	}
}
