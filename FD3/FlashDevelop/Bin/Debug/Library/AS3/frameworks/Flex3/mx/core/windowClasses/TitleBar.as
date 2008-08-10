/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-03 13:18] ***/
/**********************************************************/
package mx.core.windowClasses {
	public class TitleBar extends UIComponent {
		/**
		 * The Button object that defines the close button.
		 */
		public var closeButton:Button;
		/**
		 * The Button object that defines the maximize button.
		 */
		public var maximizeButton:Button;
		/**
		 * The Button object that defines the minimize button.
		 */
		public var minimizeButton:Button;
		/**
		 * The title that appears in the window title bar and
		 *  the dock or taskbar.
		 */
		public function get title():String;
		public function set title(value:String):void;
		/**
		 * The icon displayed in the title bar.
		 */
		public function get titleIcon():Class;
		public function set titleIcon(value:Class):void;
		/**
		 * The UITextField in the title bar that displays the application title.
		 */
		public var titleTextField:IUITextField;
		/**
		 * Constructor.
		 */
		public function TitleBar();
		/**
		 * Handles a doubleClick event in a platform-appropriate manner.
		 *
		 * @param event             <MouseEvent> 
		 */
		protected function doubleClickHandler(event:MouseEvent):void;
		/**
		 * Determines the placement of the buttons in the title bar.
		 *
		 * @param align             <String> button alignment
		 * @param unscaledWidth     <Number> width of the title bar
		 * @param unscaledHeight    <Number> height of the title bar
		 * @param leftOffset        <Number> how much space to allow on left for corners, etc.
		 * @param rightOffset       <Number> how much space to allow on right for corners, etc.
		 * @param cornerOffset      <Number> how much to indent things to take into account
		 *                            corner radius
		 */
		protected function placeButtons(align:String, unscaledWidth:Number, unscaledHeight:Number, leftOffset:Number, rightOffset:Number, cornerOffset:Number):void;
		/**
		 * Determines the alignment of the title in the title bar.
		 *
		 * @param titleAlign        <String> how to align the title.
		 * @param leftOffset        <Number> how much space to allow on left for corners, etc.
		 * @param rightOffset       <Number> how much space to allow on right for corners, etc.
		 * @param buttonAlign       <String> the way the buttons are aligned
		 */
		protected function placeTitle(titleAlign:String, leftOffset:Number, rightOffset:Number, buttonAlign:String):void;
		/**
		 * Called by the StyleManager when a style changes.
		 *
		 * @param styleProp         <String> the name of the style that's changed.
		 *                            In some cases, it can be null, usually when changing
		 *                            the global style or styleName.
		 */
		public override function styleChanged(styleProp:String):void;
	}
}
