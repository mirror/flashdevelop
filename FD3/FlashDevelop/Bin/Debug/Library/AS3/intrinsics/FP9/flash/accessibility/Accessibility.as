package flash.accessibility
{
	/// The Accessibility class manages communication with screen readers.
	public class Accessibility
	{
		/// Indicates whether a screen reader is currently active and the player is communicating with it.
		public var active:Boolean;

		/// Tells Flash Player to apply any accessibility changes made by using the DisplayObject.accessibilityProperties property.
		public static function updateProperties():void;

	}

}

