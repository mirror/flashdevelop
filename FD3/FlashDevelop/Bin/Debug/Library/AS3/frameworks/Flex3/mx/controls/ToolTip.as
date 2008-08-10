/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.UIComponent;
	import mx.core.IToolTip;
	import mx.core.IFontContextComponent;
	public class ToolTip extends UIComponent implements IToolTip, IFontContextComponent {
		/**
		 * Maximum width in pixels for new ToolTip controls.
		 */
		public static var maxWidth:Number = 300;
		/**
		 * The text displayed by the ToolTip.
		 */
		public function get text():String;
		public function set text(value:String):void;
		/**
		 * The internal UITextField that renders the text of this ToolTip.
		 */
		protected var textField:IUITextField;
		/**
		 * Constructor.
		 */
		public function ToolTip();
	}
}
