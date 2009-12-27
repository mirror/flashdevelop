package mx.effects.effectClasses
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.effects.IEffectInstance;
	import mx.effects.EffectInstance;

include "../../core/Version.as"
	/**
	 *  The ParallelInstance class implements the instance class
 *  for the Parallel effect.
 *  Flex creates an instance of this class when it plays a Parallel effect;
 *  you do not create one yourself.
 *
 *  @see mx.effects.Parallel
	 */
	public class ParallelInstance extends CompositeEffectInstance
	{
		/**
		 *  @private
	 *  Holds the child effect instances that have already completed.
		 */
		private var doneEffectQueue : Array;
		/**
		 *  @private
	 *  Holds the child effect instances that are waiting to be replayed.
		 */
		private var replayEffectQueue : Array;
		/**
		 *  @private
		 */
		private var isReversed : Boolean;
		/**
		 *  @private
		 */
		private var timer : Timer;

		/**
		 *  @private
		 */
		function get durationWithoutRepeat () : Number;

		/**
		 *  Constructor.
	 *
	 *  @param target This argument is ignored for Parallel effects.
	 *  It is included only for consistency with other types of effects.
		 */
		public function ParallelInstance (target:Object);

		/**
		 *  @private
		 */
		public function addChildSet (childSet:Array) : void;

		/**
		 *  @private
		 */
		public function play () : void;

		/**
		 *  @private
		 */
		public function pause () : void;

		/**
		 *  @private
		 */
		public function stop () : void;

		/**
		 *  @private
		 */
		public function resume () : void;

		/**
		 *  @private
		 */
		public function reverse () : void;

		/**
		 *  Interrupts any effects that are currently playing, skips over
	 *  any effects that haven't started playing, and jumps immediately
	 *  to the end of the composite effect.
		 */
		public function end () : void;

		/**
		 *  Each time a child effect of SequenceInstance or ParallelInstance
	 *  finishes, Flex calls the <code>onEffectEnd()</code> method.
	 *  For SequenceInstance, it plays the next effect.
	 *  In ParallelInstance, it keeps track of all the 
	 *  effects until all of them have finished playing. 
	 *  If you create a subclass of CompositeEffect, you must implement this method.
         *
         * @param childEffect A child effect that has finished.
		 */
		protected function onEffectEnd (childEffect:IEffectInstance) : void;

		/**
		 *  @private
		 */
		private function startTimer () : void;

		/**
		 *  @private
		 */
		private function stopTimer () : void;

		/**
		 *  @private
	 *  Used internally to figure out if we should be playing an effect
	 *  from the replay queue.
		 */
		private function timerHandler (event:TimerEvent) : void;
	}
}
