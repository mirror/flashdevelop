/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc {
	public class Responder implements IResponder {
		/**
		 * Constructs an instance of the responder with the specified handlers.
		 *
		 * @param result            <Function> Function that should be called when the request has
		 *                            completed successfully.
		 * @param fault             <Function> Function that should be called when the request has
		 *                            completed with errors.
		 */
		public function Responder(result:Function, fault:Function);
		/**
		 * This method is called by a service when an error has been received.
		 *
		 * @param info              <Object> 
		 */
		public function fault(info:Object):void;
		/**
		 * This method is called by a remote service when the return value has been
		 *  received.
		 *
		 * @param data              <Object> 
		 */
		public function result(data:Object):void;
	}
}
