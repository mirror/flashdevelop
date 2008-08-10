/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.events {
	import mx.messaging.Channel;
	public class ChannelFaultEvent extends ChannelEvent {
		/**
		 * Provides access to the destination-specific failure code. For more
		 *  specific details see the faultString and
		 *  faultDetails properties.
		 */
		public var faultCode:String;
		/**
		 * Provides destination-specific details of the failure.
		 */
		public var faultDetail:String;
		/**
		 * Provides access to the destination-specific reason for the failure.
		 */
		public var faultString:String;
		/**
		 * Provides access to the underlying reason for the failure if the channel did
		 *  not raise the failure itself.
		 */
		public var rootCause:Object;
		/**
		 * Constructs an instance of this event with the specified type.
		 *  Note that the rejected and connected arguments that correspond to properties
		 *  defined by the super-class ChannelEvent were not originally included in this method signature and have been
		 *  added at the end of the argument list to preserve backward compatibility even though this signature differs from
		 *  ChannelEvent's constructor.
		 *
		 * @param type              <String> The Channel generating the event.
		 * @param bubbles           <Boolean (default = false)> Indicates whether the Channel is in the process of
		 *                            reconnecting or not.
		 * @param cancelable        <Boolean (default = false)> The fault code.
		 * @param channel           <Channel (default = null)> The fault level.
		 * @param reconnecting      <Boolean (default = false)> The fault description.
		 * @param code              <String (default = null)> Indicates whether the Channel's connection has been rejected,
		 *                            which suppresses automatic reconnection.
		 * @param level             <String (default = null)> Indicates whether the Channel that generated this event
		 *                            is already connected.
		 * @param description       <String (default = null)> 
		 * @param rejected          <Boolean (default = false)> 
		 * @param connected         <Boolean (default = false)> 
		 */
		public function ChannelFaultEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, channel:Channel = null, reconnecting:Boolean = false, code:String = null, level:String = null, description:String = null, rejected:Boolean = false, connected:Boolean = false);
		/**
		 * Clones the ChannelFaultEvent.
		 *
		 * @return                  <Event> Copy of this ChannelFaultEvent.
		 */
		public override function clone():Event;
		/**
		 * Creates an ErrorMessage based on the ChannelFaultEvent by copying over
		 *  the faultCode, faultString, faultDetail and rootCause to the new ErrorMessage.
		 *
		 * @return                  <ErrorMessage> The ErrorMessage.
		 */
		public function createErrorMessage():ErrorMessage;
		/**
		 * Utility method to create a new ChannelFaultEvent that doesn't bubble and
		 *  is not cancelable.
		 *
		 * @param channel           <Channel> The Channel generating the event.
		 * @param reconnecting      <Boolean (default = false)> Indicates whether the Channel is in the process of
		 *                            reconnecting or not.
		 * @param code              <String (default = null)> The fault code.
		 * @param level             <String (default = null)> The fault level.
		 * @param description       <String (default = null)> The fault description.
		 * @param rejected          <Boolean (default = false)> Indicates whether the Channel's connection has been rejected,
		 *                            which suppresses automatic reconnection.
		 * @param connected         <Boolean (default = false)> Indicates whether the Channel that generated this event
		 *                            is already connected.
		 * @return                  <ChannelFaultEvent> New ChannelFaultEvent.
		 */
		public static function createEvent(channel:Channel, reconnecting:Boolean = false, code:String = null, level:String = null, description:String = null, rejected:Boolean = false, connected:Boolean = false):ChannelFaultEvent;
		/**
		 * Returns a string representation of the ChannelFaultEvent.
		 *
		 * @return                  <String> String representation of the ChannelFaultEvent.
		 */
		public override function toString():String;
		/**
		 * The FAULT event type; indicates that the Channel faulted.
		 */
		public static const FAULT:String = "channelFault";
	}
}
