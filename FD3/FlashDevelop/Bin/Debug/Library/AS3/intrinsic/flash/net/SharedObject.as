package flash.net
{
	/// The SharedObject class is used to read and store limited amounts of data on a user's computer or on a server.
	public class SharedObject extends flash.events.EventDispatcher
	{
		/** 
		 * Dispatched when a remote shared object has been updated by the server.
		 * @eventType flash.events.SyncEvent.SYNC
		 */
		[Event(name="sync", type="flash.events.SyncEvent")]

		/** 
		 * Dispatched when a SharedObject instance is reporting its status or error condition.
		 * @eventType flash.events.NetStatusEvent.NET_STATUS
		 */
		[Event(name="netStatus", type="flash.events.NetStatusEvent")]

		/** 
		 * Dispatched when an exception is thrown asynchronously -- that is, from native asynchronous code.
		 * @eventType flash.events.AsyncErrorEvent.ASYNC_ERROR
		 */
		[Event(name="asyncError", type="flash.events.AsyncErrorEvent")]

		/// The collection of attributes assigned to the data property of the object; these attributes can be shared and stored.
		public var data:Object;

		/// The current size of the shared object, in bytes.
		public var size:uint;

		/// Specifies the number of times per second that a client's changes to a shared object are sent to the server.
		public var fps:Number;

		/// The default object encoding (AMF version) for all local shared objects created in the SWF file.
		public var defaultObjectEncoding:uint;

		/// The object encoding (AMF version) for this shared object.
		public var objectEncoding:uint;

		/// Indicates the object on which callback methods are invoked.
		public var client:Object;

		/// Returns a reference to a locally persistent shared object that is only available to the current client.
		public static function getLocal(name:String, localPath:String=null, secure:Boolean=false):flash.net.SharedObject;

		/// Returns a reference to a shared object on Flash Media Server that multiple clients can access.
		public static function getRemote(name:String, remotePath:String=null, persistence:Object=false, secure:Boolean=false):flash.net.SharedObject;

		/// Connects to a remote shared object on a server through a specified NetConnection object.
		public function connect(myConnection:flash.net.NetConnection, params:String=null):void;

		/// Closes the connection between a remote shared object and the server.
		public function close():void;

		/// Immediately writes a locally persistent shared object to a local file.
		public function flush(minDiskSpace:int=0):String;

		/// Broadcasts a message to all clients connected to a remote shared object, including the client that sent the message.
		public function send(...arguments):void;

		/// For local shared objects, purges all of the data and deletes the shared object from the disk.
		public function clear():void;

		/// Indicates to the server that the value of a property in the shared object has changed.
		public function setDirty(propertyName:String):void;

		/// Updates the value of a property in a shared object and indicates to the server that the value of the property has changed.
		public function setProperty(propertyName:String, value:Object=null):void;

	}

}

