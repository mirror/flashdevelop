/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.soap.mxml {
	import mx.rpc.soap.WebService;
	import mx.rpc.mxml.IMXMLSupport;
	import mx.core.IMXMLObject;
	public dynamic  class WebService extends WebService implements IMXMLSupport, IMXMLObject {
		/**
		 * Value that indicates how to handle multiple calls to the same service. The default
		 *  value is multiple. The following values are permitted:
		 *  multiple Existing requests are not cancelled, and the developer is
		 *  responsible for ensuring the consistency of returned data by carefully
		 *  managing the event stream. This is the default.
		 *  single Only a single request at a time is allowed on the operation;
		 *  multiple requests generate a fault.
		 *  last Making a request cancels any existing request.
		 */
		public function get concurrency():String;
		public function set concurrency(value:String):void;
		/**
		 * Deprecated: Property protocol is deprecated. Please use an appropriate channel from your services configuration file (DefaultHTTP or DefaultHTTPS for instance); when useProxy is false set your URL to use the right protocol
		 */
		public var protocol:String;
		/**
		 * Deprecated: Please Use destination
		 */
		public function get serviceName():String;
		public function set serviceName(value:String):void;
		/**
		 * If true, a busy cursor is displayed while a service is executing. The default
		 *  value is false.
		 */
		public function get showBusyCursor():Boolean;
		public function set showBusyCursor(value:Boolean):void;
		/**
		 * Creates a new WebService component.
		 *
		 * @param destination       <String (default = null)> the destination of the WebService, should match a destination name in the services-config.xml file.
		 */
		public function WebService(destination:String = null);
		/**
		 * Returns an Operation of the given name. If the Operation wasn't
		 *  created beforehand, a new mx.rpc.soap.mxml.Operation is
		 *  created during this call. Operations are usually accessible by simply
		 *  naming them after the service variable
		 *  (myService.someOperation), but if your Operation name
		 *  happens to match a defined method on the service
		 *  (like setCredentials), you can use this method to get the
		 *  Operation instead.
		 *
		 * @param name              <String> Name of the Operation.
		 * @return                  <AbstractOperation> Operation that executes for this name.
		 */
		public override function getOperation(name:String):AbstractOperation;
		/**
		 * Called automatically by the MXML compiler if the WebService is setup using a tag.  If you create
		 *  the WebService through ActionScript you may want to call this method yourself as it is useful for
		 *  validating any arguments.
		 *
		 * @param document          <Object> the MXML document on which this WebService lives
		 * @param id                <String> the id of this WebService within the document
		 */
		public function initialized(document:Object, id:String):void;
	}
}
