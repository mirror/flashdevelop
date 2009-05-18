package flash.html
{
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLStream;
	import flash.html.HTMLLoader;
	import flash.display.Loader;
	import flash.net.URLRequestHeader;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;
	import flash.events.HTTPStatusEvent;

	public class ResourceLoader extends Object
	{
		public function cancel () : void;

		public function ResourceLoader (urlReq:URLRequest, htmlControl:HTMLLoader);
	}
}
