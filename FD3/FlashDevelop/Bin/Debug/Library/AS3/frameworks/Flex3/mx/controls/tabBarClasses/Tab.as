package mx.controls.tabBarClasses
{
	import flash.display.DisplayObject;
	import flash.text.TextLineMetrics;
	import mx.controls.Button;
	import mx.core.IFlexDisplayObject;
	import mx.core.IProgrammaticSkin;
	import mx.core.IStateClient;
	import mx.core.mx_internal;
	import mx.styles.ISimpleStyleClient;

	/**
	 *  @private
	 */
	public class Tab extends Button
	{
		/**
		 *  @private
		 */
		private var focusSkin : IFlexDisplayObject;

		/**
		 *  Constructor.
		 */
		public function Tab ();
		/**
		 *  @private
		 */
		public function measureText (text:String) : TextLineMetrics;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function drawFocus (isFocused:Boolean) : void;
		/**
		 *  @private
		 */
		function layoutContents (unscaledWidth:Number, unscaledHeight:Number, offset:Boolean) : void;
		/**
		 *  @private
		 */
		function viewIcon () : void;
	}
}
