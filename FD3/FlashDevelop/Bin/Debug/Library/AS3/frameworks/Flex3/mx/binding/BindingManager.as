package mx.binding
{
	import mx.core.mx_internal;

	/**
	 *  @private
	 */
	public class BindingManager
	{
		/**
		 *  @private
		 */
		static var debugDestinationStrings : Object;

		/**
		 *  Store a Binding for the destination relative to the passed in document.	 *  We don't hold a list of bindings per destination	 *  even though it is possible to have multiple.     *  The reason is that when we refresh the last binding will	 *  always win anyway, so why execute the ones that will lose.     *     *  @param document The document that this binding relates to.	 *     *  @param destStr The destination field of this binding.	 *     *  @param b The binding itself.
		 */
		public static function addBinding (document:Object, destStr:String, b:Binding) : void;
		/**
		 *  Set isEnabled for all bindings associated with a document.     *     *  @param document The document that contains the bindings.
		 */
		public static function setEnabled (document:Object, isEnabled:Boolean) : void;
		/**
		 *  Execute all bindings that bind into the specified object.     *     *  @param document The document that this binding relates to.	 *     *  @param destStr The destination field that needs to be refreshed.	 *     *  @param destObj The actual destination object	 *  (used for RepeatableBinding).
		 */
		public static function executeBindings (document:Object, destStr:String, destObj:Object) : void;
		/**
		 *  @private
		 */
		private static function getFirstWord (destStr:String) : String;
		/**
		 *  Enables debugging output for the Binding or Bindings with a matching     *  destination string.     *     *  @param destinationString The Binding's destination string.
		 */
		public static function debugBinding (destinationString:String) : void;
		/**
		 *  @private	 *  BindingManager has only static methods.	 *  We don't create instances of BindingManager.
		 */
		public function BindingManager ();
	}
}
