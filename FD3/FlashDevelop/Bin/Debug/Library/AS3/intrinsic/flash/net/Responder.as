/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	public class Responder {
		/**
		 * Creates a new Responder object. You pass a Responder object to
		 *  NetConnection.call() to handle return values
		 *  from the server. You may pass null for either or
		 *  both parameters.
		 *
		 * @param result            <Function> The function invoked if the call to the server succeeds and returns a result.
		 * @param status            <Function (default = null)> The function invoked if the server returns an error.
		 */
		public function Responder(result:Function, status:Function = null);
	}
}
