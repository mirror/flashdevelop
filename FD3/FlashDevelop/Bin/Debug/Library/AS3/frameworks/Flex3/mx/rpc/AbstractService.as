/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc {
	import flash.utils.Proxy;
	import flash.events.IEventDispatcher;
	import mx.messaging.ChannelSet;
	public dynamic  class AbstractService extends Proxy implements IEventDispatcher {
		/**
		 * Provides access to the ChannelSet used by the service. The
		 *  ChannelSet can be manually constructed and assigned, or it will be
		 *  dynamically created to use the configured Channels for the
		 *  destination for this service.
		 */
		public function get channelSet():ChannelSet;
		public function set channelSet(value:ChannelSet):void;
		/**
		 * The destination of the service. This value should match a destination
		 *  entry in the services-config.xml file.
		 */
		public function get destination():String;
		public function set destination(value:String):void;
		/**
		 * The Operations array is usually only set by the MXML compiler if you
		 *  create a service using an MXML tag.
		 */
		public function get operations():Object;
		public function set operations(value:Object):void;
		/**
		 * Provides access to the request timeout in seconds for sent messages.
		 *  A value less than or equal to zero prevents request timeout.
		 */
		public function get requestTimeout():int;
		public function set requestTimeout(value:int):void;
		/**
		 * Disconnects the service's network connection and removes any pending
		 *  request responders.
		 *  This method does not wait for outstanding network operations to complete.
		 */
		public function disconnect():void;
		/**
		 * Returns an Operation of the given name. If the Operation wasn't
		 *  created beforehand, subclasses are responsible for creating it during
		 *  this call. Operations are usually accessible by simply naming them after
		 *  the service variable (myService.someOperation), but if your
		 *  Operation name happens to match a defined method on the service (like
		 *  setCredentials), you can use this method to get the
		 *  Operation instead.
		 *
		 * @param name              <String> Name of the Operation.
		 * @return                  <AbstractOperation> Operation that executes for this name.
		 */
		public function getOperation(name:String):AbstractOperation;
		/**
		 * Logs the user out of the destination.
		 *  Logging out of a destination applies to everything connected using the
		 *  same ChannelSet as specified in the server configuration. For example,
		 *  if you're connected over the my-rtmp channel and you log out using one
		 *  of your RPC components, anything that was connected over the same
		 *  ChannelSet is logged out.
		 */
		public function logout():void;
		/**
		 * Sets the credentials for the destination accessed by the service when using Data Services on the server side.
		 *  The credentials are applied to all services connected over the same
		 *  ChannelSet. Note that services that use a proxy or a third-party adapter
		 *  to a remote endpoint will need to setRemoteCredentials instead.
		 *
		 * @param username          <String> The username for the destination.
		 * @param password          <String> The password for the destination.
		 * @param charset           <String (default = null)> The character set encoding to use while encoding the
		 *                            credentials. The default is null, which implies the legacy charset of
		 *                            ISO-Latin-1. The only other supported charset is "UTF-8".
		 */
		public function setCredentials(username:String, password:String, charset:String = null):void;
		/**
		 * The username and password to be used to authenticate a user when
		 *  accessing a remote, third-party endpoint such as a web service through a
		 *  proxy or a remote object through a custom adapter when using Data Services on the server side.
		 *
		 * @param remoteUsername    <String> the username to pass to the remote endpoint
		 * @param remotePassword    <String> the password to pass to the remote endpoint
		 * @param charset           <String (default = null)> The character set encoding to use while encoding the
		 *                            remote credentials. The default is null, which implies the legacy charset
		 *                            of ISO-Latin-1. The only other supported charset is "UTF-8".
		 */
		public function setRemoteCredentials(remoteUsername:String, remotePassword:String, charset:String = null):void;
	}
}
