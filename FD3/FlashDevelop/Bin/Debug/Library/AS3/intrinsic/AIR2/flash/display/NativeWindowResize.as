package flash.display
{
	/// The NativeWindowResize class defines constants for the possible values of the edgeOrCorner parameter of the NativeWindow startResize() method.
	public class NativeWindowResize extends Object
	{
		/// The bottom edge of the window.
		public static const BOTTOM : String;
		/// The bottom-left corner of the window.
		public static const BOTTOM_LEFT : String;
		/// The bottom-right corner of the window.
		public static const BOTTOM_RIGHT : String;
		/// The left edge of the window.
		public static const LEFT : String;
		/// Provides no hint to the system about which edge or corner to resize from, allowing for default behavior.
		public static const NONE : String;
		/// The right edge of the window.
		public static const RIGHT : String;
		/// The top edge of the window.
		public static const TOP : String;
		/// The top-left corner of the window.
		public static const TOP_LEFT : String;
		/// The top-right corner of the window.
		public static const TOP_RIGHT : String;

		public function NativeWindowResize ();
	}
}
