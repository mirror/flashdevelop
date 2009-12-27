package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.CalendarLayoutChangeEvent;
	import mx.events.DateChooserEvent;
	import mx.events.DateChooserEventDetail;
	import mx.managers.IFocusManagerComponent;
	import mx.skins.halo.DateChooserIndicator;
	import mx.styles.ISimpleStyleClient;

include "../styles/metadata/GapStyles.as"
include "../styles/metadata/LeadingStyle.as"
include "../styles/metadata/PaddingStyles.as"
include "../styles/metadata/TextStyles.as"
	/**
	 *  Name of the skin for the <code>rollOverIndicator</code>.
 *  It can be customized to some other shape other than rectangular.
 *  If you want to change just the color,
 *  use the <code>rollOverColor</code> instead.
 *  The default value is the DateChooserRollOverIndicator class.
	 */
	[Style(name="rollOverIndicatorSkin", type="Class", inherit="no")] 

	/**
	 *  Name of the skin for <code>selectionIndicator</code>.
 *  It can customized to some other shape other than rectangular.
 *  If one just needs to change color,
 *  use the <code>selectionColor</code> instead.
 *  The default value is the DateChooserSelectionIndicator class.
	 */
	[Style(name="selectionIndicatorSkin", type="Class", inherit="no")] 

	/**
	 *  Name of the skin for <code>todayIndicator</code> style property. It can be customized
 *  to some other shape other than rectangular. If you
 *  wnat to change just the color, use the <code>todayColor</code> style property instead.
 *  The default value is the DateChooserTodayIndicator class.
	 */
	[Style(name="todayIndicatorSkin", type="Class", inherit="no")] 

	/**
	 *  Name of the style sheet definition to configure the appearence of the current day's
 *  numeric text, which is highlighted
 *  in the control when the <code>showToday</code> property is <code>true</code>.
 *  Specify a "color" style to change the font color.
 *  If omitted, the current day text inherits
 *  the text styles of the control.
	 */
	[Style(name="todayStyleName", type="String", inherit="no")] 

	/**
	 *  Name of the style sheet definition to configure the weekday names of
 *  the control. If omitted, the weekday names inherit the text
 *  styles of the control.
	 */
	[Style(name="weekDayStyleName", type="String", inherit="no")] 

