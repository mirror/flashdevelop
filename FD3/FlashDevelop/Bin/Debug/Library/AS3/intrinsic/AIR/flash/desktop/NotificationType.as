package flash.desktop
{
	/// The NotificationType class defines constants for use in the priority parameter of the DockIcon bounce() method and the type parameter of the NativeWindow notifyUser() method.
	public class NotificationType extends Object
	{
		/// [AIR] Specifies that a notification alert is critical in nature and the user should attend to it promptly.
		public static const CRITICAL : String;
		/// [AIR] Specifies that a notification alert is informational in nature and the user can safely ignore it.
		public static const INFORMATIONAL : String;

		public function NotificationType ();
	}
}
