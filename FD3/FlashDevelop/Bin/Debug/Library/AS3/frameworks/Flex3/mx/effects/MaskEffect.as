package mx.effects
{
	import flash.events.EventDispatcher;
	import mx.effects.effectClasses.MaskEffectInstance;
	import mx.events.TweenEvent;

	/**
	 *  Dispatched when the effect starts, which corresponds to the 
 *  first call to the <code>onMoveTweenUpdate()</code> 
 *  and <code>onScaleTweenUpdate()</code> methods. 
 *  Flex also dispatches the first <code>tweenUpdate</code> event 
 *  for the effect at the same time.
 *
 *  <p>The <code>Effect.effectStart</code> event is dispatched 
 *  before the <code>tweenStart</code> event.</p>
 *
 *  @eventType mx.events.TweenEvent.TWEEN_START
	 */
	[Event(name="tweenStart", type="mx.events.TweenEvent")] 

	/**
	 *  Dispatched every time the effect updates the target. 
 *  The dispatching of this event corresponds to the 
 *  calls to the <code>onMoveTweenUpdate()</code> 
 *  and <code>onScaleTweenUpdate()</code> methods.
 *
 *  @eventType mx.events.TweenEvent.TWEEN_UPDATE
	 */
	[Event(name="tweenUpdate", type="mx.events.TweenEvent")] 

	/**
	 *  Dispatched when the effect ends.
 *
 *  <p>When an effect plays a single time, this event occurs
 *  at the same time as an <code>effectEnd</code> event.
 *  If you configure the effect to repeat, 
 *  it occurs at the end of every repetition of the effect,
 *  and the <code>endEffect</code> event occurs
 *  after the effect plays for the final time.</p>
 *
 *  @eventType mx.events.TweenEvent.TWEEN_END
	 */
	[Event(name="tweenEnd", type="mx.events.TweenEvent")] 

include "../core/Version.as"
	/**
	 *  The MaskEffect class is an abstract base class for all effects 
 *  that animate a mask, such as the wipe effects and the Iris effect. 
 *  This class encapsulates methods and properties that are common
 *  among all mask-based effects.
 *
 *  <p>A mask effect uses an overlay, called a mask, to perform the effect. 
 *  By default, the mask is a rectangle with the same size
 *  as the target component. </p>
 *
 *  <p>The before or after state of the target component of a mask effect
 *  must be invisible.
 *  That means a mask effect always makes a target component appear on 
 *  the screen, or disappear from the screen.</p>
 *
 *  <p>You use the <code>scaleXFrom</code>, <code>scaleYFrom</code>, 
 *  <code>scaleXTo</code>, and <code>scaleX</code> properties to specify 
 *  the initial and final scale of the mask, where a value of 1.0 corresponds
 *  to scaling the mask to the size of the target component, 2.0 scales 
 *  the mask to twice the size of the component, 0.5 scales the mask to half 
 *  the size of the component, and so on. 
 *  To use any one of these properties, you must specify all four.</p>
 *
 *  <p>You use the <code>xFrom</code>, <code>yFrom</code>, <code>xTo</code>, 
 *  and <code>yTo</code> properties to specify the coordinates of the initial
 *  position and final position of the mask relative to the target component, 
 *  where (0, 0) corresponds to the upper left corner of the target. 
 *  To use any one of these properties, you must specify all four.</p>
 *
 *  <p>The coordinates of the initial and final position of the mask
 *  depend on the type of effect and whether the <code>show</code> property
 *  is <code>true</code> or <code>false</code>.
 *  For example, for the WipeLeft effect with a <code>show</code> value of
 *  <code>false</code>, the coordinates of the initial mask position
 *  are (0, 0),corresponding to the upper-left corner of the target, 
 *  and the coordinates of the final position are the upper-right corner
 *  of the target (width, 0), where width is the width of the target.</p>
 * 
 *  <p>For a <code>show</code> value of <code>true</code> for the WipeLeft
 *  effect, the coordinates of the initial mask position are (width, 0),
 *  and the coordinates of the final position are (0, 0).</p>
 *
 *  @mxml
 *
 *  <p>The MaskEffect class defines the following properties, 
 *  which all of its subclasses inherit:</p>
 *  
 *  <pre>
 *  &lt;mx:<i>tagname</i>
 *    createMaskFunction=""
 *    moveEasingFunction=""
 *    scaleEasingFunction=""
 *    scaleXFrom=""
 *    scaleXTo=""
 *    scaleYFrom=""
 *    scaleYTo=""
 *    show="true|false"
 *    xFrom=""
 *    xTo=""
 *    yFrom=""
 *    yTo=""
 *  /&gt;
 *  </pre>
 *  
 *  @see mx.effects.effectClasses.MaskEffectInstance
 *  @see mx.effects.TweenEffect
	 */
	public class MaskEffect extends Effect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;
		/**
		 *  Function called when the effect creates the mask.
     *  The default value is a function that returns a Rectangle
     *  with the same dimensions as the target. 
     *
     *  <p>The custom mask function has the following signature:</p>
     *
     *  <pre>
     *  public function createLargeMask(targ:Object, bounds:Rectangle):Shape
     *  {
     *      var myMask:Shape = new FlexShape();
     *
     *      // Create mask.
     *
     *      return myMask;
     *  }
     *  </pre>
     *
     *  <p>Your custom mask function takes an argument
     *  corresponding to the target component of the effect, 
     *  and a second argument that defines the dimensions of the 
     *  target so that you can correctly size the mask. 
     *  You use that argument to access properties of the target
     *  component, such as <code>width</code> and <code>height</code>,
     *  so that you can create a mask with the correct size.</p>
     *
     *  <p>The function returns a single Shape object
     *  that defines the mask.</p>
		 */
		public var createMaskFunction : Function;
		/**
		 *  Easing function to use for moving the mask.
     *  @default null
		 */
		public var moveEasingFunction : Function;
		/**
		 *  @private
     *  Flag indicating whether the mask is removed automatically
     *  when the effect finishes. If false, it is removed.
     *
     *  @default true
		 */
		var persistAfterEnd : Boolean;
		/**
		 *  Easing function to use for scaling the mask.
     *  @default null
		 */
		public var scaleEasingFunction : Function;
		/**
		 *  Initial scaleX for mask.
     *
     *  <p>To specify this property,
     *  you must specify all four of these properties:
     *  <code>scaleXFrom</code>, <code>scaleYFrom</code>, 
     *  <code>scaleXTo</code>, and <code>scaleX</code>.</p>
		 */
		public var scaleXFrom : Number;
		/**
		 *  Ending scaleX for mask.
     *
     *  <p>To specify this property,
     *  you must specify all four of these properties:
     *  <code>scaleXFrom</code>, <code>scaleYFrom</code>, 
     *  <code>scaleXTo</code>, and <code>scaleX</code>.</p>
		 */
		public var scaleXTo : Number;
		/**
		 *  Initial scaleY for mask.
     *
     *  <p>To specify this property,
     *  you must specify all four of these properties:
     *  <code>scaleXFrom</code>, <code>scaleYFrom</code>, 
     *  <code>scaleXTo</code>, and <code>scaleX</code>.</p>
		 */
		public var scaleYFrom : Number;
		/**
		 *  Ending scaleY for mask.
     *
     *  <p>To specify this property,
     *  you must specify all four of these properties:
     *  <code>scaleXFrom</code>, <code>scaleYFrom</code>, 
     *  <code>scaleXTo</code>, and <code>scaleX</code>.</p>
		 */
		public var scaleYTo : Number;
		/**
		 *  @private
     *  Storage for the showTarget property.
		 */
		private var _showTarget : Boolean;
		/**
		 *  @private
		 */
		private var _showExplicitlySet : Boolean;
		/**
		 *  Initial position's x coordinate for mask.
     *
     *  <p>To specify this property,
     *  you must specify all four of these properties:
     *  <code>xFrom</code>, <code>yFrom</code>, <code>xTo</code>, 
     *  and <code>yTo</code>. </p>
		 */
		public var xFrom : Number;
		/**
		 *  Destination position's x coordinate for mask.
     *
     *  <p>To specify this property,
     *  you must specify all four of these properties:
     *  <code>xFrom</code>, <code>yFrom</code>, <code>xTo</code>, 
     *  and <code>yTo</code>. </p>
		 */
		public var xTo : Number;
		/**
		 *  Initial position's y coordinate for mask. 
     *
     *  <p>To specify this property,
     *  you must specify all four of these properties:
     *  <code>xFrom</code>, <code>yFrom</code>, <code>xTo</code>, 
     *  and <code>yTo</code>. </p>
		 */
		public var yFrom : Number;
		/**
		 *  Destination position's y coordinate for mask.
     *
     *  <p>To specify this property,
     *  you must specify all four of these properties:
     *  <code>xFrom</code>, <code>yFrom</code>, <code>xTo</code>, 
     *  and <code>yTo</code>. </p>
		 */
		public var yTo : Number;

		/**
		 *  Specifies that the target component is becoming visible, 
     *  <code>true</code>, or invisible, <code>false</code>. 
     *
     *  If you specify this effect for a <code>showEffect</code> or 
     *  <code>hideEffect</code> trigger, Flex sets the 
     *  <code>showTarget</code> property for you, either to 
     *  <code>true</code> if the component becomes visible, 
     *  or <code>false</code> if the component becomes invisible. 
     *  If you use this effect with a different effect trigger, 
     *  you should set it yourself, often within the 
     *  event listener for the <code>startEffect</code> event.
     *
     *  @default true
		 */
		public function get showTarget () : Boolean;
		/**
		 *  @private
		 */
		public function set showTarget (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function set hideFocusRing (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get hideFocusRing () : Boolean;

		/**
		 *  Constructor.
     *
     *  @param target The Object to animate with this effect.
		 */
		public function MaskEffect (target:Object = null);

		/**
		 *  Returns the component properties modified by this effect. 
     *  This method returns an Array containing: 
     *  <code>[ "visible", "width", "height" ]</code>.
     *  Since the WipeDown, WipeLeft, WipeRight, and WipeDown effect
     *  subclasses all modify these same  properties, those classes 
     *  do not implement this method. 
     * 
     *  <p>If you subclass the MaskEffect class to create a custom effect, 
     *  and it modifies a different set of properties on the target, 
     *  you must override this method 
     *  and return an Array containing a list of the properties 
     *  modified by your subclass.</p>
     *
     *  @return An Array of Strings specifying the names of the 
     *  properties modified by this effect.
     *
     *  @see mx.effects.Effect#getAffectedProperties()
		 */
		public function getAffectedProperties () : Array;

		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;

		/**
		 *  Called when the TweenEffect dispatches a TweenEvent.
     *  If you override this method, ensure that you call the super method.
     *
     *  @param event An event object of type TweenEvent.
		 */
		protected function tweenEventHandler (event:TweenEvent) : void;
	}
}
