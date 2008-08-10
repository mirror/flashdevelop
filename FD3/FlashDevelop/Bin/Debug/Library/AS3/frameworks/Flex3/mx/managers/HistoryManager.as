/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	public class HistoryManager {
		/**
		 * DEPRECATED - Initializes the HistoryManager. In general, this does not need to be called
		 *  because any time you add a component with historyManagementEnabled, Flex
		 *  calls this method. However, the HistoryManager will not work correctly if it is
		 *  not initialized from the top-level application. So, if your application does
		 *  not have any HistoryManager enabled components in it and loads other sub-applications
		 *  That do, you must call the HistoryManager.initialize() method in the
		 *  main application, usually from an initialize event handler on the application.
		 *
		 * @param sm                <ISystemManager> SystemManager for this application.
		 */
		public static function initialize(sm:ISystemManager):void;
		/**
		 * Registers an object with the HistoryManager.
		 *  The object must implement the IHistoryManagerClient interface.
		 *
		 * @param obj               <IHistoryManagerClient> Object to register.
		 */
		public static function register(obj:IHistoryManagerClient):void;
		/**
		 * Saves the application's current state so it can be restored later.
		 *  This method is automatically called by navigator containers
		 *  whenever their navigation state changes.
		 *  If you registered an interface with the HistoryManager,
		 *  you are responsible for calling the save() method
		 *  when the application state changes.
		 */
		public static function save():void;
		/**
		 * Unregisters an object with the HistoryManager.
		 *
		 * @param obj               <IHistoryManagerClient> Object to unregister.
		 */
		public static function unregister(obj:IHistoryManagerClient):void;
	}
}
