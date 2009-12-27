package mx.effects.effectClasses
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import mx.controls.SWFLoader;
	import mx.core.Container;
	import mx.core.FlexShape;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.effects.EffectInstance;
	import mx.effects.EffectManager;
	import mx.effects.Tween;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	import mx.events.TweenEvent;

include "../../core/Version.as"
	/**
	 *  The MaskEffectInstance class is an abstract base class 
 *  that implements the instance class for 
 *  the MaskEffect class. 
 *  <p>Every effect class that is a subclass of the TweenEffect class 
 *  supports the following events:</p>
 *  
 *  <ul>
 *    <li><code>tweenEnd</code>: Dispatched when the tween effect ends. </li>
 *  
 *    <li><code>tweenUpdate</code>: Dispatched every time a TweenEffect 
 *      class calculates a new value.</li> 
 *  </ul>
 *  
 *  <p>The event object passed to the event listener for these events is of type TweenEvent. 
 *  The TweenEvent class defines the property <code>value</code>, which contains 
 *  the tween value calculated by the effect. 
 *  For the Mask effect, 
 *  the <code>TweenEvent.value</code> property contains a 4-item Array, where: </p>
 *  <ul>
 *    <li>value[0]:Number  The value of the target's <code>x</code> property.</li> 
 *  
 *    <li>value[1]:Number  The value of the target's <code>y</code> property.</li>
 *  
 *    <li>value[2]:Number  The value of the target's <code>scaleX</code> property.</li>
 *  
 *    <li>value[3]:Number  The value of the target's <code>scaleY</code> property.</li>
 *  </ul>
 *
 *  @see mx.effects.MaskEffect
 *  @see mx.events.TweenEvent
	 */
	public class MaskEffectInstance extends EffectInstance
	{
		/**
		 *  Contains the effect mask, either the default mask created 
	 *  by the <code>defaultCreateMask()</code> method, 
	 *  or the one specified by the function passed to the 
	 *  <code>createMaskFunction</code> property.
		 */
		protected var effectMask : Shape;
		/**
		 *  The actual size of the effect target, including any drop shadows. 
	 *  Flex calculates the value of this property; you do not have to set it.
		 */
		protected var targetVisualBounds : Rectangle;
		/**
		 *  @private
		 */
		private var effectMaskRefCount : Number;
		/**
		 *  @private
		 */
		private var invalidateBorder : Boolean;
		/**
		 *  @private
		 */
		private var moveTween : Tween;
		/**
		 *  @private
		 */
		private var origMask : DisplayObject;
		/**
		 *  @private
		 */
		private var origScrollRect : Rectangle;
		/**
		 *  @private
		 */
		private var scaleTween : Tween;
		/**
		 *  @private
		 */
		private var tweenCount : int;
		/**
		 *  @private
		 */
		private var currentMoveTweenValue : Object;
		/**
		 *  @private
		 */
		private var currentScaleTweenValue : Object;
		/**
		 *  @private
		 */
		private var MASK_NAME : String;
		/**
		 *  @private
		 */
		private var dispatchedStartEvent : Boolean;
		/**
		 *  @private
		 */
		private var useSnapshotBounds : Boolean;
		/**
		 *  @private
		 */
		private var stoppedEarly : Boolean;
		/**
		 *  @private
		 */
		var persistAfterEnd : Boolean;
		/**
		 *  @private
	 *  Storage for the createMaskFunction property.
		 */
		private var _createMaskFunction : Function;
		/**
		 *  Easing function to use for moving the mask.
		 */
		public var moveEasingFunction : Function;
		/**
		 *  Easing function to use for scaling the mask.
		 */
		public var scaleEasingFunction : Function;
		/**
		 *  Initial scaleX for mask.
		 */
		public var scaleXFrom : Number;
		/**
		 *  Ending scaleX for mask.
		 */
		public var scaleXTo : Number;
		/**
		 *  Initial scaleY for mask.
		 */
		public var scaleYFrom : Number;
		/**
		 *  Ending scaleY for mask.
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
		 *  The area where the mask is applied on the target.
	 *  The dimensions are relative to the target itself.
	 *  By default, the area is the entire target and is created like this: 
	 *  <code>new Rectangle(0, 0, target.width, target.height);</code>
		 */
		public var targetArea : Rectangle;
		/**
		 *  Initial position's x coordinate for mask.
		 */
		public var xFrom : Number;
		/**
		 *  Destination position's x coordinate for mask.
		 */
		public var xTo : Number;
		/**
		 *  Initial position's y coordinate for mask.
		 */
		public var yFrom : Number;
		/**
		 *  Destination position's y coordinate for mask.
		 */
		public var yTo : Number;

		/**
		 *  Function called when the effect creates the mask.
	 *  The default value is a function that returns a Rectangle
	 *  with the same dimensions as the effect target. 
	 *
	 *  <p>You can use this property to specify your own callback function to draw the mask. 
	 *  The function must have the following signature:</p>
	 * 
	 *  <pre>
	 *  public function createLargeMask(targ:Object, bounds:Rectangle):Shape {
	 *    var myMask:Shape = new Shape();
	 *    // Create mask.
	 *  
	 *    return myMask;
	 *  }
	 *  </pre>
	 *
	 *  <p>You set this property to the name of the function, 
	 *  as the following example shows for the WipeLeft effect:</p>
	 * 
	 *  <pre>
	 *    &lt;mx:WipeLeft id="showWL" createMaskFunction="createLargeMask" showTarget="false"/&gt;</pre>
		 */
		public function get createMaskFunction () : Function;
		/**
		 *  @private
		 */
		public function set createMaskFunction (value:Function) : void;

		/**
		 *  @private
		 */
		public function get playheadTime () : Number;

		/**
		 *  @private
		 */
		function set playReversed (value:Boolean) : void;

		/**
		 *  Specifies that the target component is becoming visible, 
     *  <code>false</code>, or invisible, <code>true</code>.
	 *
	 *  @default true
		 */
		public function get showTarget () : Boolean;
		/**
		 *  @private
		 */
		public function set showTarget (value:Boolean) : void;

		/**
		 *  Constructor. 
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function MaskEffectInstance (target:Object);

		/**
		 *  @private
		 */
		public function initEffect (event:Event) : void;

		/**
		 *  @private
		 */
		public function startEffect () : void;

		/**
		 *  @private
		 */
		public function play () : void;

		/**
		 *  Pauses the effect until you call the <code>resume()</code> method.
		 */
		public function pause () : void;

		/**
		 *  @private
		 */
		public function stop () : void;

		/**
		 *  Resumes the effect after it has been paused 
	 *  by a call to the <code>pause()</code> method.
		 */
		public function resume () : void;

		/**
		 *  Plays the effect in reverse,
	 *  starting from the current position of the effect.
		 */
		public function reverse () : void;

		/**
		 *  @private
		 */
		public function end () : void;

		/**
		 *  @private
		 */
		public function finishEffect () : void;

		/**
		 *  @private
		 */
		private function initMask () : void;

		/**
		 *  Creates the default mask for the effect.
	 *
	 *  @param targ The effect target.
	 *  @param bounds The actual visual bounds of the target which includes drop shadows
	 *  
	 *  @return A Shape object that defines the mask.
		 */
		protected function defaultCreateMask (targ:Object, bounds:Rectangle) : Shape;

		/**
		 *  Initializes the <code>move</code> and <code>scale</code>
	 *  properties of the effect. 
	 *  All subclasses should override this function.
	 *  Flex calls it after the mask has been created,
	 *  but before the tweens are created.
		 */
		protected function initMaskEffect () : void;

		/**
		 *  @private
	 *  Returns a rectangle that describes the visible region of the component, including any dropshadows
		 */
		private function getVisibleBounds (targ:DisplayObject) : Rectangle;

		/**
		 *  Callback method that is called when the x and y position 
	 *  of the mask should be updated by the effect. 
	 *  You do not call this method directly. 
     *  This method implements the method of the superclass. 
     *
 	 *  @param value Contains an interpolated 
	 *  x and y value for the mask position, where <code>value[0]</code> 
	 *  contains the new x position of the mask, 
	 *  and <code>value[1]</code> contains the new y position.
		 */
		protected function onMoveTweenUpdate (value:Object) : void;

		/**
		 *  Callback method that is called when the x and y position 
	 *  of the mask should be updated by the effect for the last time. 
	 *  You do not call this method directly. 
     *  This method implements the method of the superclass. 
     *
 	 *  @param value Contains the final 
	 *  x and y value for the mask position, where <code>value[0]</code> 
	 *  contains the x position of the mask, 
	 *  and <code>value[1]</code> contains the y position.
		 */
		protected function onMoveTweenEnd (value:Object) : void;

		/**
		 *  Callback method that is called when the 
	 *  <code>scaleX</code> and <code>scaleY</code> properties 
	 *  of the mask should be updated by the effect. 
	 *  You do not call this method directly. 
     *  This method implements the method of the superclass. 
     *
 	 *  @param value Contains an interpolated 
	 *  <code>scaleX</code> and <code>scaleY</code> value for the mask, 
	 *  where <code>value[0]</code> 
	 *  contains the new <code>scaleX</code> value of the mask, 
	 *  and <code>value[1]</code> contains the new <code>scaleY</code> value.
		 */
		protected function onScaleTweenUpdate (value:Object) : void;

		/**
		 *  Callback method that is called when the 
	 *  <code>scaleX</code> and <code>scaleY</code> properties 
	 *  of the mask should be updated by the effect for the last time. 
	 *  You do not call this method directly. 
     *  This method implements the method of the superclass. 
     *
 	 *  @param value Contains the final 
	 *  <code>scaleX</code> and <code>scaleY</code> value for the mask, 
	 *  where <code>value[0]</code> 
	 *  contains the <code>scaleX</code> value of the mask, 
	 *  and <code>value[1]</code> contains the <code>scaleY</code> value.
		 */
		protected function onScaleTweenEnd (value:Object) : void;

		/**
		 *  @private
		 */
		private function finishTween () : void;

		/**
		 *  @private
		 */
		private function removeMask () : void;

		/**
		 *  @private
		 */
		private function saveTweenValue (moveValue:Object, scaleValue:Object) : void;

		/**
		 *  @private
		 */
		function eventHandler (event:Event) : void;
	}
}
