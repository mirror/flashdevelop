package mx.effects.effectClasses
{
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.effects.EffectInstance;
	import mx.effects.IEffectInstance;
	import mx.effects.Tween;

include "../../core/Version.as"
	/**
	 *  The SequenceInstance class implements the instance class 
 *  for the Sequence effect.
 *  Flex creates an instance of this class when it plays a Sequence effect;
 *  you do not create one yourself.
 *
 *  @see mx.effects.Sequence
	 */
	public class SequenceInstance extends CompositeEffectInstance
	{
		/**
		 *  @private
		 */
		private var activeChildCount : Number;
		/**
		 *  @private
	 *  Used internally to store the sum of all previously playing effects.
		 */
		private var currentInstanceDuration : Number;
		/**
		 *  @private
	 *  Used internally to track the set of effect instances
	 *  that the Sequence is currently playing.
		 */
		private var currentSet : Array;
		/**
		 *  @private
	 *  Used internally to track the index number of the current set
	 *  of playing effect instances
		 */
		private var currentSetIndex : int;
		/**
		 *  @private
		 */
		private var startTime : Number;

		/**
		 *  @private
		 */
		function get durationWithoutRepeat () : Number;

		/**
		 *  Constructor.
	 *
	 *  @param target This argument is ignored for Sequence effects.
	 *  It is included only for consistency with other types of effects.
		 */
		public function SequenceInstance (target:Object);

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
		 *  Each time a child effect of SequenceInstance finishes, 
	*  Flex calls the <code>onEffectEnd()</code> method.
	*  For SequenceInstance, it plays the next effect.
	*  This method implements the method of the superclass.
	*
	*  @param childEffect The child effect.
		 */
		protected function onEffectEnd (childEffect:IEffectInstance) : void;

		/**
		 *  @private
		 */
		private function playNextChildSet (offset:Number = 0) : Boolean;
	}
}
