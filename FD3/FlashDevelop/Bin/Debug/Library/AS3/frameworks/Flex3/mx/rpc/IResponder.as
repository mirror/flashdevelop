package mx.rpc
{
	/**
	 *  This interface provides the contract for any service
 *  that needs to respond to remote or asynchronous calls.
	 */
	public interface IResponder
	{
		/**
		 *  This method is called by a service when the return value
	 *  has been received. 
	 *  While <code>data</code> is typed as Object, it is often
	 *  (but not always) an mx.rpc.events.ResultEvent.
		 */
		public function result (data:Object) : void;

		/**
		 *  This method is called by a service when an error has been received.
	 *  While <code>info</code> is typed as Object it is often
	 *  (but not always) an mx.rpc.events.FaultEvent.
		 */
		public function fault (info:Object) : void;
	}
}
