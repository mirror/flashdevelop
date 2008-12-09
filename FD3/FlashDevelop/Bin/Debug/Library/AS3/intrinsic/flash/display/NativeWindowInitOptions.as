package flash.display
{
	/// The NativeWindowInitOptions class defines the initialization options used to construct a new NativeWindow instance.
	public class NativeWindowInitOptions
	{
		/// [AIR] Specifies whether system chrome is provided for the window.
		public var systemChrome:String;

		/// [AIR] Specifies whether the window supports transparency and alpha blending against the desktop.
		public var transparent:Boolean;

		/// [AIR] Specifies the type of the window to be created.
		public var type:String;

		/// [AIR] Specifies whether the window can be minimized.
		public var minimizable:Boolean;

		/// [AIR] Specifies whether the window can be maximized.
		public var maximizable:Boolean;

		/// [AIR] Specifies whether the window can be resized.
		public var resizable:Boolean;

		/// [AIR] Creates a new NativeWindowInitOptions object.
		public function NativeWindowInitOptions();

	}

}

