/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class KeyboardEvent extends Event {
		/**
		 * Indicates whether the Alt key is active (true) or inactive (false) on Windows;
		 *  indicates whether the Option key is active on Mac OS.
		 */
		public function get altKey():Boolean;
		public function set altKey(value:Boolean):void;
		/**
		 * Contains the character code value of the key pressed or released.
		 *  The character code values are English keyboard values. For example,
		 *  if you press Shift+3, charCode is # on a Japanese keyboard,
		 *  just as it is on an English keyboard.
		 */
		public function get charCode():uint;
		public function set charCode(value:uint):void;
		/**
		 * On Windows, indicates whether the Ctrl key is active (true) or inactive (false);
		 *  On Mac OS, indicates whether either the Ctrl key or the Command key is active.
		 */
		public function get ctrlKey():Boolean;
		public function set ctrlKey(value:Boolean):void;
		/**
		 * The key code value of the key pressed or released.
		 */
		public function get keyCode():uint;
		public function set keyCode(value:uint):void;
		/**
		 * Indicates the location of the key on the keyboard. This is useful for differentiating keys
		 *  that appear more than once on a keyboard. For example, you can differentiate between the
		 *  left and right Shift keys by the value of this property: KeyLocation.LEFT
		 *  for the left and KeyLocation.RIGHT for the right. Another example is
		 *  differentiating between number keys pressed on the standard keyboard
		 *  (KeyLocation.STANDARD) versus the numeric keypad (KeyLocation.NUM_PAD).
		 */
		public function get keyLocation():uint;
		public function set keyLocation(value:uint):void;
		/**
		 * Indicates whether the Shift key modifier is active (true) or inactive
		 *  (false).
		 */
		public function get shiftKey():Boolean;
		public function set shiftKey(value:Boolean):void;
		/**
		 * Creates an Event object that contains specific information about keyboard events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Possible values are:
		 *                            KeyboardEvent.KEY_DOWN and KeyboardEvent.KEY_UP
		 * @param bubbles           <Boolean (default = true)> Determines whether the Event object participates in the bubbling stage of the event flow.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled.
		 * @param charCodeValue     <uint (default = 0)> The character code value of the key pressed or released. The character code values returned are English keyboard values. For example, if you press Shift+3, the getASCIICode() method returns # on a Japanese keyboard, just as it does on an English keyboard.
		 * @param keyCodeValue      <uint (default = 0)> The key code value of the key pressed or released.
		 * @param keyLocationValue  <uint (default = 0)> The location of the key on the keyboard.
		 * @param ctrlKeyValue      <Boolean (default = false)> On Windows, indicates whether the Ctrl key is activated. On Mac, indicates whether either the Ctrl key or the Command key is activated.
		 * @param altKeyValue       <Boolean (default = false)> Indicates whether the Alt key modifier is activated (Windows only).
		 * @param shiftKeyValue     <Boolean (default = false)> Indicates whether the Shift key modifier is activated.
		 * @param controlKeyValue   <Boolean (default = false)> 
		 * @param commandKeyValue   <Boolean (default = false)> 
		 */
		public function KeyboardEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, charCodeValue:uint = 0, keyCodeValue:uint = 0, keyLocationValue:uint = 0, ctrlKeyValue:Boolean = false, altKeyValue:Boolean = false, shiftKeyValue:Boolean = false, controlKeyValue:Boolean = false, commandKeyValue:Boolean = false);
		/**
		 * Creates a copy of the KeyboardEvent object and sets the value of each property to match that of the original.
		 *
		 * @return                  <Event> A new KeyboardEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the KeyboardEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the KeyboardEvent object.
		 */
		public override function toString():String;
		/**
		 * Indicates that the display should be rendered after processing of this event completes, if the display
		 *  list has been modified
		 */
		public function updateAfterEvent():void;
		/**
		 * Defines the value of the type property of a keyDown event object.
		 */
		public static const KEY_DOWN:String = "keyDown";
		/**
		 * Defines the value of the type property of a keyUp event object.
		 */
		public static const KEY_UP:String = "keyUp";
	}
}
