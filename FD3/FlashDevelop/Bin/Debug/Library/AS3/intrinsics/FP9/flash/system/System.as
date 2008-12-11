package flash.system
{
	/// The System class contains properties related to certain operations that take place on the user's computer, such as operations with shared objects, local settings for cameras and microphones, and use of the Clipboard.
	public class System
	{
		/// The currently installed system IME.
		public var ime:flash.system.IME;

		/// The amount of memory (in bytes) currently in use by Adobe&#xAE; Flash&#xAE; Player.
		public var totalMemory:uint;

		/// A Boolean value that tells Flash Player which code page to use to interpret external text files.
		public var useCodePage:Boolean;

		/// Replaces the contents of the Clipboard with a specified text string.
		public static function setClipboard(string:String):void;

		/// Pauses the Flash Player.
		public static function pause():void;

		/// Resumes the Flash Player after using System.pause().
		public static function resume():void;

		/// Closes the Flash Player.
		public static function exit(code:uint):void;

		/// Forces the garbage collection process.
		public static function gc():void;

	}

}

