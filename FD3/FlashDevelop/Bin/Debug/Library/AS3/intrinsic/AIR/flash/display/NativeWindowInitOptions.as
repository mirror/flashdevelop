package flash.display
{
	/// The NativeWindowInitOptions class defines the initialization options used to construct a new NativeWindow instance.
	public class NativeWindowInitOptions extends Object
	{
		/// Specifies whether the window can be maximized.
		public function get maximizable () : Boolean;
		public function set maximizable (value:Boolean) : void;

		/// Specifies whether the window can be minimized.
		public function get minimizable () : Boolean;
		public function set minimizable (value:Boolean) : void;

		/// Specifies whether the window can be resized.
		public function get resizable () : Boolean;
		public function set resizable (value:Boolean) : void;

		/// Specifies whether system chrome is provided for the window.
		public function get systemChrome () : String;
		public function set systemChrome (value:String) : void;

		/// Specifies whether the window supports transparency and alpha blending against the desktop.
		public function get transparent () : Boolean;
		public function set transparent (value:Boolean) : void;

		/// Specifies the type of the window to be created.
		public function get type () : String;
		public function set type (value:String) : void;

		/// Creates a new NativeWindowInitOptions object.
		public function NativeWindowInitOptions ();
	}
}
