/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.text {
	public final  class CSMSettings {
		/**
		 * The size, in pixels, for which the settings apply.
		 */
		public var fontSize:Number;
		/**
		 * The inside cutoff value, above which densities are set to a maximum density
		 *  value (such as 255).
		 */
		public var insideCutoff:Number;
		/**
		 * The outside cutoff value, below which densities are set to zero.
		 */
		public var outsideCutoff:Number;
		/**
		 * Creates a new CSMSettings object which stores stroke values for custom anti-aliasing settings.
		 *
		 * @param fontSize          <Number> The size, in pixels, for which the settings apply.
		 * @param insideCutoff      <Number> The inside cutoff value, above which densities are set to a maximum density
		 *                            value (such as 255).
		 * @param outsideCutoff     <Number> The outside cutoff value, below which densities are set to zero.
		 */
		public function CSMSettings(fontSize:Number, insideCutoff:Number, outsideCutoff:Number);
	}
}
