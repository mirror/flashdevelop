/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.system {
	public final  class System {
		/**
		 * The currently installed system IME.
		 *  To register for imeComposition events, call
		 *  addEventListener() on this instance.
		 */
		public static function get ime():IME;
		/**
		 * The amount of memory (in bytes) currently in use by Adobe®
		 *  Flash® Player or Adobe® AIR™.
		 */
		public static function get totalMemory():uint;
		/**
		 * A Boolean value that determines which code page to use to interpret external text files.
		 *  When the property is set to false, external text files are interpretted as Unicode.
		 *  (These files must be encoded as Unicode when you save them.) When the property is set to
		 *  true, external text files are interpretted using the traditional code page of the
		 *  operating system running the application. The default value of useCodePage is false.
		 */
		public static function get useCodePage():Boolean;
		public function set useCodePage(value:Boolean):void;
		/**
		 * Closes Flash Player.
		 *
		 * @param code              <uint> A value to pass to the operating system. Typically, if
		 *                            the process exits normally, the value is 0.
		 */
		public static function exit(code:uint):void;
		/**
		 * Forces the garbage collection process.
		 */
		public static function gc():void;
		/**
		 * Pauses Flash Player or the AIR Debug Launcher (ADL).
		 *  After calling this method, nothing in the application continues except the delivery of Socket events.
		 */
		public static function pause():void;
		/**
		 * Resumes the application after calling System.pause().
		 */
		public static function resume():void;
		/**
		 * Replaces the contents of the Clipboard with a specified text string.
		 *
		 * @param string            <String> A plain-text string of characters to put on the system Clipboard, replacing its current contents (if any).
		 */
		public static function setClipboard(string:String):void;
	}
}
