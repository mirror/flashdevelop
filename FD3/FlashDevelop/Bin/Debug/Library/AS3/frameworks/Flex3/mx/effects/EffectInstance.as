/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	import flash.events.EventDispatcher;
	import mx.effects.effectClasses.PropertyChanges;
	import flash.events.Event;
	public class EffectInstance extends EventDispatcher implements IEffectInstance {
		/**
		 * The name of the effect class, such as "FadeInstance".
		 */
		public function get className():String;
		/**
		 * The duration of the effect, in milliseconds.
		 */
		public function get duration():Number;
		public function set duration(value:Number):void;
		/**
		 * The IEffect object that created this IEffectInstance object.
		 */
		public function get effect():IEffect;
		public function set effect(value:IEffect):void;
		/**
		 * A property that lets you access the target
		 *  list-based control of a data effect.
		 *  This property enables an instance of an effect class
		 *  to communicate with the  list-based control
		 *  on which the effect is playing.
		 */
		public function get effectTargetHost():IEffectTargetHost;
		public function set effectTargetHost(value:IEffectTargetHost):void;
		/**
		 * Determines whether the effect should hide
		 *  the focus ring when starting the effect.
		 *  The effect target is responsible for the hiding the focus ring.
		 *  Subclasses of the UIComponent class hide the focus ring automatically.
		 *  If the effect target is not a subclass of the UIComponent class,
		 *  you must add functionality to it to hide the focus ring.
		 */
		public function get hideFocusRing():Boolean;
		public function set hideFocusRing(value:Boolean):void;
		/**
		 * Current position in time of the effect.
		 *  This property has a value between 0 and the actual duration
		 *  (which includes the value of the startDelay,
		 *  repeatCount, and repeatDelay properties).
		 */
		public function get playheadTime():Number;
		/**
		 * Specifies the PropertyChanges object containing
		 *  the start and end values for the set of properties
		 *  relevant to the effect's targets.
		 *  This property is only set if the
		 *  captureStartValues() method was called
		 *  on the effect that created this effect instance.
		 */
		public function get propertyChanges():PropertyChanges;
		public function set propertyChanges(value:PropertyChanges):void;
		/**
		 * Number of times to repeat the effect.
		 *  Possible values are any integer greater than or equal to 0.
		 */
		public function get repeatCount():int;
		public function set repeatCount(value:int):void;
		/**
		 * Amount of time, in milliseconds,
		 *  to wait before repeating the effect.
		 */
		public function get repeatDelay():int;
		public function set repeatDelay(value:int):void;
		/**
		 * Amount of time, in milliseconds,
		 *  to wait before starting the effect.
		 *  Possible values are any int greater than or equal to 0.
		 *  If the effect is repeated by using the repeatCount
		 *  property, the startDelay property is applied
		 *  only the first time the effect is played.
		 */
		public function get startDelay():int;
		public function set startDelay(value:int):void;
		/**
		 * If true, blocks all background processing
		 *  while the effect is playing.
		 *  Background processing includes measurement, layout,
		 *  and processing responses that have arrived from the server.
		 */
		public function get suspendBackgroundProcessing():Boolean;
		public function set suspendBackgroundProcessing(value:Boolean):void;
		/**
		 * The UIComponent object to which this effect is applied.
		 */
		public function get target():Object;
		public function set target(value:Object):void;
		/**
		 * The event, if any, which triggered the playing of the effect.
		 *  This property is useful when an effect is assigned to
		 *  multiple triggering events.
		 */
		public function get triggerEvent():Event;
		public function set triggerEvent(value:Event):void;
		/**
		 * Constructor.
		 *
		 * @param target            <Object> UIComponent object to animate with this effect.
		 */
		public function EffectInstance(target:Object);
		/**
		 * Interrupts an effect instance that is currently playing,
		 *  and jumps immediately to the end of the effect.
		 *  This method is invoked by a call
		 *  to the Effect.end() method.
		 *  As part of its implementation, it calls
		 *  the finishEffect() method.
		 */
		public function end():void;
		/**
		 * Called by the end() method when the effect
		 *  finishes playing.
		 *  This function dispatches an endEffect event
		 *  for the effect target.
		 */
		public function finishEffect():void;
		/**
		 * Called after each iteration of a repeated effect finishes playing.
		 */
		public function finishRepeat():void;
		/**
		 * This method is called if the effect was triggered by the EffectManager.
		 *  This base class version saves the event that triggered the effect
		 *  in the triggerEvent property.
		 *  Each subclass should override this method.
		 *
		 * @param event             <Event> The Event object that was dispatched
		 *                            to trigger the effect.
		 *                            For example, if the trigger was a mouseDownEffect, the event
		 *                            would be a MouseEvent with type equal to MouseEvent.MOUSEDOWN.
		 */
		public function initEffect(event:Event):void;
		/**
		 * Pauses the effect until you call the resume() method.
		 */
		public function pause():void;
		/**
		 * Plays the effect instance on the target.
		 *  Call the startEffect() method instead
		 *  to make an effect start playing on an EffectInstance.
		 */
		public function play():void;
		/**
		 * Resumes the effect after it has been paused
		 *  by a call to the pause() method.
		 */
		public function resume():void;
		/**
		 * Plays the effect in reverse, starting from
		 *  the current position of the effect.
		 */
		public function reverse():void;
		/**
		 * Plays the effect instance on the target after the
		 *  startDelay period has elapsed.
		 *  Called by the Effect class.
		 *  Use this function instead of the play() method
		 *  when starting an EffectInstance.
		 */
		public function startEffect():void;
		/**
		 * Stops the effect, leaving the target in its current state.
		 *  This method is invoked by a call
		 *  to the Effect.stop() method.
		 *  As part of its implementation, it calls
		 *  the finishEffect() method.
		 */
		public function stop():void;
	}
}
