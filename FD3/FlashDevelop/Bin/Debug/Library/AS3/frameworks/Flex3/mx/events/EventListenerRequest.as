package mx.events
{
	import flash.events.Event;

include "../core/Version.as"
	/**
	 *  Request sent from one SystemManager to a SystemManager in another 
 *  application through their bridge to add or remove a listener to a specified event 
 *  on your behalf. The <code>data</code> property is not used. Only certain events
 *  can be requested. When the event is triggered in the other application, that
 *  event is re-dispatched through the bridge where the requesting
 *  SystemManager picks up the event and redispatches it from itself.
 *  In general, this request is generated because some other code called
 *  the <code>addEventListener()</code> method for one of the approved events on its SystemManager.
	 */
	public class EventListenerRequest extends SWFBridgeRequest
	{
		/**
		 *  Request to add an event listener.
		 */
		public static const ADD_EVENT_LISTENER_REQUEST : String = "addEventListenerRequest";
		/**
		 *  Request to remove an event listener.
		 */
		public static const REMOVE_EVENT_LISTENER_REQUEST : String = "removeEventListenerRequest";
		/**
		 *  @private
		 */
		private var _priority : int;
		/**
		 *  @private
		 */
		private var _useCapture : Boolean;
		/**
		 *  @private
		 */
		private var _eventType : String;
		/**
		 *  @private
		 */
		private var _useWeakReference : Boolean;

		/**
		 *  The <code>priority</code> parameter
     *  to <code>addEventListener()</code>.
     *
	 *  @see flash.events.IEventDispatcher#addEventListener
		 */
		public function get priority () : int;

		/**
		 *  The <code>useCapture</code> parameter
     *  to <code>addEventListener()</code>.
     *
	 *  @see flash.events.IEventDispatcher#addEventListener
		 */
		public function get useCapture () : Boolean;

		/**
		 *  The type of the event to listen to.
     *
	 *  @see flash.events.Event#type
		 */
		public function get eventType () : String;

		/**
		 *  The <code>useWeakReference</code> parameter
     *  to <code>addEventListener()</code>.
     *
	 *  @see flash.events.IEventDispatcher#addEventListener
		 */
		public function get useWeakReference () : Boolean;

		/**
		 *  Marshals an event by copying the relevant parameters
     *  from the event into a new event.
     	*  
     	*  @param event The event to marshal.
     	*  
     	*  @return An EventListenerRequest that defines the new event.
		 */
		public static function marshal (event:Event) : EventListenerRequest;

		/**
		 *  Creates a new request to add or remove an event listener.
	 * 
	 *  @param type The event type; indicates the action that caused the event. Either <code>EventListenerRequest.ADD</code>
	 *  or <code>EventListenerRequest.REMOVE</code>.
         *
         *  @param bubbles Specifies whether the event can bubble up the display list hierarchy.
         *
         *  @param cancelable Specifies whether the behavior associated with the event can be prevented.
         *
	 *  @param eventType The type of message you would normally pass to the <code>addEventListener()</code> method.
         *
	 *  @param useCapture Determines whether the listener works in the capture phase or the target and bubbling phases.
         *
	 *  @param priority The priority level of the event listener. Priorities are designated by a 32-bit integer.
         *
	 *  @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * 
	 *  @see flash.events.IEventDispatcher#addEventListener
		 */
		public function EventListenerRequest (type:String, bubbles:Boolean = false, cancelable:Boolean = true, eventType:String = null, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false);

		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}
