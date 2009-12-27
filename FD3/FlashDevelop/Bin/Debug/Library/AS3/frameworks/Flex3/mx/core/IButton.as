package mx.core
{
	/**
	 *  The IButton interface is a marker interface that indicates that a component
 *  acts as a button.
	 */
	public interface IButton extends IUIComponent
	{
		/**
		 *  @copy mx.controls.Button#emphasized
		 */
		public function get emphasized () : Boolean;
		public function set emphasized (value:Boolean) : void;

		/**
		 *  @copy mx.core.UIComponent#callLater()
		 */
		public function callLater (method:Function, args:Array = null) : void;
	}
}
