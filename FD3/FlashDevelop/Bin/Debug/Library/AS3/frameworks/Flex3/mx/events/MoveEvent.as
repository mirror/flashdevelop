package mx.events
{
	import flash.events.Event;

include "../core/Version.as"
	/**
	 *  Represents event objects that are dispatched when a Flex component moves.
 *
 *  @see mx.core.UIComponent
	 */
	public class MoveEvent extends Event
	{
		/**
		 *  The <code>MoveEvent.MOVE</code> constant defines the value of the
	 *  <code>type</code> property of the event object for a <code>move</code> event.
	 *
     *	<p>The properties of the event object have the following values:</p>
	 *  <table class="innertable">
	 *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the
     *       event listener that handles the event. For example, if you use
     *       <code>myButton.addEventListener()</code> to register an event listener,
     *       myButton is the value of the <code>currentTarget</code>. </td></tr>
     *     <tr><td><code>oldX</code></td><td>The previous x coordinate of the object, in pixels.</td></tr>
     *     <tr><td><code>oldY</code></td><td>The previous y coordinate of the object, in pixels.</td></tr>
     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;
     *       it is not always the Object listening for the event.
     *       Use the <code>currentTarget</code> property to always access the
     *       Object listening for the event.</td></tr>
	 *  </table>
	 *
     *  @eventType move
		 */
		public static const MOVE : String = "move";
		/**
		 *  The previous <code>x</code> coordinate of the object, in pixels.
		 */
		public var oldX : Number;
		/**
		 *  The previous <code>y</code> coordinate of the object, in pixels.
		 */
		public var oldY : Number;

		/**
		 *  Constructor.
	 *
	 *  @param type The event type; indicates the action that caused the event.
	 *
	 *  @param bubbles Specifies whether the event can bubble
	 *  up the display list hierarchy.
	 *
	 *  @param cancelable Specifies whether the behavior
	 *  associated with the event can be prevented.
	 *
	 *  @param oldX The previous x coordinate of the object, in pixels.
	 *
	 *  @param oldY The previous y coordinate of the object, in pixels.
		 */
		public function MoveEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldX:Number = NaN, oldY:Number = NaN);

		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}
