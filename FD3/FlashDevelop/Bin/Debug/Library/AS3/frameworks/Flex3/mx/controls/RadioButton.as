package mx.controls
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.core.FlexVersion;
	import mx.events.ItemClickEvent;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerGroup;

	/**
	 *  The RadioButton control lets the user make a single choice *  within a set of mutually exclusive choices. *  A RadioButton group is composed of two or more RadioButton controls *  with the same <code>groupName</code> property. *  The RadioButton group can refer to a group created by the *  <code>&lt;mx:RadioButtonGroup&gt;</code> tag. *  The user selects only one member of the group at a time. *  Selecting an unselected group member deselects the currently selected *  RadioButton control within that group. * *  <p>The RadioButton control has the following default characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>Wide enough to display the text label of the control</td> *        </tr> *        <tr> *           <td>Minimum size</td> *           <td>0 pixels</td> *        </tr> *        <tr> *           <td>Maximum size</td> *           <td>Undefined</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:RadioButton&gt;</code> tag inherits all of the tag *  attributes of its superclass, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:RadioButton *    <strong>Properties</strong> *    groupName="" *    labelPlacement="right|left|top|bottom" *   *    <strong>Styles</strong> *    disabledIconColor="0x999999" *    iconColor="0x2B333C" *  /&gt; *  </pre> * *  @includeExample examples/RadioButtonExample.mxml * *  @see mx.controls.RadioButtonGroup
	 */
	public class RadioButton extends Button implements IFocusManagerGroup
	{
		/**
		 *  @private     *  Placeholder for mixin by RadioButtonAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private     *  Default inital index value
		 */
		local var indexNumber : int;
		/**
		 *  @private     *  Storage for the group property.
		 */
		private var _group : RadioButtonGroup;
		/**
		 *  @private     *  Storage for groupName property.
		 */
		local var _groupName : String;
		/**
		 *  @private
		 */
		private var groupChanged : Boolean;
		/**
		 *  @private     *  Storage for value property.
		 */
		private var _value : Object;

		/**
		 *  @private     *  A RadioButton doesn't have an emphasized state, so _emphasized     *  is set false in the constructor and can't be changed via this setter.
		 */
		public function get emphasized () : Boolean;
		/**
		 *  Position of the label relative to the RadioButton icon.     *  Valid values in MXML are <code>"right"</code>, <code>"left"</code>,     *  <code>"bottom"</code>, and <code>"top"</code>.     *     *  <p>In ActionScript, you use the following constants     *  to set this property:     *  <code>ButtonLabelPlacement.RIGHT</code>,     *  <code>ButtonLabelPlacement.LEFT</code>,     *  <code>ButtonLabelPlacement.BOTTOM</code>, and     *  <code>ButtonLabelPlacement.TOP</code>.</p>     *     *  @default ButtonLabelPlacement.RIGHT
		 */
		public function get labelPlacement () : String;
		/**
		 *  @private     *  A RadioButton is always toggleable by definition, so toggle is set     *  true in the constructor and can't be changed for a RadioButton.
		 */
		public function get toggle () : Boolean;
		/**
		 *  @private
		 */
		public function set toggle (value:Boolean) : void;
		/**
		 *  The RadioButtonGroup object to which this RadioButton belongs.     *     *  @default "undefined"
		 */
		public function get group () : RadioButtonGroup;
		/**
		 *  @private
		 */
		public function set group (value:RadioButtonGroup) : void;
		/**
		 *  Specifies the name of the group to which this RadioButton control belongs, or      *  specifies the value of the <code>id</code> property of a RadioButtonGroup control     *  if this RadioButton is part of a group defined by a RadioButtonGroup control.     *     *  @default "undefined"
		 */
		public function get groupName () : String;
		/**
		 *  @private
		 */
		public function set groupName (value:String) : void;
		/**
		 *  Optional user-defined value     *  that is associated with a RadioButton control.     *      *  @default null
		 */
		public function get value () : Object;
		/**
		 *  @private
		 */
		public function set value (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function RadioButton ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private     *  Update properties before measurement/layout.
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
		 *  @private     *  Create radio button group if it does not exist     *  and add the instance to the group.
		 */
		private function addToGroup () : Object;
		/**
		 *  @private
		 */
		function deleteGroup () : void;
		/**
		 *  @private     *  Set next radio button in the group.
		 */
		private function setPrev (moveSelection:Boolean = true) : void;
		/**
		 *  @private     *  Set the previous radio button in the group.
		 */
		private function setNext (moveSelection:Boolean = true) : void;
		/**
		 *  @private
		 */
		private function setThis () : void;
		/**
		 *  @private     *  Support the use of keyboard within the group.
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private     *  Support the use of keyboard within the group.
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;
		/**
		 *  @private     *  When we are added, make sure we are part of our group.
		 */
		private function addHandler (event:FlexEvent) : void;
		/**
		 *  @private     *  Set radio button to selected and dispatch that there has been a change.
		 */
		protected function clickHandler (event:MouseEvent) : void;
	}
}
