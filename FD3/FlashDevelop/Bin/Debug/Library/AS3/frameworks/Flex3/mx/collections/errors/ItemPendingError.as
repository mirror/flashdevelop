/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections.errors {
	import mx.rpc.IResponder;
	public class ItemPendingError extends Error {
		/**
		 * An array of IResponder handlers that will be called when
		 *  the asynchronous request completes.
		 */
		public function get responders():Array;
		/**
		 * Constructor.
		 *
		 * @param message           <String> A message providing information about the error cause.
		 */
		public function ItemPendingError(message:String);
		/**
		 * addResponder adds a responder to an Array of responders.
		 *  The object assigned to the responder parameter must implement the
		 *  mx.rpc.IResponder interface.
		 *
		 * @param responder         <IResponder> A handler which will be called when the asynchronous request completes.
		 */
		public function addResponder(responder:IResponder):void;
	}
}
