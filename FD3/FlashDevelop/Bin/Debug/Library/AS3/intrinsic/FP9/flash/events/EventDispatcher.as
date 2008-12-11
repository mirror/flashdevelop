package flash.events
{
	/// The EventDispatcher class implements the IEventDispatcher interface and is the base class for the DisplayObject class.
	public class EventDispatcher
	{
		/** 
		 * [broadcast event] Dispatched when Flash Player loses operating system focus and is becoming inactive.
		 * @eventType flash.events.Event.DEACTIVATE
		 */
		[Event(name="deactivate", type="flash.events.Event")]

		/** 
		 * [broadcast event] Dispatched when Flash Player gains operating system focus and becomes active.
		 * @eventType flash.events.Event.ACTIVATE
		 */
		[Event(name="activate", type="flash.events.Event")]

		/// Aggregates an instance of the EventDispatcher class.
		public function EventDispatcher(target:flash.events.IEventDispatcher=null);

		/// Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void;

		/// Removes a listener from the EventDispatcher object.
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void;

		/// Dispatches an event into the event flow.
		public function dispatchEvent(event:flash.events.Event):Boolean;

		/// Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
		public function hasEventListener(type:String):Boolean;

		/// Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
		public function willTrigger(type:String):Boolean;

	}

}

