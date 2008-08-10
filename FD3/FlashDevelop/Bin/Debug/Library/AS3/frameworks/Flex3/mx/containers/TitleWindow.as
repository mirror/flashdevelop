/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers {
	public class TitleWindow extends Panel {
		/**
		 * Whether to display a Close button in the TitleWindow container.
		 *  The default value is false.
		 *  Set it to true to display the Close button.
		 *  Selecting the Close button generates a close event,
		 *  but does not close the TitleWindow container.
		 *  You must write a handler for the close event
		 *  and close the TitleWindow from within it.
		 */
		public function get showCloseButton():Boolean;
		public function set showCloseButton(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function TitleWindow();
	}
}
