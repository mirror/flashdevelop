package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;

include "../../core/Version.as"
	/**
	 *  The skin for the mask of the ProgressBar's determinate and indeterminate bars.
 *  The mask defines the area in which the progress bar or 
 *  indeterminate progress bar is displayed.
 *  By default, the mask defines the progress bar to be inset 1 pixel from the track.
 *
 *  @see mx.controls.ProgressBar
	 */
	public class ProgressMaskSkin extends ProgrammaticSkin
	{
		/**
		 *  Constructor.
		 */
		public function ProgressMaskSkin ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
	}
}
