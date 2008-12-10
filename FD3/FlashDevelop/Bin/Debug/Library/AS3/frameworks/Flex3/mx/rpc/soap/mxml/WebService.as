package mx.rpc.soap.mxml
{
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.IEventDispatcher;
	import mx.core.IMXMLObject;
	import mx.core.mx_internal;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.mxml.Concurrency;
	import mx.rpc.mxml.IMXMLSupport;
	import mx.rpc.soap.mxml.Operation;
	import mx.rpc.soap.WebService;

	/**
	 * The &lt;mx:WebService&gt; tag gives you access to the operations of SOAP-compliant * web services. * @mxml  * <p> * The &lt;mx:WebService&gt; tag accepts the following tag attributes: * </p> * <pre> * &lt;mx:WebService *   <b>Properties</b> *   concurrency="multiple|single|last" *   destination="<i>No default.</i>" *   id="<i>No default.</i>" *   serviceName="<i>No default.</i>" *   showBusyCursor="false|true" *   makeObjectsBindable="false|true" *   useProxy="false|true" *   wsdl="<i>No default.</i>" * *   <b>Events</b> *   fault="<i>No default.</i>" *   result="<i>No default.</i>" * /&gt; * </pre> * </p> * <p> * An &lt;mx:WebService&gt; tag can have multiple &lt;mx:operation&gt; tags, which have the following tag attributes: * </p> * <pre> * &lt;mx:operation *   <b>Properties</b> *   concurrency="multiple|single|last" *   name=<i>No default, required.</i> *   resultFormat="object|xml|e4x" *   makeObjectsBindable="false|true" * *    *   <b>Events</b> *   fault=<i>No default.</i> *   result=<i>No default.</i> * /&gt; * </pre> * * An &lt;mx:Operation&gt; tag contains an &lt;mx:request&gt; tag.  * To specify an XML structure in an &lt;mx:request&gt; tag, you must set the value of the tag's * <code>format</code> attribute to <code>"xml"</code>. Otherwise, the body is converted into Objects. * *  @includeExample examples/WebServiceExample.mxml -noswf *
	 */
	public dynamic class WebService extends mx.rpc.soap.WebService implements IMXMLSupport
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		local var document : Object;
		local var id : String;
		private var _concurrency : String;
		private var _showBusyCursor : Boolean;

		/**
		 * Value that indicates how to handle multiple calls to the same service. The default     * value is multiple. The following values are permitted:     * <ul>     * <li>multiple Existing requests are not cancelled, and the developer is     * responsible for ensuring the consistency of returned data by carefully     * managing the event stream. This is the default.</li>     * <li>single Only a single request at a time is allowed on the operation;     * multiple requests generate a fault.</li>     * <li>last Making a request cancels any existing request.</li>     * </ul>
		 */
		public function get concurrency () : String;
		/**
		 *  @private
		 */
		public function set concurrency (c:String) : void;
		/**
		 * Deprecated, use the appropriate destination instead, or if using a url, use <code>DefaultHTTP</code> or <code>DefaultHTTPS</code>.     * The deprecated behavior will simply update the destination if the default is being used.
		 */
		public function set protocol (protocol:String) : void;
		public function get serviceName () : String;
		public function set serviceName (sn:String) : void;
		/**
		 * If <code>true</code>, a busy cursor is displayed while a service is executing. The default    * value is <code>false</code>.
		 */
		public function get showBusyCursor () : Boolean;
		public function set showBusyCursor (sbc:Boolean) : void;

		/**
		 * Creates a new WebService component.     *     * @param destination The destination of the WebService, which should     * match a destination name in the services-config.xml file. If     * unspecified, the WebService component uses the DefaultHTTP destination.
		 */
		public function WebService (destination:String = null);
		/**
		 * This handler is called after the document fires the creationComplete event so that     * if errors occur while loading the WSDL all components will be ready to handle the fault.     * @private
		 */
		public function creationComplete (event:Event) : void;
		/**
		 * If this event is an error or fault, and the event type does not     * have a listener, we notify the parent document.  If the          * parent document does not have a listener, then we throw     * a runtime exception.  However, this is an asynchronous runtime     * exception which is only exposed through the debug player.     * A listener should be defined.     *     * @private
		 */
		public function dispatchEvent (event:Event) : Boolean;
		/**
		 * Returns an Operation of the given name. If the Operation wasn't     * created beforehand, a new <code>mx.rpc.soap.mxml.Operation</code> is     * created during this call. Operations are usually accessible by simply     * naming them after the service variable     * (<code>myService.someOperation</code>), but if your Operation name     * happens to match a defined method on the service     * (like <code>setCredentials</code>), you can use this method to get the     * Operation instead.     * @param name Name of the Operation.     * @return Operation that executes for this name.
		 */
		public function getOperation (name:String) : AbstractOperation;
		/**
		 * Called automatically by the MXML compiler if the WebService is setup using a tag.  If you create     * the WebService through ActionScript you may want to call this method yourself as it is useful for     * validating any arguments.     *     * @param document the MXML document on which this WebService lives     * @param id the id of this WebService within the document
		 */
		public function initialized (document:Object, id:String) : void;
	}
}
