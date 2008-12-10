package mx.effects.effectClasses
{
	import mx.core.mx_internal;

	/**
	 *  The SetPropertyActionInstance class implements the instance class *  for the SetPropertyAction effect. *  Flex creates an instance of this class when it plays a SetPropertyAction *  effect; you do not create one yourself. * *  @see mx.effects.SetPropertyAction
	 */
	public class SetPropertyActionInstance extends ActionEffectInstance
	{
		/**
		 *  The name of the property being changed.
		 */
		public var name : String;
		/**
		 *  Storage for the value property.
		 */
		private var _value : *;

		/**
		 *  The new value for the property.
		 */
		public function get value () : *;
		/**
		 *  @private
		 */
		public function set value (val:*) : void;

		/**
		 *  Constructor.	 *	 *  @param target The Object to animate with this effect.
		 */
		public function SetPropertyActionInstance (target:Object);
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  @private
		 */
		protected function saveStartValue () : *;
	}
}
