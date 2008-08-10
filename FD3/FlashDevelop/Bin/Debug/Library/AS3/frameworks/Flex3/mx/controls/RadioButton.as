/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.managers.IFocusManagerGroup;
	public class RadioButton extends Button implements IFocusManagerGroup {
		/**
		 * The RadioButtonGroup object to which this RadioButton belongs.
		 */
		public function get group():RadioButtonGroup;
		public function set group(value:RadioButtonGroup):void;
		/**
		 * Specifies the name of the group to which this RadioButton control belongs, or
		 *  specifies the value of the id property of a RadioButtonGroup control
		 *  if this RadioButton is part of a group defined by a RadioButtonGroup control.
		 */
		public function get groupName():String;
		public function set groupName(value:String):void;
		/**
		 * Position of the label relative to the RadioButton icon.
		 *  Valid values in MXML are "right", "left",
		 *  "bottom", and "top".
		 */
		public function get labelPlacement():String;
		public function set labelPlacement(value:String):void;
		/**
		 * Optional user-defined value
		 *  that is associated with a RadioButton control.
		 */
		public function get value():Object;
		public function set value(value:Object):void;
		/**
		 * Constructor.
		 */
		public function RadioButton();
	}
}
