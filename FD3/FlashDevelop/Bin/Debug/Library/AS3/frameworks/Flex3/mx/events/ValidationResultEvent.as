package mx.events
{
	import flash.events.Event;

include "../core/Version.as"
	/**
	 *  The ValidationResultEvent class represents the event object 
 *  passed to the listener for the <code>valid</code> validator event
 *  or the <code>invalid</code> validator event. 
 *
 *  @see mx.validators.Validator
 *  @see mx.validators.ValidationResult
 *  @see mx.validators.RegExpValidationResult
	 */
	public class ValidationResultEvent extends Event
	{
		/**
		 *  The <code>ValidationResultEvent.INVALID</code> constant defines the value of the 
	 *  <code>type</code> property of the event object for an <code>invalid</code> event.
	 *  The value of this constant is "invalid".
	 *
	 *  <p>The properties of the event object have the following values:</p>
	 *  <table class="innertable">
	 *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the 
     *       event listener that handles the event. For example, if you use 
     *       <code>myButton.addEventListener()</code> to register an event listener, 
     *       myButton is the value of the <code>currentTarget</code>. </td></tr>
     *     <tr><td><code>field</code></td><td>The name of the field that failed validation.</td></tr>
     *     <tr><td><code>message</code></td><td>A single string that contains 
     *       every error message from all of the ValidationResult objects in the results Array.</td></tr>
     *     <tr><td><code>results</code></td><td>An array of ValidationResult objects, 
     *       one per validated field.</td></tr>
     *     <tr><td><code>target</code></td><td>The Object that dispatched the event; 
     *       it is not always the Object listening for the event. 
     *       Use the <code>currentTarget</code> property to always access the 
     *       Object listening for the event.</td></tr>
	 *  </table>
	 *
     *  @eventType invalid
		 */
		public static const INVALID : String = "invalid";
		/**
		 *  The <code>ValidationResultEvent.VALID</code> constant defines the value of the 
	 *  <code>type</code> property of the event object for a <code>valid</code>event.
	 *  The value of this constant is "valid".
	 *
	 *  <p>The properties of the event object have the following values:</p>
	 *  <table class="innertable">
	 *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the 
     *       event listener that handles the event. For example, if you use 
     *       <code>myButton.addEventListener()</code> to register an event listener, 
     *       myButton is the value of the <code>currentTarget</code>. </td></tr>
     *     <tr><td><code>field</code></td><td>An empty String.</td></tr>
     *     <tr><td><code>message</code></td><td>An empty String.</td></tr>
     *     <tr><td><code>results</code></td><td>An empty Array.</td></tr>
     *     <tr><td><code>target</code></td><td>The Object that dispatched the event; 
     *       it is not always the Object listening for the event. 
     *       Use the <code>currentTarget</code> property to always access the 
     *       Object listening for the event.</td></tr>
	 *  </table>
	 *
     *  @eventType valid
		 */
		public static const VALID : String = "valid";
		/**
		 *  The name of the field that failed validation and triggered the event.
		 */
		public var field : String;
		/**
		 *  An array of ValidationResult objects, one per validated field. 
	 *
	 *  @see mx.validators.ValidationResult
		 */
		public var results : Array;

		/**
		 *  A single string that contains every error message from all
	 *  of the ValidationResult objects in the results Array.
		 */
		public function get message () : String;

		/**
		 *  Constructor.
	 *
	 *  @param type The event type; indicates the action that caused the event.
	 *
	 *  @param bubbles Specifies whether the event can bubble up the 
	 *  display list hierarchy.
	 *
	 *  @param cancelable Specifies whether the behavior associated with the event can be prevented.
	 *
	 *  @param field The name of the field that failed validation and triggered the event.
	 *
	 *  @param results An array of ValidationResult objects, one per validated field.
		 */
		public function ValidationResultEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, field:String = null, results:Array = null);

		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}
