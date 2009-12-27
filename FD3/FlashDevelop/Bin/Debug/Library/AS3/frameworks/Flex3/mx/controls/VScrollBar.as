package mx.controls
{
	import flash.ui.Keyboard;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.controls.scrollClasses.ScrollBarDirection;
	import mx.core.mx_internal;
	import mx.events.ScrollEvent;

	/**
	 *  Dispatched when the ScrollBar control scrolls through
 *  user initiated action or programmatically. 
 *
 *  @eventType mx.events.ScrollEvent.SCROLL
	 */
	[Event(name="scroll", type="mx.events.ScrollEvent")] 

	/**
	 *  Number of milliseconds to wait after the first <code>buttonDown</code>
 *  event before repeating <code>buttonDown</code> events at the
 *  <code>repeatInterval</code>.
 *  The default value is 500.
	 */
	[Style(name="repeatDelay", type="Number", format="Time", inherit="no")] 

	/**
	 *  Number of milliseconds between <code>buttonDown</code> events
 *  if the user presses and holds the mouse on a button.
 *  The default value is 35.
	 */
	[Style(name="repeatInterval", type="Number", format="Time", inherit="no")] 

	[Exclude(name="direction", kind="property")] 

include "../core/Version.as"
	/**
	 *  The VScrollBar (vertical ScrollBar) control  lets you control
 *  the portion of data that is displayed when there is too much data
 *  to fit in a display area.
 * 
 *  This control extends the base ScrollBar control. 
 *  
 *  <p>Although you can use the VScrollBar control as a stand-alone control,
 *  you usually combine it as part of another group of components to
 *  provide scrolling functionality.</p>
 *  
 *  <p>A ScrollBar control consist of four parts: two arrow buttons,
 *  a track, and a thumb. 
 *  The position of the thumb and the display of the arrow buttons
 *  depend on the current state of the ScrollBar control.
 *  The ScrollBar control uses four parameters to calculate its 
 *  display state:</p>
 *
 *  <ul>
 *    <li>Minimum range value</li>
 *    <li>Maximum range value</li>
 *    <li>Current position - must be within the
 *    minimum and maximum range values</li>
 *    <li>Viewport size - represents the number of items
 *    in the range that you can display at one time. The
 *    number of items must be less than or equal to the 
 *    range, where the range is the set of values between
 *    the minimum range value and the maximum range value.</li>
 *  </ul>
 *  
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:VScrollBar&gt;</code> tag inherits all the
 *  tag attributes of its superclass, and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:VScrollBar
 *    <strong>Styles</strong>
 *    repeatDelay="500"
 *    repeatInterval="35"
 * 
 *    <strong>Events</strong>
 *    scroll="<i>No default</i>"
 *  /&gt;
 *  </pre>
 *  
 *  @includeExample examples/VScrollBarExample.mxml
 *
 *  @see mx.controls.scrollClasses.ScrollBar
	 */
	public class VScrollBar extends ScrollBar
	{
		/**
		 *  @private
     *  Don't allow user to change the direction.
		 */
		public function set direction (value:String) : void;

		/**
		 *  @private
		 */
		public function get minWidth () : Number;

		/**
		 *  @private
		 */
		public function get minHeight () : Number;

		/**
		 *  Constructor.
		 */
		public function VScrollBar ();

		/**
		 *  @private
		 */
		protected function measure () : void;

		/**
		 *  @private
     *  Map keys to scroll events.
		 */
		function isScrollBarKey (key:uint) : Boolean;
	}
}
