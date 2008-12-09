package flash.text.engine
{
	/// The TextRotation class is an enumeration of constant values used with the following properties:ElementFormat.textRotation, ContentElement.textRotation,TextBlock.lineRotation, and TextLine.getAtomTextRotation().
	public class TextRotation
	{
		/// Specifies no rotation.
		public static const ROTATE_0:String = "rotate0";

		/// Specifies a 90 degree clockwise rotation.
		public static const ROTATE_90:String = "rotate90";

		/// Specifies a 180 degree rotation.
		public static const ROTATE_180:String = "rotate180";

		/// Specifies a 270 degree clockwise rotation.
		public static const ROTATE_270:String = "rotate270";

		/// Specifies a 90 degree counter clockwise rotation for full width and wide glyphs only, as determined by the Unicode properties of the glyph.
		public static const AUTO:String = "auto";

	}

}

