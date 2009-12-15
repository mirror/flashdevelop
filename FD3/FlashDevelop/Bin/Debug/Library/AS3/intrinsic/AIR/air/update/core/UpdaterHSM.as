package air.update.core
{
	import air.update.states.HSM;
	import air.update.logging.Logger;
	import flash.net.URLRequest;
	import flash.events.Event;
	import air.update.core.AIRUnpackager;
	import flash.filesystem.File;
	import air.update.descriptors.UpdateDescriptor;
	import air.update.net.FileDownloader;
	import air.update.descriptors.ApplicationDescriptor;
	import air.update.core.UpdaterConfiguration;

	public class UpdaterHSM extends HSM
	{
		public static const EVENT_ASYNC : String;
		public static const EVENT_CHECK : String;
		public static const EVENT_DOWNLOAD : String;
		public static const EVENT_FILE : String;
		public static const EVENT_FILE_INSTALL_TRIGGER : String;
		public static const EVENT_INSTALL : String;
		public static const EVENT_INSTALL_TRIGGER : String;
		public static const EVENT_STATE_CLEAR_TRIGGER : String;
		public static const EVENT_VERIFIED : String;

		public function get airFile () : File;

		public function get applicationDescriptor () : ApplicationDescriptor;

		public function get configuration () : UpdaterConfiguration;
		public function set configuration (value:UpdaterConfiguration) : void;

		public function get descriptor () : UpdateDescriptor;

		public function cancel () : void;

		public function checkAsync (url:String) : void;

		public function getUpdateState () : int;

		public function installFile (file:File) : void;

		public function UpdaterHSM ();
	}
}
