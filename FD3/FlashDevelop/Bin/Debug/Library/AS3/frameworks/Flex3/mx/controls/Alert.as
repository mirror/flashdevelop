/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.containers.Panel;
	import flash.display.Sprite;
	public class Alert extends Panel {
		/**
		 * A bitmask that contains Alert.OK, Alert.CANCEL,
		 *  Alert.YES, and/or Alert.NO indicating
		 *  the buttons available in the Alert control.
		 */
		public var buttonFlags:uint = 0x0004;
		/**
		 * Height of each Alert button, in pixels.
		 *  All buttons must be the same height.
		 */
		public static var buttonHeight:Number = 22;
		/**
		 * Width of each Alert button, in pixels.
		 *  All buttons must be the same width.
		 */
		public static var buttonWidth:Number = NaN;
		/**
		 * The label for the Cancel button.
		 */
		public static function get cancelLabel():String;
		public function set cancelLabel(value:String):void;
		/**
		 * A bitflag that contains either Alert.OK,
		 *  Alert.CANCEL, Alert.YES,
		 *  or Alert.NO to specify the default button.
		 */
		public var defaultButtonFlag:uint = 0x0004;
		/**
		 * The class of the icon to display.
		 *  You typically embed an asset, such as a JPEG or GIF file,
		 *  and then use the variable associated with the embedded asset
		 *  to specify the value of this property.
		 */
		public var iconClass:Class;
		/**
		 * The label for the No button.
		 */
		public static function get noLabel():String;
		public function set noLabel(value:String):void;
		/**
		 * The label for the OK button.
		 */
		public static function get okLabel():String;
		public function set okLabel(value:String):void;
		/**
		 * The text to display in this alert dialog box.
		 */
		public var text:String = "";
		/**
		 * The label for the Yes button.
		 */
		public static function get yesLabel():String;
		public function set yesLabel(value:String):void;
		/**
		 * Constructor.
		 */
		public function Alert();
		/**
		 * Static method that pops up the Alert control. The Alert control
		 *  closes when you select a button in the control, or press the Escape key.
		 *
		 * @param text              <String (default = "")> Text string that appears in the Alert control.
		 *                            This text is centered in the alert dialog box.
		 * @param title             <String (default = "")> Text string that appears in the title bar.
		 *                            This text is left justified.
		 * @param flags             <uint (default = 0x4)> Which buttons to place in the Alert control.
		 *                            Valid values are Alert.OK, Alert.CANCEL,
		 *                            Alert.YES, and Alert.NO.
		 *                            The default value is Alert.OK.
		 *                            Use the bitwise OR operator to display more than one button.
		 *                            For example, passing (Alert.YES | Alert.NO)
		 *                            displays Yes and No buttons.
		 *                            Regardless of the order that you specify buttons,
		 *                            they always appear in the following order from left to right:
		 *                            OK, Yes, No, Cancel.
		 * @param parent            <Sprite (default = null)> Object upon which the Alert control centers itself.
		 * @param closeHandler      <Function (default = null)> Event handler that is called when any button
		 *                            on the Alert control is pressed.
		 *                            The event object passed to this handler is an instance of CloseEvent;
		 *                            the detail property of this object contains the value
		 *                            Alert.OK, Alert.CANCEL,
		 *                            Alert.YES, or Alert.NO.
		 * @param iconClass         <Class (default = null)> Class of the icon that is placed to the left
		 *                            of the text in the Alert control.
		 * @param defaultButtonFlag <uint (default = 0x4)> A bitflag that specifies the default button.
		 *                            You can specify one and only one of
		 *                            Alert.OK, Alert.CANCEL,
		 *                            Alert.YES, or Alert.NO.
		 *                            The default value is Alert.OK.
		 *                            Pressing the Enter key triggers the default button
		 *                            just as if you clicked it. Pressing Escape triggers the Cancel
		 *                            or No button just as if you selected it.
		 * @return                  <Alert> A reference to the Alert control.
		 */
		public static function show(text:String = "", title:String = "", flags:uint = 0x4, parent:Sprite = null, closeHandler:Function = null, iconClass:Class = null, defaultButtonFlag:uint = 0x4):Alert;
		/**
		 * Value that enables a Cancel button on the Alert control when passed
		 *  as the flags parameter of the show() method.
		 *  You can use the | operator to combine this bitflag
		 *  with the OK, YES,
		 *  NO, and NONMODAL flags.
		 */
		public static const CANCEL:uint = 0x0008;
		/**
		 * Value that enables a No button on the Alert control when passed
		 *  as the flags parameter of the show() method.
		 *  You can use the | operator to combine this bitflag
		 *  with the OK, CANCEL,
		 *  YES, and NONMODAL flags.
		 */
		public static const NO:uint = 0x0002;
		/**
		 * Value that makes an Alert nonmodal when passed as the
		 *  flags parameter of the show() method.
		 *  You can use the | operator to combine this bitflag
		 *  with the OK, CANCEL,
		 *  YES, and NO flags.
		 */
		public static const NONMODAL:uint = 0x8000;
		/**
		 * Value that enables an OK button on the Alert control when passed
		 *  as the flags parameter of the show() method.
		 *  You can use the | operator to combine this bitflag
		 *  with the CANCEL, YES,
		 *  NO, and NONMODAL flags.
		 */
		public static const OK:uint = 0x0004;
		/**
		 * Value that enables a Yes button on the Alert control when passed
		 *  as the flags parameter of the show() method.
		 *  You can use the | operator to combine this bitflag
		 *  with the OK, CANCEL,
		 *  NO, and NONMODAL flags.
		 */
		public static const YES:uint = 0x0001;
	}
}
