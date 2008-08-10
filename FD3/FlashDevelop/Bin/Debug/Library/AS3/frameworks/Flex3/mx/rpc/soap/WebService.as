/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.soap {
	public dynamic  class WebService extends AbstractWebService {
		/**
		 * The location of the WSDL document for this WebService. If you use a
		 *  relative URL, make sure that the rootURL has been specified
		 *  or that you created the WebService in MXML.
		 */
		public function get wsdl():String;
		public function set wsdl(value:String):void;
		/**
		 * Creates a new WebService.  The destination, if specified, should match
		 *  an entry in services-config.xml.  If unspecified, the WebService uses
		 *  the DefaultHTTP destination. The rootURL is required if you
		 *  intend to use a relative URL find the WSDL document for this WebService.
		 *
		 * @param destination       <String (default = null)> 
		 * @param rootURL           <String (default = null)> 
		 */
		public function WebService(destination:String = null, rootURL:String = null);
		/**
		 * Returns a Boolean value that indicates whether the WebService ready to
		 *  load a WSDL (does it have a valid destination or wsdl specified).
		 */
		public function canLoadWSDL():Boolean;
		/**
		 * Returns an Operation of the given name. If the Operation wasn't
		 *  created beforehand, a new mx.rpc.soap.Operation is created
		 *  during this call. Operations are usually accessible by simply naming
		 *  them after the service variable (myService.someOperation),
		 *  but if your Operation name happens to match a defined method on the
		 *  service (like setCredentials), you can use this method to
		 *  get the Operation instead.
		 *
		 * @param name              <String> Name of the Operation.
		 * @return                  <AbstractOperation> Operation that executes for this name.
		 */
		public override function getOperation(name:String):AbstractOperation;
		/**
		 * @param operation         <Operation> 
		 */
		protected function initializeOperation(operation:Operation):void;
		/**
		 * Instructs the WebService to download the WSDL document.  The WebService
		 *  calls this method automatically WebService when specified in the
		 *  WebService MXML tag, but it must be called manually if you create the
		 *  WebService object in ActionScript after you have specified the
		 *  destination or wsdl property value.
		 *
		 * @param uri               <String (default = null)> If the wsdl hasn't been specified previously, it may be
		 *                            specified here.
		 */
		public function loadWSDL(uri:String = null):void;
		/**
		 * Represents an instance of WebService as a String, describing
		 *  important properties such as the destination id and the set of
		 *  channels assigned.
		 */
		public function toString():String;
		/**
		 */
		public static const DEFAULT_DESTINATION_HTTP:String = "DefaultHTTP";
		/**
		 */
		public static const DEFAULT_DESTINATION_HTTPS:String = "DefaultHTTPS";
	}
}
