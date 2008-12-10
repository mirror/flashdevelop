package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.collections.ListCollectionView;
	import mx.collections.XMLListCollection;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.IIMESupport;
	import mx.core.IRectangularBorder;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleProxy;
	import mx.utils.UIDUtil;

	/**
	 *  Name of the class to use as the default skin for the background and border.  *  For the ComboBase class, there is no default value. *  For the ComboBox class, the default value is the ComboBoxArrowSkin class.
	 */
	[Style(name="skin", type="Class", inherit="no", states=" up, over, down, disabled,  editableUp, editableOver, editableDown, editableDisabled")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when the mouse is not over the control. *  For the ComboBase class, there is no default value. *  For the ComboBox class, the default value is the ComboBoxArrowSkin class.
	 */
	[Style(name="upSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when the mouse is over the control. *  For the ComboBase class, there is no default value. *  For the ComboBox class, the default value is the ComboBoxArrowSkin class. *  For the ColorPicker class, the default value is the ColorPickerSkin class. *  For the DateField class, the default value is the ScrollArrowDownSkin class.
	 */
	[Style(name="overSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when the user holds down the mouse button. *  For the ComboBase class, there is no default value. *  For the ComboBox class, the default value is the ComboBoxArrowSkin class. *  For the ColorPicker class, the default value is the ColorPickerSkin class. *  For the DateField class, the default value is the ScrollArrowDownSkin class.
	 */
	[Style(name="downSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when the control is disabled. *  For the ComboBase class, there is no default value. *  For the ComboBox class, the default value is the ComboBoxArrowSkin class. *  For the ColorPicker class, the default value is the ColorPickerSkin class. *  For the DateField class, the default value is the ScrollArrowDownSkin class.
	 */
	[Style(name="disabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when the mouse is not over the control, and the <code>editable</code> *  property is <code>true</code>. This skin is only used by the ComboBox class. *  For the ComboBase class, there is no default value. *  For the ComboBox class, the default value is the ComboBoxArrowSkin class.
	 */
	[Style(name="editableUpSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when the mouse is over the control, and the <code>editable</code> *  property is <code>true</code>. This skin is only used by the ComboBox class. *  For the ComboBase class, there is no default value. *  For the ComboBox class, the default value is the ComboBoxArrowSkin class.
	 */
	[Style(name="editableOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when the user holds down the mouse button, and the <code>editable</code> *  property is <code>true</code>. This skin is only used by the ComboBox class. *  For the ComboBase class, there is no default value. *  For the ComboBox class, the default value is the ComboBoxArrowSkin class.
	 */
	[Style(name="editableDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border *  when the control is disabled, and the <code>editable</code> *  property is <code>true</code>. This skin is only used by the ComboBox class. *  For the ComboBase class, there is no default value. *  For the ComboBox class, the default value is the ComboBoxArrowSkin class.
	 */
	[Style(name="editableDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  The style declaration for the internal TextInput subcomponent  *  that displays the current selection.  *  If no value is specified, then the TextInput subcomponent uses  *  the default text styles defined by the ComboBase class. * *  @default ""
	 */
	[Style(name="textInputStyleName", type="String", inherit="no")] 

	/**
	 *  The ComboBase class is the base class for controls that display text in a  *  text field and have a button that causes a drop-down list to appear where  *  the user can choose which text to display. *  The ComboBase class is not used directly as an MXML tag. * *  @mxml * *  <p>The <code>&lt;mx:ComboBase&gt;</code> tag inherits all the tag attributes *  of its superclass, and adds the following tag attributes:</p> * *  <pre> *  &lt;<i>mx:tagname</i> *    <b>Properties</b> *    dataProvider="null" *    editable="false|true" *    imeMode="null" *    restrict="null" *    selectedIndex="-1" *    selectedItem="null" *    text="" *    &nbsp; *    <b>Styles</b> *    disabledSkin="<i>Depends on class</i>" *    downSkin="<i>Depends on class</i>" *    editableDisabledSkin="<i>Depends on class</i>" *    editableDownSkin="<i>Depends on class</i>" *    editableOverSkin="<i>Depends on class</i>" *    editableUpSkin="<i>Depends on class</i>" *    overSkin="<i>Depends on class</i>" *    textInputStyleName=""  *    upSkin="<i>Depends on class</i>" * *  /&gt; *  </pre> * *  @see mx.controls.Button *  @see mx.controls.TextInput *  @see mx.collections.ICollectionView
	 */
	public class ComboBase extends UIComponent implements IIMESupport
	{
		/**
		 *  @private     *  Placeholder for mixin by ComboBaseAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  The ICollectionView of items this component displays.
		 */
		protected var collection : ICollectionView;
		/**
		 *  The main IViewCursor used to fetch items from the     *  dataProvider and pass the items to the renderers.     *  At the end of any sequence of code, it must always be positioned     *  at the topmost visible item on screen.
		 */
		protected var iterator : IViewCursor;
		/**
		 *  @private     *  A separate IViewCursor used to find indices of items and other things.     *  The collectionIterator can be at any place within the set of items.
		 */
		local var collectionIterator : IViewCursor;
		/**
		 *  @private     *  The internal object that draws the border.
		 */
		local var border : IFlexDisplayObject;
		/**
		 *  @private     *  The internal Button property that causes the drop-down list to appear.
		 */
		local var downArrowButton : Button;
		/**
		 *  @private
		 */
		local var wrapDownArrowButton : Boolean;
		/**
		 *  @private
		 */
		local var useFullDropdownSkin : Boolean;
		/**
		 *  @private
		 */
		private var selectedUID : String;
		/**
		 *  @private     *  A flag indicating that selection has changed
		 */
		local var selectionChanged : Boolean;
		/**
		 *  @private     *  A flag indicating that selectedIndex has changed
		 */
		local var selectedIndexChanged : Boolean;
		/**
		 *  @private     *  A flag indicating that selectedItem has changed
		 */
		local var selectedItemChanged : Boolean;
		/**
		 *  @private     *  Stores the old value of the borderStyle style
		 */
		local var oldBorderStyle : String;
		/**
		 *  @private     *  Storage for enabled property.
		 */
		private var _enabled : Boolean;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  @private     *  Storage for editable property.
		 */
		private var _editable : Boolean;
		/**
		 *  @private
		 */
		local var editableChanged : Boolean;
		/**
		 *  @private
		 */
		private var _imeMode : String;
		/**
		 *  @private     *  Storage for restrict property.
		 */
		private var _restrict : String;
		private var _selectedIndex : int;
		/**
		 *  @private     *  Storage for the selectedItem property.
		 */
		private var _selectedItem : Object;
		/**
		 *  @private     *  Storage for the text property.
		 */
		private var _text : String;
		/**
		 *  @private
		 */
		local var textChanged : Boolean;
		/**
		 *  The internal TextInput subcomponent that displays     *  the current selection.
		 */
		protected var textInput : TextInput;
		private static var _textInputStyleFilters : Object;

		/**
		 *  @private     *  The baselinePosition of a ComboBase is calculated for its TextInput.
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  Set of styles to pass from the ComboBase to the down arrow button     *  @see mx.styles.StyleProxy
		 */
		protected function get arrowButtonStyleFilters () : Object;
		/**
		 *  Returns an EdgeMetrics object that has four properties:     *  <code>left</code>, <code>top</code>, <code>right</code>,     *  and <code>bottom</code>.     *  The value of each property is equal to the thickness of the     *  corresponding side of the border, expressed in pixels.     *     *  @return EdgeMetrics object with the left, right, top,     *  and bottom properties.
		 */
		protected function get borderMetrics () : EdgeMetrics;
		/**
		 *  The set of items this component displays. This property is of type     *  Object because the derived classes can handle a variety of data     *  types such as Arrays, XML, ICollectionViews, and other classes.  All     *  are converted into an ICollectionView and that ICollectionView is     *  returned if you get the value of this property; you will not get the     *  value you set if it was not an ICollectionView.     *     *  <p>Setting this property will adjust the <code>selectedIndex</code>     *  property (and therefore the <code>selectedItem</code> property) if      *  the <code>selectedIndex</code> property has not otherwise been set.      *  If there is no <code>prompt</code> property, the <code>selectedIndex</code>     *  property will be set to 0; otherwise it will remain at -1,     *  the index used for the prompt string.       *  If the <code>selectedIndex</code> property has been set and     *  it is out of range of the new data provider, unexpected behavior is     *  likely to occur.</p>     *
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  A flag that indicates whether the control is editable,      *  which lets the user directly type entries that are not specified      *  in the dataProvider, or not editable, which requires the user select     *  from the items in the dataProvider.     *     *  <p>If <code>true</code> keyboard input will be entered in the     *  editable text field; otherwise it will be used as shortcuts to     *  select items in the dataProvider.</p>     *     *  @default false.     *  This property is ignored by the DateField control.     *
		 */
		public function get editable () : Boolean;
		/**
		 *  @private
		 */
		public function set editable (value:Boolean) : void;
		/**
		 *  @copy mx.controls.TextInput#imeMode     *      *  @default null
		 */
		public function get imeMode () : String;
		/**
		 *  @private
		 */
		public function set imeMode (value:String) : void;
		/**
		 *  Set of characters that a user can or cannot enter into the text field.     *      *  @default null     *     *  @see flash.text.TextField#restrict     *
		 */
		public function get restrict () : String;
		/**
		 *  @private
		 */
		public function set restrict (value:String) : void;
		/**
		 *  The index in the data provider of the selected item.     *  If there is a <code>prompt</code> property, the <code>selectedIndex</code>     *  value can be set to -1 to show the prompt.     *  If there is no <code>prompt</code>, property then <code>selectedIndex</code>     *  will be set to 0 once a <code>dataProvider</code> is set.     *     *  <p>If the ComboBox control is editable, the <code>selectedIndex</code>     *  property is -1 if the user types any text     *  into the text field.</p>     *     *  <p>Unlike many other Flex properties that are invalidating (setting     *  them does not have an immediate effect), the <code>selectedIndex</code> and     *  <code>selectedItem</code> properties are synchronous; setting one immediately      *  affects the other.</p>     *     *  @default -1
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;
		/**
		 *  The item in the data provider at the selectedIndex.     *     *  <p>If the data is an object or class instance, modifying     *  properties in the object or instance modifies the      *  <code>dataProvider</code> object but may not update the views       *  unless the instance is Bindable or implements IPropertyChangeNotifier     *  or a call to dataProvider.itemUpdated() occurs.</p>     *     *  Setting the <code>selectedItem</code> property causes the     *  ComboBox control to select that item (display it in the text field and     *  set the <code>selectedIndex</code>) if it exists in the data provider.     *  If the ComboBox control is editable, the <code>selectedItem</code>     *  property is <code>null</code> if the user types any text     *  into the text field.     *     *  <p>Unlike many other Flex properties that are invalidating (setting     *  them does not have an immediate effect), <code>selectedIndex</code> and     *  <code>selectedItem</code> are synchronous; setting one immediately      *  affects the other.</p>     *     *  @default null;
		 */
		public function get selectedItem () : Object;
		/**
		 *  @private
		 */
		public function set selectedItem (data:Object) : void;
		/**
		 *  Contents of the text field.  If the control is non-editable     *  setting this property has no effect. If the control is editable,      *  setting this property sets the contents of the text field.     *     *  @default ""
		 */
		public function get text () : String;
		/**
		 *  @private
		 */
		public function set text (value:String) : void;
		/**
		 *  The set of styles to pass from the ComboBase to the text input.      *  These styles are ignored if you set      *  the <code>textInputStyleName</code> style property.     *  @see mx.styles.StyleProxy
		 */
		protected function get textInputStyleFilters () : Object;
		/**
		 *  The value of the selected item. If the item is a Number or String,     *  the value is the item. If the item is an object, the value is     *  the <code>data</code> property, if it exists, or the <code>label</code>     *  property, if it exists.     *     *  <p><strong>Note:</strong> Using the <code>selectedItem</code> property      *  is often preferable to using this property. The <code>value</code>     *  property exists for backward compatibility with older applications.</p>     *
		 */
		public function get value () : Object;
		/**
		 *  @private
		 */
		function get ComboDownArrowButton () : Button;

		/**
		 *  Constructor.
		 */
		public function ComboBase ();
		/**
		 *  @private
		 */
		private function setSelectedItem (data:Object, clearFirst:Boolean = true) : void;
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  Determines the <code>measuredWidth</code> and     *  <code>measuredHeight</code> properties of the control.     *  The measured width is the width of the widest text     *  in the <code>dataProvider</code>     *  plus the width of the drop-down button.     *  The measured height is the larger of either the button or the text.     *  If no data provider has been set or there are no items     *  in the data provider, the <code>measuredWidth</code> property is set to     *  <code>UIComponent.DEFAULT_MEASURED_WIDTH</code> and the      *  <code>measuredHeight</code> property is set     *  to <code>UIComponent.DEFAULT_MEASURED_HEIGHT</code>.     *      *  @see mx.core.UIComponent#measure()
		 */
		protected function measure () : void;
		/**
		 *  Sizes and positions the internal components in the given width     *  and height.  The drop-down button is placed all the way to the right     *  and the text field fills the remaining area.     *      *  @param unscaledWidth Specifies the width of the component, in pixels,     *  in the component's coordinates, regardless of the value of the     *  <code>scaleX</code> property of the component.     *     *  @param unscaledHeight Specifies the height of the component, in pixels,     *  in the component's coordinates, regardless of the value of the     *  <code>scaleY</code> property of the component.     *      *  @see mx.core.UIComponent#updateDisplayList()
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function setFocus () : void;
		/**
		 *  @private
		 */
		protected function isOurFocus (target:DisplayObject) : Boolean;
		/**
		 *  Determines default values of the height and width to use for the      *  entries in the drop-down list.      *  Each subclass of ComboBase must implement this method and return      *  an Object containing two properties: <code>width</code> and      *  <code>height</code>.     *     *  @param numItems The number of items to check to determine the size.     *     *  @return An Object with <code>width</code> and <code>height</code>      *  properties.
		 */
		protected function calculatePreferredSizeFromData (numItems:int) : Object;
		/**
		 *  Determines the UID for a dataProvider item.     *  Every dataProvider item must have or will be assigned a unique     *  identifier (UID).     *     *  @param data A dataProvider item.     *     *  @return A unique identifier.
		 */
		protected function itemToUID (data:Object) : String;
		/**
		 *  @private
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  Responds to changes to the data provider.  The component will adjust     *  the <code>selectedIndex</code> property if items are added or removed      *  before the component's selected item.     *     *  @param event The CollectionEvent dispatched from the collection.     *     *  @see mx.events.CollectionEvent
		 */
		protected function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private     *  Forward an event to the down arrow button.
		 */
		private function textInput_mouseEventHandler (event:Event) : void;
		/**
		 *  Handles changes to the TextInput that serves as the editable     *  text field in the component.  The method sets      *  <code>selectedIndex</code> to -1 (and therefore      *  <code>selectedItem</code> to <code>null</code>).     *      *  @param event The event that is triggered each time the text in the control changes.
		 */
		protected function textInput_changeHandler (event:Event) : void;
		/**
		 *  @private     *  valueCommit handler for the textInput
		 */
		private function textInput_valueCommitHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function textInput_enterHandler (event:FlexEvent) : void;
		/**
		 *  Performs some action when the drop-down button is pressed.  This is     *  an abstract base class implementation, so it has no effect and is     *  overridden by the subclasses.     *      *  @param event The event that is triggered when the drop-down button is pressed.
		 */
		protected function downArrowButton_buttonDownHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		function getTextInput () : TextInput;
	}
}
