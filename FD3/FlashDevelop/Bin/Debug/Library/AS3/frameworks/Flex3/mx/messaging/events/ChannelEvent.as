package mx.messaging.events
{
	import flash.events.Event;
	import mx.messaging.Channel;

	/**
	 *  The ChannelEvent is used to propagate channel events within the messaging system.
	 */
	public class ChannelEvent extends Event
	{
		/**
		 *  The CONNECT event type; indicates that the Channel connected to its     *  endpoint.     *  <p>The value of this constant is <code>"channelConnect"</code>.</p>     *     *  <p>The properties of the event object have the following values:</p>     *  <table class="innertable">     *     <tr><th>Property</th><th>Value</th></tr>     *     <tr><td><code>bubbles</code></td><td>false</td></tr>     *     <tr><td><code>cancelable</code></td><td>false</td></tr>     *     <tr><td><code>channel</code></td><td>The channel that generated this event.</td></tr>        *     <tr><td><code>currentTarget</code></td><td>The Object that defines the      *       event listener that handles the event. For example, if you use      *       <code>myButton.addEventListener()</code> to register an event listener,      *       myButton is the value of the <code>currentTarget</code>. </td></tr>     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;      *       it is not always the Object listening for the event.      *       Use the <code>currentTarget</code> property to always access the      *       Object listening for the event.</td></tr>     *     <tr><td><code>reconnecting</code></td><td> Indicates whether the channel     *       that generated this event is reconnecting.</td></tr>     *     <tr><td><code>rejected</code></td><td> Indicates whether the channel that     *       generated this event was rejected. This would be true in the event that     *       the channel has been disconnected due to inactivity and should not attempt to     *       failover or connect on an alternate channel.</td></tr>        *  </table>     *  @eventType channelConnect
		 */
		public static const CONNECT : String = "channelConnect";
		/**
		 *  The DISCONNECT event type; indicates that the Channel disconnected from its     *  endpoint.     *  <p>The value of this constant is <code>"channelDisconnect"</code>.</p>     *     *  <p>The properties of the event object have the following values:</p>     *  <table class="innertable">     *     <tr><th>Property</th><th>Value</th></tr>     *     <tr><td><code>bubbles</code></td><td>false</td></tr>     *     <tr><td><code>cancelable</code></td><td>false</td></tr>     *     <tr><td><code>channel</code></td><td>The channel that generated this event.</td></tr>        *     <tr><td><code>currentTarget</code></td><td>The Object that defines the      *       event listener that handles the event. For example, if you use      *       <code>myButton.addEventListener()</code> to register an event listener,      *       myButton is the value of the <code>currentTarget</code>. </td></tr>     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;      *       it is not always the Object listening for the event.      *       Use the <code>currentTarget</code> property to always access the      *       Object listening for the event.</td></tr>     *     <tr><td><code>reconnecting</code></td><td> Indicates whether the channel     *       that generated this event is reconnecting.</td></tr>     *     <tr><td><code>rejected</code></td><td> Indicates whether the channel that     *       generated this event was rejected. This would be true in the event that     *       the channel has been disconnected due to inactivity and should not attempt to     *       failover or connect on an alternate channel.</td></tr>        *  </table>     *  @eventType channelDisconnect
		 */
		public static const DISCONNECT : String = "channelDisconnect";
		/**
		 *  The Channel that generated this event.
		 */
		public var channel : Channel;
		/**
		 * Indicates whether the Channel that generated this event is already connected.
		 */
		public var connected : Boolean;
		/**
		 *  Indicates whether the Channel that generated this event is reconnecting.
		 */
		public var reconnecting : Boolean;
		/**
		 *  Indicates whether the Channel that generated this event was rejected.      *  This would be true in the event that the channel has been     *  disconnected due to inactivity and should not attempt to failover or     *  connect on an alternate channel.
		 */
		public var rejected : Boolean;

		/**
		 * @private
		 */
		public function get channelId () : String;

		/**
		 *  Utility method to create a new ChannelEvent that doesn't bubble and     *  is not cancelable.     *      *  @param type The ChannelEvent type.     *       *  @param channel The Channel generating the event.     *      *  @param reconnecting Indicates whether the Channel is in the process of     *  reconnecting or not.     *      *  @param rejected Indicates whether the Channel's connection has been rejected,     *  which suppresses automatic reconnection.     *      *  @param connected Indicates whether the Channel that generated this event      *  is already connected.     *      *  @return New ChannelEvent.
		 */
		public static function createEvent (type:String, channel:Channel = null, reconnecting:Boolean = false, rejected:Boolean = false, connected:Boolean = false) : ChannelEvent;
		/**
		 *  Constructs an instance of this event with the specified type and Channel     *  instance.     *      *  @param type The ChannelEvent type.     *      *  @param bubbles Specifies whether the event can bubble up the display      *  list hierarchy.     *      *  @param cancelable Indicates whether the behavior associated with the      *  event can be prevented; used by the RPC subclasses.     *     *  @param channel The Channel generating the event.     *      *  @param reconnecting Indicates whether the Channel is in the process of     *  reconnecting or not.     *      *  @param rejected Indicates whether the Channel's connection has been rejected,     *  which suppresses automatic reconnection.     *      *  @param connected Indicates whether the Channel that generated this event      *  is already connected.
		 */
		public function ChannelEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, channel:Channel = null, reconnecting:Boolean = false, rejected:Boolean = false, connected:Boolean = false);
		/**
		 *  Clones the ChannelEvent.     *     *  @return Copy of this ChannelEvent.
		 */
		public function clone () : Event;
		/**
		 *  Returns a string representation of the ChannelEvent.     *     *  @return String representation of the ChannelEvent.
		 */
		public function toString () : String;
	}
}
