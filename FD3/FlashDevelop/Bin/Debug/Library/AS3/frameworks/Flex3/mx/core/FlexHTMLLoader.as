/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-03 13:18] ***/
/**********************************************************/
package mx.core {
	public class FlexHTMLLoader extends HTMLLoader implements IFocusManagerComplexComponent {
		/**
		 * A flag that indicates whether the component can receive focus when selected.
		 */
		public function get focusEnabled():Boolean;
		public function set focusEnabled(value:Boolean):void;
		/**
		 * Whether the component can receive focus when clicked on.
		 *  If false, focus will be transferred to
		 *  the first parent that is mouseFocusEnable
		 *  set to true.
		 */
		public function get mouseFocusEnabled():Boolean;
		public function set mouseFocusEnabled(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function FlexHTMLLoader();
		/**
		 * Called by the FocusManager when the component receives focus.
		 *  The component may in turn set focus to an internal component.
		 *  The component's setFocus() method will still be called when focused by
		 *  the mouse, but this method will be used when focus changes via the
		 *  keyboard.
		 *
		 * @param direction         <String> one of flash.display.FocusDirection
		 */
		public function assignFocus(direction:String):void;
		/**
		 * Called by the FocusManager when the component receives focus.
		 *  The component should draw or hide a graphic
		 *  that indicates that the component has focus.
		 *
		 * @param isFocused         <Boolean> If true, draw the focus indicator,
		 *                            otherwise hide it.
		 */
		public function drawFocus(isFocused:Boolean):void;
		/**
		 * Called by the FocusManager when the component receives focus.
		 *  The component may in turn set focus to an internal component.
		 */
		public function setFocus():void;
		/**
		 * Returns a string indicating the location of this object
		 *  within the hierarchy of DisplayObjects in the Application.
		 *  This string, such as "MyApp0.HBox5.FlexLoader13",
		 *  is built by the displayObjectToString() method
		 *  of the mx.utils.NameUtils class from the name
		 *  property of the object and its ancestors.
		 *
		 * @return                  <String> A String indicating the location of this object
		 *                            within the DisplayObject hierarchy.
		 */
		public override function toString():String;
	}
}
