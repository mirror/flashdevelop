﻿package mx.rpc.events
{
	import flash.events.Event;
	import mx.messaging.messages.IMessage;
	import mx.rpc.AsyncToken;

	/**
	 * The event that indicates an RPC operation has been invoked.
	 */
	public class InvokeEvent extends AbstractEvent
	{
		/**
		 * The INVOKE event type.     *      * <p>The properties of the event object have the following values:</p>     * <table class="innertable">     *     <tr><th>Property</th><th>Value</th></tr>     *     <tr><td><code>bubbles</code></td><td>false</td></tr>     *     <tr><td><code>token</code></td><td> The token that represents the indiviudal call     *     to the method. Used in the asynchronous completion token pattern.</td></tr>     *     <tr><td><code>cancelable</code></td><td>true</td></tr>     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the      *       event listener that handles the event. For example, if you use      *       <code>myButton.addEventListener()</code> to register an event listener,      *       myButton is the value of the <code>currentTarget</code>. </td></tr>     *     <tr><td><code>message</code></td><td> The request Message associated with this event.</td></tr>     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;      *       it is not always the Object listening for the event.      *       Use the <code>currentTarget</code> property to always access the      *       Object listening for the event.</td></tr>     *  </table>     *  @eventType invoke
		 */
		public static const INVOKE : String = "invoke";

		/**
		 * Create a new InvokeEvent.     * @param type The event type; indicates the action that triggered the event.     * @param bubbles Specifies whether the event can bubble up the display list hierarchy.     * @param cancelable Specifies whether the behavior associated with the event can be prevented.     * @param token Token that represents the call to the method. Used in the asynchronous      *     completion token pattern.     * @param message Source Message of the request.
		 */
		public function InvokeEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, token:AsyncToken = null, message:IMessage = null);
		/**
		 * @private
		 */
		public static function createEvent (token:AsyncToken = null, message:IMessage = null) : InvokeEvent;
		/**
		 * Because this event can be re-dispatched we have to implement clone to     * return the appropriate type, otherwise we will get just the standard     * event type.     * @private
		 */
		public function clone () : Event;
		/**
		 * Returns a string representation of the InvokeEvent.    *    * @return String representation of the InvokeEvent.
		 */
		public function toString () : String;
	}
}
