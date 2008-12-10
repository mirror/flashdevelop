package mx.containers.utilityClasses
{
	import mx.containers.BoxDirection;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.core.ScrollPolicy;

	/**
	 *  @private *  The BoxLayout class is for internal use only.
	 */
	public class BoxLayout extends Layout
	{
		/**
		 *  @private
		 */
		public var direction : String;

		/**
		 *  Constructor.
		 */
		public function BoxLayout ();
		/**
		 *  @private	 *  Measure container as per Box layout rules.
		 */
		public function measure () : void;
		/**
		 *  @private	 *  Lay out children as per Box layout rules.
		 */
		public function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		private function isVertical () : Boolean;
		/**
		 *  @private
		 */
		function widthPadding (numChildren:Number) : Number;
		/**
		 *  @private
		 */
		function heightPadding (numChildren:Number) : Number;
		/**
		 *  @private	 *  Returns a numeric value for the align setting.	 *  0 = left/top, 0.5 = center, 1 = right/bottom
		 */
		function getHorizontalAlignValue () : Number;
		/**
		 *  @private	 *  Returns a numeric value for the align setting.	 *  0 = left/top, 0.5 = center, 1 = right/bottom
		 */
		function getVerticalAlignValue () : Number;
	}
}
