/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.system {
	import flash.events.EventDispatcher;
	public final  class IME extends EventDispatcher {
		/**
		 * The conversion mode of the current IME.
		 *  Possible values are IME mode string constants that indicate the conversion mode:
		 *  ALPHANUMERIC_FULL
		 *  ALPHANUMERIC_HALF
		 *  CHINESE
		 *  JAPANESE_HIRAGANA
		 *  JAPANESE_KATAKANA_FULL
		 *  JAPANESE_KATAKANA_HALF
		 *  KOREAN
		 *  UNKNOWN (read-only value; this value cannot be set)
		 */
		public static function get conversionMode():String;
		public function set conversionMode(value:String):void;
		/**
		 * Indicates whether the system IME is enabled (true) or disabled (false).
		 *  An enabled IME performs multibyte input; a disabled IME performs alphanumeric input.
		 */
		public static function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		/**
		 * Instructs the IME to select the first candidate for the current composition string.
		 */
		public static function doConversion():void;
		/**
		 * Sets the IME composition string. When this string is set, the user
		 *  can select IME candidates before committing the result to the text
		 *  field that currently has focus.
		 *
		 * @param composition       <String> The string to send to the IME.
		 */
		public static function setCompositionString(composition:String):void;
	}
}
