package mx.core
{
	import flash.display.InteractiveObject;
	import mx.managers.IFocusManager;

	public class ContainerGlobals
	{
		/**
		 *  @private     *  Internal variable that keeps track of the container     *  that currently has focus.
		 */
		public static var focusedContainer : InteractiveObject;

		/**
		 *  @private     *  Support for defaultButton.
		 */
		public static function checkFocus (oldObj:InteractiveObject, newObj:InteractiveObject) : void;
	}
}
