package mx.messaging.events
{
	import flash.events.Event;
	import mx.messaging.messages.IMessage;

	/**
	 *  Represents events that are dispatched as a result of invoking operations *  on a MessagePersister. * *  @see mx.messaging.MessagePersister * @private
	 */
	public class MessagePersisterEvent extends Event
	{
		/**
		 *  The <code>SUCCESS</code> status indicates that an operation invoked on a     *  message persister completed without errors.
		 */
		public static const SUCCESS : String = "success";
		/**
		 *  The <code>RESULT</code> status indicates that a <code>load</code> operation      *  invoked on a message persister is returning an array of stored messages.
		 */
		public static const RESULT : String = "result";
		/**
		 *  The <code>FAULT</code> status indicates that an operation invoked on a      *  message persister failed.
		 */
		public static const FAULT : String = "fault";
		private var _id : String;
		private var _op : String;
		private var _messages : Array;
		private var _message : IMessage;

		/**
		 *  The Id for the message agent that invoked the operation.
		 */
		public function get id () : String;
		/**
		 *  The operation that the message agent invoked.
		 */
		public function get operation () : String;
		/**
		 *  The messages associated with an event having status <code>RESULT</code>.
		 */
		public function set messages (value:Array) : void;
		public function get messages () : Array;
		/**
		 *  The source message that was passed to <code>save</code>     *  that was successfully saved or faulted.
		 */
		public function set message (value:IMessage) : void;
		public function get message () : IMessage;
		/**
		 * @private
		 */
		public function get messageId () : String;
		/**
		 * @private
		 */
		public function get messageCount () : int;

		/**
		 *  Normally called internally and not used in application code. This event is     *  generated to report a successful result for a load() invocation or succes or fault     *  for invoking operations on a <code>MessagePersister</code>.     *     *  @see mx.messaging.MessagePersister     *     *  @param The event type of the event.     *      *  @param bubbles Specifies whether the event can bubble up the display      *  list hierarchy.     *      *  @param cancelable Indicates whether the behavior associated with the      *  event can be prevented.     *      *  @param The Id for the message agent that invoked the operation.     *     *  @param The operation that the message agent invoked.
		 */
		public function MessagePersisterEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, id:String = null, operation:String = null);
		public static function createEvent (type:String, id:String, operation:String) : MessagePersisterEvent;
		/**
		 *  @private
		 */
		public function clone () : Event;
		public function toString () : String;
	}
}
