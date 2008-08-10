/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.events {
	import flash.events.Event;
	import mx.messaging.Channel;
	public class ChannelEvent extends Event {
		/**
		 * The Channel that generated this event.
		 */
		public var channel:Channel;
		/**
		 * Indicates whether the Channel that generated this event is already connected.
		 */
		public var connected:Boolean;
		/**
		 * Indicates whether the Channel that generated this event is reconnecting.
		 */
		public var reconnecting:Boolean;
		/**
		 * Indicates whether the Channel that generated this event was rejected.
		 *  This would be true in the event that the channel has been
		 *  disconnected due to inactivity and should not attempt to failover or
		 *  connect on an alternate channel.
		 */
		public var rejected:Boolean;
		/**
		 * Constructs an instance of this event with the specified type and Channel
		 *  instance.
		 *
		 * @param type              <String> The ChannelEvent type.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display
		 *                            list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Indicates whether the behavior associated with the
		 *                            event can be prevented; used by the RPC subclasses.
		 * @param channel           <Channel (default = null)> The Channel generating the event.
		 * @param reconnecting      <Boolean (default = false)> Indicates whether the Channel is in the process of
		 *                            reconnecting or not.
		 * @param rejected          <Boolean (default = false)> Indicates whether the Channel's connection has been rejected,
		 *                            which suppresses automatic reconnection.
		 * @param connected         <Boolean (default = false)> Indicates whether the Channel that generated this event
		 *                            is already connected.
		 */
		public function ChannelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, channel:Channel = null, reconnecting:Boolean = false, rejected:Boolean = false, connected:Boolean = false);
		/**
		 * Clones the ChannelEvent.
		 *
		 * @return                  <Event> Copy of this ChannelEvent.
		 */
		public override function clone():Event;
		/**
		 * Utility method to create a new ChannelEvent that doesn't bubble and
		 *  is not cancelable.
		 *
		 * @param type              <String> The ChannelEvent type.
		 * @param channel           <Channel (default = null)> The Channel generating the event.
		 * @param reconnecting      <Boolean (default = false)> Indicates whether the Channel is in the process of
		 *                            reconnecting or not.
		 * @param rejected          <Boolean (default = false)> Indicates whether the Channel's connection has been rejected,
		 *                            which suppresses automatic reconnection.
		 * @param connected         <Boolean (default = false)> Indicates whether the Channel that generated this event
		 *                            is already connected.
		 * @return                  <ChannelEvent> New ChannelEvent.
		 */
		public static function createEvent(type:String, channel:Channel = null, reconnecting:Boolean = false, rejected:Boolean = false, connected:Boolean = false):ChannelEvent;
		/**
		 * Returns a string representation of the ChannelEvent.
		 *
		 * @return                  <String> String representation of the ChannelEvent.
		 */
		public override function toString():String;
		/**
		 * The CONNECT event type; indicates that the Channel connected to its
		 *  endpoint.
		 */
		public static const CONNECT:String = "channelConnect";
		/**
		 * The DISCONNECT event type; indicates that the Channel disconnected from its
		 *  endpoint.
		 */
		public static const DISCONNECT:String = "channelDisconnect";
	}
}
