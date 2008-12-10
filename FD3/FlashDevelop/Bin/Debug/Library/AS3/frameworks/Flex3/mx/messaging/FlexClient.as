package mx.messaging
{
	import flash.events.EventDispatcher;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;

	/**
	 *  Dispatched when a property of the FlexClient singleton changes. *  Listeners must be added via FlexClient.getInstance().addEventListener(...). *  *  @eventType mx.events.PropertyChangeEvent.PROPERTY_CHANGE
	 */
	[Event(name="propertyChange", type="mx.events.PropertyChangeEvent")] 

	/**
	 *  Singleton class that stores the global Id for this Player instance that is  *  server assigned when the client makes its initial connection to the server.
	 */
	public class FlexClient extends EventDispatcher
	{
		/**
		 *  @private     *  This value is passed to the server in an initial client connect to     *  indicate that the client needs a server-assigned FlexClient Id.
		 */
		static const NULL_FLEXCLIENT_ID : String = "nil";
		/**
		 *  @private	 *  The sole instance of this singleton class.
		 */
		private static var _instance : FlexClient;
		/**
		 *  @private     *  Storage for the global FlexClient Id for the Player instance.      *  This value is server assigned and is set as part of the Channel connect process.
		 */
		private var _id : String;
		/**
		 *  @private
		 */
		private var _waitForFlexClientId : Boolean;

		/**
		 *  The global FlexClient Id for this Player instance.     *  This value is server assigned and is set as part of the Channel connect process.     *  Once set, it will not change for the duration of the Player instance's lifespan.     *  If no Channel has connected to a server this value is null.
		 */
		public function get id () : String;
		/**
		 *  @private
		 */
		public function set id (value:String) : void;
		/**
		 *  @private      *  Guard condition that Channel instances use to coordinate their connect attempts during application startup     *  when a FlexClient Id has not yet been returned by the server.     *  The initial Channel connect process must be serialized.     *  Once a FlexClient Id is set further Channel connects and disconnects do not require synchronization.
		 */
		function get waitForFlexClientId () : Boolean;
		/**
		 *  @private
		 */
		function set waitForFlexClientId (value:Boolean) : void;

		/**
		 *  Returns the sole instance of this singleton class,	 *  creating it if it does not already exist.         *         *  @return Returns the sole instance of this singleton class,	 *  creating it if it does not already exist.
		 */
		public static function getInstance () : FlexClient;
		/**
		 *  @private	 *  Constructor.
		 */
		public function FlexClient ();
	}
}
