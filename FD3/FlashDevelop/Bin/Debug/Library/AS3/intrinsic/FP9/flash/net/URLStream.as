package flash.net
{
	/// The URLStream class provides low-level access to downloading URLs.
	public class URLStream extends flash.events.EventDispatcher
	{
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
		 * Dispatched when an input/output error occurs that causes a load operation to fail.
		 * @eventType flash.events.IOErrorEvent.IO_ERROR
		 */
		[Event(name="ioError", type="flash.events.IOErrorEvent")]

		/** 
		 * [AIR] Dispatched if a call to the URLStream.load() method attempts to access data over HTTP and Adobe AIR is able to detect and return the status code for the request.
		 * @eventType flash.events.HTTPStatusEvent.HTTP_RESPONSE_STATUS
		 */
		[Event(name="httpResponseStatus", type="flash.events.HTTPStatusEvent")]

		/** 
		 * Dispatched if a call to URLStream.load() attempts to access data over HTTP, and Flash Player or  or Adobe AIR is able to detect and return the status code for the request.
		 * @eventType flash.events.HTTPStatusEvent.HTTP_STATUS
		 */
		[Event(name="httpStatus", type="flash.events.HTTPStatusEvent")]

		/** 
		 * Dispatched if a call to URLStream.load() attempts to load data from a server outside the security sandbox.
		 * @eventType flash.events.SecurityErrorEvent.SECURITY_ERROR
		 */
		[Event(name="securityError", type="flash.events.SecurityErrorEvent")]

		/** 
		 * Dispatched when data has loaded successfully.
		 * @eventType flash.events.Event.COMPLETE
		 */
		[Event(name="complete", type="flash.events.Event")]

		/// Indicates whether this URLStream object is currently connected.
		public var connected:Boolean;

		/// Returns the number of bytes of data available for reading in the input buffer.
		public var bytesAvailable:uint;

		/// Controls the version of Action Message Format (AMF) used when writing or reading an object.
		public var objectEncoding:uint;

		/// Indicates the byte order for the data.
		public var endian:String;

		/// Begins downloading the URL specified in the request parameter.
		public function load(request:flash.net.URLRequest):void;

		/// Reads length bytes of data from the stream.
		public function readBytes(bytes:flash.utils.ByteArray, offset:uint=0, length:uint=0):void;

		/// Reads a Boolean value from the stream.
		public function readBoolean():Boolean;

		/// Reads a signed byte from the stream.
		public function readByte():int;

		/// Reads an unsigned byte from the stream.
		public function readUnsignedByte():uint;

		/// Reads a signed 16-bit integer from the stream.
		public function readShort():int;

		/// Reads an unsigned 16-bit integer from the stream.
		public function readUnsignedShort():uint;

		/// Reads an unsigned 32-bit integer from the stream.
		public function readUnsignedInt():uint;

		/// Reads a signed 32-bit integer from the stream.
		public function readInt():int;

		/// Reads an IEEE 754 single-precision floating-point number from the stream.
		public function readFloat():Number;

		/// Reads an IEEE 754 double-precision floating-point number from the stream.
		public function readDouble():Number;

		/// Reads a multibyte string of specified length from the byte stream using the specified character set.
		public function readMultiByte(length:uint, charSet:String):String;

		/// Reads a UTF-8 string from the stream.
		public function readUTF():String;

		/// Reads a sequence of length UTF-8 bytes from the stream, and returns a string.
		public function readUTFBytes(length:uint):String;

		/// Immediately closes the stream and cancels the download operation.
		public function close():void;

		/// Reads an object from the socket, encoded in Action Message Format (AMF).
		public function readObject():void;

	}

}

