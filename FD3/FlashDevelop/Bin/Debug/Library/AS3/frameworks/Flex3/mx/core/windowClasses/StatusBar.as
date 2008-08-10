/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-03 13:18] ***/
/**********************************************************/
package mx.core.windowClasses {
	public class StatusBar extends UIComponent {
		/**
		 * The string that appears in the status bar, if it is visible.
		 */
		public function get status():String;
		public function set status(value:String):void;
		/**
		 * A reference to the UITextField that displays the status bar's text.
		 */
		public var statusTextField:IUITextField;
		/**
		 * Constructor.
		 */
		public function StatusBar();
	}
}
