/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.desktop {
	import flash.filesystem.File;
	public final  class Updater {
		/**
		 * The constructor function for the Updater class. Note that the update()
		 *  method is not a static member of the class. You must instantiate an Updater object
		 *  and call the update() method on it.
		 */
		public function Updater();
		/**
		 * Updates the currently running application with the version of the
		 *  application contained in the specified AIR file. The application in
		 *  the AIR file must have the same application identifier
		 *  (appID) as the currently running application.
		 *
		 * @param airFile           <File> The File object pointing to the AIR file that contains the
		 *                            update version of the application.
		 * @param version           <String> The required version in the new AIR file. The string in the
		 *                            version attribute of the main application element of the
		 *                            application descriptor file for the AIR file must match this value in order for the
		 *                            update to succeed.
		 */
		public function update(airFile:File, version:String):void;
	}
}
