package mx.core
{
	import mx.managers.IFocusManager;

	/**
	 *  IContainer is a interface that indicates a component *  extends or mimics mx.core.Container * *  @see mx.core.Container
	 */
	public interface IContainer extends IUIComponent
	{
		/**
		 *  @copy mx.core.Container#defaultButton
		 */
		public function get defaultButton () : IFlexDisplayObject;
		public function set defaultButton (value:IFlexDisplayObject) : void;
		/**
		 *  @copy mx.core.Container#creatingContentPane
		 */
		public function get creatingContentPane () : Boolean;
		public function set creatingContentPane (value:Boolean) : void;
		/**
		 *  @copy mx.core.Container#viewMetrics
		 */
		public function get viewMetrics () : EdgeMetrics;
		/**
		 *  @copy mx.core.Container#horizontalScrollPosition
		 */
		public function get horizontalScrollPosition () : Number;
		public function set horizontalScrollPosition (value:Number) : void;
		/**
		 *  @copy mx.core.Container#verticalScrollPosition
		 */
		public function get verticalScrollPosition () : Number;
		public function set verticalScrollPosition (value:Number) : void;
		/**
		 *  @copy mx.core.UIComponent#focusManager
		 */
		public function get focusManager () : IFocusManager;

	}
}
