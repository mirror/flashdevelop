/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.remoting.mxml {
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.mxml.IMXMLSupport;
	import mx.core.IMXMLObject;
	public dynamic  class RemoteObject extends RemoteObject implements IMXMLSupport, IMXMLObject {
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
		 * This property allows the developer to quickly specify an endpoint for a RemoteObject
		 *  destination without referring to a services configuration file at compile time or programmatically creating
		 *  a ChannelSet. It also overrides an existing ChannelSet if one has been set for the RemoteObject service.
		 */
		public function get endpoint():String;
		public function set endpoint(value:String):void;
		/**
		 * If true, a busy cursor is displayed while a service is executing. The default
		 *  value is false.
		 */
		public function get showBusyCursor():Boolean;
		public function set showBusyCursor(value:Boolean):void;
		/**
		 * Create a new RemoteObject.
		 *
		 * @param destination       <String (default = null)> the destination of the RemoteObject, should match a destination name
		 *                            in the services-config.xml file.
		 */
		public function RemoteObject(destination:String = null);
		/**
		 * Returns an Operation of the given name. If the Operation wasn't
		 *  created beforehand, a new mx.rpc.remoting.mxml.Operation is
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
		 * Called automatically by the MXML compiler if the RemoteObject is set up using a tag.  If you create
		 *  the RemoteObject through ActionScript you may want to call this method yourself as it is useful for
		 *  validating any arguments.
		 *
		 * @param document          <Object> the MXML document on which this RemoteObject lives
		 * @param id                <String> the id of this RemoteObject within the document
		 */
		public function initialized(document:Object, id:String):void;
	}
}
