package flash.system
{
	/// The IME class lets you directly manipulate the operating system's input method editor (IME) in the Flash Player application that is running on a client computer.
	public class IME extends flash.events.EventDispatcher
	{
		/** 
		 * Dispatched when a user has completed an input method editor (IME) composition and the reading string is available.
		 * @eventType flash.events.IMEEvent.IME_COMPOSITION
		 */
		[Event(name="imeComposition", type="flash.events.IMEEvent")]

		/// Indicates whether the system IME is enabled (true) or disabled (false).
		public var enabled:Boolean;

		/// The conversion mode of the current IME.
		public var conversionMode:String;

		/// Sets the IME composition string.
		public static function setCompositionString(composition:String):void;

		/// Instructs the IME to select the first candidate for the current composition string.
		public static function doConversion():void;

	}

}

