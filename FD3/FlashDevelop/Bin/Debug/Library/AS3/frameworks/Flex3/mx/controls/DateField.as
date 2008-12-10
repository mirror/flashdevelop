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
	import flash.ui.Keyboard;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListData;
	import mx.core.ClassFactory;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.core.mx_internal;
	import mx.core.UIComponentGlobals;
	import mx.events.CalendarLayoutChangeEvent;
	import mx.events.DateChooserEvent;
	import mx.events.DropdownEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.InterManagerRequest;
	import mx.events.SandboxMouseEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when a date is selected or changed, *  and the DateChooser control closes. * *  @eventType mx.events.CalendarLayoutChangeEvent.CHANGE *  @helpid 3613
	 */
	[Event(name="change", type="mx.events.CalendarLayoutChangeEvent")] 
	/**
	 *  Dispatched when a date is selected or the user clicks *  outside the drop-down list. * *  @eventType mx.events.DropdownEvent.CLOSE *  @helpid 3615
	 */
	[Event(name="close", type="mx.events.DropdownEvent")] 
	/**
	 *  Dispatched when the <code>data</code> property changes. * *  <p>When you use a component as an item renderer, *  the <code>data</code> property contains the data to display. *  You can listen for this event and update the component *  when the <code>data</code> property changes.</p> *  *  @eventType mx.events.FlexEvent.DATA_CHANGE
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when a user selects the field to open the drop-down list. * *  @eventType mx.events.DropdownEvent.OPEN *  @helpid 3614
	 */
	[Event(name="open", type="mx.events.DropdownEvent")] 
	/**
	 *  Dispatched when the month changes due to user interaction. * *  @eventType mx.events.DateChooserEvent.SCROLL *  @helpid 3616
	 */
	[Event(name="scroll", type="mx.events.DateChooserEvent")] 
	/**
	 *  Color of the border. *  The following controls support this style: Button, CheckBox, *  ComboBox, MenuBar, *  NumericStepper, ProgressBar, RadioButton, ScrollBar, Slider, and any *  components that support the <code>borderStyle</code> style. *  The default value depends on the component class; *  if not overriden for the class, the default value is <code>0xB7BABC</code>.
	 */
	[Style(name="borderColor", type="uint", format="Color", inherit="no")] 
	/**
	 *  The bounding box thickness of the DateChooser control. *  The default value is 1.
	 */
	[Style(name="borderThickness", type="Number", format="Length", inherit="no")] 
	/**
	 *  Radius of component corners. *  The following components support this style: Alert, Button, ComboBox,   *  LinkButton, MenuBar, NumericStepper, Panel, ScrollBar, Tab, TitleWindow,  *  and any component *  that supports a <code>borderStyle</code> property set to <code>"solid"</code>. *  The default value depends on the component class; *  if not overriden for the class, the default value is <code>0</code>.
	 */
	[Style(name="cornerRadius", type="Number", format="Length", inherit="no", deprecatedReplacement="dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Name of the CSS Style declaration to use for the styles for the *  DateChooser control's drop-down list. *  By default, the DateChooser control uses the DateField control's *  inheritable styles.  *   *  <p>You can use this class selector to set the values of all the style properties  *  of the DateChooser class, including <code>cornerRadius</code>, *  <code>fillAlphas</code>, <code>fillColors</code>, <code>headerColors</code>, <code>headerStyleName</code>,  *  <code>highlightAlphas</code>, <code>todayStyleName</code>, and <code>weekdayStyleName</code>.</p>
	 */
	[Style(name="dateChooserStyleName", type="String", inherit="no")] 
	/**
	 *  Alphas used for the background fill of controls. Use [1, 1] to make the control background *  opaque. *   *  @default [ 0.6, 0.4 ]
	 */
	[Style(name="fillAlphas", type="Array", arrayType="Number", inherit="no", deprecatedReplacement="nextMonthStyleFilters, prevMonthStyleFilters, dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Colors used to tint the background of the control. *  Pass the same color for both values for a flat-looking control. *   *  @default [ 0xFFFFFF, 0xCCCCCC ]
	 */
	[Style(name="fillColors", type="Array", arrayType="uint", format="Color", inherit="no", deprecatedReplacement="nextMonthStyleFilters, prevMonthStyleFilters, dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Colors of the band at the top of the DateChooser control. *  The default value is <code>[ 0xE6EEEE, 0xFFFFFF ]</code>.
	 */
	[Style(name="headerColors", type="Array", arrayType="uint", format="Color", inherit="yes", deprecatedReplacement="dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Name of the style sheet definition to configure the text (month name and year) *  and appearance of the header area of the control.
	 */
	[Style(name="headerStyleName", type="String", inherit="no", deprecatedReplacement="dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Alpha transparencies used for the highlight fill of controls. *  The first value specifies the transparency of the top of the highlight and the second value specifies the transparency  *  of the bottom of the highlight. The highlight covers the top half of the skin. *   *  @default [ 0.3, 0.0 ]
	 */
	[Style(name="highlightAlphas", type="Array", arrayType="Number", inherit="no", deprecatedReplacement="dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Color of the highlight area of the date when the user holds the *  mouse pointer over a date in the DateChooser control. *  @default 0xE3FFD6
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Color of the highlight area of the currently selected date *  in the DateChooser control. *  @default 0xCDFFC1
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Name of the class to use as the default skin for the background and border.  *  For the DateField class, there is no default value.
	 */
	[Style(name="skin", type="Class", inherit="no", states=" up, over, down, disabled")] 
	/**
	 *  Color of the highlight of today's date in the DateChooser control. *  The default value is <code>0x2B333</code>.
	 */
	[Style(name="todayColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Name of the style sheet definition to configure the appearance of the current day's *  numeric text, which is highlighted *  in the control when the <code>showToday</code> property is <code>true</code>. *  Specify a <code>color</code> style property to change the font color. *  If omitted, the current day text inherits *  the text styles of the control.
	 */
	[Style(name="todayStyleName", type="String", inherit="no", deprecatedReplacement="dateChooserStyleName", deprecatedSince="3.0")] 
	/**
	 *  Name of the style sheet definition to configure the weekday names of *  the control. If omitted, the weekday names inherit the text *  styles of the control.
	 */
	[Style(name="weekDayStyleName", type="String", inherit="no", deprecatedReplacement="dateChooserStyleName", deprecatedSince="3.0")] 

	/**
	 *  The DateField control is a text field that shows the date *  with a calendar icon on its right side. *  When the user clicks anywhere inside the bounding box *  of the control, a DateChooser control pops up *  and shows the dates in the month of the current date. *  If no date is selected, the text field is blank *  and the month of the current date is displayed *  in the DateChooser control. * *  <p>When the DateChooser control is open, the user can scroll *  through months and years, and select a date. *  When a date is selected, the DateChooser control closes, *  and the text field shows the selected date.</p> * *  <p>The user can also type the date in the text field if the <code>editable</code> *  property of the DateField control is set to <code>true</code>.</p> * *  <p>The DateField has the same default characteristics (shown below) as the DateChooser for its expanded date chooser.</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>A size large enough to hold the calendar, and wide enough to display the day names</td> *        </tr> *        <tr> *           <td>Minimum size</td> *           <td>0 pixels</td> *        </tr> *        <tr> *           <td>Maximum size</td> *           <td>No limit</td> *        </tr> *     </table> **  <p>The DateField has the following default characteristics for the collapsed control:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>A size large enough to hold the formatted date and the calendar icon</td> *        </tr> *        <tr> *           <td>Minimum size</td> *           <td>0 pixels</td> *        </tr> *        <tr> *           <td>Maximum size</td> *           <td>No limit</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:DateField&gt</code> tag inherits all of the tag attributes *  of its superclass, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:DateField *    <strong>Properties</strong> *    dayNames="["S", "M", "T", "W", "T", "F", "S"]" *    disabledDays="<i>No default</i>" *    disabledRanges="<i>No default</i>" *    displayedMonth="<i>Current month</i>" *    displayedYear="<i>Current year</i>" *    dropdownFactory="<i>ClassFactory that creates an mx.controls.DateChooser</i>" *    firstDayOfWeek="0" *    formatString="MM/DD/YYYY" *    labelFunction="<i>Internal formatter</i>" *    maxYear="2100" *    minYear="1900" *    monthNames="["January", "February", "March", "April", "May", *    "June", "July", "August", "September", "October", "November", *    "December"]" *    monthSymbol="" *    parseFunction="<i>Internal parser</i>" *    selectableRange="<i>No default</i>" *    selectedDate="<i>No default</i>" *    showToday="true|false" *    yearNavigationEnabled="false|true" *    yearSymbol="" *   *   <strong>Styles</strong> *    borderColor="0xAAB3B3" *    color="0x0xB333C" *    dateChooserStyleName="dateFieldPopup" *    disabledColor="0xAAB3B3" *    disabledIconColor="0x999999" *    focusAlpha="0.5" *    focusRoundedCorners="tl tr bl br" *    fontAntiAliasType="advanced" *    fontFamily="Verdana" *    fontGridFitType="pixel" *    fontSharpness="0" *    fontSize="10" *    fontStyle="normal|italic" *    fontThickness="0" *    fontWeight="normal|bold" *    iconColor="0x111111" *    leading="2" *    paddingLeft="0" *    paddingRight="0" *    rollOverColor="0xE3FFD6" *    selectionColor="0xB7F39B" *    textAlign="left|right|center" *    textDecoration="none|underline" *    textIndent="0" *    todayColor="0x2B333C" *  *    <strong>Events</strong> *    change="<i>No default</i>" *    close="<i>No default</i>" *    dataChange="<i>No default</i>" *    open="<i>No default</i>" *    scroll="<i>No default</i>" *  /&gt; *  </pre>
	 */
	public class DateField extends ComboBase implements IDataRenderer
	{
		/**
		 *  @private     *  Placeholder for mixin by DateFieldAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
		 */
		private var creatingDropdown : Boolean;
		/**
		 *  @private
		 */
		local var showingDropdown : Boolean;
		/**
		 *  @private
		 */
		private var inKeyDown : Boolean;
		/**
		 *  @private
		 */
		private var isPressed : Boolean;
		/**
		 *  @private
		 */
		private var openPos : Number;
		/**
		 *  @private
		 */
		private var lastSelectedDate : Date;
		/**
		 *  @private
		 */
		private var updateDateFiller : Boolean;
		/**
		 *  @private
		 */
		private var addedToPopupManager : Boolean;
		/**
		 *  @private
		 */
		private var isMouseOver : Boolean;
		/**
		 *  @private
		 */
		private var yearChangedWithKeys : Boolean;
		/**
		 *  @private     *  Flag that will block default data/listData behavior
		 */
		private var selectedDateSet : Boolean;
		/**
		 *  @private     *  Storage for the enabled property.
		 */
		private var _enabled : Boolean;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  @private     *  Storage for the data property
		 */
		private var _data : Object;
		/**
		 *  @private     *  Storage for the dayNames property.
		 */
		private var _dayNames : Array;
		/**
		 *  @private
		 */
		private var dayNamesChanged : Boolean;
		/**
		 *  @private
		 */
		private var dayNamesOverride : Array;
		/**
		 *  @private     *  Storage for the disabledDays property.
		 */
		private var _disabledDays : Array;
		/**
		 *  @private
		 */
		private var disabledDaysChanged : Boolean;
		/**
		 *  @private     *  Storage for the disabledRanges property.
		 */
		private var _disabledRanges : Array;
		/**
		 *  @private
		 */
		private var disabledRangesChanged : Boolean;
		/**
		 *  @private     *  Storage for the displayedMonth property.
		 */
		private var _displayedMonth : int;
		/**
		 *  @private
		 */
		private var displayedMonthChanged : Boolean;
		/**
		 *  @private     *  Storage for the displayedYear property.
		 */
		private var _displayedYear : int;
		/**
		 *  @private
		 */
		private var displayedYearChanged : Boolean;
		/**
		 *  @private     *  Storage for the dropdown property.
		 */
		private var _dropdown : DateChooser;
		/**
		 *  @private     *  Storage for the dropdownFactory property.
		 */
		private var _dropdownFactory : IFactory;
		/**
		 *  @private     *  Storage for the firstDayOfWeek property.
		 */
		private var _firstDayOfWeek : Object;
		/**
		 *  @private
		 */
		private var firstDayOfWeekChanged : Boolean;
		/**
		 *  @private
		 */
		private var firstDayOfWeekOverride : Object;
		/**
		 *  @private     *  Storage for the formatString property.
		 */
		private var _formatString : String;
		/**
		 *  @private
		 */
		private var formatStringOverride : String;
		/**
		 *  @private     *  Storage for the labelFunction property.
		 */
		private var _labelFunction : Function;
		/**
		 *  @private     *  Storage for the listData property
		 */
		private var _listData : BaseListData;
		/**
		 *  @private     *  Storage for the maxYear property.
		 */
		private var _maxYear : int;
		/**
		 *  @private
		 */
		private var maxYearChanged : Boolean;
		/**
		 *  @private     *  Storage for the minYear property.
		 */
		private var _minYear : int;
		/**
		 *  @private
		 */
		private var minYearChanged : Boolean;
		/**
		 *  @private     *  Storage for the monthNames property.
		 */
		private var _monthNames : Array;
		/**
		 *  @private
		 */
		private var monthNamesChanged : Boolean;
		/**
		 *  @private
		 */
		private var monthNamesOverride : Array;
		/**
		 *  @private     *  Storage for the monthSymbol property.
		 */
		private var _monthSymbol : String;
		/**
		 *  @private
		 */
		private var monthSymbolChanged : Boolean;
		/**
		 *  @private
		 */
		private var monthSymbolOverride : String;
		/**
		 *  @private     *  Storage for the parseFunction property.
		 */
		private var _parseFunction : Function;
		/**
		 *  @private     *  Storage for the selectableRange property.
		 */
		private var _selectableRange : Object;
		/**
		 *  @private
		 */
		private var selectableRangeChanged : Boolean;
		/**
		 *  @private     *  Storage for the selectedDate property.
		 */
		private var _selectedDate : Date;
		/**
		 *  @private
		 */
		private var selectedDateChanged : Boolean;
		/**
		 *  @private     *  Storage for the showToday property.
		 */
		private var _showToday : Boolean;
		/**
		 *  @private
		 */
		private var showTodayChanged : Boolean;
		/**
		 *  @private     *  Storage for the yearNavigationEnabled property.
		 */
		private var _yearNavigationEnabled : Boolean;
		/**
		 *  @private
		 */
		private var yearNavigationEnabledChanged : Boolean;
		/**
		 *  @private     *  Storage for the yearSymbol property.
		 */
		private var _yearSymbol : String;
		/**
		 *  @private
		 */
		private var yearSymbolChanged : Boolean;
		/**
		 *  @private
		 */
		private var yearSymbolOverride : String;

		/**
		 *  @private
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  The <code>data</code> property lets you pass a value     *  to the component when you use it in an item renderer or item editor.     *  You typically use data binding to bind a field of the <code>data</code>     *  property to a property of this component.     *     *  <p>When you use the control as a drop-in item renderer or drop-in     *  item editor, Flex automatically writes the current value of the item     *  to the <code>selectedDate</code> property of this control.</p>     *     *  @default null     *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  Weekday names for DateChooser control.     *  Setting this property changes the day labels     *  of the DateChooser control.     *  Sunday is the first day (at index 0).     *  The rest of the week names follow in the normal order.     *       *  @default [ "S", "M", "T", "W", "T", "F", "S" ]     *  @helpid 3626
		 */
		public function get dayNames () : Array;
		/**
		 *  @private
		 */
		public function set dayNames (value:Array) : void;
		/**
		 *  Days to disable in a week.     *  All the dates in a month, for the specified day, are disabled.     *  This property immediately changes the user interface     *  of the DateChooser control.     *  The elements of this Array can have values from 0 (Sunday)     *  to 6 (Saturday).     *  For example, a value of <code>[0, 6]</code> disables     *  Sunday and Saturday.     *     *  @default []     *  @helpid 3627
		 */
		public function get disabledDays () : Array;
		/**
		 *  @private
		 */
		public function set disabledDays (value:Array) : void;
		/**
		 *  Disables single and multiple days.     *     *  <p>This property accepts an Array of objects as a parameter.     *  Each object in this Array is a Date object that specifies a     *  single day to disable; or an object containing one or both     *  of the <code>rangeStart</code> and <code>rangeEnd</code> properties,     *  each of whose values is a Date object.     *  The value of these properties describes the boundaries     *  of the date range.     *  If either is omitted, the range is considered     *  unbounded in that direction.     *  If you specify only <code>rangeStart</code>,     *  all the dates after the specified date are disabled,     *  including the <code>rangeStart</code> date.     *  If you specify only <code>rangeEnd</code>,     *  all the dates before the specified date are disabled,     *  including the <code>rangeEnd</code> date.     *  To disable a single day, use a single Date object that specifies a date     *  in the Array. Time values are zeroed out from the Date object if     *  they are present.</p>     *     *  <p>The following example, disables the following dates: January 11     *  2006, the range January 23 - February 10 2006, and March 1 2006     *  and all following dates.</p>     *     *  <pre>disabledRanges="{[new Date(2006,0,11), {rangeStart:     *  new Date(2006,0,23), rangeEnd: new Date(2006,1,10)},     *  {rangeStart: new Date(2006,2,1)}]}"</pre>     *     *  <p>Setting this property immediately changes the appearance of the     *  DateChooser control, if the disabled dates are included in the     *  <code>displayedMonth</code> and <code>displayedYear</code>     *  properties.</p>     *     *  @default []     *  @helpid 3629
		 */
		public function get disabledRanges () : Array;
		/**
		 *  @private
		 */
		public function set disabledRanges (value:Array) : void;
		/**
		 *  Used with the <code>displayedYear</code> property,     *  the <code>displayedMonth</code> property     *  specifies the month displayed in the DateChooser control.     *  Month numbers are zero-based, so January is 0 and December is 11.     *  Setting this property immediately changes the appearance     *  of the DateChooser control.     *  The default value is the month number of today's date.     *     *  <p>The default value is the current month.</p>     *     *  @helpid 3624
		 */
		public function get displayedMonth () : int;
		/**
		 *  @private
		 */
		public function set displayedMonth (value:int) : void;
		/**
		 *  Used with the <code>displayedMonth</code> property,     *  the <code>displayedYear</code> property determines     *  which year is displayed in the DateChooser control.     *  Setting this property immediately changes the appearance     *  of the DateChooser control.     *       *  <p>The default value is the current year.</p>     *     *  @helpid 3625
		 */
		public function get displayedYear () : int;
		/**
		 *  @private
		 */
		public function set displayedYear (value:int) : void;
		/**
		 *  Contains a reference to the DateChooser control     *  contained by the DateField control.  The class used      *  can be set with <code>dropdownFactory</code> as long as      *  it extends <code>DateChooser</code>.
		 */
		public function get dropdown () : DateChooser;
		/**
		 *  The IFactory that creates a DateChooser-derived instance to use     *  as the date-chooser     *  The default value is an IFactory for DateChooser     *
		 */
		public function get dropdownFactory () : IFactory;
		/**
		 *  @private
		 */
		public function set dropdownFactory (value:IFactory) : void;
		/**
		 *  Day of the week (0-6, where 0 is the first element     *  of the dayNames Array) to display in the first column     *  of the  DateChooser control.     *  Setting this property changes the order of the day columns.     *     *  @default 0 (Sunday)     *  @helpid 3623
		 */
		public function get firstDayOfWeek () : Object;
		/**
		 *  @private
		 */
		public function set firstDayOfWeek (value:Object) : void;
		/**
		 *  The format of the displayed date in the text field.     *  This property can contain any combination of <code>"MM"</code>,      *  <code>"DD"</code>, <code>"YY"</code>, <code>"YYYY"</code>,     *  delimiter, and punctuation characters.     *      *  @default "MM/DD/YYYY"
		 */
		public function get formatString () : String;
		/**
		 *  @private
		 */
		public function set formatString (value:String) : void;
		/**
		 *  Function used to format the date displayed     *  in the text field of the DateField control.     *  If no function is specified, the default format is used.     *       *  <p>The function takes a Date object as an argument,     *  and returns a String in the format to be displayed,      *  as the following example shows:</p>     *  <pre>     *  public function formatDate(currentDate:Date):String {     *      ...     *      return dateString;     *  }</pre>     *     *  <p>If you allow the user to enter a date in the text field     *  of the DateField control, and you define a formatting function using      *  the <code>labelFunction</code> property, you should specify a      *  function to the <code>parseFunction</code> property that converts      *  the input text string to a Date object for use by the DateField control,      *  or set the <code>parseFunction</code> property to null.</p>     *     *  @default null     *  @see mx.controls.DateField#parseFunction     *  @helpid 3618
		 */
		public function get labelFunction () : Function;
		/**
		 *  @private
		 */
		public function set labelFunction (value:Function) : void;
		/**
		 *  When a component is used as a drop-in item renderer or drop-in     *  item editor, Flex initializes the <code>listData</code> property     *  of the component with the appropriate data from the List control.     *  The component can then use the <code>listData</code> property     *  to initialize the <code>data</code> property of the drop-in     *  item renderer or drop-in item editor.     *     *  <p>You do not set this property in MXML or ActionScript;     *  Flex sets it when the component is used as a drop-in item renderer     *  or drop-in item editor.</p>     *     *  @default null     *  @see mx.controls.listClasses.IDropInListItemRenderer
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;
		/**
		 *  The last year selectable in the control.     *  @default 2100     *     *  @helpid
		 */
		public function get maxYear () : int;
		/**
		 *  @private
		 */
		public function set maxYear (value:int) : void;
		/**
		 *  The first year selectable in the control.     *  @default 1900     *     *  @helpid
		 */
		public function get minYear () : int;
		/**
		 *  @private
		 */
		public function set minYear (value:int) : void;
		/**
		 *  Names of the months displayed at the top of the control.     *  The <code>monthSymbol</code> property is appended to the end of      *  the value specified by the <code>monthNames</code> property,      *  which is useful in languages such as Japanese.     *     *  @default [ "January", "February", "March", "April", "May", "June",      *  "July", "August", "September", "October", "November", "December" ]
		 */
		public function get monthNames () : Array;
		/**
		 *  @private
		 */
		public function set monthNames (value:Array) : void;
		/**
		 *  This property is appended to the end of the value specified      *  by the <code>monthNames</code> property to define the names      *  of the months displayed at the top of the control.     *  Some languages, such as Japanese, use an extra      *  symbol after the month name.      *     *  @default ""
		 */
		public function get monthSymbol () : String;
		/**
		 *  @private
		 */
		public function set monthSymbol (value:String) : void;
		/**
		 *  Function used to parse the date entered as text     *  in the text field area of the DateField control and return a      *  Date object to the control.     *  If no function is specified, Flex uses     *  the default function.     *  If you set the <code>parseFunction</code> property, it should      *  typically perform the reverse of the function specified to      *  the <code>labelFunction</code> property.     *       *  <p>The function takes two arguments      *  and returns a Date object to the DateField control,      *  as the following example shows:</p>     *  <pre>     *  public function parseDate(valueString:String, inputFormat:String):Date {     *      ...     *      return newDate     *  }</pre>     *      *  <p>Where the <code>valueString</code> argument contains the text      *  string entered by the user in the text field, and the <code>inputFormat</code>      *  argument contains the format of the string. For example, if you      *  only allow the user to enter a text sting using two characters for      *  month, day, and year, then pass "MM/DD/YY" to      *  the <code>inputFormat</code> argument. </p>     *     *  @see mx.controls.DateField#labelFunction     *      *  @helpid
		 */
		public function get parseFunction () : Function;
		/**
		 *  @private
		 */
		public function set parseFunction (value:Function) : void;
		/**
		 *  Range of dates between which dates are selectable.     *  For example, a date between 04-12-2006 and 04-12-2007     *  is selectable, but dates out of this range are disabled.     *     *  <p>This property accepts an Object as a parameter.     *  The Object contains two properties, <code>rangeStart</code>     *  and <code>rangeEnd</code>, of type Date.     *  If you specify only <code>rangeStart</code>,     *  all the dates after the specified date are enabled.     *  If you only specify <code>rangeEnd</code>,     *  all the dates before the specified date are enabled.     *  To enable only a single day in a DateChooser control,     *  you can pass a Date object directly. Time values are      *  zeroed out from the Date object if they are present.</p>     *     *  <p>The following example enables only the range     *  January 1, 2006 through June 30, 2006. Months before January     *  and after June do not appear in the DateChooser.</p>     *     *  <pre>selectableRange="{{rangeStart : new Date(2006,0,1),     *  rangeEnd : new Date(2006,5,30)}}"</pre>     *     *  @default null     *  @helpid 3628
		 */
		public function get selectableRange () : Object;
		/**
		 *  @private
		 */
		public function set selectableRange (value:Object) : void;
		/**
		 *  Date as selected in the DateChooser control.     *  Accepts a Date object as a parameter. If the incoming Date      *  object has any time values, they are zeroed out.     *     *  <p>Selecting the currently selected date in the control deselects it,      *  sets the <code>selectedDate</code> property to <code>null</code>,      *  and then dispatches the <code>change</code> event.</p>     *     *  @default null     *  @helpid 3630
		 */
		public function get selectedDate () : Date;
		/**
		 *  @private
		 */
		public function set selectedDate (value:Date) : void;
		/**
		 *  If <code>true</code>, specifies that today is highlighted     *  in the DateChooser control.     *  Setting this property immediately changes the appearance     *  of the DateChooser control.     *     *  @default true     *  @helpid 3622
		 */
		public function get showToday () : Boolean;
		/**
		 *  @private
		 */
		public function set showToday (value:Boolean) : void;
		/**
		 *  Enables year navigation. When <code>true</code>     *  an up and down button appear to the right     *  of the displayed year. You can use these buttons     *  to change the current year.     *  These button appear to the left of the year in locales where year comes      *  before the month in the date format.     *     *  @default false
		 */
		public function get yearNavigationEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set yearNavigationEnabled (value:Boolean) : void;
		/**
		 *  This property is appended to the end of the year      *  displayed at the top of the control.     *  Some languages, such as Japanese,      *  add a symbol after the year.      *     *  @default ""
		 */
		public function get yearSymbol () : String;
		/**
		 *  @private
		 */
		public function set yearSymbol (value:String) : void;

		/**
		 *  Parses a String object that contains a date, and returns a Date     *  object corresponding to the String.     *  The <code>inputFormat</code> argument contains the pattern     *  in which the <code>valueString</code> String is formatted.     *  It can contain <code>"M"</code>,<code>"D"</code>,<code>"Y"</code>,     *  and delimiter and punctuation characters.     *     *  <p>The function does not check for the validity of the Date object.     *  If the value of the date, month, or year is NaN, this method returns null.</p>     *      *  <p>For example:     *  <pre>var dob:Date = DateField.stringToDate("06/30/2005", "MM/DD/YYYY");</pre>             *  </p>     *     *  @param valueString Date value to format.     *     *  @param inputFormat String defining the date format.     *     *  @return The formatted date as a Date object.     *
		 */
		public static function stringToDate (valueString:String, inputFormat:String) : Date;
		/**
		 *  Formats a Date into a String according to the <code>outputFormat</code> argument.     *  The <code>outputFormat</code> argument contains a pattern in which     *  the <code>value</code> String is formatted.     *  It can contain <code>"M"</code>,<code>"D"</code>,<code>"Y"</code>,     *  and delimiter and punctuation characters.     *     *  @param value Date value to format.     *     *  @param outputFormat String defining the date format.     *     *  @return The formatted date as a String.     *     *  @example <pre>var todaysDate:String = DateField.dateToString(new Date(), "MM/DD/YYYY");</pre>
		 */
		public static function dateToString (value:Date, outputFormat:String) : String;
		/**
		 *  Constructor.
		 */
		public function DateField ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private     *  Create subobjects in the component.
		 */
		protected function createChildren () : void;
		/**
		 *  @private
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
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		/**
		 *  @private
		 */
		public function regenerateStyleCache (recursive:Boolean) : void;
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Opens the DateChooser control.     *     *  @helpid 3620
		 */
		public function open () : void;
		/**
		 *  Closes the DateChooser control.     *     *  @helpid 3621
		 */
		public function close () : void;
		/**
		 *  @private
		 */
		private function displayDropdown (show:Boolean, triggerEvent:Event = null) : void;
		/**
		 *  @private
		 */
		private function createDropdown () : void;
		/**
		 *  @private     *  This is the default date format that is displayed     *  if labelFunction is not defined.
		 */
		private function dateFiller (value:Date) : void;
		/**
		 *  @private     *  This method scrubs out time values from incoming date objects
		 */
		private function scrubTimeValue (value:Object) : Object;
		/**
		 *  @private     *  This method scrubs out time values from incoming date objects
		 */
		private function scrubTimeValues (values:Array) : Array;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function downArrowButton_buttonDownHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		protected function textInput_changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function removedFromStageHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dropdown_changeHandler (event:CalendarLayoutChangeEvent) : void;
		/**
		 *  @private
		 */
		private function dropdown_scrollHandler (event:DateChooserEvent) : void;
		/**
		 *  @private
		 */
		private function dropdown_mouseDownOutsideHandler (event:Event) : void;
		/**
		 *  @private     *  Handling change in selectedDate due to user interaction.
		 */
		private function selectedDate_changeHandler (triggerEvent:Event) : void;
		/**
		 *  @private
		 */
		private function textInput_textInputHandler (event:TextEvent) : void;
		/**
		 *  @private
		 */
		function isShowingDropdown () : Boolean;
	}
}
