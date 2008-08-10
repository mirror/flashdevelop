/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc {
	public class AbstractOperation extends AbstractInvoker {
		/**
		 * The arguments to pass to the Operation when it is invoked. If you call
		 *  the send() method with no parameters, an array based on
		 *  this object is sent. If you call the send() method with
		 *  parameters (or call the function directly on the service) those
		 *  parameters are used instead of whatever is stored in this property.
		 *  For RemoteObject Operations the associated argumentNames array determines
		 *  the order of the arguments passed.
		 */
		public var arguments:Object;
		/**
		 * The name of this Operation. This is how the Operation is accessed off the
		 *  service. It can only be set once.
		 */
		public function get name():String;
		public function set name(value:String):void;
		/**
		 * Provides convenient access to the service on which the Operation
		 *  is being invoked. Note that the service cannot be changed after
		 *  the Operation is constructed.
		 */
		public function get service():AbstractService;
		/**
		 * Creates a new Operation. This is usually done directly by the MXML
		 *  compiler or automatically by the service when an unknown Operation has
		 *  been accessed. It is not recommended that a developer use this
		 *  constructor directly.
		 *
		 * @param service           <AbstractService (default = null)> 
		 * @param name              <String (default = null)> 
		 */
		public function AbstractOperation(service:AbstractService = null, name:String = null);
		/**
		 * Executes the method. Any arguments passed in are passed along as part of
		 *  the method call. If there are no arguments passed, the arguments object
		 *  is used as the source of parameters.
		 *
		 * @return                  <AsyncToken> AsyncToken Call using the asynchronous completion token pattern.
		 *                            The same object is available in the result and
		 *                            fault events from the token property.
		 */
		public function send(... args):AsyncToken;
	}
}
