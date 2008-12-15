package flash.display 
{
	public final class StageScaleMode 
	{
		/**
		 * Specifies that the entire Adobe® Flash® application be visible in the specified area without trying to preserve
		 *  the original aspect ratio. Distortion can occur.
		 */
		public static const EXACT_FIT:String = "exactFit";
		/**
		 * Specifies that the entire Flash application fill the specified area, without distortion but possibly with
		 *  some cropping, while maintaining the original aspect ratio of the application.
		 */
		public static const NO_BORDER:String = "noBorder";
		/**
		 * Specifies that the size of the Flash application be fixed, so that it remains unchanged even as the size
		 *  of the player window changes. Cropping might occur if the player window is smaller than the content.
		 */
		public static const NO_SCALE:String = "noScale";
		/**
		 * Specifies that the entire Flash application be visible in the specified area without distortion while
		 *  maintaining the original aspect ratio of the application. Borders can appear on two sides of the application.
		 */
		public static const SHOW_ALL:String = "showAll";
	}
	
}
