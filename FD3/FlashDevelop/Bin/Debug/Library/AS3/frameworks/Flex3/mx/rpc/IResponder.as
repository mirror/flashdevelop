/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc {
	public interface IResponder {
		/**
		 * This method is called by a service when an error has been received.
		 *  While info is typed as Object it is often
		 *  (but not always) an mx.rpc.events.FaultEvent.
		 *
		 * @param info              <Object> 
		 */
		public function fault(info:Object):void;
		/**
		 * This method is called by a service when the return value
		 *  has been received.
		 *  While data is typed as Object, it is often
		 *  (but not always) an mx.rpc.events.ResultEvent.
		 *
		 * @param data              <Object> 
		 */
		public function result(data:Object):void;
	}
}
