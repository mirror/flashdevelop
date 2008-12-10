package mx.managers
{
	import flash.net.LocalConnection;
	import mx.core.mx_internal;
	import mx.managers.HistoryManager;

	/**
	 *  @private
	 */
	internal class MainLocalConnection extends LocalConnection
	{
		/**
		 *  Constructor.
		 */
		public function MainLocalConnection ();
		/**
		 *  @private
		 */
		public function loadState (stateVars:Object) : void;
		/**
		 *  @private
		 */
		public function register () : void;
		/**
		 *  @private
		 */
		public function registered () : void;
	}
}
