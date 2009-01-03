package flash.desktop
{
	import flash.filesystem.File;

	/// The Updater class is used to update the currently running application with a different version.
	public class Updater extends Object
	{
		/// [AIR] Updates the currently running application with the version of the application contained in the specified AIR file.
		public function update (airFile:File, version:String) : void;
	}
}
