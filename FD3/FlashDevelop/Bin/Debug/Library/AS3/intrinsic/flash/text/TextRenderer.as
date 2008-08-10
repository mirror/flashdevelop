/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.text {
	public final  class TextRenderer {
		/**
		 * Controls the rendering of advanced anti-aliased text. The visual quality of text is very subjective, and while
		 *  Flash Player tries to use the best settings for various conditions, designers may choose a different
		 *  look or feel for their text. Also, using displayMode allows a designer to override Flash
		 *  Player's subpixel choice and create visual consistency independent of the user's hardware. Use the values in the TextDisplayMode class to set this property.
		 */
		public static function get displayMode():String;
		public function set displayMode(value:String):void;
		/**
		 * The adaptively sampled distance fields (ADFs) quality level for advanced anti-aliasing. The only acceptable values are
		 *  3, 4, and 7.
		 */
		public static function get maxLevel():int;
		public function set maxLevel(value:int):void;
		/**
		 * Sets a custom continuous stroke modulation (CSM) lookup table for a font.
		 *  Flash Player attempts to detect the best CSM for your font. If you are not
		 *  satisfied with the CSM that the Flash Player provides, you can customize
		 *  your own CSM by using the setAdvancedAntiAliasingTable() method.
		 *
		 * @param fontName          <String> The name of the font for which you are applying settings.
		 * @param fontStyle         <String> The font style indicated by using one of the values from
		 *                            the flash.text.FontStyle class.
		 * @param colorType         <String> This value determines whether the stroke is dark or whether it is light.
		 *                            Use one of the values from the flash.text.TextColorType class.
		 * @param advancedAntiAliasingTable<Array> An array of one or more CSMSettings objects
		 *                            for the specified font. Each object contains the following properties:
		 *                            fontSize
		 *                            insideCutOff
		 *                            outsideCutOff
		 *                            The advancedAntiAliasingTable array can contain multiple entries
		 *                            that specify CSM settings for different font sizes.
		 *                            The fontSize is the size, in pixels, for which the settings apply.
		 *                            Advanced anti-aliasing uses adaptively sampled distance fields (ADFs) to
		 *                            represent the outlines that determine a glyph. Flash Player uses an outside cutoff value
		 *                            (outsideCutOff),
		 *                            below which densities are set to zero, and an inside cutoff value (insideCutOff),
		 *                            above which densities
		 *                            are set to a maximum density value (such as 255). Between these two cutoff values,
		 *                            the mapping function is a linear curve ranging from zero at the outside cutoff
		 *                            to the maximum density at the inside cutoff.
		 *                            Adjusting the outside and inside cutoff values affects stroke weight and
		 *                            edge sharpness. The spacing between these two parameters is comparable to twice the
		 *                            filter radius of classic anti-aliasing methods; a narrow spacing provides a sharper edge,
		 *                            while a wider spacing provides a softer, more filtered edge. When
		 *                            the spacing is zero, the resulting density image is a bi-level bitmap. When the
		 *                            spacing is very wide, the resulting density image has a watercolor-like edge.
		 *                            Typically, users prefer sharp, high-contrast edges at small point sizes, and
		 *                            softer edges for animated text and larger point sizes.
		 *                            The outside cutoff typically has a negative value, and the inside cutoff typically
		 *                            has a positive value, and their midpoint typically lies near zero. Adjusting these
		 *                            parameters to shift the midpoint toward negative infinity increases the stroke
		 *                            weight; shifting the midpoint toward positive infinity decreases the stroke weight.
		 *                            Make sure that the outside cutoff value is always less than or equal to the inside cutoff value.
		 */
		public static function setAdvancedAntiAliasingTable(fontName:String, fontStyle:String, colorType:String, advancedAntiAliasingTable:Array):void;
	}
}
