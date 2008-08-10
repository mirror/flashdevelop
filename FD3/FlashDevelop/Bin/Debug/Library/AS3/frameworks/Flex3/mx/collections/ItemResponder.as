/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	import mx.rpc.IResponder;
	public class ItemResponder implements IResponder {
		/**
		 * Constructs an instance of the responder with the specified data and
		 *  handlers.
		 *
		 * @param result            <Function> Function that should be called when the request has
		 *                            completed successfully.
		 *                            Must have the following signature:
		 *                            public function (result:Object, token:Object = null):void;
		 * @param fault             <Function> Function that should be called when the request has
		 *                            completed with errors.
		 *                            Must have the following signature:
		 *                            public function (error:ErrorMessage, token:Object = null):void;
		 * @param token             <Object (default = null)> Object [optional] additional information to associate with
		 *                            this request. This object is passed to the result and fault functions
		 *                            as their second parameter.
		 */
		public function ItemResponder(result:Function, fault:Function, token:Object = null);
		/**
		 * This method is called by a service when an error has been received.
		 *
		 * @param info              <Object> Object containing the information about the error that
		 *                            occured.
		 */
		public function fault(info:Object):void;
		/**
		 * This method is called by a service when the return value has been
		 *  received.
		 *
		 * @param data              <Object> Object containing the information returned from the request.
		 */
		public function result(data:Object):void;
	}
}
