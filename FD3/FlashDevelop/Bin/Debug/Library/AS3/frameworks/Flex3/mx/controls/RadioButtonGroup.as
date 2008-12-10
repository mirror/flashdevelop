package mx.controls
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.core.IMXMLObject;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;

	/**
	 *  Dispatched when the value of the selected RadioButton control in  *  this group changes. * *  @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")] 
	/**
	 *  Dispatched when a user selects a RadioButton control in the group. *  You can also set a handler for individual RadioButton controls. * *  @eventType mx.events.ItemClickEvent.ITEM_CLICK
	 */
	[Event(name="itemClick", type="mx.events.ItemClickEvent")] 

	/**
	 *  The RadioButtonGroup control defines a group of RadioButton controls *  that act as a single mutually exclusive control; therefore,  *  a user can select only one RadioButton control at a time. *  The <code>id</code> property is required when you use the *  <code>&lt;mx:RadioButtonGroup&gt;</code> tag to define the name *  of the group. *  *  <p>Notice that the RadioButtonGroup control is a subclass of EventDispatcher, not UIComponent,  *  and implements the IMXMLObject interface.  *  All other Flex visual components are subclasses of UIComponent, which implements  *  the IUIComponent interface.  *  The RadioButtonGroup control has support built into the Flex compiler  *  that allows you to use the RadioButtonGroup control as a child of a Flex container,  *  event though it does not implement IUIComponent.  *  All other container children must implement the IUIComponent interface.</p> * *  <p>Therefore, if you try to define a visual component as a subclass of  *  EventDispatcher that implements the IMXMLObject interface,  *  you will not be able to use it as the child of a container.</p> *   *  @mxml *   *  <p>The <code>&lt;mx:RadioButtonGroup&gt;</code> tag inherits all of the *  tag attributes of its superclass, and adds the following tag attributes:</p> *   *  <pre> *  &lt;mx:RadioButtonGroup *    <strong>Properties</strong> *    enabled="true|false"       *    id="<i>No default</i>" *    labelPlacement="right|left|top|bottom" *   *    <strong>Events</strong> *    change="<i>No default</i>" *    itemClick="<i>No default</i>" *  /&gt; *  </pre> *   *  @includeExample examples/RadioButtonGroupExample.mxml *   *  @see mx.controls.RadioButton
	 */
	public class RadioButtonGroup extends EventDispatcher implements IMXMLObject
	{
		/**
		 *  @private     *  The document containing a reference to this RadioButtonGroup.
		 */
		private var document : IFlexDisplayObject;
		/**
		 *  @private     *  An Array of the RadioButtons that belong to this group.
		 */
		private var radioButtons : Array;
		/**
		 *  @private     *  Index for the next RadioButton added to this group.
		 */
		private var indexNumber : int;
		/**
		 *  @private     *  Storage for the labelPlacement property.
		 */
		private var _labelPlacement : String;
		/**
		 *  @private     *  Storage for the selectedValue property.
		 */
		private var _selectedValue : Object;
		/**
		 *  @private     *  Reference to the selected radio button.
		 */
		private var _selection : RadioButton;

		/**
		 *  Determines whether selection is allowed.     *       *  @default true
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  Position of the RadioButton label relative to the RadioButton icon     *  for each control in the group.     *  You can override this setting for the individual controls.     *     *  <p>Valid values in MXML are <code>"right"</code>, <code>"left"</code>,      *  <code>"bottom"</code>, and <code>"top"</code>. </p>     *     *  <p>In ActionScript, you use the following constants to set this property:     *  <code>ButtonLabelPlacement.RIGHT</code>, <code>ButtonLabelPlacement.LEFT</code>,     *  <code>ButtonLabelPlacement.BOTTOM</code>, and <code>ButtonLabelPlacement.TOP</code>.</p>     *     *  @default "right"
		 */
		public function get labelPlacement () : String;
		/**
		 *  @private
		 */
		public function set labelPlacement (value:String) : void;
		/**
		 *  The number of RadioButtons that belong to this RadioButtonGroup.     *      *  @default "undefined"
		 */
		public function get numRadioButtons () : int;
		/**
		 *  The value of the <code>value</code> property of the selected     *  RadioButton control in the group, if this has been set     *  to be something other than <code>null</code> (the default value).     *  Otherwise, <code>selectedValue</code> is the value of the     *  <code>label</code> property of the selected RadioButton.     *  If no RadioButton is selected, this property is <code>null</code>.     *     *  <p>If you set <code>selectedValue</code>, Flex selects the     *  RadioButton control whose <code>value</code> or     *  <code>label</code> property matches this value.</p>     *     *  @default null
		 */
		public function get selectedValue () : Object;
		/**
		 *  @private.
		 */
		public function set selectedValue (value:Object) : void;
		/**
		 *  Contains a reference to the currently selected     *  RadioButton control in the group.      *  You can access the property in ActionScript only;     *  it is not settable in MXML.      *  Setting this property to <code>null</code> deselects the currently selected RadioButton control.      *     *  @default null
		 */
		public function get selection () : RadioButton;
		/**
		 *  @private
		 */
		public function set selection (value:RadioButton) : void;

		/**
		 *  Constructor.     *     *  @param document In simple cases where a class extends EventDispatcher,      *  the <code>document</code> parameter should not be used.     *     *  @see flash.events.EventDispatcher
		 */
		public function RadioButtonGroup (document:IFlexDisplayObject = null);
		/**
		 *  Implementation of the <code>IMXMLObject.initialized()</code> method      *  to support deferred instantiation.     *     *  @param document The MXML document that created this object.     *     *  @param id The identifier used by document to refer to this object.      *  If the object is a deep property on document, <code>id</code> is null.     *      *  @see mx.core.IMXMLObject
		 */
		public function initialized (document:Object, id:String) : void;
		/**
		 *  Returns the RadioButton control at the specified index.     *     *  @param index The index of the RadioButton control in the      *  RadioButtonGroup control, where the index of the first control is 0.     *     *  @return The specified RadioButton control.
		 */
		public function getRadioButtonAt (index:int) : RadioButton;
		/**
		 *  @private     *  Add a radio button to the group.
		 */
		function addInstance (instance:RadioButton) : void;
		/**
		 *  @private     *  Remove a radio button from the group.
		 */
		function removeInstance (instance:RadioButton) : void;
		/**
		 *  @private     *  Return the value or the label value     *  of the selected radio button.
		 */
		private function getValue () : String;
		/**
		 *  @private
		 */
		function setSelection (value:RadioButton, fireChange:Boolean = true) : void;
		/**
		 *  @private
		 */
		private function changeSelection (index:int, fireChange:Boolean = true) : void;
		/**
		 *  @private
		 */
		private function radioButton_removedHandler (event:Event) : void;
	}
}
