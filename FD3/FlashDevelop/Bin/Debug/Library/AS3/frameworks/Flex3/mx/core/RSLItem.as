package mx.core
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	import mx.events.RSLEvent;
	import mx.utils.LoaderUtil;

include "../core/Version.as"
	/**
	 *  @private
 *  RSL Item Class
 * 
 *  Contains properties to describe the RSL and methods to help load the RSL.
	 */
	public class RSLItem
	{
		/**
		 *  @private
     *  Only valid after loading has started
		 */
		public var urlRequest : URLRequest;
		/**
		 *  @private
		 */
		public var total : uint;
		/**
		 *  @private
		 */
		public var loaded : uint;
		/**
		 *  @private
     * 
     *  Provides the url used to locate relative RSL urls.
		 */
		public var rootURL : String;
		/**
		 *  @private
		 */
		protected var url : String;
		/**
		 *  @private
		 */
		private var errorText : String;
		/**
		 *  @private
		 */
		private var completed : Boolean;
		/**
		 *  @private
     *  External handlers so the load can be 
     *  observed by the class calling load().
		 */
		protected var chainedProgressHandler : Function;
		protected var chainedCompleteHandler : Function;
		protected var chainedIOErrorHandler : Function;
		protected var chainedSecurityErrorHandler : Function;
		protected var chainedRSLErrorHandler : Function;

		/**
		 *  Create a RSLItem with a given URL.
     * 
     *  @param url location of RSL to load
     *  
     *  @param rootURL provides the url used to locate relative RSL urls.
		 */
		public function RSLItem (url:String, rootURL:String = null);

		/**
		 * 
     *  Load an RSL. 
     * 
     *  @param progressHandler Receives ProgressEvent.PROGRESS events.
     *  May be null.
     *
     *  @param completeHandler Receives Event.COMPLETE events.
     *  May be null.
     *
     *  @param ioErrorHandler Receives IOErrorEvent.IO_ERROR events.
     *  May be null.
     *
     *  @param securityErrorHandler
     *  Receives SecurityErrorEvent.SECURITY_ERROR events.
     *  May be null.
     *
     *  @param rslErrorHandler Receives RSLEvent.RSL_ERROR events.
     *  May be null.
		 */
		public function load (progressHandler:Function, completeHandler:Function, ioErrorHandler:Function, securityErrorHandler:Function, rslErrorHandler:Function) : void;

		/**
		 *  @private
		 */
		public function itemProgressHandler (event:ProgressEvent) : void;

		/**
		 *  @private
		 */
		public function itemCompleteHandler (event:Event) : void;

		/**
		 *  @private
		 */
		public function itemErrorHandler (event:ErrorEvent) : void;
	}
}
