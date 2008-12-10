package mx.effects.effectClasses
{
	import mx.styles.StyleManager;
	import mx.core.mx_internal;

	/**
	 *  The SetStyleActionInstance class implements the instance class *  for the SetStyleAction effect. *  Flex creates an instance of this class when it plays a SetStyleAction *  effect; you do not create one yourself. * *  @see mx.effects.SetStyleAction
	 */
	public class SetStyleActionInstance extends ActionEffectInstance
	{
		/**
		 *  The name of the style property being changed.
		 */
		public var name : String;
		/**
		 *  @private	 *  Storage for the value property.
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
		public function SetStyleActionInstance (target:Object);
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
