package mx.core
{
	import flash.geom.Rectangle;

	/**
	 *  The IToolTip interface defines the API that tooltip-like components
 *  must implement in order to work with the ToolTipManager.
 *  The ToolTip class implements this interface.
 *
 *  @see mx.controls.ToolTip
 *  @see mx.managers.ToolTipManager
	 */
	public interface IToolTip extends IUIComponent
	{
		/**
		 *  A Rectangle that specifies the size and position
	 *  of the base drawing surface for this tooltip.
		 */
		public function get screen () : Rectangle;

		/**
		 *  The text that appears in the tooltip.
		 */
		public function get text () : String;
		/**
		 *  @private
		 */
		public function set text (value:String) : void;
	}
}
