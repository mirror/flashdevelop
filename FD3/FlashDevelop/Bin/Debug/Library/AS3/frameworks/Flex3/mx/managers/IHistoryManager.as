package mx.managers
{
	import mx.managers.IHistoryManagerClient;

	/**
	 *  @private
	 */
	public interface IHistoryManager
	{
		public function register (obj:IHistoryManagerClient) : void;
		public function unregister (obj:IHistoryManagerClient) : void;
		public function save () : void;
		public function registered () : void;
		public function registerHandshake () : void;
		public function load (stateVars:Object) : void;
		public function loadInitialState () : void;
	}
}
