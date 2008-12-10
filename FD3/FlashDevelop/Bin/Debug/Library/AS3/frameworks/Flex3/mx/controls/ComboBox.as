package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListBase;
	import mx.controls.listClasses.ListData;
	import mx.core.ClassFactory;
	import mx.core.FlexVersion;
	import mx.core.EdgeMetrics;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.Tween;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.DropdownEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.InterManagerRequest;
	import mx.events.ListEvent;
	import mx.events.SandboxMouseEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when the ComboBox contents changes as a result of user *  interaction, when the <code>selectedIndex</code> or *  <code>selectedItem</code> property changes, and, if the ComboBox control *  is editable, each time a keystroke is entered in the box. * *  @eventType mx.events.ListEvent.CHANGE
	 */
	[Event(name="change", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when the drop-down list is dismissed for any reason such when  *  the user: *  <ul> *      <li>selects an item in the drop-down list</li> *      <li>clicks outside of the drop-down list</li> *      <li>clicks the drop-down button while the drop-down list is  *  displayed</li> *      <li>presses the ESC key while the drop-down list is displayed</li> *  </ul> * *  @eventType mx.events.DropdownEvent.CLOSE
	 */
	[Event(name="close", type="mx.events.DropdownEvent")] 
	/**
	 *  Dispatched when the <code>data</code> property changes. * *  <p>When you use a component as an item renderer, *  the <code>data</code> property contains an item from the *  dataProvider. *  You can listen for this event and update the component *  when the <code>data</code> property changes.</p> *  *  @eventType mx.events.FlexEvent.DATA_CHANGE
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched if the <code>editable</code> property *  is set to <code>true</code> and the user presses the Enter key *  while typing in the editable text field. * *  @eventType mx.events.FlexEvent.ENTER
	 */
	[Event(name="enter", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when user rolls the mouse out of a drop-down list item. *  The event object's <code>target</code> property contains a reference *  to the ComboBox and not the drop-down list. * *  @eventType mx.events.ListEvent.ITEM_ROLL_OUT
	 */
	[Event(name="itemRollOut", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when the user rolls the mouse over a drop-down list item. *  The event object's <code>target</code> property contains a reference *  to the ComboBox and not the drop-down list. * *  @eventType mx.events.ListEvent.ITEM_ROLL_OVER
	 */
	[Event(name="itemRollOver", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when the user clicks the drop-down button *  to display the drop-down list.  It is also dispatched if the user *  uses the keyboard and types Ctrl-Down to open the drop-down. * *  @eventType mx.events.DropdownEvent.OPEN
	 */
	[Event(name="open", type="mx.events.DropdownEvent")] 
	/**
	 *  Dispatched when the user scrolls the ComboBox control's drop-down list. * *  @eventType mx.events.ScrollEvent.SCROLL
	 */
	[Event(name="scroll", type="mx.events.ScrollEvent")] 
	/**
	 *  The set of BackgroundColors for drop-down list rows in an alternating *  pattern. *  Value can be an Array of two of more colors. *  If <code>undefined</code> then the rows will use the drop-down list's  *  backgroundColor style. * *  @default undefined
	 */
	[Style(name="alternatingItemColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 
	/**
	 *  Width of the arrow button in pixels. *  @default 22
	 */
	[Style(name="arrowButtonWidth", type="Number", format="Length", inherit="no")] 
	/**
	 *  The thickness of the border of the drop-down list, in pixels.  *  This value is overridden if you define  *  <code>borderThickness</code> when setting the  *  <code>dropdownStyleName</code> CSSStyleDeclaration.  * *  @default 1
	 */
	[Style(name="borderThickness", type="Number", format="Length", inherit="no")] 
	/**
	 *  The length of the transition when the drop-down list closes, in milliseconds. *  The default transition has the drop-down slide up into the ComboBox. * *  @default 250
	 */
	[Style(name="closeDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  An easing function to control the close transition.  Easing functions can *  be used to control the acceleration and deceleration of the transition. * *  @default undefined
	 */
	[Style(name="closeEasingFunction", type="Function", inherit="no")] 
	/**
	 *  The color of the border of the ComboBox.  If <code>undefined</code> *  the drop-down list will use its normal borderColor style.  This style *  is used by the validators to show the ComboBox in an error state. *  *  @default undefined
	 */
	[Style(name="dropdownBorderColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The name of a CSSStyleDeclaration to be used by the drop-down list.  This *  allows you to control the appearance of the drop-down list or its item *  renderers. *  * [deprecated] * *  @default "comboDropDown"
	 */
	[Style(name="dropDownStyleName", type="String", inherit="no", deprecatedReplacement="dropdownStyleName")] 
	/**
	 *  The name of a CSSStyleDeclaration to be used by the drop-down list.  This *  allows you to control the appearance of the drop-down list or its item *  renderers. * *  @default "comboDropdown"
	 */
	[Style(name="dropdownStyleName", type="String", inherit="no")] 
	/**
	 *  Length of the transition when the drop-down list opens, in milliseconds. *  The default transition has the drop-down slide down from the ComboBox. * *  @default 250
	 */
	[Style(name="openDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  An easing function to control the open transition.  Easing functions can *  be used to control the acceleration and deceleration of the transition. * *  @default undefined
	 */
	[Style(name="openEasingFunction", type="Function", inherit="no")] 
	/**
	 *  Number of pixels between the control's bottom border *  and the bottom of its content area. *  When the <code>editable</code> property is <code>true</code>,  *  <code>paddingTop</code> and <code>paddingBottom</code> affect the size  *  of the ComboBox control, but do not affect the position of the editable text field. *   *  @default 0
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the control's top border *  and the top of its content area. *  When the <code>editable</code> property is <code>true</code>,  *  <code>paddingTop</code> and <code>paddingBottom</code> affect the size  *  of the ComboBox control, but do not affect the position of the editable text field. *   *  @default 0
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 
	/**
	 *  The rollOverColor of the drop-down list. *  @see mx.controls.List
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The selectionColor of the drop-down list. *  @see mx.controls.List
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The selectionDuration of the drop-down list. *  *  @default 250 *  *  @see mx.controls.List
	 */
	[Style(name="selectionDuration", type="uint", format="Time", inherit="no")] 
	/**
	 *  The selectionEasingFunction of the drop-down list. *  *  @default undefined *  *  @see mx.controls.List
	 */
	[Style(name="selectionEasingFunction", type="Function", inherit="no")] 
	/**
	 *  The textRollOverColor of the drop-down list. *  *  @default #2B333C *   *  @see mx.controls.List
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The textSelectedColor of the drop-down list. *  *  @default #2B333C *  @see mx.controls.List
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The ComboBox control contains a drop-down list *  from which the user can select a single value. *  Its functionality is very similar to that of the *  SELECT form element in HTML. *  The ComboBox can be editable, in which case *  the user can type entries into the TextInput portion *  of the ComboBox that are not in the list. * *  <p>The ComboBox control has the following default sizing  *     characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>Wide enough to accommodate the longest entry in the  *               drop-down list in the display area of the main *               control, plus the drop-down button. When the  *               drop-down list is not visible, the default height  *               is based on the label text size.  * *               <p>The default drop-down list height is five rows, or  *               the number of entries in the drop-down list, whichever  *               is smaller. The default height of each entry in the  *               drop-down list is 22 pixels.</p></td> *        </tr> *        <tr> *           <td>Minimum size</td> *           <td>0 pixels.</td> *        </tr> *        <tr> *           <td>Maximum size</td> *           <td>5000 by 5000.</td> *        </tr> *        <tr> *           <td>dropdownWidth</td> *           <td>The width of the ComboBox control.</td> *        </tr> *        <tr> *           <td>rowCount</td> *           <td>5 rows.</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:ComboBox&gt;</code> tag inherits all the tag attributes *  of its superclass, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:ComboBox *    <b>Properties</b> *    dataProvider="null" *    dropdownFactory="<i>ClassFactory that creates an mx.controls.List</i>" *    dropdownWidth="<i>100 or width of the longest text in the dataProvider</i>" *    itemRenderer="null" *    labelField="label" *    labelFunction="null" *    prompt="null" *    rowCount="5" *    selectedIndex="-1" *    selectedItem="null" *     *    <b>Styles</b> *    alternatingItemColors="undefined" *    arrowButtonWidth="22" *    borderColor="0xB7BABC" *    borderThickness="1" *    closeDuration="250" *    closeEasingFunction="undefined" *    color="0x0B333C" *    cornerRadius="0" *    disabledColor="0xAAB3B3" *    disabledIconColor="0x919999" *    dropdownBorderColor="undefined" *    dropdownStyleName="comboDropdown" *    fillAlphas="[0.6,0.4]" *    fillColors="[0xFFFFFF, 0xCCCCCC]" *    focusAlpha="0.4" *    focusRoundedCorners="tl tr bl br" *    fontAntiAliasType="advanced|normal" *    fontFamily="Verdana" *    fontGridFitType="pixel|none|subpixel" *    fontSharpness="0" *    fontSize="10" *    fontStyle="normal|italic" *    fontThickness="0" *    fontWeight="normal|bold" *    highlightAlphas="[0.3,0.0]" *    iconColor="0x111111" *    leading="0" *    openDuration="250" *    openEasingFunction="undefined" *    paddingTop="0" *    paddingBottom="0" *    paddingLeft="5" *    paddingRight="5" *    rollOverColor="<i>Depends on theme color"</i> *    selectionColor="<i>Depends on theme color"</i> *    selectionDuration="250" *    selectionEasingFunction="undefined" *    textAlign="left|center|right" *    textDecoration="none|underline" *    textIndent="0" *    textRollOverColor="0x2B333C" *    textSelectedColor="0x2B333C" *     *    <b>Events</b> *    change="<i>No default</i>" *    close="<i>No default</i>" *    dataChange="<i>No default</i>" *    enter="<i>No default</i>" *    itemRollOut="<i>No default</i>" *    itemRollOver="<i>No default</i>" *    open="<i>No default</i>" *    scroll="<i>No default</i>" *  /&gt; *  </pre> * *  @includeExample examples/SimpleComboBox.mxml * *  @see mx.controls.List *  @see mx.effects.Tween *  @see mx.managers.PopUpManager *
	 */
	public class ComboBox extends ComboBase implements IDataRenderer
	{
		/**
		 *  @private     *  Placeholder for mixin by ComboBoxAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private     *  A reference to the internal List that pops up to display a row     *  for each dataProvider item.
		 */
		private var _dropdown : ListBase;
		/**
		 *  @private     *  A int to track the oldIndex, used when the dropdown is dismissed using the ESC key.
		 */
		private var _oldIndex : int;
		/**
		 *  @private     *  The tween used for showing and hiding the drop-down list.
		 */
		private var tween : Tween;
		/**
		 *  @private     *  A flag to track whether the dropDown tweened up or down.
		 */
		private var tweenUp : Boolean;
		/**
		 *  @private
		 */
		private var preferredDropdownWidth : Number;
		/**
		 *  @private
		 */
		private var dropdownBorderStyle : String;
		/**
		 *  @private     *  Is the dropdown list currently shown?
		 */
		private var _showingDropdown : Boolean;
		/**
		 *  @private
		 */
		private var _selectedIndexOnDropdown : int;
		/**
		 *  @private
		 */
		private var bRemoveDropdown : Boolean;
		/**
		 *  @private
		 */
		private var inTween : Boolean;
		/**
		 *  @private
		 */
		private var bInKeyDown : Boolean;
		/**
		 *  @private     *  Flag that will block default data/listData behavior
		 */
		private var selectedItemSet : Boolean;
		/**
		 *  @private     *  Event that is causing the dropDown to open or close.
		 */
		private var triggerEvent : Event;
		/**
		 *  @private     *  Whether the text property was explicitly set or not
		 */
		private var explicitText : Boolean;
		/**
		 *  @private     *  Storage for the data property.
		 */
		private var _data : Object;
		/**
		 *  @private     *  Storage for the listData property.
		 */
		private var _listData : BaseListData;
		/**
		 *  @private
		 */
		private var collectionChanged : Boolean;
		/**
		 *  @private     *  Storage for itemRenderer property.
		 */
		private var _itemRenderer : IFactory;
		/**
		 *  @private     *  Storage for the dropdownFactory property.
		 */
		private var _dropdownFactory : IFactory;
		/**
		 *  @private     *  Storage for the dropdownWidth property.
		 */
		private var _dropdownWidth : Number;
		/**
		 *  @private     *  Storage for the labelField property.
		 */
		private var _labelField : String;
		/**
		 *  @private
		 */
		private var labelFieldChanged : Boolean;
		/**
		 *  @private     *  Storage for the labelFunction property.
		 */
		private var _labelFunction : Function;
		/**
		 *  @private
		 */
		private var labelFunctionChanged : Boolean;
		private var promptChanged : Boolean;
		/**
		 *  @private     *  Storage for the prompt property.
		 */
		private var _prompt : String;
		/**
		 *  @private     *  Storage for the rowCount property.
		 */
		private var _rowCount : int;
		private var implicitSelectedIndex : Boolean;

		/**
		 *  The <code>data</code> property lets you pass a value     *  to the component when you use it in an item renderer or item editor.     *  You typically use data binding to bind a field of the <code>data</code>     *  property to a property of this component.     *     *  <p>The ComboBox control uses the <code>listData</code> property and the     *  <code>data</code> property as follows. If the ComboBox is in a      *  DataGrid control, it expects the <code>dataField</code> property of the      *  column to map to a property in the data and sets      *  <code>selectedItem</code> to that property. If the ComboBox control is      *  in a List control, it expects the <code>labelField</code> of the list      *  to map to a property in the data and sets <code>selectedItem</code> to      *  that property.      *  Otherwise, it sets <code>selectedItem</code> to the data itself.</p>     *     *  <p>You do not set this property in MXML.</p>     *     *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  When a component is used as a drop-in item renderer or drop-in item      *  editor, Flex initializes the <code>listData</code> property of the      *  component with the appropriate data from the List control. The      *  component can then use the <code>listData</code> property and the      *  <code>data</code> property to display the appropriate information      *  as a drop-in item renderer or drop-in item editor.     *     *  <p>You do not set this property in MXML or ActionScript; Flex sets it      *  when the component     *  is used as a drop-in item renderer or drop-in item editor.</p>     *     *  @see mx.controls.listClasses.IDropInListItemRenderer
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;
		/**
		 *  @inheritDoc
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  IFactory that generates the instances that displays the data for the     *  drop-down list of the control.  You can use this property to specify      *  a custom item renderer for the drop-down list.     *     *  <p>The control uses a List control internally to create the drop-down     *  list.     *  The default item renderer for the List control is the ListItemRenderer     *  class, which draws the text associated with each item in the list,      *  and an optional icon. </p>     *     *  @see mx.controls.List     *  @see mx.controls.listClasses.ListItemRenderer
		 */
		public function get itemRenderer () : IFactory;
		/**
		 *  @private
		 */
		public function set itemRenderer (value:IFactory) : void;
		/**
		 *  Index of the selected item in the drop-down list.     *  Setting this property sets the current index and displays     *  the associated label in the TextInput portion.     *  <p>The default value is -1, but it set to 0     *  when a <code>dataProvider</code> is assigned, unless there is a prompt.     *  If the control is editable, and the user types in the TextInput portion,     *  the value of the <code>selectedIndex</code> property becomes      *  -1. If the value of the <code>selectedIndex</code>      *  property is out of range, the <code>selectedIndex</code> property is set to the last     *  item in the <code>dataProvider</code>.</p>
		 */
		public function set selectedIndex (value:int) : void;
		/**
		 *  Contains a reference to the selected item in the     *  <code>dataProvider</code>.     *  If the data is an object or class instance, modifying     *  properties in the object or instance modifies the <code>dataProvider</code>     *  and thus its views.  Setting the selectedItem itself causes the     *  ComboBox to select that item (display it in the TextInput portion and set     *  the selectedIndex) if it exists in the dataProvider.     *  <p>If the ComboBox control is editable, the <code>selectedItem</code>     *  property is <code>null</code> if the user types any text     *  into the TextInput.     *  It has a value only if the user selects an item from the drop-down     *  list, or if it is set programmatically.</p>
		 */
		public function set selectedItem (value:Object) : void;
		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;
		/**
		 *  A reference to the List control that acts as the drop-down in the ComboBox.
		 */
		public function get dropdown () : ListBase;
		/**
		 *  The IFactory that creates a ListBase-derived instance to use     *  as the drop-down.     *  The default value is an IFactory for List     *
		 */
		public function get dropdownFactory () : IFactory;
		/**
		 *  @private
		 */
		public function set dropdownFactory (value:IFactory) : void;
		/**
		 *  The set of styles to pass from the ComboBox to the dropDown.     *  Styles in the dropDownStyleName style will override these styles.     *  @see mx.styles.StyleProxy     *  @review
		 */
		protected function get dropDownStyleFilters () : Object;
		/**
		 *  Width of the drop-down list, in pixels.     *  <p>The default value is 100 or the width of the longest text     *  in the <code>dataProvider</code>, whichever is greater.</p>     *
		 */
		public function get dropdownWidth () : Number;
		/**
		 *  @private
		 */
		public function set dropdownWidth (value:Number) : void;
		/**
		 *  Name of the field in the items in the <code>dataProvider</code>     *  Array to display as the label in the TextInput portion and drop-down list.     *  By default, the control uses a property named <code>label</code>     *  on each Array object and displays it.     *  <p>However, if the <code>dataProvider</code> items do not contain     *  a <code>label</code> property, you can set the <code>labelField</code>     *  property to use a different property.</p>     *
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;
		/**
		 *  User-supplied function to run on each item to determine its label.     *  By default the control uses a property named <code>label</code>     *  on each <code>dataProvider</code> item to determine its label.     *  However, some data sets do not have a <code>label</code> property,     *  or do not have another property that can be used for displaying     *  as a label.     *  <p>An example is a data set that has <code>lastName</code> and     *  <code>firstName</code> fields but you want to display full names.     *  You use <code>labelFunction</code> to specify a callback function     *  that uses the appropriate fields and return a displayable String.</p>     *     *  <p>The labelFunction takes a single argument which is the item     *  in the dataProvider and returns a String:</p>     *  <pre>     *  myLabelFunction(item:Object):String     *  </pre>     *
		 */
		public function get labelFunction () : Function;
		/**
		 *  @private
		 */
		public function set labelFunction (value:Function) : void;
		/**
		 *  The prompt for the ComboBox control. A prompt is     *  a String that is displayed in the TextInput portion of the     *  ComboBox when <code>selectedIndex</code> = -1.  It is usually     *  a String like "Select one...".  If there is no     *  prompt, the ComboBox control sets <code>selectedIndex</code> to 0     *  and displays the first item in the <code>dataProvider</code>.
		 */
		public function get prompt () : String;
		/**
		 *  @private
		 */
		public function set prompt (value:String) : void;
		/**
		 *  Maximum number of rows visible in the ComboBox control list.     *  If there are fewer items in the     *  dataProvider, the ComboBox shows only as many items as     *  there are in the dataProvider.     *       *  @default 5
		 */
		public function get rowCount () : int;
		/**
		 *  @private
		 */
		public function set rowCount (value:int) : void;
		/**
		 *  The String displayed in the TextInput portion of the ComboBox. It     *  is calculated from the data by using the <code>labelField</code>      *  or <code>labelFunction</code>.
		 */
		public function get selectedLabel () : String;
		/**
		 *  @private
		 */
		function get isShowingDropdown () : Boolean;

		/**
		 *  Constructor.
		 */
		public function ComboBox ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  Makes sure the control is at least 40 pixels wide,     *  and tall enough to fit one line of text     *  in the TextInput portion of the control but at least     *  22 pixels high.
		 */
		protected function measure () : void;
		/**
		 *  @private     *  Make sure the drop-down width is the same as the rest of the ComboBox
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  Returns a string representing the <code>item</code> parameter.     *       *  <p>This method checks in the following order to find a value to return:</p>     *       *  <ol>     *    <li>If you have specified a <code>labelFunction</code> property,     *  returns the result of passing the item to the function.</li>     *    <li>If the item is a String, Number, Boolean, or Function, returns     *  the item.</li>     *    <li>If the item has a property with the name specified by the control's     *  <code>labelField</code> property, returns the contents of the property.</li>     *    <li>If the item has a label property, returns its value.</li>     *  </ol>     *      *  @param item The object that contains the value to convert to a label. If the item is null, this method returns the empty string.
		 */
		public function itemToLabel (item:Object) : String;
		/**
		 *  Displays the drop-down list.
		 */
		public function open () : void;
		/**
		 *  Hides the drop-down list.
		 */
		public function close (trigger:Event = null) : void;
		/**
		 *  @private
		 */
		function hasDropdown () : Boolean;
		/**
		 *  @private
		 */
		private function getDropdown () : ListBase;
		/**
		 *  @private
		 */
		private function displayDropdown (show:Boolean, trigger:Event = null) : void;
		/**
		 *  @private
		 */
		private function dispatchChangeEvent (oldEvent:Event, prevValue:int, newValue:int) : void;
		/**
		 *  @private
		 */
		private function destroyDropdown () : void;
		/**
		 *  @private
		 */
		protected function collectionChangeHandler (event:Event) : void;
		private function popup_moveHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function textInput_changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function downArrowButton_buttonDownHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function dropdown_mouseOutsideHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dropdown_itemClickHandler (event:ListEvent) : void;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		private function stage_resizeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dropdown_scrollHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dropdown_itemRollOverHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dropdown_itemRollOutHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dropdown_changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private     *  This acts as the destructor.
		 */
		private function unloadHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function removedFromStageHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function onTweenUpdate (value:Number) : void;
		/**
		 *  @private
		 */
		function onTweenEnd (value:Number) : void;
		/**
		 *  Determines default values of the height and width to use for each      *  entry in the drop-down list, based on the maximum size of the label      *  text in the first <code>numItems</code> items in the data provider.      *     *  @param count The number of items to check to determine the value.     *       *  @return An Object containing two properties: width and height.
		 */
		protected function calculatePreferredSizeFromData (count:int) : Object;
	}
}
