package flash.system
{
	import flash.system.IME;

	/// The System class contains properties related to certain operations that take place on the user's computer, such as operations with shared objects, local settings for cameras and microphones, and the use of the Clipboard.
	public class System extends Object
	{
		/// The currently installed system IME.
		public static function get ime () : IME;

		/// The amount of memory (in bytes) currently in use by Adobe® Flash® Player or Adobe® AIR™.
		public static function get totalMemory () : uint;

		/// A Boolean value that determines which code page to use to interpret external text files.
		public static function get useCodePage () : Boolean;
		public static function set useCodePage (value:Boolean) : void;

		public static function get vmVersion () : String;

		public static function disposeXML (node:XML) : void;

		/// Closes Flash Player.
		public static function exit (code:uint) : void;

		/// Forces the garbage collection process.
		public static function gc () : void;

		public static function nativeConstructionOnly (object:Object) : void;

		/// Pauses Flash Player or the AIR Debug Launcher (ADL).
		public static function pause () : void;

		/// Resumes the application after calling System.pause().
		public static function resume () : void;

		/// Replaces the contents of the Clipboard with a specified text string.
		public static function setClipboard (string:String) : void;

		public function System ();
	}
}
