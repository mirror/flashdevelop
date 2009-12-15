package flash.display
{
	import flash.events.EventDispatcher;

	/// The NativeMenuItem class represents a single item in a menu.
	public class NativeMenuItem extends EventDispatcher
	{
		/// Controls whether this menu item is enabled.
		public function get enabled () : Boolean;
		public function set enabled (isSeparator:Boolean) : void;

		/// Creates a new NativeMenuItem object.
		public function NativeMenuItem ();
	}
}
