package mx.core
{
	/**
	 *  The IStateClient interface defines the interface that  *  components must implement to support view states.
	 */
	public interface IStateClient
	{
		/**
		 *  The current view state.
		 */
		public function get currentState () : String;
		/**
		 *  @private
		 */
		public function set currentState (value:String) : void;

	}
}
