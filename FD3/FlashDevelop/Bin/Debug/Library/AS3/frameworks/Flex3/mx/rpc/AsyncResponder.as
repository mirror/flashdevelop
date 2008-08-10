/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc {
	public class AsyncResponder implements IResponder {
		/**
		 * Constructs an instance of the responder with the specified data and
		 *  handlers.
		 *
		 * @param result            <Function> result Function that should be called when the request has
		 *                            completed successfully.
		 *                            Must have the following signature:
		 *                            public function (result:Object, token:Object = null):void;
		 * @param fault             <Function> fault Function that should be called when the request has
		 *                            completed with errors.
		 *                            Must have the following signature:
		 *                            public function (error:ErrorMessage, token:Object = null):void;
		 * @param token             <Object (default = null)> token Object [optional] additional information to associate with
		 *                            this request.
		 */
		public function AsyncResponder(result:Function, fault:Function, token:Object = null);
		/**
		 * This method is called by a service when an error has been received.
		 *
		 * @param info              <Object> info Object containing the information about the error that
		 *                            occured.
		 */
		public function fault(info:Object):void;
		/**
		 * This method is called by a service when the return value has been
		 *  received.
		 *
		 * @param data              <Object> data Object containing the information returned from the request.
		 */
		public function result(data:Object):void;
	}
}
