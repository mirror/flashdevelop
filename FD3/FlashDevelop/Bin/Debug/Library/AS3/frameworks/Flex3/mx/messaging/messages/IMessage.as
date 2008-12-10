package mx.messaging.messages
{
	/**
	 *  This interface defines the contract for message objects.
	 */
	public interface IMessage
	{
		/**
		 *  The body of a message contains the specific data that needs to be      *  delivered to the remote destination.
		 */
		public function get body () : Object;
		/**
		 *  @private
		 */
		public function set body (value:Object) : void;
		/**
		 *  The clientId indicates which client sent the message.
		 */
		public function get clientId () : String;
		/**
		 *  @private
		 */
		public function set clientId (value:String) : void;
		/**
		 *  The message destination.
		 */
		public function get destination () : String;
		/**
		 *  @private
		 */
		public function set destination (value:String) : void;
		/**
		 *  Provides access to the headers of the message.     *  The headers of a message are an associative array where the key is the     *  header name.     *  This property provides access to specialized meta information for the      *  specific message instance.
		 */
		public function get headers () : Object;
		/**
		 *  @private
		 */
		public function set headers (value:Object) : void;
		/**
		 *  The unique id for the message.     *  The message id can be used to correlate a response to the original     *  request message in request-response messaging scenarios.
		 */
		public function get messageId () : String;
		/**
		 *  @private
		 */
		public function set messageId (value:String) : void;
		/**
		 *  Provides access to the time stamp for the message.     *  A time stamp is the date and time that the message was sent.     *  The time stamp is used for tracking the message through the system,     *  ensuring quality of service levels and providing a mechanism for     *  expiration.     *     *  @see #timeToLive
		 */
		public function get timestamp () : Number;
		/**
		 *  @private
		 */
		public function set timestamp (value:Number) : void;
		/**
		 *  The time to live value of a message indicates how long the message     *  should be considered valid and deliverable.     *  This value works in conjunction with the <code>timestamp</code> value.     *  Time to live is the number of milliseconds that this message remains     *  valid starting from the specified <code>timestamp</code> value.     *  For example, if the <code>timestamp</code> value is 04/05/05 1:30:45 PST     *  and the <code>timeToLive</code> value is 5000, then this message will     *  expire at 04/05/05 1:30:50 PST.     *  Once a message expires it will not be delivered to any other clients.
		 */
		public function get timeToLive () : Number;
		/**
		 *  @private
		 */
		public function set timeToLive (value:Number) : void;

		/**
		 *  This method will return a string representation of the message.     *     *  @return String representation of the message.
		 */
		public function toString () : String;
	}
}
