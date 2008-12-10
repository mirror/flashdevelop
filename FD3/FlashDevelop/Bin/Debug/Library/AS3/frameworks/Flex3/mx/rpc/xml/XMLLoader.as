package mx.rpc.xml
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.core.mx_internal;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.XMLLoadEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.URLUtil;

	[Event(name="fault", type="mx.rpc.events.FaultEvent")] 
	[Event(name="xmlLoad", type="mx.rpc.events.XMLLoadEvent")] 

	/**
	 * Base class to help manage loading of an XML document at runtime. * @private
	 */
	public class XMLLoader extends EventDispatcher
	{
		protected var loader : HTTPService;
		public var loadsOutstanding : int;

		public function XMLLoader (httpService:HTTPService = null);
		/**
		 * Asynchronously loads an XML document for the given URL.
		 */
		public function load (url:String) : void;
		protected function initializeService (httpService:HTTPService = null) : void;
		protected function internalLoad (location:String) : AsyncToken;
		protected function getQualifiedLocation (location:String, parentLocation:String = null) : String;
		/**
		 * If a fault occured trying to load the XML document, a FaultEvent     * is simply redispatched.
		 */
		protected function faultHandler (event:FaultEvent) : void;
		/**
		 * Dispatches an XMLLoadEvent with the XML formatted result     * and location (if known).
		 */
		protected function resultHandler (event:ResultEvent) : void;
	}
}
