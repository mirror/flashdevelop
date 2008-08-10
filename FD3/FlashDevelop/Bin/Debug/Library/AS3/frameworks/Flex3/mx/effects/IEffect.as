/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	import flash.events.Event;
	public interface IEffect extends <a href="../../mx/effects/IAbstractEffect.html">IAbstractEffect</a> , <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * The name of the effect class, such as "Fade".
		 */
		public function get className():String;
		/**
		 * Specifies a custom filter object, of type EffectTargetFilter,
		 *  used by the effect to determine the targets
		 *  on which to play the effect.
		 */
		public function get customFilter():EffectTargetFilter;
		public function set customFilter(value:EffectTargetFilter):void;
		/**
		 * Duration of the effect in milliseconds.
		 */
		public function get duration():Number;
		public function set duration(value:Number):void;
		/**
		 * A property that lets you access the target list-based control
		 *  of a data effect.
		 *  This property enables an instance of an effect class to communicate
		 *  with the list-based control on which the effect is playing.
		 */
		public function get effectTargetHost():IEffectTargetHost;
		public function set effectTargetHost(value:IEffectTargetHost):void;
		/**
		 * Specifies an algorithm for filtering targets for an effect.
		 *  A value of null specifies no filtering.
		 */
		public function get filter():String;
		public function set filter(value:String):void;
		/**
		 * Determines whether the effect should hide the focus ring
		 *  when starting the effect.
		 *  The effect target is responsible for the hiding the focus ring.
		 *  Subclasses of the UIComponent class hide the focus ring automatically.
		 *  If the effect target is not a subclass of the UIComponent class,
		 *  you must add functionality to it to hide the focus ring.
		 */
		public function get hideFocusRing():Boolean;
		public function set hideFocusRing(value:Boolean):void;
		/**
		 * A read-only flag which is true if any instances of the effect
		 *  are currently playing, and false if none are.
		 */
		public function get isPlaying():Boolean;
		/**
		 * Additional delay, in milliseconds, for effect targets
		 *  after the first target of the effect.
		 *  This value is added to the value
		 *  of the startDelay property.
		 */
		public function get perElementOffset():Number;
		public function set perElementOffset(value:Number):void;
		/**
		 * An Array of property names to use when performing filtering.
		 *  This property is used internally and should not be set by
		 *  effect users.
		 */
		public function get relevantProperties():Array;
		public function set relevantProperties(value:Array):void;
		/**
		 * An Array of style names to use when performing filtering.
		 *  This property is used internally and should not be set by
		 *  effect users.
		 */
		public function get relevantStyles():Array;
		public function set relevantStyles(value:Array):void;
		/**
		 * The UIComponent object to which this effect is applied.
		 *  When an effect is triggered by an effect trigger,
		 *  the target property is automatically set to be
		 *  the object that triggers the effect.
		 */
		public function get target():Object;
		public function set target(value:Object):void;
		/**
		 * An Array of UIComponent objects that are targets for the effect.
		 *  When the effect is playing, it performs the effect on each target
		 *  in parallel.
		 *  Setting the target property replaces all objects
		 *  in this Array.
		 *  When the targets property is set, the target
		 *  property returns the first item in this Array.
		 */
		public function get targets():Array;
		public function set targets(value:Array):void;
		/**
		 * The Event object passed to this Effect
		 *  by the EffectManager when an effect is triggered,
		 *  or null if the effect is not being
		 *  played by the EffectManager.
		 */
		public function get triggerEvent():Event;
		public function set triggerEvent(value:Event):void;
		/**
		 * Captures the current values of the relevant properties
		 *  on the effect's targets and saves them as end values.
		 */
		public function captureEndValues():void;
		/**
		 * Captures the current values of the relevant properties
		 *  of an additional set of targets
		 *
		 * @param targets           <Array> Array of targets for which values will be captured
		 */
		public function captureMoreStartValues(targets:Array):void;
		/**
		 * Captures the current values of the relevant properties
		 *  on the effect's targets.
		 *  Flex automatically calls the captureStartValues()
		 *  method when the effect is part of a transition.
		 */
		public function captureStartValues():void;
		/**
		 * Creates a single effect instance and initializes it.
		 *  Use this method instead of the play() method
		 *  to manipulate the effect instance properties
		 *  before the effect instance plays.
		 *
		 * @param target            <Object (default = null)> Object to animate with this effect.
		 * @return                  <IEffectInstance> The effect instance object for the effect.
		 */
		public function createInstance(target:Object = null):IEffectInstance;
		/**
		 * Takes an Array of target objects and invokes the
		 *  createInstance() method on each target.
		 *
		 * @param targets           <Array (default = null)> Array of objects to animate with this effect.
		 * @return                  <Array> Array of effect instance objects, one per target,
		 *                            for the effect.
		 */
		public function createInstances(targets:Array = null):Array;
		/**
		 * Removes event listeners from an instance
		 *  and removes it from the list of instances.
		 *
		 * @param instance          <IEffectInstance> 
		 */
		public function deleteInstance(instance:IEffectInstance):void;
		/**
		 * Interrupts an effect that is currently playing,
		 *  and jumps immediately to the end of the effect.
		 *  Calling this method invokes the EffectInstance.end()
		 *  method.
		 *
		 * @param effectInstance    <IEffectInstance (default = null)> EffectInstance to terminate.
		 */
		public function end(effectInstance:IEffectInstance = null):void;
		/**
		 * Returns an Array of Strings, where each String is the name
		 *  of a property that is changed by this effect.
		 *  For example, the Move effect returns an Array that contains
		 *  "x" and "y".
		 *
		 * @return                  <Array> An Array of Strings specifying the names of the
		 *                            properties modified by this effect.
		 */
		public function getAffectedProperties():Array;
		/**
		 * Pauses the effect until you call the resume() method.
		 */
		public function pause():void;
		/**
		 * Begins playing the effect.
		 *  You typically call the end() method
		 *  before you call the play() method
		 *  to ensure that any previous instance of the effect
		 *  has ended before you start a new one.
		 *
		 * @param targets           <Array (default = null)> Array of target objects on which to play this effect.
		 *                            If this parameter is specified, then the effect's targets
		 *                            property is not used.
		 * @param playReversedFromEnd<Boolean (default = false)> If true,
		 *                            play the effect backwards.
		 * @return                  <Array> Array of EffectInstance objects, one per target,
		 *                            for the effect.
		 */
		public function play(targets:Array = null, playReversedFromEnd:Boolean = false):Array;
		/**
		 * Resumes the effect after it has been paused
		 *  by a call to the pause() method.
		 */
		public function resume():void;
		/**
		 * Plays the effect in reverse, if the effect is currently playing,
		 *  starting from the current position of the effect.
		 */
		public function reverse():void;
		/**
		 * Stops the effect, leaving the effect targets in their current state.
		 *  Unlike a call to the pause() method,
		 *  you cannot call the resume() method after calling
		 *  the stop() method.
		 *  However, you can call the play() method to restart the effect.
		 */
		public function stop():void;
	}
}
