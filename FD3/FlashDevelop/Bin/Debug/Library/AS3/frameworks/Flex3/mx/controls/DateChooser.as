package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import mx.core.FlexSprite;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.FlexVersion;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.CalendarLayoutChangeEvent;
	import mx.events.DateChooserEvent;
	import mx.events.DateChooserEventDetail;
	import mx.events.FlexEvent;
	import mx.graphics.RectangularDropShadow;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.ResourceBundle;
	import mx.styles.StyleManager;
	import mx.utils.GraphicsUtil;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when a date is selected or changed. * *  @eventType mx.events.CalendarLayoutChangeEvent.CHANGE *  @helpid 3601 *  @tiptext change event
	 */
	[Event(name="change", type="mx.events.CalendarLayoutChangeEvent")] 
	/**
	 *  Dispatched when the month changes due to user interaction. * *  @eventType mx.events.DateChooserEvent.SCROLL *  @helpid 3600 *  @tiptext scroll event
	 */
	[Event(name="scroll", type="mx.events.DateChooserEvent")] 
	/**
	 *  Alpha level of the color defined by the <code>backgroundColor</code> *  property. *  Valid values range from 0.0 to 1.0. *  @default 1.0
	 */
	[Style(name="backgroundAlpha", type="Number", inherit="no")] 
	/**
	 *  Background color of the DateChooser control. *   *  @default 0xFFFFF
	 */
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no")] 
	/**
	 *  Color of the border. *  The following controls support this style: Button, CheckBox, *  ComboBox, MenuBar, *  NumericStepper, ProgressBar, RadioButton, ScrollBar, Slider, and any *  components that support the <code>borderStyle</code> style. *  The default value depends on the component class; *  if not overriden for the class, the default value is <code>0xB7BABC</code>.
	 */
	[Style(name="borderColor", type="uint", format="Color", inherit="no")] 
	/**
	 *  Bounding box thickness. *  Only used when <code>borderStyle</code> is set to <code>"solid"</code>. *  @default 1
	 */
	[Style(name="borderThickness", type="Number", format="Length", inherit="no")] 
	/**
	 *  Radius of component corners. *  The following components support this style: Alert, Button, ComboBox,   *  LinkButton, MenuBar, NumericStepper, Panel, ScrollBar, Tab, TitleWindow,  *  and any component *  that supports a <code>borderStyle</code> property set to <code>"solid"</code>. *  The default value depends on the component class; *  if not overriden for the class, the default value is <code>0</code>.
	 */
	[Style(name="cornerRadius", type="Number", format="Length", inherit="no")] 
	/**
	 *  Alphas used for the background fill of controls. Use [1, 1] to make the control background *  opaque. *   *  @default [ 0.6, 0.4 ]
	 */
	[Style(name="fillAlphas", type="Array", arrayType="Number", inherit="no", deprecatedReplacement="nextMonthStyleFilters, prevMonthStyleFilters", deprecatedSince="3.0")] 
	/**
	 *  Colors used to tint the background of the control. *  Pass the same color for both values for a flat-looking control. *   *  @default [ 0xFFFFFF, 0xCCCCCC ]
	 */
	[Style(name="fillColors", type="Array", arrayType="uint", format="Color", inherit="no", deprecatedReplacement="nextMonthStyleFilters, prevMonthStyleFilters", deprecatedSince="3.0")] 
	/**
	 *  Colors of the band at the top of the DateChooser control. *  The default value is <code>[ 0xE1E5EB, 0xF4F5F7 ]</code>.
	 */
	[Style(name="headerColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 
	/**
	 *  Name of the style sheet definition to configure the text (month name and year) *  and appearance of the header area of the control.
	 */
	[Style(name="headerStyleName", type="String", inherit="no")] 
	/**
	 *  Alpha transparencies used for the highlight fill of controls. *  The first value specifies the transparency of the top of the highlight and the second value specifies the transparency  *  of the bottom of the highlight. The highlight covers the top half of the skin. *   *  @default [ 0.3, 0.0 ]
	 */
	[Style(name="highlightAlphas", type="Array", arrayType="Number", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the next month arrow. *  The default value is the DateChooserMonthArrowSkin class.
	 */
	[Style(name="nextMonthSkin", type="Class", inherit="no", states="up, over, down, disabled")] 
	/**
	 *  Name of the class to use as the skin for the next month arrow *  when the arrow is disabled. *  The default value is the DateChooserMonthArrowSkin class.
	 */
	[Style(name="nextMonthDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the next month arrow *  when the user presses the mouse button down on the arrow. *  The default value is the DateChooserMonthArrowSkin class.
	 */
	[Style(name="nextMonthDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the next month arrow *  when the user moves the mouse pointer over the arrow. *  The default value is the DateChooserMonthArrowSkin class.
	 */
	[Style(name="nextMonthOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the next month arrow *  when the mouse pointer is not over the arrow. *  The default value is the DateChooserMonthArrowSkin class.
	 */
	[Style(name="nextMonthUpSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the next year arrow. *  The default value is the DateChooserYearArrowSkin class.
	 */
	[Style(name="nextYearSkin", type="Class", inherit="no", states="up, over, down, disabled")] 
	/**
	 *  Name of the class to use as the skin for the next year arrow *  when the arrow is disabled.  *  The default value is the DateChooserYearArrowSkin class.
	 */
	[Style(name="nextYearDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the next Year arrow *  when the user presses the mouse button down on the arrow. *  The default value is the DateChooserYearArrowSkin class.
	 */
	[Style(name="nextYearDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the next Year arrow *  when the user moves the mouse pointer over the arrow. *  The default value is the DateChooserYearArrowSkin class.
	 */
	[Style(name="nextYearOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the next Year arrow *  when the mouse pointer is not over the arrow. *  The default value is the DateChooserYearArrowSkin class.
	 */
	[Style(name="nextYearUpSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the previous month arrow. *  The default value is the DateChooserMonthArrowSkin class.
	 */
	[Style(name="prevMonthSkin", type="Class", inherit="no", states="up, over, down, disabled")] 
	/**
	 *  Name of the class to use as the skin for the previous month arrow *  when the arrow is disabled. *  The default value is the DateChooserMonthArrowSkin class.
	 */
	[Style(name="prevMonthDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the previous month arrow *  when the user presses the mouse button down over the arrow. *  The default value is the DateChooserMonthArrowSkin class.
	 */
	[Style(name="prevMonthDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the previous month arrow *  when the user holds the mouse pointer over the arrow. *  The default value is the DateChooserMonthArrowSkin class.
	 */
	[Style(name="prevMonthOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the previous month arrow *  when the mouse pointer is not over the arrow. *  The default value is the DateChooserMonthArrowSkin class.
	 */
	[Style(name="prevMonthUpSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the previous year arrow. *  The default value is the DateChooserYearArrowSkin class.
	 */
	[Style(name="prevYearSkin", type="Class", inherit="no", states="up, over, down, disabled")] 
	/**
	 *  Name of the class to use as the skin for the previous Year arrow *  when the arrow is disabled. *  The default value is the DateChooserYearArrowSkin class.
	 */
	[Style(name="prevYearDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the previous Year arrow *  when the user presses the mouse button down over the arrow. *  The default value is the DateChooserYearArrowSkin class.
	 */
	[Style(name="prevYearDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the previous Year arrow *  when the user holds the mouse pointer over the arrow. *  The default value is the DateChooserYearArrowSkin class.
	 */
	[Style(name="prevYearOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the previous Year arrow *  when the mouse button not over the arrow. *  The default value is the DateChooserYearArrowSkin class.
	 */
	[Style(name="prevYearUpSkin", type="Class", inherit="no")] 
	/**
	 *  Color of the highlight area of the date when the user holds the *  mouse pointer over a date in the DateChooser control. *  @default 0xE3FFD6
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Name of the class to use as the skin for the  *  highlight area of the date when the user holds the *  mouse pointer over a date in the DateChooser control. * *  @default mx.skins.halo.DateChooserIndicator
	 */
	[Style(name="rollOverIndicatorSkin", type="Class", inherit="no")] 
	/**
	 *  Color of the highlight area of the currently selected date *  in the DateChooser control. *  @default 0xCDFFC1
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Name of the class to use as the skin for the  *  highlight area of the currently selected date *  in the DateChooser control. * *  @default mx.skins.halo.DateChooserIndicator
	 */
	[Style(name="selectionIndicatorSkin", type="Class", inherit="no")] 
	/**
	 *  Color of the background of today's date. *  The default value is <code>0x818181</code>.
	 */
	[Style(name="todayColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Name of the class to use as the skin for the  *  highlight area of today's date *  in the DateChooser control. * *  @default mx.skins.halo.DateChooserIndicator
	 */
	[Style(name="todayIndicatorSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the style sheet definition to configure the appearance of the current day's *  numeric text, which is highlighted *  in the control when the <code>showToday</code> property is <code>true</code>. *  Specify a "color" style to change the font color. *  If omitted, the current day text inherits *  the text styles of the control.
	 */
	[Style(name="todayStyleName", type="String", inherit="no")] 
	/**
	 *  Name of the style sheet definition to configure the weekday names of *  the control. If omitted, the weekday names inherit the text *  styles of the control.
	 */
	[Style(name="weekDayStyleName", type="String", inherit="no")] 

	/**
	 *  The DateChooser control displays the name of a month, the year, *  and a grid of the days of the month, with columns labeled *  for the day of the week. *  The user can select a date, a range of dates, or multiple dates. *  The control contains forward and back arrow buttons *  for changing the month and year. *  You can let users select multiple dates, disable the selection *  of certain dates, and limit the display to a range of dates. * *  <p>The DateChooser control has the following default characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>A size large enough to hold the calendar, and wide enough to display the day names</td> *        </tr> *        <tr> *           <td>Minimum size</td> *           <td>0 pixels</td> *        </tr> *        <tr> *           <td>Maximum size</td> *           <td>No limit</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:DateChooser&gt;</code> tag inherits all of the tag attributes *  of its superclass, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:DateChooser *    <strong>Properties</strong> *    allowDisjointSelection="true|false" *    allowMultipleSelection="false|true" *    dayNames="["S", "M", "T", "W", "T", "F", "S"]" *    disabledDays="<i>No default</i>" *    disabledRanges="<i>No default</i>" *    displayedMonth="<i>Current month</i>" *    displayedYear="<i>Current year</i>" *    firstDayOfWeek="0" *    maxYear="2100" *    minYear="1900" *    monthNames="["January", "February", "March", "April", "May", *      "June", "July", "August", "September", "October", "November", *      "December"]" *    monthSymbol="" *    selectableRange="<i>No default</i>" *    selectedDate="<i>No default</i>" *    selectedRanges="<i>No default</i>" *    showToday="true|false" *    yearNavigationEnabled="false|true" *    yearSymbol="" *  *    <strong>Styles</strong> *    backgroundColor="0xFFFFFF" *    backgroundAlpha="1.0" *    borderColor="0xAAB3B3" *    borderThickness="1" *    color="0x0B333C" *    cornerRadius="4" *    disabledColor="0xAAB3B3" *    disabledIconColor="0x999999" *    fillAlphas="[0.6, 0.4]" *    fillColors="[0xFFFFFF, 0xCCCCCC]" *    focusAlpha="0.5" *    focusRoundedCorners"tl tr bl br" *    fontAntiAliasType="advanced" *    fontFamily="Verdana" *    fontGridFitType="pixel" *    fontSharpness="0" *    fontSize="10" *    fontStyle="normal|italic" *    fontThickness="0" *    fontWeight="normal|bold" *    headerColors="[0xE1E5EB, 0xF4F5F7]" *    headerStyleName="headerDateText" *    highlightAlphas="[0.3, 0.0]" *    horizontalGap="8" *    iconColor="0x111111" *    leading="2" *    nextMonthDisabledSkin="DateChooserMonthArrowSkin" *    nextMonthDownSkin="DateChooserMonthArrowSkin" *    nextMonthOverSkin="DateChooserMonthArrowSkin" *    nextMonthSkin = "DateChooserMonthArrowSkin"  *    nextMonthUpSkin="DateChooserMonthArrowSkin" *    nextYearDisabledSkin="DateChooserYearArrowSkin" *    nextYearDownSkin="DateChooserYearArrowSkin" *    nextYearOverSkin="DateChooserYearArrowSkin" *    nextYearSkin = "DateChooserYearArrowSkin" *    nextYearUpSkin="DateChooserYearArrowSkin" *    prevMonthDisabledSkin="DateChooserMonthArrowSkin" *    prevMonthDownSkin="DateChooserMonthArrowSkin" *    prevMonthOverSkin="DateChooserMonthArrowSkin" *    prevMonthSkin = "DateChooserMonthArrowSkin" *    prevMonthUpSkin="DateChooserMonthArrowSkin" *    prevYearDisabledSkin="DateChooserYearArrowSkin" *    prevYearDownSkin="DateChooserYearArrowSkin" *    prevYearOverSkin="DateChooserYearArrowSkin" *    prevYearSkin = "DateChooserYearArrowSkin" *    prevYearUpSkin="DateChooserYearArrowSkin" *    rollOverColor="0xEEFEE6" *    rollOverIndicatorSkin="DateChooserIndicator" *    selectionColor="0xB7F39B" *    selectionIndicatorSkin="DateChooserIndicator" *    textAlign="left|right|center" *    textDecoration
	 */
	public class DateChooser extends UIComponent implements IFocusManagerComponent
	{
		/**
		 *  @private
		 */
		private var HEADER_WIDTH_PAD : Number;
		/**
		 *  @private     *  Width pad month skins
		 */
		private var SKIN_WIDTH_PAD : Number;
		/**
		 *  @private
		 */
		private var SKIN_HEIGHT_PAD : Number;
		/**
		 *  @private     *  Padding between buttons and also at the sides.
		 */
		private var YEAR_BUTTONS_PAD : Number;
		/**
		 *  @private     *  Placeholder for mixin by DateChooserAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
		 */
		local var background : UIComponent;
		/**
		 *  @private
		 */
		local var border : UIComponent;
		/**
		 *  @private
		 */
		local var headerDisplay : UIComponent;
		/**
		 *  @private     *  The internal UITextField that displays     *  the currently visible month and year.
		 */
		local var monthDisplay : IUITextField;
		/**
		 *  @private
		 */
		local var fwdMonthHit : Sprite;
		/**
		 *  @private
		 */
		local var backMonthHit : Sprite;
		/**
		 *  @private
		 */
		local var upYearHit : Sprite;
		/**
		 *  @private
		 */
		local var downYearHit : Sprite;
		/**
		 *  @private
		 */
		local var calHeader : UIComponent;
		/**
		 *  @private
		 */
		local var yearDisplay : IUITextField;
		/**
		 *  @private     *  The internal Button which, when clicked,     *  makes the DateChooser display the next year.
		 */
		local var upYearButton : Button;
		/**
		 *  @private     *  The internal Button which, when clicked,     *  makes the DateChooser display the previous year.
		 */
		local var downYearButton : Button;
		/**
		 *  @private     *  The internal Button which, when clicked,     *  makes the DateChooser display the next month.
		 */
		local var fwdMonthButton : Button;
		/**
		 *  @private     *  The internal Button which, when clicked,     *  makes the DateChooser display the previous month.
		 */
		local var backMonthButton : Button;
		/**
		 *  @private     *  The internal CalendarLayout that displays the grid of dates.
		 */
		local var dateGrid : CalendarLayout;
		/**
		 *  @private
		 */
		local var dropShadow : RectangularDropShadow;
		/**
		 *  @private
		 */
		private var previousSelectedCellIndex : Number;
		/**
		 *  @private
		 */
		private var monthSkinWidth : Number;
		/**
		 *  @private
		 */
		private var monthSkinHeight : Number;
		/**
		 *  @private
		 */
		private var yearSkinWidth : Number;
		/**
		 *  @private
		 */
		private var yearSkinHeight : Number;
		/**
		 *  @private
		 */
		private var headerHeight : Number;
		/**
		 *  @private     *  Storage for the enabled property.
		 */
		private var _enabled : Boolean;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  @private     *  Storage for the allowDisjointSelection property.
		 */
		private var _allowDisjointSelection : Boolean;
		/**
		 *  @private
		 */
		private var allowDisjointSelectionChanged : Boolean;
		/**
		 *  @private     *  Storage for the allowMultipleSelection property.
		 */
		private var _allowMultipleSelection : Boolean;
		/**
		 *  @private
		 */
		private var allowMultipleSelectionChanged : Boolean;
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
		 *  @private     *  Storage for the maxYear property.
		 */
		private var _maxYear : int;
		/**
		 *  @private     *  Storage for the minYear property.
		 */
		private var _minYear : int;
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
		private static var _nextMonthStyleFilters : Object;
		private static var _nextYearStyleFilters : Object;
		private static var _prevMonthStyleFilters : Object;
		private static var _prevYearStyleFilters : Object;
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
		 *  @private     *  Storage for the selectedRanges property.
		 */
		private var _selectedRanges : Array;
		/**
		 *  @private
		 */
		private var selectedRangesChanged : Boolean;
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
		 *  @private     *  The baselinePosition of a DateChooser is calculated     *  for its month/year text.
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  If <code>true</code>, specifies that non-contiguous(disjoint)     *  selection is allowed in the DateChooser control.     *  This property has an effect only if the     *  <code>allowMultipleSelection</code> property is <code>true</code>.     *  Setting this property changes the appearance of the     *  DateChooser control.     *     *  @default true;     *  @helpid     *  @tiptext Non-contiguous is allowed if true
		 */
		public function get allowDisjointSelection () : Boolean;
		/**
		 *  @private
		 */
		public function set allowDisjointSelection (value:Boolean) : void;
		/**
		 *  If <code>true</code>, specifies that multiple selection     *  is allowed in the DateChooser control.     *  Setting this property changes the appearance of the DateChooser control.     *     *  @default false     *  @helpid     *  @tiptext Multiple selection is allowed if true
		 */
		public function get allowMultipleSelection () : Boolean;
		/**
		 *  @private
		 */
		public function set allowMultipleSelection (value:Boolean) : void;
		/**
		 *  The set of styles to pass from the DateChooser to the calendar layout.     *  @see mx.styles.StyleProxy
		 */
		protected function get calendarLayoutStyleFilters () : Object;
		/**
		 *  The weekday names for DateChooser control.     *  Changing this property changes the day labels     *  of the DateChooser control.     *  Sunday is the first day (at index 0).     *  The rest of the week names follow in the normal order.     *     *  @default [ "S", "M", "T", "W", "T", "F", "S" ].     *  @helpid 3607     *  @tiptext The names of days of week in a DateChooser
		 */
		public function get dayNames () : Array;
		/**
		 *  @private
		 */
		public function set dayNames (value:Array) : void;
		/**
		 *  The days to disable in a week.     *  All the dates in a month, for the specified day, are disabled.     *  This property changes the appearance of the DateChooser control.     *  The elements of this array can have values from 0 (Sunday) to     *  6 (Saturday).     *  For example, a value of <code>[ 0, 6 ]</code>     *  disables Sunday and Saturday.     *     *  @default []     *  @helpid 3608     *  @tiptext The disabled days in a week
		 */
		public function get disabledDays () : Array;
		/**
		 *  @private
		 */
		public function set disabledDays (value:Array) : void;
		/**
		 *  Disables single and multiple days.     *     *  <p>This property accepts an Array of objects as a parameter.     *  Each object in this array is a Date object, specifying a     *  single day to disable; or an object containing either or both     *  of the <code>rangeStart</code> and <code>rangeEnd</code> properties,     *  each of whose values is a Date object.     *  The value of these properties describes the boundaries     *  of the date range.     *  If either is omitted, the range is considered     *  unbounded in that direction.     *  If you specify only <code>rangeStart</code>,     *  all the dates after the specified date are disabled,     *  including the <code>rangeStart</code> date.     *  If you specify only <code>rangeEnd</code>,     *  all the dates before the specified date are disabled,     *  including the <code>rangeEnd</code> date.     *  To disable a single day, use a single Date object specifying a date     *  in the Array. Time values are zeroed out from the Date      *  object if they are present.</p>     *     *  <p>The following example, disables the following dates: January 11     *  2006, the range January 23 - February 10 2006, and March 1 2006     *  and all following dates.</p>     *     *  <p><code>disabledRanges="{[ new Date(2006,0,11), {rangeStart:     *  new Date(2006,0,23), rangeEnd: new Date(2006,1,10)},     *  {rangeStart: new Date(2006,2,1)} ]}"</code></p>     *     *  @default []     *  @helpid 3610     *  @tiptext The disabled dates inside the selectableRange
		 */
		public function get disabledRanges () : Array;
		/**
		 *  @private
		 */
		public function set disabledRanges (value:Array) : void;
		/**
		 *  Used together with the <code>displayedYear</code> property,     *  the <code>displayedMonth</code> property specifies the month     *  displayed in the DateChooser control.     *  Month numbers are zero-based, so January is 0 and December is 11.     *  Setting this property changes the appearance of the DateChooser control.     *     *  <p>The default value is the current month.</p>     *     *  @helpid 3605     *  @tiptext The currently displayed month in the DateChooser
		 */
		public function get displayedMonth () : int;
		/**
		 *  @private
		 */
		public function set displayedMonth (value:int) : void;
		/**
		 *  Used together with the <code>displayedMonth</code> property,     *  the <code>displayedYear</code> property specifies the month     *  displayed in the DateChooser control.     *  Setting this property changes the appearance of the DateChooser control.     *     *  <p>The default value is the current year.</p>     *     *  @helpid 3606     *  @tiptext The currently displayed year in DateChooser
		 */
		public function get displayedYear () : int;
		/**
		 *  @private
		 */
		public function set displayedYear (value:int) : void;
		/**
		 *  Number representing the day of the week to display in the     *  first column of the DateChooser control.     *  The value must be in the range 0 to 6, where 0 corresponds to Sunday,     *  the first element of the <code>dayNames</code> Array.     *     *  <p>Setting this property changes the order of the day columns.     *  For example, setting it to 1 makes Monday the first column     *  in the control.</p>     *     *  @default 0 (Sunday)     *  @tiptext Sets the first day of week for DateChooser
		 */
		public function get firstDayOfWeek () : Object;
		/**
		 *  @private
		 */
		public function set firstDayOfWeek (value:Object) : void;
		/**
		 *  @private
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  The last year selectable in the control.     *     *  @default 2100     *  @helpid     *  @tiptext Maximum year limit
		 */
		public function get maxYear () : int;
		/**
		 *  @private
		 */
		public function set maxYear (value:int) : void;
		/**
		 *  The first year selectable in the control.     *     *  @default 1900     *  @helpid     *  @tiptext Minimum year limit
		 */
		public function get minYear () : int;
		/**
		 *  @private
		 */
		public function set minYear (value:int) : void;
		/**
		 *  Names of the months displayed at the top of the DateChooser control.     *  The <code>monthSymbol</code> property is appended to the end of      *  the value specified by the <code>monthNames</code> property,      *  which is useful in languages such as Japanese.     *     *  @default [ "January", "February", "March", "April", "May", "June",      *  "July", "August", "September", "October", "November", "December" ]     *  @tiptext The name of the months displayed in the DateChooser
		 */
		public function get monthNames () : Array;
		/**
		 *  @private
		 */
		public function set monthNames (value:Array) : void;
		/**
		 *  This property is appended to the end of the value specified      *  by the <code>monthNames</code> property to define the names      *  of the months displayed at the top of the DateChooser control.     *  Some languages, such as Japanese, use an extra      *  symbol after the month name.      *     *  @default ""
		 */
		public function get monthSymbol () : String;
		/**
		 *  @private
		 */
		public function set monthSymbol (value:String) : void;
		/**
		 *  The set of styles to pass from the DateChooser to the next month button.     *  @see mx.styles.StyleProxy
		 */
		protected function get nextMonthStyleFilters () : Object;
		/**
		 *  The set of styles to pass from the DateChooser to the next year button.     *  @see mx.styles.StyleProxy
		 */
		protected function get nextYearStyleFilters () : Object;
		/**
		 *  The set of styles to pass from the DateChooser to the previous month button.     *  @see mx.styles.StyleProxy
		 */
		protected function get prevMonthStyleFilters () : Object;
		/**
		 *  The set of styles to pass from the DateChooser to the previous year button.     *  @see mx.styles.StyleProxy
		 */
		protected function get prevYearStyleFilters () : Object;
		/**
		 *  Range of dates between which dates are selectable.     *  For example, a date between 04-12-2006 and 04-12-2007     *  is selectable, but dates out of this range are disabled.     *     *  <p>This property accepts an Object as a parameter.     *  The Object contains two properties, <code>rangeStart</code>     *  and <code>rangeEnd</code>, of type Date.     *  If you specify only <code>rangeStart</code>,     *  all the dates after the specified date are enabled.     *  If you only specify <code>rangeEnd</code>,     *  all the dates before the specified date are enabled.     *  To enable only a single day in a DateChooser control,     *  you can pass a Date object directly. Time values are      *  zeroed out from the Date object if they are present.</p>     *     *  <p>The following example enables only the range     *  January 1, 2006 through June 30, 2006. Months before January     *  and after June do not appear in the DateChooser.</p>     *     *  <p><code>selectableRange="{{rangeStart : new Date(2006,0,1),     *  rangeEnd : new Date(2006,5,30)}}"</code></p>     *     *  @default null     *  @helpid 3609     *  @tiptext The start and end dates between which a date can be selected
		 */
		public function get selectableRange () : Object;
		/**
		 *  @private
		 */
		public function set selectableRange (value:Object) : void;
		/**
		 *  Date selected in the DateChooser control.     *  If the incoming Date object has any time values,      *  they are zeroed out.     *     *  <p>Holding down the Control key when selecting the      *  currently selected date in the control deselects it,      *  sets the <code>selectedDate</code> property to <code>null</code>,      *  and then dispatches the <code>change</code> event.</p>     *     *  @default null
		 */
		public function get selectedDate () : Date;
		/**
		 *  @private
		 */
		public function set selectedDate (value:Date) : void;
		/**
		 *  Selected date ranges.     *     *  <p>This property accepts an Array of objects as a parameter.     *  Each object in this array has two date Objects,     *  <code>rangeStart</code> and <code>rangeEnd</code>.     *  The range of dates between each set of <code>rangeStart</code>     *  and <code>rangeEnd</code> (inclusive) are selected.     *  To select a single day, set both <code>rangeStart</code> and <code>rangeEnd</code>     *  to the same date. Time values are zeroed out from the Date      *  object if they are present.</p>     *      *  <p>The following example, selects the following dates: January 11     *  2006, the range January 23 - February 10 2006. </p>     *     *  <p><code>selectedRanges="{[ {rangeStart: new Date(2006,0,11),     *  rangeEnd: new Date(2006,0,11)}, {rangeStart:new Date(2006,0,23),     *  rangeEnd: new Date(2006,1,10)} ]}"</code></p>     *     *  @default []     *  @helpid 0000     *  @tiptext The selected dates
		 */
		public function get selectedRanges () : Array;
		/**
		 *  @private
		 */
		public function set selectedRanges (value:Array) : void;
		/**
		 *  If <code>true</code>, specifies that today is highlighted     *  in the DateChooser control.     *  Setting this property changes the appearance of the DateChooser control.     *     *  @default true     *  @helpid 3603     *  @tiptext The highlight on the current day of the month
		 */
		public function get showToday () : Boolean;
		/**
		 *  @private
		 */
		public function set showToday (value:Boolean) : void;
		/**
		 *  Enables year navigation. When <code>true</code>     *  an up and down button appear to the right     *  of the displayed year. You can use these buttons     *  to change the current year.     *  These button appear to the left of the year in locales where year comes      *  before the month in the date format.     *     *  @default false     *  @tiptext Enables yearNavigation
		 */
		public function get yearNavigationEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set yearNavigationEnabled (value:Boolean) : void;
		/**
		 *  This property is appended to the end of the year      *  displayed at the top of the DateChooser control.     *  Some languages, such as Japanese,      *  add a symbol after the year.      *     *  @default ""
		 */
		public function get yearSymbol () : String;
		/**
		 *  @private
		 */
		public function set yearSymbol (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function DateChooser ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private     *  Create subobjects in the component. This method creates textfields for     *  dates in a month, month scroll buttons, header row, background and border.
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
		protected function resourcesChanged () : void;
		/**
		 *  @private     *  Creates the month display label     *  and adds it as a child of this component.     *      *  @param childIndex The index of where to add the child.     *  If -1, the text field is appended to the end of the list.
		 */
		function createMonthDisplay (childIndex:int) : void;
		/**
		 *  @private     *  Removes the month dislay label from this component.
		 */
		function removeMonthDisplay () : void;
		/**
		 *  @private     *  Creates the month display label and adds it as a child of this component.     *      *  @param childIndex The index of where to add the child.     *  If -1, the text field is appended to the end of the list.
		 */
		function createYearDisplay (childIndex:int) : void;
		/**
		 *  @private     *  Removes the month dislay label from this component.
		 */
		function removeYearDisplay () : void;
		/**
		 *  @private
		 */
		function updateDateDisplay () : void;
		/**
		 *  @private
		 */
		private function getYearNavigationButtons () : void;
		/**
		 *  @private
		 */
		function setMonthWidth () : void;
		/**
		 *  @private     *  Returns true if year comes before month in DateFormat.     *  Used for correct placement of year and month in header.
		 */
		private function yearBeforeMonth (dateFormat:String) : Boolean;
		/**
		 *  @private     *  This method scrubs out time values from incoming date objects
		 */
		function scrubTimeValue (value:Object) : Object;
		/**
		 *  @private     *  This method scrubs out time values from incoming date objects
		 */
		function scrubTimeValues (values:Array) : Array;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private     *  event is either a KeyboardEvent or a FlexEvent
		 */
		private function upYearButton_buttonDownHandler (event:Event) : void;
		/**
		 *  @private     *  event is either a KeyboardEvent or a FlexEvent
		 */
		private function downYearButton_buttonDownHandler (event:Event) : void;
		/**
		 *  @private     *  event is either a KeyboardEvent or a FlexEvent
		 */
		private function fwdMonthButton_buttonDownHandler (event:Event) : void;
		/**
		 *  @private     *  event is either a KeyboardEvent or a FlexEvent
		 */
		private function backMonthButton_buttonDownHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function dateGrid_scrollHandler (event:DateChooserEvent) : void;
		/**
		 *  @private
		 */
		private function dateGrid_changeHandler (event:CalendarLayoutChangeEvent) : void;
	}
}
