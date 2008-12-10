package mx.rpc.soap
{
	import flash.events.Event;
	import flash.xml.XMLDocument;
	import mx.rpc.events.WSDLLoadEvent;
	import mx.rpc.wsdl.WSDL;

	/**
	 * This event is dispatched when a WSDL XML document has loaded successfully.
	 */
	public class LoadEvent extends WSDLLoadEvent
	{
		/**
		 * The <code>LOAD</code> constant defines the value of the <code>type</code> property    * of the event object for a <code>load</code> event.    *    * <p>The properties of the event object have the following values:</p>    * <table class="innertable">    *     <tr><th>Property</th><th>Value</th></tr>    *     <tr><td><code>bubbles</code></td><td>false</td></tr>    *     <tr><td><code>cancelable</code></td><td>true</td></tr>    *     <tr><td><code>wsdl</code></td><td>WSDL object.</td></tr>    *     <tr><td><code>location</code></td><td>URI of the WSDL document</td></tr>    *  </table>    *    *  @eventType load
		 */
		public static const LOAD : String = "load";
		private var _document : XMLDocument;

		/**
		 * This getter is retained to provide legacy access to the loaded document     * as an instance of flash.xml.XMLDocument.
		 */
		public function get document () : XMLDocument;

		/**
		 * Creates a new WSDLLoadEvent.     * @param type The event type; indicates the action that triggered the event.     * @param bubbles Specifies whether the event can bubble up the display list hierarchy.     * @param cancelable Specifies whether the behavior associated with the event can be prevented.     * @param wsdl Object that contains the WSDL document.     * @param location URL of the WSDL document.
		 */
		public function LoadEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = true, wsdl:WSDL = null, location:String = null);
		/**
		 * Returns a copy of this LoadEvent.     *     * @return Returns a copy of this LoadEvent.
		 */
		public function clone () : Event;
		/**
		 * Returns a String representation of this LoadEvent.     *     * @return Returns a String representation of this LoadEvent.
		 */
		public function toString () : String;
		/**
		 * A helper method to create a new LoadEvent.     * @private
		 */
		public static function createEvent (wsdl:WSDL, location:String = null) : LoadEvent;
	}
}
