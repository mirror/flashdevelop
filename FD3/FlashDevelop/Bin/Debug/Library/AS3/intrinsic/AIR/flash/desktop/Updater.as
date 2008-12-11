package flash.desktop
{
	/// The Updater class is used to update the currently running application with a different version.
	public class Updater
	{
		/// [AIR] The constructor function for the Updater class.
		public function Updater():void;

		/// [AIR] Updates the currently running application with the version of the application contained in the specified AIR file.
		public function update(airFile:flash.filesystem.File, version:String):void;

	}

}

