package mx.rpc
{
	/**
	 * This class provides an RPC specific implementation of <code>mx.rpc.IResponder</code>. *  * It allows the creator to associate data (a token) and methods that should be  * called when a request is completed. * * The result method specified must have the following signature: *  <code><pre> *     public function myResultFunction(result:Object, token:Object = null):void; *  </pre></code> * * The fault method specified must have the following signature: *  <code><pre> *     public function myFaultFunction(error:Object, token:Object = null):void; *  </pre></code> *  * Any other signature will result in a runtime error.
	 */
	public class AsyncResponder implements IResponder
	{
		private var _resultHandler : Function;
		private var _faultHandler : Function;
		private var _token : Object;

		/**
		 *  Constructs an instance of the responder with the specified data and      *  handlers.     *       *  @param  result Function that should be called when the request has     *          completed successfully.     *          Must have the following signature:     *          <code><pre>     *              public function (result:Object, token:Object = null):void;     *          </pre></code>     *  @param  fault Function that should be called when the request has     *          completed with errors.     *          Must have the following signature:     *          <code><pre>     *              public function (error:ErrorMessage, token:Object = null):void;     *          </pre></code>     *  @param  token Object [optional] additional information to associate with     *          this request.
		 */
		public function AsyncResponder (result:Function, fault:Function, token:Object = null);
		/**
		 *  This method is called by a service when the return value has been      *  received.     *     *  @param  data Object containing the information returned from the request.
		 */
		public function result (data:Object) : void;
		/**
		 *  This method is called by a service when an error has been received.     *     *  @param  info Object containing the information about the error that      *          occured.
		 */
		public function fault (info:Object) : void;
	}
}
