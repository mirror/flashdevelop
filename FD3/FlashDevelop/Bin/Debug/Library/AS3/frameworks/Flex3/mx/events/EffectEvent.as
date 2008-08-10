/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	import mx.effects.IEffectInstance;
	public class EffectEvent extends Event {
		/**
		 * The effect instance object for the event.
		 *  You can use this property to access the properties of the effect
		 *  instance object from within your event listener.
		 */
		public var effectInstance:IEffectInstance;
		/**
		 * Constructor.
		 *
		 * @param eventType         <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the
		 *                            display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param effectInstance    <IEffectInstance (default = null)> The effect instance that triggered the event.
		 */
		public function EffectEvent(eventType:String, bubbles:Boolean = false, cancelable:Boolean = false, effectInstance:IEffectInstance = null);
		/**
		 * The EffectEvent.EFFECT_END constant defines the value of the
		 *  type property of the event object for an
		 *  effectEnd event.
		 */
		public static const EFFECT_END:String = "effectEnd";
		/**
		 * The EffectEvent.EFFECT_START constant defines the value of the
		 *  type property of the event object for an
		 *  effectStart event.
		 */
		public static const EFFECT_START:String = "effectStart";
	}
}
