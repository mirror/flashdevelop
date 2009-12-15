package air.update.core
{
	import air.update.states.HSM;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.net.URLStream;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;

	public class UCFUnpackager extends HSM
	{
		public function set enableSignatureValidation (enable:Boolean) : void;

		public function get isComplete () : Boolean;

		public function get outputDirectory () : File;
		public function set outputDirectory (dir:File) : void;

		public function cancel () : void;

		public function UCFUnpackager ();

		public function unpackageAsync (url:String) : void;
	}
}
