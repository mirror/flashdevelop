package mx.core.windowClasses
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import mx.core.WindowedApplication;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUITextField;
	import mx.core.mx_internal;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;

	/**
	 *  The default status bar for a WindowedApplication or a Window. *  *  @see mx.core.Window *  @see mx.core.WindowedApplication *  *  @playerversion AIR 1.1
	 */
	public class StatusBar extends UIComponent
	{
		/**
		 *  @private     *  A reference to the status bar's skin.
		 */
		local var statusBarBackground : IFlexDisplayObject;
		/**
		 *  @private	 *  Storage for the status property.
		 */
		private var _status : String;
		/**
		 *  @private
		 */
		private var statusChanged : Boolean;
		/**
		 *  A reference to the UITextField that displays the status bar's text.
		 */
		public var statusTextField : IUITextField;

		/**
		 *  The string that appears in the status bar, if it is visible.     *      *  @default ""
		 */
		public function get status () : String;
		/**
		 *  @private
		 */
		public function set status (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function StatusBar ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
	}
}
