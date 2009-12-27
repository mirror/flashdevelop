package mx.events
{
	import flash.events.Event;

include "../core/Version.as"
	/**
	 *  Represents event objects that are dispatched when the size of a Flex 
 *  component changes.
 *
 *  @see mx.core.UIComponent
	 */
	public class ResizeEvent extends Event
	{
		/**
		 *  The <code>ResizeEvent.RESIZE</code> constant defines the value of the
	 *  <code>type</code> property of the event object for a <code>resize</code> event.
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
     *     <tr><td><code>oldHeight</code></td><td>The previous height of the object, in pixels.</td></tr>
     *     <tr><td><code>oldWidth</code></td><td>The previous width of the object, in pixels.</td></tr>
     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;
     *       it is not always the Object listening for the event.
     *       Use the <code>currentTarget</code> property to always access the
     *       Object listening for the event.</td></tr>
	 *  </table>
	 *
     *  @eventType resize
		 */
		public static const RESIZE : String = "resize";
		/**
		 *  The previous <code>height</code> of the object, in pixels.
		 */
		public var oldHeight : Number;
		/**
		 *  The previous <code>width</code> of the object, in pixels.
		 */
		public var oldWidth : Number;

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
	 *  @param oldWidth The previous width of the object, in pixels.
	 *
	 *  @param oldHeight The previous height of the object, in pixels.
		 */
		public function ResizeEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldWidth:Number = NaN, oldHeight:Number = NaN);

		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}
