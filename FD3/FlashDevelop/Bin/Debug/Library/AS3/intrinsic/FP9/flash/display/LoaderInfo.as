package flash.display
{
	/// The LoaderInfo class provides information about a loaded SWF file or a loaded image file (JPEG, GIF, or PNG).
	public class LoaderInfo extends flash.events.EventDispatcher
	{
		/** 
		 * Dispatched when a network request is made over HTTP and Flash Player can detect the HTTP status code.
		 * @eventType flash.events.HTTPStatusEvent.HTTP_STATUS
		 */
		[Event(name="httpStatus", type="flash.events.HTTPStatusEvent")]

		/** 
		 * Dispatched by a LoaderInfo object whenever a loaded object is removed by using the unload() method of the Loader object, or when a second load is performed by the same Loader object and the original content is removed prior to the load beginning.
		 * @eventType flash.events.Event.UNLOAD
		 */
		[Event(name="unload", type="flash.events.Event")]

		/** 
		 * Dispatched when data is received as the download operation progresses.
		 * @eventType flash.events.ProgressEvent.PROGRESS
		 */
		[Event(name="progress", type="flash.events.ProgressEvent")]

		/** 
		 * Dispatched when a load operation starts.
		 * @eventType flash.events.Event.OPEN
		 */
		[Event(name="open", type="flash.events.Event")]

		/** 
		 * Dispatched when an input or output error occurs that causes a load operation to fail.
		 * @eventType flash.events.IOErrorEvent.IO_ERROR
		 */
		[Event(name="ioError", type="flash.events.IOErrorEvent")]

		/** 
		 * Dispatched when the properties and methods of a loaded SWF file are accessible and ready for use.
		 * @eventType flash.events.Event.INIT
		 */
		[Event(name="init", type="flash.events.Event")]

		/** 
		 * Dispatched when data has loaded successfully.
		 * @eventType flash.events.Event.COMPLETE
		 */
		[Event(name="complete", type="flash.events.Event")]

		/// The URL of the SWF file that initiated the loading of the media described by this LoaderInfo object.
		public var loaderURL:String;

		/// The URL of the media being loaded.
		public var url:String;

		/// The number of bytes that are loaded for the media.
		public var bytesLoaded:uint;

		/// The number of compressed bytes in the entire media file.
		public var bytesTotal:uint;

		/// When an external SWF file is loaded, all ActionScript 3.0 definitions contained in the loaded class are stored in the applicationDomain property.
		public var applicationDomain:flash.system.ApplicationDomain;

		/// The file format version of the loaded SWF file.
		public var swfVersion:uint;

		/// The ActionScript version of the loaded SWF file.
		public var actionScriptVersion:uint;

		/// The nominal frame rate, in frames per second, of the loaded SWF file.
		public var frameRate:Number;

		/// An object that contains name-value pairs that represent the parameters provided to the loaded SWF file.
		public var parameters:Object;

		/// The nominal width of the loaded content.
		public var width:int;

		/// The nominal height of the loaded file.
		public var height:int;

		/// The MIME type of the loaded file.
		public var contentType:String;

		/// An EventDispatcher instance that can be used to exchange events across security boundaries.
		public var sharedEvents:flash.events.EventDispatcher;

		/// Expresses the domain relationship between the loader and the content: true if they have the same origin domain; false otherwise.
		public var sameDomain:Boolean;

		/// Expresses the trust relationship from content (child) to the Loader (parent).
		public var childAllowsParent:Boolean;

		/// Expresses the trust relationship from Loader (parent) to the content (child).
		public var parentAllowsChild:Boolean;

		/// The Loader object associated with this LoaderInfo object.
		public var loader:flash.display.Loader;

		/// The loaded object associated with this LoaderInfo object.
		public var content:flash.display.DisplayObject;

		/// The bytes associated with a LoaderInfo object.
		public var bytes:flash.utils.ByteArray;

		/// Returns the LoaderInfo object associated with a SWF file defined as an object.
		public static function getLoaderInfoByDefinition(object:Object):flash.display.LoaderInfo;

	}

}

