/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	public interface IHistoryManagerClient {
		/**
		 * Loads the state of this object.
		 *
		 * @param state             <Object> State of this object to load.
		 *                            This will be null when loading the initial state of the application.
		 */
		public function loadState(state:Object):void;
		/**
		 * Saves the state of this object.
		 *  The object contains name:value pairs for each property
		 *  to be saved with the state.
		 *
		 * @return                  <Object> The state of this object.
		 */
		public function saveState():Object;
		/**
		 * Converts this object to a unique string.
		 *  Implemented by UIComponent.
		 *
		 * @return                  <String> The unique identifier for this object.
		 */
		public function toString():String;
	}
}
