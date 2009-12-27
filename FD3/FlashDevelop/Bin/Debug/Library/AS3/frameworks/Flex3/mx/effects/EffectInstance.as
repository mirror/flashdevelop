package mx.effects
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.effects.effectClasses.PropertyChanges;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;

include "../core/Version.as"
	/**
	 *  The EffectInstance class represents an instance of an effect
 *  playing on a target.
 *  Each target has a separate effect instance associated with it.
 *  An effect instance's lifetime is transitory.
 *  An instance is created when the effect is played on a target
 *  and is destroyed when the effect has finished playing. 
 *  If there are multiple effects playing on a target at the same time 
 *  (for example, a Parallel effect), there is a separate effect instance
 *  for each effect.
 * 
 *  <p>Effect developers must create an instance class
 *  for their custom effects.</p>
 *
 *  @see mx.effects.Effect
	 */
	public class EffectInstance extends EventDispatcher implements IEffectInstance
	{
		/**
		 *  @private
     *  Timer used to track startDelay and repeatDelay.
		 */
		var delayTimer : Timer;
		/**
		 *  @private
     *  Starting time of delayTimer.
		 */
		private var delayStartTime : Number;
		/**
		 *  @private
     *  Elapsed time of delayTimer when paused.
     *  Used by resume() to figure out amount of time remaining.
		 */
		private var delayElapsedTime : Number;
		/**
		 *  @private
     *  Internal flag remembering whether the user
     *  explicitly specified a duration or not.
		 */
		var durationExplicitlySet : Boolean;
		/**
		 *  @private
     *  If this is a "hide" effect, the EffectManager sets this flag
     *  as a reminder to hide the object when the effect finishes.
		 */
		var hideOnEffectEnd : Boolean;
		/**
		 *  @private
     *  Pointer back to the CompositeEffect that created this instance.
     *  Value is null if we are not the child of a CompositeEffect
		 */
		var parentCompositeEffectInstance : EffectInstance;
		/**
		 *  @private
     *  Number of times that the instance has been played.
		 */
		private var playCount : int;
		/**
		 *  @private
     *  Used internally to prevent the effect from repeating
     *  once the effect has been ended by calling end().
		 */
		var stopRepeat : Boolean;
		/**
		 *  @private
     *  Storage for the duration property.
		 */
		private var _duration : Number;
		/**
		 *  @private
     *  Storage for the effect property.
		 */
		private var _effect : IEffect;
		/**
		 *  @private
     *  Storage for the effectTargetHost property.
		 */
		private var _effectTargetHost : IEffectTargetHost;
		/**
		 *  @private
     *  Storage for the hideFocusRing property.
		 */
		private var _hideFocusRing : Boolean;
		/**
		 *  @private
     *  Storage for the playReversed property.
		 */
		private var _playReversed : Boolean;
		/**
		 *  @private
     *  Storage for the propertyChanges property.
		 */
		private var _propertyChanges : PropertyChanges;
		/**
		 *  @private
     *  Storage for the repeatCount property.
		 */
		private var _repeatCount : int;
		/**
		 *  @private
     *  Storage for the repeatDelay property.
		 */
		private var _repeatDelay : int;
		/**
		 *  @private
     *  Storage for the startDelay property.
		 */
		private var _startDelay : int;
		/**
		 *  @private
     *  Storage for the suspendBackgroundProcessing property.
		 */
		private var _suspendBackgroundProcessing : Boolean;
		/**
		 *  @private
     *  Storage for the target property.
		 */
		private var _target : Object;
		/**
		 *  @private
     *  Storage for the triggerEvent property.
		 */
		private var _triggerEvent : Event;

		/**
		 *  @private
     *  Used internally to determine the duration
     *  including the startDelay, repeatDelay, and repeatCount values.
		 */
		function get actualDuration () : Number;

		/**
		 *  @copy mx.effects.IEffectInstance#className
		 */
		public function get className () : String;

		/**
		 *  @copy mx.effects.IEffectInstance#duration
		 */
		public function get duration () : Number;
		/**
		 *  @private
		 */
		public function set duration (value:Number) : void;

		/**
		 *  @copy mx.effects.IEffectInstance#effect
		 */
		public function get effect () : IEffect;
		/**
		 *  @private
		 */
		public function set effect (value:IEffect) : void;

		/**
		 *  @copy mx.effects.IEffectInstance#effectTargetHost
		 */
		public function get effectTargetHost () : IEffectTargetHost;
		/**
		 *  @private
		 */
		public function set effectTargetHost (value:IEffectTargetHost) : void;

		/**
		 *  @copy mx.effects.IEffectInstance#hideFocusRing
		 */
		public function get hideFocusRing () : Boolean;
		/**
		 *  @private
		 */
		public function set hideFocusRing (value:Boolean) : void;

		/**
		 *  @copy mx.effects.IEffectInstance#playheadTime
		 */
		public function get playheadTime () : Number;

		/**
		 *  @private
     *  Used internally to specify whether or not this effect
     *  should be played in reverse.
     *  Set this value before you play the effect.
		 */
		function get playReversed () : Boolean;
		/**
		 *  @private
		 */
		function set playReversed (value:Boolean) : void;

		/**
		 *  @copy mx.effects.IEffectInstance#propertyChanges
		 */
		public function get propertyChanges () : PropertyChanges;
		/**
		 *  @private
		 */
		public function set propertyChanges (value:PropertyChanges) : void;

		/**
		 *  @copy mx.effects.IEffectInstance#repeatCount
		 */
		public function get repeatCount () : int;
		/**
		 *  @private
		 */
		public function set repeatCount (value:int) : void;

		/**
		 *  @copy mx.effects.IEffectInstance#repeatDelay
		 */
		public function get repeatDelay () : int;
		/**
		 *  @private
		 */
		public function set repeatDelay (value:int) : void;

		/**
		 *  @copy mx.effects.IEffectInstance#startDelay
		 */
		public function get startDelay () : int;
		/**
		 *  @private
		 */
		public function set startDelay (value:int) : void;

		/**
		 *  @copy mx.effects.IEffectInstance#suspendBackgroundProcessing
		 */
		public function get suspendBackgroundProcessing () : Boolean;
		/**
		 *  @private
		 */
		public function set suspendBackgroundProcessing (value:Boolean) : void;

		/**
		 *  @copy mx.effects.IEffectInstance#target
		 */
		public function get target () : Object;
		/**
		 *  @private
		 */
		public function set target (value:Object) : void;

		/**
		 *  @copy mx.effects.IEffectInstance#triggerEvent
		 */
		public function get triggerEvent () : Event;
		/**
		 *  @private
		 */
		public function set triggerEvent (value:Event) : void;

		/**
		 *  Constructor.
     *
     *  @param target UIComponent object to animate with this effect.
		 */
		public function EffectInstance (target:Object);

		/**
		 *  @copy mx.effects.IEffectInstance#initEffect()
		 */
		public function initEffect (event:Event) : void;

		/**
		 *  @copy mx.effects.IEffectInstance#startEffect()
		 */
		public function startEffect () : void;

		/**
		 *  @copy mx.effects.IEffectInstance#play()
		 */
		public function play () : void;

		/**
		 *  @copy mx.effects.IEffectInstance#pause()
		 */
		public function pause () : void;

		/**
		 *  @copy mx.effects.IEffectInstance#stop()
		 */
		public function stop () : void;

		/**
		 *  @copy mx.effects.IEffectInstance#resume()
		 */
		public function resume () : void;

		/**
		 *  @copy mx.effects.IEffectInstance#reverse()
		 */
		public function reverse () : void;

		/**
		 *  @copy mx.effects.IEffectInstance#end()
		 */
		public function end () : void;

		/**
		 *  @copy mx.effects.IEffectInstance#finishEffect()
		 */
		public function finishEffect () : void;

		/**
		 *  @copy mx.effects.IEffectInstance#finishRepeat()
		 */
		public function finishRepeat () : void;

		/**
		 *  @private
		 */
		function playWithNoDuration () : void;

		/**
		 *  @private
     *  If someone explicitly sets the visibility of the target object
     *  to true, clear the flag that is remembering to hide the 
     *  target when this effect ends.
		 */
		function eventHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function delayTimerHandler (event:TimerEvent) : void;
	}
}
