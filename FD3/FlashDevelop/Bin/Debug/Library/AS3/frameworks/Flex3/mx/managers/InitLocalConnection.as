package mx.managers
{
	import flash.net.LocalConnection;
	import mx.core.mx_internal;

include "../core/Version.as"
	/**
	 *  @private
	 */
	internal class InitLocalConnection extends LocalConnection
	{
		/**
		 *  Constructor.
		 */
		public function InitLocalConnection ();

		/**
		 *  @private
		 */
		public function loadInitialState () : void;
	}
}
