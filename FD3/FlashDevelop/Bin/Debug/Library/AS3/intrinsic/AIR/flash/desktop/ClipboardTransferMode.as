package flash.desktop
{
	/// Defines constants for the modes used as values of the transferMode parameter of the Clipboard.getData() method.
	public class ClipboardTransferMode
	{
		/// [AIR] The Clipboard object should return a reference if available and a copy if not.
		public static const ORIGINAL_PREFERRED:String = "originalPreferred";

		/// [AIR] The Clipboard object should only return a reference.
		public static const ORIGINAL_ONLY:String = "originalOnly";

		/// [AIR] The Clipboard object should return a copy if available and a reference if not.
		public static const CLONE_PREFERRED:String = "clonePreferred";

		/// [AIR] The Clipboard object should only return a copy.
		public static const CLONE_ONLY:String = "cloneOnly";

	}

}

