package mx.controls.buttonBarClasses
{
	import mx.controls.Button;
	import mx.core.UITextFormat;
	import mx.core.mx_internal;

	/**
	 *  @private *  The ButtonBarButton class is for internal use.
	 */
	public class ButtonBarButton extends Button
	{
		/**
		 *  @private
		 */
		private var inLayoutContents : Boolean;

		/**
		 *  Constructor.
		 */
		public function ButtonBarButton ();
		/**
		 *  @private
		 */
		public function determineTextFormatFromStyles () : UITextFormat;
		/**
		 *  @private
		 */
		function layoutContents (unscaledWidth:Number, unscaledHeight:Number, offset:Boolean) : void;
	}
}
