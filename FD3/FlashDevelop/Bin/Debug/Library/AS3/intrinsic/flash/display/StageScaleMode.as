package flash.display
{
	/// The StageScaleMode class provides values for the Stage.scaleMode property.
	public class StageScaleMode
	{
		/// Specifies that the entire application be visible in the specified area without distortion while maintaining the original aspect ratio of the application.
		public static const SHOW_ALL:String = "showAll";

		/// Specifies that the entire application be visible in the specified area without trying to preserve the original aspect ratio.
		public static const EXACT_FIT:String = "exactFit";

		/// Specifies that the entire application fill the specified area, without distortion but possibly with some cropping, while maintaining the original aspect ratio of the application.
		public static const NO_BORDER:String = "noBorder";

		/// Specifies that the size of the application be fixed, so that it remains unchanged even as the size of the player window changes.
		public static const NO_SCALE:String = "noScale";

	}

}

