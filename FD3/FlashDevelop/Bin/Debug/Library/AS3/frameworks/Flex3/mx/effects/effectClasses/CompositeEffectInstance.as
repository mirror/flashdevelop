package mx.effects.effectClasses
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.effects.EffectInstance;
	import mx.effects.IEffectInstance;
	import mx.effects.Tween;
	import mx.events.EffectEvent;

	/**
	 *  The CompositeEffectInstance class implements the instance class *  for the CompositeEffect class. *  Flex creates an instance of this class  when it plays a CompositeEffect; *  you do not create one yourself. * *  @see mx.effects.CompositeEffect
	 */
	public class CompositeEffectInstance extends EffectInstance
	{
		/**
		 *  @private 	 *  Internal queue of EffectInstances that are currently playing or waiting to be played.	 *  Used internally by subclasses.
		 */
		local var activeEffectQueue : Array;
		/**
		 *  @private
		 */
		private var _playheadTime : Number;
		/**
		 *  @private
		 */
		local var childSets : Array;
		/**
		 *  @private
		 */
		local var endEffectCalled : Boolean;
		/**
		 *  @private	 *  Used internally to obtain the playheadTime for the composite effect.
		 */
		local var timerTween : Tween;

		/**
		 *  @private	 *  Used internally to retrieve the actual duration,	 *  which includes startDelay, repeatCount, and repeatDelay.
		 */
		function get actualDuration () : Number;
		/**
		 *  @private
		 */
		public function get playheadTime () : Number;
		/**
		 *  @private	 *  Used internally to calculate the duration from the children effects	 *  for one repetition of this effect.
		 */
		function get durationWithoutRepeat () : Number;

		/**
		 *  Constructor.  	 *	 *  @param target This argument is ignored for Composite effects.	 *  It is included only for consistency with other types of effects.
		 */
		public function CompositeEffectInstance (target:Object);
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
		 *  @private
		 */
		public function finishEffect () : void;
		/**
		 *  Adds a new set of child effects to this Composite effect.	 *  A Sequence effect plays each child effect set one at a time,	 *  in the order that it is added.	 *  A Parallel effect plays all child effect sets simultaneously;	 *  the order in which they are added doesn't matter.	 *	 *  @param childSet Array of child effects to be added	 *  to the CompositeEffect.
		 */
		public function addChildSet (childSet:Array) : void;
		/**
		 *  @private	 *  Check if we have a RotateInstance in one of our childSets array elements
		 */
		function hasRotateInstance () : Boolean;
		/**
		 *  @private
		 */
		function playWithNoDuration () : void;
		/**
		 *  Called each time one of the child effects has finished playing. 	 *  Subclasses must implement this function.	 *	 *  @param The child effect.
		 */
		protected function onEffectEnd (childEffect:IEffectInstance) : void;
		/**
		 *  @private
		 */
		public function onTweenUpdate (value:Object) : void;
		/**
		 *  @private
		 */
		public function onTweenEnd (value:Object) : void;
		/**
		 *  @private
		 */
		public function initEffect (event:Event) : void;
		/**
		 *  @private
		 */
		function effectEndHandler (event:EffectEvent) : void;
	}
}
