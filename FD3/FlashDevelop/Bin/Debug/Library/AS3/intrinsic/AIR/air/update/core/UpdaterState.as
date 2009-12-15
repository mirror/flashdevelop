package air.update.core
{
	import air.update.logging.Logger;
	import flash.filesystem.File;
	import air.update.descriptors.StateDescriptor;

	public class UpdaterState extends Object
	{
		public function get descriptor () : StateDescriptor;

		public function addFailedUpdate (version:String) : void;

		public function load () : void;

		public function removeAllFailedUpdates () : void;

		public function removePreviousStorageData (previousStorage:File) : void;

		public function resetUpdateData () : void;

		public function saveToDocuments () : void;

		public function saveToStorage () : void;

		public function UpdaterState ();
	}
}
