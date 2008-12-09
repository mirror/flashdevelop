package flash.display
{
	/// The StageQuality class provides values for the Stage.quality property.
	public class StageQuality
	{
		/// Specifies low rendering quality: graphics are not anti-aliased, and bitmaps are not smoothed.
		public static const LOW:String = "low";

		/// Specifies medium rendering quality: graphics are anti-aliased using a 2 x 2 pixel grid, but bitmaps are not smoothed.
		public static const MEDIUM:String = "medium";

		/// Specifies high rendering quality: graphics are anti-aliased using a 4 x 4 pixel grid, and bitmaps are smoothed if the movie is static.
		public static const HIGH:String = "high";

		/// Specifies very high rendering quality: graphics are anti-aliased using a 4 x 4 pixel grid and bitmaps are always smoothed.
		public static const BEST:String = "best";

	}

}

