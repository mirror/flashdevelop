package mx.managers
{
	import flash.display.DisplayObject;
	import mx.core.IToolTip;
	import mx.core.IUIComponent;
	import mx.effects.Effect;

	/**
	 *  @private *  This interface was used by Flex 2.0.1. *  Flex 3 uses IToolTipManager2 instead.
	 */
	public interface IToolTipManager
	{
		/**
		 *  @private
		 */
		public function get currentTarget () : DisplayObject;
		/**
		 *  @private
		 */
		public function set currentTarget (value:DisplayObject) : void;
		/**
		 *  @private
		 */
		public function get currentToolTip () : IToolTip;
		/**
		 *  @private
		 */
		public function set currentToolTip (value:IToolTip) : void;
		/**
		 *  @private
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get hideDelay () : Number;
		/**
		 *  @private
		 */
		public function set hideDelay (value:Number) : void;
		/**
		 *  @private
		 */
		public function get hideEffect () : Effect;
		/**
		 *  @private
		 */
		public function set hideEffect (value:Effect) : void;
		/**
		 *  @private
		 */
		public function get scrubDelay () : Number;
		/**
		 *  @private
		 */
		public function set scrubDelay (value:Number) : void;
		/**
		 *  @private
		 */
		public function get showDelay () : Number;
		/**
		 *  @private
		 */
		public function set showDelay (value:Number) : void;
		/**
		 *  @private
		 */
		public function get showEffect () : Effect;
		/**
		 *  @private
		 */
		public function set showEffect (value:Effect) : void;
		/**
		 *  @private
		 */
		public function get toolTipClass () : Class;
		/**
		 *  @private
		 */
		public function set toolTipClass (value:Class) : void;

		/**
		 *  @private
		 */
		public function registerToolTip (target:DisplayObject, oldToolTip:String, newToolTip:String) : void;
		/**
		 *  @private
		 */
		public function registerErrorString (target:DisplayObject, oldErrorString:String, newErrorString:String) : void;
		/**
		 *  @private
		 */
		public function sizeTip (toolTip:IToolTip) : void;
		/**
		 *  @private
		 */
		public function createToolTip (text:String, x:Number, y:Number, errorTipBorderStyle:String = null, context:IUIComponent = null) : IToolTip;
		/**
		 *  @private
		 */
		public function destroyToolTip (toolTip:IToolTip) : void;
	}
}
