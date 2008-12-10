package mx.effects.effectClasses
{
	import mx.core.mx_internal;
	import mx.effects.EffectInstance;

	/**
	 *  The ActionEffectInstance class is the superclass for all  *  action effect instance classes.
	 */
	public class ActionEffectInstance extends EffectInstance
	{
		/**
		 *  Indicates whether the effect has been played (<code>true</code>), 	 *  or not (<code>false</code>). 	 *	 *  <p>The <code>play()</code> method sets this property to 	 *  <code>true</code> after the effect plays;	 *  you do not set it directly.</p>
		 */
		protected var playedAction : Boolean;
		/**
		 *  @private
		 */
		private var _startValue : *;

		/**
		 *  Constructor.	 *	 *  @param target The Object to animate with this effect.
		 */
		public function ActionEffectInstance (target:Object);
		/**
		 *  Subclasses implement this method to save the starting state	 *  before the effect plays.	 *	 *  @return Returns the starting state value.
		 */
		protected function saveStartValue () : *;
		/**
		 *  Returns the starting state value that was saved by the	 *  <code>saveStartValue()</code> method.	 *	 *  @return Returns the starting state value.
		 */
		protected function getStartValue () : *;
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  @private
		 */
		public function end () : void;
	}
}
