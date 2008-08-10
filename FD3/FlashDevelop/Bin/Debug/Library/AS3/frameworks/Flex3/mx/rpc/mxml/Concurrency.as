/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.mxml {
	public final  class Concurrency {
		/**
		 * Making a request cancels any existing request.
		 */
		public static const LAST:String = "last";
		/**
		 * Existing requests are not cancelled, and the developer is responsible for ensuring
		 *  the consistency of returned data by carefully managing the event stream.
		 */
		public static const MULTIPLE:String = "multiple";
		/**
		 * Only a single request at a time is allowed on the operation; multiple requests generate a fault.
		 */
		public static const SINGLE:String = "single";
	}
}
