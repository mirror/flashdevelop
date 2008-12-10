package mx.core
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import mx.events.RSLEvent;
	import mx.utils.SHA256;
	import mx.utils.LoaderUtil;

	/**
	 *  @private *  Cross-domain RSL Item Class. *  *  The rsls are typically located on a different host than the loader.  *  There are signed and unsigned Rsls, both have a digest to confirm the  *  correct rsl is loaded. *  Signed Rsls are loaded by setting the digest of the URLRequest. *  Unsigned Rsls are check using actionScript to calculate a sha-256 hash of  *  the loaded bytes and compare them to the expected digest. *
	 */
	public class CrossDomainRSLItem extends RSLItem
	{
		private var rslUrls : Array;
		private var policyFileUrls : Array;
		private var digests : Array;
		private var isSigned : Array;
		private var hashTypes : Array;
		private var urlIndex : int;

		/**
		 *  Create a cross-domain RSL item to load.    *     *  @param rslUrls Array of Strings, may not be null. Each String is the url of an RSL to load.    *  @param policyFileUrls Array of Strings, may not be null. Each String contains the url of an    *                       policy file which may be required to allow the RSL to be read from another    *                       domain. An empty string means there is no policy file specified.    *  @param digests Array of Strings, may not be null. A String contains the value of the digest    *                computed by the hash in the corresponding entry in the hashTypes Array. An empty    *                string may be provided for unsigned RSLs to loaded them without verifying the digest.    *                This is provided as a development cycle convenience and should not be used in a    *                production application.    *  @param hashTypes Array of Strings, may not be null. Each String identifies the type of hash    *                  used to compute the digest. Currently the only valid value is SHA256.TYPE_ID.    *  @param isSigned Array of boolean, may not be null. Each boolean value specifies if the RSL to be    *                  loaded is a signed or unsigned RSL. If the value is true the RSL is signed.     *                  If the value is false the RSL is unsigned.    *  @param rootURL provides the url used to locate relative RSL urls.
		 */
		public function CrossDomainRSLItem (rslUrls:Array, policyFileUrls:Array, digests:Array, hashTypes:Array, isSigned:Array, rootURL:String = null);
		/**
		 *      * Load an RSL.     *     * @param progressHandler       receives ProgressEvent.PROGRESS events, may be null.    * @param completeHandler       receives Event.COMPLETE events, may be null.    * @param ioErrorHandler        receives IOErrorEvent.IO_ERROR events, may be null.    * @param securityErrorHandler  receives SecurityErrorEvent.SECURITY_ERROR events, may be null.    * @param rslErrorHandler       receives RSLEvent.RSL_ERROR events, may be null.    *
		 */
		public function load (progressHandler:Function, completeHandler:Function, ioErrorHandler:Function, securityErrorHandler:Function, rslErrorHandler:Function) : void;
		/**
		 *  @private     *  Complete the load of the cross-domain rsl by loading it into the current     *  application domain. The load was started by loadCdRSL.     *      *  @param - urlLoader from the complete event.     *      *  @return - true if the load was completed successfully or unsuccessfully,      *            false if the load of a failover rsl was started
		 */
		private function completeCdRslLoad (urlLoader:URLLoader) : Boolean;
		/**
		 *  Does the current url being processed have a failover?    *     * @return true if a failover url exists, false otherwise.
		 */
		public function hasFailover () : Boolean;
		/**
		 *  Load the next url from the list of failover urls.
		 */
		public function loadFailover () : void;
		/**
		 *  @private
		 */
		public function itemCompleteHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function itemErrorHandler (event:ErrorEvent) : void;
		/**
		 * loader.loadBytes() has a complete event.     * Done loading this rsl into memory. Call the completeHandler     * to start loading the next rsl.     *      *  @private
		 */
		private function loadBytesCompleteHandler (event:Event) : void;
	}
}