include "../core/Version.as"
	/**
	 *  @private
 *  The CalendarLayout class handles the layout of the date grid in a month.
 *  CalendarLayout can be extended to develop DateControls with
 *  single month display control or side-by-side month displays.
 *
 *  @see mx.styles.StyleManager
	 */
	public class CalendarLayout extends UIComponent implements IFocusManagerComponent
	{
		/**
		 *  @private
		 */
		private var todayRow : int;
		/**
		 *  @private
		 */
		private var todayColumn : int;
		/**
		 *  @private
		 */
		private var enabledDaysInMonth : Array;
		/**
		 *  @private
		 */
		private var disabledRangeMode : Array;
		/**
		 *  @private
		 */
		private var cellHeight : Number;
		/**
		 *  @private
		 */
		private var cellWidth : Number;
		/**
		 *  @private
		 */
		private var yOffset : Number;
		/**
		 *  @private
		 */
		var dayBlocksArray : Array;
		/**
		 *  @private
		 */
		private var disabledArrays : Array;
		/**
		 *  @private
		 */
		private var todaysLabelReference : IUITextField;
		/**
		 *  @private
		 */
		private var selectedMonthYearChanged : Boolean;
		/**
		 *  @private
		 */
		private var todayIndicator : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var selectionIndicator : Array;
		/**
		 *  @private
		 */
		private var rollOverIndicator : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var selectedRangeCount : int;
		/**
		 *  @private
		 */
		private var lastSelectedDate : Date;
		/**
		 *  @private
		 */
		private var rangeStartDate : Date;
		/**
		 *  @private
		 */
		var selRangeMode : int;
		/**
		 *  @private
	 *  Storage for the displayedYear property.
		 */
		private var _enabled : Boolean;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  @private
	 *  Storage for the allowDisjointSelection property.
		 */
		private var _allowDisjointSelection : Boolean;
		/**
		 *  @private
	 *  Storage for the allowMultipleSelection property.
		 */
		private var _allowMultipleSelection : Boolean;
		/**
		 *  @private
	 *  Storage for the dayNames property.
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
		 *  @private
	 *  Storage for the disabledDays property.
		 */
		private var _disabledDays : Array;
		/**
		 *  @private
	 *  Storage for the disabledRanges property.
		 */
		private var _disabledRanges : Array;
		/**
		 *  @private
	 *  Storage for the displayedMonth property.
		 */
		private var _displayedMonth : int;
		/**
		 *  @private
	 *  Holds the proposed value of displayedMonth until it can be verified in commitProperties
		 */
		private var _proposedDisplayedMonth : int;
		/**
		 *  @private
	 *  Storage for the displayedYear property.
		 */
		private var _displayedYear : int;
		/**
		 *  @private
	 *  Holds the proposed value of displayedYear until it can be verified in commitProperties
		 */
		private var _proposedDisplayedYear : int;
		/**
		 *  @private
	 *  Storage for the firstDayOfWeek property.
		 */
		private var _firstDayOfWeek : int;
		/**
		 *  @private
	 *  Storage for the selectableRange property.
		 */
		private var _selectableRange : Object;
		/**
		 *  @private
	 *  Storage for the selectableRange property.
		 */
		private var _selectedRanges : Array;
		/**
		 *  @private
	 *  Storage for the showToday property.
		 */
		private var _showToday : Boolean;
		/**
		 *  We don't use 'is' to prevent dependency issues
		 */
		private static var dcis : Object;

		/**
		 *  @private
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function get allowDisjointSelection () : Boolean;
		/**
		 *  @private
		 */
		public function set allowDisjointSelection (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function get allowMultipleSelection () : Boolean;
		/**
		 *  @private
		 */
		public function set allowMultipleSelection (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function get dayNames () : Array;
		/**
		 *  @private
		 */
		public function set dayNames (value:Array) : void;

		/**
		 *  @private
		 */
		public function get disabledDays () : Array;
		/**
		 *  @private
		 */
		public function set disabledDays (value:Array) : void;

		/**
		 *  @private
		 */
		public function get disabledRanges () : Array;
		/**
		 *  @private
		 */
		public function set disabledRanges (value:Array) : void;

		/**
		 *  @private
		 */
		public function get displayedMonth () : int;
		/**
		 *  @private
		 */
		public function set displayedMonth (value:int) : void;

		/**
		 *  @private
		 */
		public function get displayedYear () : int;
		/**
		 *  @private
		 */
		public function set displayedYear (value:int) : void;

		/**
		 *  @private
		 */
		public function get firstDayOfWeek () : int;
		/**
		 *  @private
		 */
		public function set firstDayOfWeek (value:int) : void;

		/**
		 *  @private
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;

		/**
		 *  @private
		 */
		public function get selectableRange () : Object;
		/**
		 *  @private
		 */
		public function set selectableRange (value:Object) : void;

		/**
		 *  @private
		 */
		public function get selectedRanges () : Array;
		/**
		 *  @private
		 */
		public function set selectedRanges (value:Array) : void;

		/**
		 *  @private
		 */
		public function get showToday () : Boolean;
		/**
		 *  @private
		 */
		public function set showToday (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function get selectedDate () : Date;
		/**
		 *  @private
		 */
		public function set selectedDate (value:Date) : void;

		/**
		 *  Constructor.
		 */
		public function CalendarLayout ();

		/**
		 *  @private
	 *  Everything that gets initially created now exists.
	 *  Some things, such as the selection skins and disabled skins,
	 *  are created later as they are needed.
	 *  Set the "S", "M", etc. labels in the first row.
	 *  
	 *  Set the day-number labels ("1".."31") in the other rows.
	 *  This method also displays the selection skins,
	 *  the disabled skins, and the "today" indicator.
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
		 *  @private
     *  Creates the day labels and adds them as children of this component.
     * 
     *  @param childIndex The index of where to add the children.
	 *  If -1, the text fields are appended to the end of the list.
		 */
		function createDayLabels (childIndex:int) : void;

		/**
		 *  @private
     *  Removes the day labels from this component.
		 */
		function removeDayLabels () : void;

		/**
		 *  @private
     *  @param childIndex The index of where to add the child.
		 */
		function createTodayIndicator (childIndex:int) : void;

		/**
		 *  @private
		 */
		function removeTodayIndicator () : void;

		/**
		 *  @private
		 */
		function drawDayNames () : void;

		/**
		 *  @private
		 */
		function setSelectedMonthAndYear (monthVal:int = -1, yearVal:int = -1) : void;

		/**
		 *  @private
	 *  Called from setSelectedMonthAndYear() to get an Offset of the starting day of the month
		 */
		function getOffsetOfMonth (year:int, month:int) : int;

		/**
		 *  @private
		 */
		function getNumberOfDaysInMonth (year:int, month:int) : int;

		/**
		 *  @private
		 */
		function stepDate (deltaY:int, deltaM:int, triggerEvent:Event = null) : void;

		/**
		 *  @private Takes a year and a month as well as an increment year and month value
     *           and returns a new valid year/month.
		 */
		static function getNewIncrementDate (oldYear:int, oldMonth:int, deltaY:int, deltaM:int) : Object;

		/**
		 *  @private
		 */
		function dispatchChangeEvent (triggerEvent:Event = null) : void;

		/**
		 *  @private
	 * 
	 *  Returns true if the date is within the dates specified by the dateRange object.
		 */
		function isDateInRange (value:Date, dateRange:Object, rangeMode:int, ignoreDay:Boolean = false) : Boolean;

		/**
		 *  @private
	 *
	 *  Checking for valid dates, months and Years before setting them through API
 	 *  Returns true is date is disabled. null date is considered enabled,
	 *  as one can set date to null.
		 */
		function checkDateIsDisabled (value:Date) : Boolean;

		/**
		 *  @private
     *  Adds the newDate to the list of selected dates.
     *  If range is true, a range of dates starting from the previous selection is selected.
		 */
		function addToSelected (newDate:Date, range:Boolean = false) : void;

		/**
		 *  @private
     *  Increments/decrements a date by 'No. of days'
	 *  specified by amount and returns the new date.
		 */
		function incrementDate (value:Date, amount:int = 1) : Date;

		/**
		 *  @private
	 *  Returns true if newDate is selected.
		 */
		function isSelected (newDate:Date) : Boolean;

		/**
		 *  @private
	 *  Removes the range of dates specified by startDate and endDate
	 *  from the selected dates.
		 */
		function removeRangeFromSelection (startDate:Date, endDate:Date) : void;

		/**
		 *  @private
	 *  Updates the visible property of all the selected indicators.
	 *  Called when a date range has been selected or deselected.
		 */
		function setSelectedIndicators () : void;

		/**
		 *  @private
		 */
		function addSelectionIndicator (columnIndex:int, rowIndex:int) : void;

		/**
		 *  @private
		 */
		function removeSelectionIndicator (columnIndex:int, rowIndex:int) : void;

		/**
		 *  @private
     * 
     *  Removes the selection indicators from this component.
		 */
		function removeSelectionIndicators () : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		private function mouseOverHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function mouseOutHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function mouseMoveHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function mouseUpHandler (event:MouseEvent) : void;

		private static function isDateChooserIndicator (parent:Object) : Boolean;
	}
}
