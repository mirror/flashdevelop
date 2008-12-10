package mx.rpc
{
	import mx.core.mx_internal;

	/**
	 * @private
	 */
	public class ActiveCalls
	{
		private var calls : Object;
		private var callOrder : Array;

		public function ActiveCalls ();
		public function addCall (id:String, token:AsyncToken) : void;
		public function getAllMessages () : Array;
		public function cancelLast () : AsyncToken;
		public function hasActiveCalls () : Boolean;
		public function removeCall (id:String) : AsyncToken;
		public function wasLastCall (id:String) : Boolean;
	}
}
