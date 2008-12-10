package mx.rpc.soap
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.DirectHTTPChannel;
	import mx.messaging.config.LoaderConfig;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncRequest;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.WSDLLoadEvent;
	import mx.rpc.http.HTTPService;
	import mx.rpc.wsdl.WSDL;
	import mx.rpc.wsdl.WSDLLoader;
	import mx.rpc.wsdl.WSDLOperation;
	import mx.rpc.wsdl.WSDLPort;
	import mx.utils.URLUtil;
	import mx.utils.XMLUtil;

	/**
	 * The <code>LoadEvent.LOAD</code> is dispatched when the WSDL * document has loaded successfully. * * @eventType mx.rpc.soap.LoadEvent.LOAD
	 */
	[Event(name="load", type="mx.rpc.soap.LoadEvent")] 

	/**
	 * The WebService class provides access to SOAP-based web services on remote * servers.
	 */
	public dynamic class WebService extends AbstractWebService
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		private var _wsdlURL : String;
		private var _log : ILogger;
		private var _wsdlFault : Boolean;
		private var _wsdl : mx.rpc.wsdl.WSDL;
		private var _wsdlLoader : WSDLLoader;
		public static const DEFAULT_DESTINATION_HTTP : String = "DefaultHTTP";
		public static const DEFAULT_DESTINATION_HTTPS : String = "DefaultHTTPS";

		function get wsdlFault () : Boolean;
		/**
		 * The location of the WSDL document for this WebService. If you use a     * relative URL, make sure that the <code>rootURL</code> has been specified     * or that you created the WebService in MXML.
		 */
		public function get wsdl () : String;
		public function set wsdl (w:String) : void;

		/**
		 * Creates a new WebService.  The destination, if specified, should match     * an entry in services-config.xml.  If unspecified, the WebService uses     * the DefaultHTTP destination. The <code>rootURL</code> is required if you     * intend to use a relative URL to find the WSDL document for this WebService.     *     * @param destination The destination of the WebService, should match a destination      * name in the services-config.xml file.     *     * @param rootURL The root URL of the WebService.
		 */
		public function WebService (destination:String = null, rootURL:String = null);
		/**
		 * Returns a Boolean value that indicates whether the WebService is ready to     * load a WSDL (does it have a valid destination or wsdl specified).     *     * @return Returns <code>true</code> if the WebService is ready to load a WSDL;     * otherwise, returns <code>false</code>.
		 */
		public function canLoadWSDL () : Boolean;
		/**
		 * Returns an Operation of the given name. If the Operation wasn't     * created beforehand, a new <code>mx.rpc.soap.Operation</code> is created     * during this call. Operations are usually accessible by simply naming     * them after the service variable (<code>myService.someOperation</code>),     * but if your Operation name happens to match a defined method on the     * service (like <code>setCredentials</code>), you can use this method to     * get the Operation instead.     * @param name Name of the Operation.     * @return Operation that executes for this name.
		 */
		public function getOperation (name:String) : mx.rpc.AbstractOperation;
		/**
		 * Instructs the WebService to download the WSDL document.  The WebService     * calls this method automatically WebService when specified in the     * WebService MXML tag, but it must be called manually if you create the     * WebService object in ActionScript after you have specified the     * <code>destination</code> or <code>wsdl</code> property value.     *     * @param uri If the wsdl hasn't been specified previously, it may be     * specified here.
		 */
		public function loadWSDL (uri:String = null) : void;
		/**
		 * Represents an instance of WebService as a String, describing     * important properties such as the destination id and the set of     * channels assigned.     *     * @return Returns a String representation of the WebService.
		 */
		public function toString () : String;
		function wsdlFaultHandler (event:FaultEvent) : void;
		function wsdlHandler (event:WSDLLoadEvent) : void;
		/**
		 * @private
		 */
		function deriveHTTPService () : HTTPService;
		/**
		 * Initializes a new Operation.    *    * @param operation The Operation to initialize.
		 */
		protected function initializeOperation (operation:Operation) : void;
		private function dispatchFault (faultCode:String, faultString:String, faultDetail:String = null) : void;
	}
}
