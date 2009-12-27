package mx.effects.effectClasses
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import mx.core.mx_internal;

include "../../core/Version.as"
	/**
	 *  The AddChildActionInstance class implements the instance class
 *  for the AddChildAction effect.
 *  Flex creates an instance of this class when it plays
 *  an AddChildAction effect; you do not create one yourself.
 *
 *  @see mx.effects.AddChildAction
	 */
	public class AddChildActionInstance extends ActionEffectInstance
	{
		/**
		 *  The index of the child within the parent.
		 */
		public var index : int;
		/**
		 *  The location where the child component is added.
		 */
		public var relativeTo : DisplayObjectContainer;
		/**
		 *  The position of the child component, relative to relativeTo, where it is added.
		 */
		public var position : String;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function AddChildActionInstance (target:Object);

		/**
		 *  @private
		 */
		public function play () : void;
	}
}
