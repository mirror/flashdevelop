package mx.managers
{
	import mx.core.IFlexDisplayObject;

	/**
	 *  Components that implement IToolTipManagerClient can have tooltips and must  *  have a toolTip getter/setter. *  The ToolTipManager class manages showing and hiding the  *  tooltip on behalf of any component which is an IToolTipManagerClient. *  *  @see mx.controls.ToolTip *  @see mx.managers.ToolTipManager *  @see mx.core.IToolTip
	 */
	public interface IToolTipManagerClient extends IFlexDisplayObject
	{
		/**
		 *  The text of this component's tooltip.
		 */
		public function get toolTip () : String;
		/**
		 *  @private
		 */
		public function set toolTip (value:String) : void;

	}
}
