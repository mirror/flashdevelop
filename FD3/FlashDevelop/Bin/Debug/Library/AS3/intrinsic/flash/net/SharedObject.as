/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	import flash.events.EventDispatcher;
	public class SharedObject extends EventDispatcher {
		/**
		 * Indicates the object on which
		 *  callback methods are invoked. The default object is this.
		 *  You can set the client property to another object, and callback methods will be
		 *  invoked on that other object.
		 */
		public function get client():Object;
		public function set client(value:Object):void;
		/**
		 * The collection of attributes assigned to the data property of the object; these attributes can
		 *  be shared and stored. Each attribute can be an object of any ActionScript or JavaScript
		 *  type - Array, Number, Boolean, ByteArray, XML, and so on.
		 */
		public function get data():Object;
		/**
		 * The default object encoding (AMF version) for all local shared objects created in the SWF file.
		 *  When local shared objects are written to disk, the
		 *  SharedObject.defaultObjectEncoding property
		 *  indicates which Action Message Format version should be used: the ActionScript 3.0 format (AMF3) or the ActionScript 1.0 or 2.0 format (AMF0).
		 */
		public static function get defaultObjectEncoding():uint;
		public function set defaultObjectEncoding(value:uint):void;
		/**
		 * Specifies the number of times per second that a client's changes to a
		 *  shared object are sent to the server.
		 */
		public function set fps(value:Number):void;
		/**
		 * The object encoding (AMF version) for this shared object. When a local shared object is written to disk,
		 *  the objectEncoding property indicates which Action
		 *  Message Format version should be used: the ActionScript 3.0 format (AMF3)
		 *  or the ActionScript 1.0 or 2.0 format (AMF0).
		 */
		public function get objectEncoding():uint;
		public function set objectEncoding(value:uint):void;
		/**
		 * The current size of the shared object, in bytes.
		 */
		public function get size():uint;
		/**
		 * For local shared objects, purges all of the data and deletes the shared object from the disk.
		 *  The reference to the shared object is still active, but its data properties are deleted.
		 */
		public function clear():void;
		/**
		 * Closes the connection between a remote shared object and the server.
		 *  If a remote shared object is locally persistent, the user can make changes
		 *  to the local copy of the object after this method is called. Any changes made
		 *  to the local object are sent to the server the next time the user connects
		 *  to the remote shared object.
		 */
		public function close():void;
		/**
		 * Connects to a remote shared object on a server through a specified NetConnection object.
		 *  Use this method after calling getRemote().
		 *  When a connection is successful, the sync event is dispatched.
		 *
		 * @param myConnection      <NetConnection> A NetConnection object that uses the Real-Time Messaging Protocol (RTMP),
		 *                            such as a NetConnection object used to communicate with Flash Media Server.
		 * @param params            <String (default = null)> A string defining a message to pass to the remote shared object on the server.
		 *                            Cannot be used with Flash Media Server.
		 */
		public function connect(myConnection:NetConnection, params:String = null):void;
		/**
		 * Immediately writes a locally persistent shared object to a local file. If you don't use this
		 *  method, Flash Player writes the shared object to a file when the shared object session ends -
		 *  that is, when the SWF file is closed, when the shared object is garbage-collected
		 *  because it no longer has any references to it, or when you call SharedObject.clear()
		 *  or SharedObject.close().
		 *
		 * @param minDiskSpace      <int (default = 0)> The minimum disk space, in bytes,
		 *                            that must be allotted for this object.
		 * @return                  <String> Either of the following values:
		 *                            SharedObjectFlushStatus.PENDING: The user has permitted local information
		 *                            storage for objects from this domain, but the
		 *                            amount of space allotted is not sufficient to store the object. Flash Player prompts
		 *                            the user to allow more space.
		 *                            To allow space for the shared object to grow when it is saved, thus avoiding
		 *                            a SharedObjectFlushStatus.PENDING return value, pass a value
		 *                            for minDiskSpace.
		 *                            SharedObjectFlushStatus.FLUSHED: The shared object has been
		 *                            successfully written to a file on the local disk.
		 */
		public function flush(minDiskSpace:int = 0):String;
		/**
		 * Returns a reference to a locally persistent shared object that is only available to the current client.
		 *  If the shared object does not already exist, this method creates one. If any values
		 *  passed to getLocal() are invalid or if the call fails, Flash Player throws an exception.
		 *
		 * @param name              <String> The name of the object. The name can include forward slashes (/); for example,
		 *                            work/addresses is a legal name. Spaces are not allowed in a shared
		 *                            object name, nor are the following characters:
		 *                            ~ % & \ ; : " ' , < > ? #
		 * @param localPath         <String (default = null)> The full or partial path to the SWF file that created the shared object, and that
		 *                            determines where the shared object will be stored locally. If you do not specify this parameter, the
		 *                            full path is used.
		 * @param secure            <Boolean (default = false)> Determines whether access to this shared object
		 *                            is restricted to SWF files that are delivered over an HTTPS connection.
		 *                            If your SWF file is delivered over HTTPS, this parameter's value has the following effects:
		 *                            If this parameter is set to true, Flash Player creates a new secure shared object or
		 *                            gets a reference to an existing secure shared object. This secure shared object
		 *                            can be read from or written to only by SWF files delivered over HTTPS that call
		 *                            SharedObject.getLocal() with the secure parameter set to
		 *                            true.
		 *                            If this parameter is set to false, Flash Player creates a new shared object or
		 *                            gets a reference to an existing shared object that can be read from
		 *                            or written to by SWF files delivered over non-HTTPS connections.
		 *                            If your SWF file is delivered over a non-HTTPS connection and you try to set this parameter
		 *                            to true, the creation of a new shared object (or the access of a previously
		 *                            created secure shared object) fails and null is returned. Regardless of the
		 *                            value of this parameter, the created shared objects count toward the total amount
		 *                            of disk space allowed for a domain.
		 *                            The following diagram shows the use of the secure parameter:
		 * @return                  <SharedObject> A reference to a shared object that is persistent locally and is available only to the
		 *                            current client. If Flash Player can't create or find the shared object (for example, if
		 *                            localPath was
		 *                            specified but no such directory exists), this method throws an exception.
		 */
		public static function getLocal(name:String, localPath:String = null, secure:Boolean = false):SharedObject;
		/**
		 * Returns a reference to a shared object on Flash Media Server that multiple
		 *  clients can access.
		 *  If the remote shared object does not already exist, this method creates one.
		 *
		 * @param name              <String> The name of the remote shared object. The name can include forward slashes (/);
		 *                            for example, work/addresses is a legal name. Spaces are not allowed in a shared object name,
		 *                            nor are the following characters:
		 *                            ~ % & \ ; :  " ' , > ? ? #
		 * @param remotePath        <String (default = null)> The URI of the server on which the shared object will be stored.
		 *                            This URI must be identical to the URI of the NetConnection object passed to the
		 *                            connect() method.
		 * @param persistence       <Object (default = false)> Specifies whether the attributes of the shared
		 *                            object's data property are persistent locally, remotely, or both. This parameter can also specify
		 *                            where the shared object will be stored locally. Acceptable values are as follows:
		 *                            A value of false specifies that the shared object is not persistent
		 *                            on the client or server.
		 *                            A value of true specifies that the shared object is persistent only on the server.
		 *                            A full or partial local path to the shared object indicates that the shared
		 *                            object is persistent on the client and the server. On the client, it is stored in the
		 *                            specified path; on the server, it is stored in a subdirectory within the application
		 *                            directory.
		 *                            Note: If the user has chosen to never allow local storage
		 *                            for this domain, the object will not be saved locally, even if a local path is
		 *                            specified for persistence. For more information, see the class description.
		 * @param secure            <Boolean (default = false)> Determines whether access to this shared object is restricted to SWF
		 *                            files that are delivered over an HTTPS connection. For more information, see the
		 *                            description of the secure parameter in the
		 *                            getLocal method entry.
		 * @return                  <SharedObject> A reference to an object that can be shared across multiple clients.
		 */
		public static function getRemote(name:String, remotePath:String = null, persistence:Object = false, secure:Boolean = false):SharedObject;
		/**
		 * Broadcasts a message to all clients connected to a remote shared object,
		 *  including the client that sent the message. To process and respond to the message,
		 *  create a callback function attached to the shared object.
		 */
		public function send(... arguments):void;
		/**
		 * Indicates to the server that the value of a property
		 *  in the shared object has changed.
		 *  This method marks properties as dirty, which means changed.
		 *
		 * @param propertyName      <String> The name of the property that has changed.
		 */
		public function setDirty(propertyName:String):void;
		/**
		 * Updates the value of a property in a shared object and indicates to the server
		 *  that the value of the property has changed. The setProperty() method
		 *  explicitly marks properties as changed, or dirty.
		 *
		 * @param propertyName      <String> The name of the property in the shared object.
		 * @param value             <Object (default = null)> The value of the property (an ActionScript object), or null to delete the property.
		 */
		public function setProperty(propertyName:String, value:Object = null):void;
	}
}
