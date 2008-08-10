/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.http.mxml {
	import mx.rpc.http.HTTPService;
	import mx.rpc.mxml.IMXMLSupport;
	import mx.core.IMXMLObject;
	public class HTTPService extends HTTPService implements IMXMLSupport, IMXMLObject {
		/**
		 * Value that indicates how to handle multiple calls to the same service. The default
		 *  value is multiple. The following values are permitted:
		 *  multiple Existing requests are not cancelled, and the developer is
		 *  responsible for ensuring the consistency of returned data by carefully
		 *  managing the event stream. This is the default value.
		 *  single Only a single request at a time is allowed on the operation;
		 *  multiple requests generate a fault.
		 *  last Making a request cancels any existing request.
		 */
		public function get concurrency():String;
		public function set concurrency(value:String):void;
		/**
		 * If true, a busy cursor is displayed while a service is executing. The default
		 *  value is false.
		 */
		public function get showBusyCursor():Boolean;
		public function set showBusyCursor(value:Boolean):void;
		/**
		 * Creates a new HTTPService. This constructor is usually called by the generated code of an MXML document.
		 *  You usually use the mx.rpc.http.HTTPService class to create an HTTPService in ActionScript.
		 *
		 * @param rootURL           <String (default = null)> 
		 * @param destination       <String (default = null)> 
		 */
		public function HTTPService(rootURL:String = null, destination:String = null);
		/**
		 * Cancels the most recent HTTPService request.
		 *
		 * @param id                <String (default = null)> 
		 */
		public override function cancel(id:String = null):AsyncToken;
		/**
		 * If you create this class in ActionScript and want it to function with validation, you must
		 *  call this method and pass in the MXML document and the HTTPService's id.
		 *
		 * @param document          <Object> 
		 * @param id                <String> 
		 */
		public function initialized(document:Object, id:String):void;
		/**
		 * Executes an HTTPService request. The parameters are optional, but if specified should
		 *  be an Object containing name-value pairs or an XML object depending on the contentType.
		 *
		 * @param parameters        <Object (default = null)> 
		 * @return                  <AsyncToken> an AsyncToken.  It will be the same object available in the result
		 *                            or fault event's token property.
		 */
		public override function send(parameters:Object = null):AsyncToken;
	}
}
