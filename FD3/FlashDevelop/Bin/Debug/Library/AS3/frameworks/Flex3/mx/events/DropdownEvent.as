﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The DropdownEvent class represents the event object passed to  *  the event listener for the <code>open</code> and <code>close</code> events.
	 */
	public class DropdownEvent extends Event
	{
		/**
		 *  The <code>DropdownEvent.CLOSE</code> constant defines the value of the 	 *  <code>type</code> property of the event object for a <code>close</code> event.	 *	 *  <p>The properties of the event object have the following values:</p>	 *  <table class="innertable">	 *     <tr><th>Property</th><th>Value</th></tr>     *     <tr><td><code>bubbles</code></td><td>false</td></tr>     *     <tr><td><code>cancelable</code></td><td>false</td></tr>     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the      *       event listener that handles the event. For example, if you use      *       <code>myButton.addEventListener()</code> to register an event listener,      *       myButton is the value of the <code>currentTarget</code>. </td></tr>     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;      *       it is not always the Object listening for the event.      *       Use the <code>currentTarget</code> property to always access the      *       Object listening for the event.</td></tr>     *     <tr><td><code>triggerEvent</code></td><td>A value indicating the      *       type of input action that triggered the event.</td></tr>	 *  </table>	 *     *  @eventType close
		 */
		public static const CLOSE : String = "close";
		/**
		 *  The <code>DropdownEvent.OPEN</code> constant defines the value of the 	 *  <code>type</code> property of the event object for a <code>open</code> event.	 *	 *  <p>The properties of the event object have the following values:</p>	 *  <table class="innertable">	 *     <tr><th>Property</th><th>Value</th></tr>     *     <tr><td><code>bubbles</code></td><td>false</td></tr>     *     <tr><td><code>cancelable</code></td><td>false</td></tr>     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the      *       event listener that handles the event. For example, if you use      *       <code>myButton.addEventListener()</code> to register an event listener,      *       myButton is the value of the <code>currentTarget</code>. </td></tr>     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;      *       it is not always the Object listening for the event.      *       Use the <code>currentTarget</code> property to always access the      *       Object listening for the event.</td></tr>     *     <tr><td><code>triggerEvent</code></td><td>A value indicating the      *       type of input action that triggered the event.</td></tr>	 *  </table>	 *     *  @eventType open
		 */
		public static const OPEN : String = "open";
		/**
		 *  If the control is opened or closed in response to a user action, 	 *  this property contains a value indicating the type of input action. 	 *  The value is either <code>InteractionInputType.MOUSE</code> 	 *  or <code>InteractionInputType.KEYBOARD</code>.
		 */
		public var triggerEvent : Event;

		/**
		 *  Constructor.	 *	 *  @param type The event type; indicates the action that caused the event.	 *	 *  @param bubbles Specifies whether the event can bubble	 *  up the display list hierarchy.	 *	 *  @param cancelable Specifies whether the behavior	 *  associated with the event can be prevented.	 *	 *  @param triggerEvent A value indicating the      *  type of input action that triggered the event
		 */
		public function DropdownEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, triggerEvent:Event = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}
