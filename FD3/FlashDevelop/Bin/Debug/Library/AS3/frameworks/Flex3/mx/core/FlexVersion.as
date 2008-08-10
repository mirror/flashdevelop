/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public class FlexVersion {
		/**
		 * A function that gets called when the compatibility version
		 *  is set more than once, or set after it has been read.
		 *  If this function is not set, the SDK throws an error.
		 *  If set, File calls this function, but it is
		 *  up to the developer to decide how to handle the call.
		 *  This function will also be called if the function is set more than once.
		 *  The function takes two parameters: the first is a uint
		 *  which is the version that was attempted to be set; the second
		 *  is a string that is the reason it failed, either
		 *  VERSION_ALREADY_SET or VERSION_ALREADY_READ.
		 */
		public static function get compatibilityErrorFunction():Function;
		public function set compatibilityErrorFunction(value:Function):void;
		/**
		 * The current version that the framework maintains compatibility for.
		 *  This defaults to CURRENT_VERSION.
		 *  It can be changed only once; changing it a second time
		 *  results in a call to the compatibilityErrorFunction() method
		 *  if it exists, or results in a runtime error.
		 *  Changing it after the compatibilityVersion property has been read results in an error
		 *  because code that is dependent on the version has already run.
		 *  There are no notifications; the assumption is that this is set only once, and this it is set
		 *  early enough that no code that depends on it has run yet.
		 */
		public static function get compatibilityVersion():uint;
		public function set compatibilityVersion(value:uint):void;
		/**
		 * The compatibility version, as a string of the form "X.X.X".
		 *  This is a pass-through to the compatibilityVersion
		 *  property, which converts the number to and from a more
		 *  human-readable String version.
		 */
		public static function get compatibilityVersionString():String;
		public function set compatibilityVersionString(value:String):void;
		/**
		 * The current released version of the Flex SDK, encoded as a uint.
		 */
		public static const CURRENT_VERSION:uint = 0x03000000;
		/**
		 * The compatibilityVersion value of Flex 2.0,
		 *  encoded numerically as a uint.
		 *  Code can compare this constant against
		 *  the compatibilityVersion
		 *  to implement version-specific behavior.
		 */
		public static const VERSION_2_0:uint = 0x02000000;
		/**
		 * The compatibilityVersion value of Flex 2.0.1,
		 *  encoded numerically as a uint.
		 *  Code can compare this constant against
		 *  the compatibilityVersion
		 *  to implement version-specific behavior.
		 */
		public static const VERSION_2_0_1:uint = 0x02000001;
		/**
		 * The compatibilityVersion value of Flex 3.0,
		 *  encoded numerically as a uint.
		 *  Code can compare this constant against
		 *  the compatibilityVersion
		 *  to implement version-specific behavior.
		 */
		public static const VERSION_3_0:uint = 0x03000000;
		/**
		 * A String passed as a parameter
		 *  to the compatibilityErrorFunction() method
		 *  if the compatibility version has already been read.
		 */
		public static const VERSION_ALREADY_READ:String = "versionAlreadyRead";
		/**
		 * A String passed as a parameter
		 *  to the compatibilityErrorFunction() method
		 *  if the compatibility version has already been set.
		 */
		public static const VERSION_ALREADY_SET:String = "versionAlreadySet";
	}
}
