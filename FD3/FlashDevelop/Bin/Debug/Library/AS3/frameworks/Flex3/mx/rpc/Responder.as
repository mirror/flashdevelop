package mx.rpc
{
	/**
	 *  This class provides a default implementation <code>mx.rpc.IResponder</code>
	 */
	public class Responder implements IResponder
	{
		/**
		 *  @private
		 */
		private var _resultHandler : Function;
		/**
		 *  @private
		 */
		private var _faultHandler : Function;

		/**
		 *  Constructs an instance of the responder with the specified handlers.	 *  	 *  @param	result Function that should be called when the request has	 *           completed successfully.	 *  @param	fault Function that should be called when the request has	 *			completed with errors.
		 */
		public function Responder (result:Function, fault:Function);
		/**
		 *  This method is called by a remote service when the return value has been 	 *  received.         *         * @param data While <code>data</code> is typed as Object, it is often (but not always) an mx.rpc.events.ResultEvent.
		 */
		public function result (data:Object) : void;
		/**
		 *  This method is called by a service when an error has been received.         *         * @param info While <code>info</code> is typed as Object, it is often (but not always) an mx.rpc.events.FaultEvent.
		 */
		public function fault (info:Object) : void;
	}
}
