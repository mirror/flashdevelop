package air.update.net
{
	import flash.events.EventDispatcher;
	import air.update.logging.Logger;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.events.HTTPStatusEvent;
	import flash.net.URLStream;
	import flash.events.ErrorEvent;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	import flash.filesystem.FileStream;

	public class FileDownloader extends EventDispatcher
	{
		public function cancel () : void;

		public function download () : void;

		public function FileDownloader (url:URLRequest, file:File);

		public function inProgress () : Boolean;
	}
}
