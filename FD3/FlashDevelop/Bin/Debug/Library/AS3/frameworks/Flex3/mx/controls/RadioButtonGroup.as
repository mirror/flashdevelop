/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import flash.events.EventDispatcher;
	import mx.core.IMXMLObject;
	import mx.core.IFlexDisplayObject;
	public class RadioButtonGroup extends EventDispatcher implements IMXMLObject {
		/**
		 * Determines whether selection is allowed.
		 */
		public function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		/**
		 * Position of the RadioButton label relative to the RadioButton icon
		 *  for each control in the group.
		 *  You can override this setting for the individual controls.
		 */
		public function get labelPlacement():String;
		public function set labelPlacement(value:String):void;
		/**
		 * The number of RadioButtons that belong to this RadioButtonGroup.
		 */
		public function get numRadioButtons():int;
		/**
		 * The value of the value property of the selected
		 *  RadioButton control in the group, if this has been set
		 *  to be something other than null (the default value).
		 *  Otherwise, selectedValue is the value of the
		 *  label property of the selected RadioButton.
		 *  If no RadioButton is selected, this property is null.
		 */
		public function get selectedValue():Object;
		public function set selectedValue(value:Object):void;
		/**
		 * Contains a reference to the currently selected
		 *  RadioButton control in the group.
		 *  You can access the property in ActionScript only;
		 *  it is not settable in MXML.
		 *  Setting this property to null deselects the currently selected RadioButton control.
		 */
		public function get selection():RadioButton;
		public function set selection(value:RadioButton):void;
		/**
		 * Constructor.
		 *
		 * @param document          <IFlexDisplayObject (default = null)> In simple cases where a class extends EventDispatcher,
		 *                            the document parameter should not be used.
		 */
		public function RadioButtonGroup(document:IFlexDisplayObject = null);
		/**
		 * Returns the RadioButton control at the specified index.
		 *
		 * @param index             <int> The index of the RadioButton control in the
		 *                            RadioButtonGroup control, where the index of the first control is 0.
		 * @return                  <RadioButton> The specified RadioButton control.
		 */
		public function getRadioButtonAt(index:int):RadioButton;
		/**
		 * Implementation of the IMXMLObject.initialized() method
		 *  to support deferred instantiation.
		 *
		 * @param document          <Object> The MXML document that created this object.
		 * @param id                <String> The identifier used by document to refer to this object.
		 *                            If the object is a deep property on document, id is null.
		 */
		public function initialized(document:Object, id:String):void;
	}
}
