/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.remoting {
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	public class Operation extends AbstractOperation {
		/**
		 * An ordered list of the names of the arguments to pass to a method invocation.  Since the arguments object is
		 *  a hashmap with no guaranteed ordering, this array helps put everything together correctly.
		 *  It will be set automatically by the MXML compiler, if necessary, when the Operation is used in tag form.
		 */
		public var argumentNames:Array;
		/**
		 * When this value is true, anonymous objects returned are forced to bindable objects.
		 */
		public function get makeObjectsBindable():Boolean;
		public function set makeObjectsBindable(value:Boolean):void;
		/**
		 * Creates a new Operation. This is usually done directly automatically by the RemoteObject
		 *  when an unknown operation has been accessed. It is not recommended that a developer use this constructor
		 *  directly.
		 *
		 * @param remoteObject      <AbstractService (default = null)> 
		 * @param name              <String (default = null)> 
		 */
		public function Operation(remoteObject:AbstractService = null, name:String = null);
		/**
		 * Executes the method. Any arguments passed in are passed along as part of
		 *  the method call. If there are no arguments passed, the arguments object
		 *  is used as the source of parameters.
		 *
		 * @return                  <AsyncToken> AsyncToken Call using the asynchronous completion token pattern.
		 *                            The same object is available in the result and
		 *                            fault events from the token property.
		 */
		public override function send(... args):AsyncToken;
	}
}
