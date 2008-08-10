/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class EventDispatcher implements IEventDispatcher {
		/**
		 * Aggregates an instance of the EventDispatcher class.
		 *
		 * @param target            <IEventDispatcher (default = null)> The target object for events dispatched to the EventDispatcher object.
		 *                            This parameter is used when the EventDispatcher instance is aggregated by a class that implements IEventDispatcher; it is necessary so that the containing object can be the target for events.
		 *                            Do not use this parameter in simple cases in which a class extends EventDispatcher.
		 */
		public function EventDispatcher(target:IEventDispatcher = null);
		/**
		 * Registers an event listener object with an EventDispatcher object so that the listener
		 *  receives notification of an event. You can register event listeners on all nodes in the
		 *  display list for a specific type of event, phase, and priority.
		 *
		 * @param type              <String> The type of event.
		 * @param listener          <Function> The listener function that processes the event. This function must accept
		 *                            an Event object as its only parameter and must return nothing, as this example shows:
		 *                            function(evt:Event):void
		 *                            The function can have any name.
		 * @param useCapture        <Boolean (default = false)> Determines whether the listener works in the capture phase or the
		 *                            target and bubbling phases. If useCapture is set to true,
		 *                            the listener processes the event only during the capture phase and not in the
		 *                            target or bubbling phase. If useCapture is false, the
		 *                            listener processes the event only during the target or bubbling phase. To listen for
		 *                            the event in all three phases, call addEventListener twice, once with
		 *                            useCapture set to true, then again with
		 *                            useCapture set to false.
		 * @param priority          <int (default = 0)> The priority level of the event listener. The priority is designated by
		 *                            a signed 32-bit integer. The higher the number, the higher the priority. All listeners
		 *                            with priority n are processed before listeners of priority n-1. If two
		 *                            or more listeners share the same priority, they are processed in the order in which they
		 *                            were added. The default priority is 0.
		 * @param useWeakReference  <Boolean (default = false)> Determines whether the reference to the listener is strong or
		 *                            weak. A strong reference (the default) prevents your listener from being garbage-collected.
		 *                            A weak reference does not. Class-level member functions are not subject to garbage
		 *                            collection, so you can set useWeakReference to true for
		 *                            class-level member functions without subjecting them to garbage collection. If you set
		 *                            useWeakReference to true for a listener that is a nested inner
		 *                            function, the function will be garbage-collected and no longer persistent. If you create
		 *                            references to the inner function (save it in another variable) then it is not
		 *                            garbage-collected and stays persistent.
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		/**
		 * Dispatches an event into the event flow. The event target is the EventDispatcher
		 *  object upon which the dispatchEvent() method is called.
		 *
		 * @param event             <Event> The Event object that is dispatched into the event flow.
		 *                            If the event is being redispatched, a clone of the event is created automatically.
		 *                            After an event is dispatched, its target property cannot be changed, so you
		 *                            must create a new copy of the event for redispatching to work.
		 * @return                  <Boolean> A value of true if the event was successfully dispatched. A value of false indicates failure or that preventDefault() was called
		 *                            on the event.
		 */
		public function dispatchEvent(event:Event):Boolean;
		/**
		 * Checks whether the EventDispatcher object has any listeners registered for a specific type
		 *  of event. This allows you to determine where an EventDispatcher object has altered
		 *  handling of an event type in the event flow hierarchy. To determine whether a specific
		 *  event type actually triggers an event listener, use willTrigger().
		 *
		 * @param type              <String> The type of event.
		 * @return                  <Boolean> A value of true if a listener of the specified type is registered;
		 *                            false otherwise.
		 */
		public function hasEventListener(type:String):Boolean;
		/**
		 * Removes a listener from the EventDispatcher object. If there is no matching listener registered with the EventDispatcher object, a call to this method has no effect.
		 *
		 * @param type              <String> The type of event.
		 * @param listener          <Function> The listener object to remove.
		 * @param useCapture        <Boolean (default = false)> Specifies whether the listener was registered for the capture phase or the
		 *                            target and bubbling phases. If the listener was registered for both the capture phase and the
		 *                            target and bubbling phases, two calls to removeEventListener() are required
		 *                            to remove both, one call with useCapture() set to true, and another
		 *                            call with useCapture() set to false.
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		/**
		 * Checks whether an event listener is registered with this EventDispatcher object or any of
		 *  its ancestors for the specified event type. This method returns true if an
		 *  event listener is triggered during any phase of the event flow when an event of the
		 *  specified type is dispatched to this EventDispatcher object or any of its descendants.
		 *
		 * @param type              <String> The type of event.
		 * @return                  <Boolean> A value of true if a listener of the specified type will be triggered; false otherwise.
		 */
		public function willTrigger(type:String):Boolean;
	}
}
