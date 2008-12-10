package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.core.mx_internal;
	import mx.skins.ProgrammaticSkin;

	/**
	 *  The skins of the DateChooser's indicators for  *  displaying today, rollover and selected dates.
	 */
	public class DateChooserIndicator extends ProgrammaticSkin
	{
		/**
		 *  @private
		 */
		local var indicatorColor : String;

		/**
		 *  Constructor
		 */
		public function DateChooserIndicator ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
