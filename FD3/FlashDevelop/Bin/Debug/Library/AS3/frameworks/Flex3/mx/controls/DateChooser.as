/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.UIComponent;
	import mx.managers.IFocusManagerComponent;
	import mx.core.IFontContextComponent;
	public class DateChooser extends UIComponent implements IFocusManagerComponent, IFontContextComponent {
		/**
		 * If true, specifies that non-contiguous(disjoint)
		 *  selection is allowed in the DateChooser control.
		 *  This property has an effect only if the
		 *  allowMultipleSelection property is true.
		 *  Setting this property changes the appearance of the
		 *  DateChooser control.
		 */
		public function get allowDisjointSelection():Boolean;
		public function set allowDisjointSelection(value:Boolean):void;
		/**
		 * If true, specifies that multiple selection
		 *  is allowed in the DateChooser control.
		 *  Setting this property changes the appearance of the DateChooser control.
		 */
		public function get allowMultipleSelection():Boolean;
		public function set allowMultipleSelection(value:Boolean):void;
		/**
		 * The set of styles to pass from the DateChooser to the calendar layout.
		 */
		protected function get calendarLayoutStyleFilters():Object;
		/**
		 * The weekday names for DateChooser control.
		 *  Changing this property changes the day labels
		 *  of the DateChooser control.
		 *  Sunday is the first day (at index 0).
		 *  The rest of the week names follow in the normal order.
		 */
		public function get dayNames():Array;
		public function set dayNames(value:Array):void;
		/**
		 * The days to disable in a week.
		 *  All the dates in a month, for the specified day, are disabled.
		 *  This property changes the appearance of the DateChooser control.
		 *  The elements of this array can have values from 0 (Sunday) to
		 *  6 (Saturday).
		 *  For example, a value of [ 0, 6 ]
		 *  disables Sunday and Saturday.
		 */
		public function get disabledDays():Array;
		public function set disabledDays(value:Array):void;
		/**
		 * Disables single and multiple days.
		 */
		public function get disabledRanges():Array;
		public function set disabledRanges(value:Array):void;
		/**
		 * Used together with the displayedYear property,
		 *  the displayedMonth property specifies the month
		 *  displayed in the DateChooser control.
		 *  Month numbers are zero-based, so January is 0 and December is 11.
		 *  Setting this property changes the appearance of the DateChooser control.
		 */
		public function get displayedMonth():int;
		public function set displayedMonth(value:int):void;
		/**
		 * Used together with the displayedMonth property,
		 *  the displayedYear property specifies the month
		 *  displayed in the DateChooser control.
		 *  Setting this property changes the appearance of the DateChooser control.
		 */
		public function get displayedYear():int;
		public function set displayedYear(value:int):void;
		/**
		 * Number representing the day of the week to display in the
		 *  first column of the DateChooser control.
		 *  The value must be in the range 0 to 6, where 0 corresponds to Sunday,
		 *  the first element of the dayNames Array.
		 */
		public function get firstDayOfWeek():Object;
		public function set firstDayOfWeek(value:Object):void;
		/**
		 * The last year selectable in the control.
		 */
		public function get maxYear():int;
		public function set maxYear(value:int):void;
		/**
		 * The first year selectable in the control.
		 */
		public function get minYear():int;
		public function set minYear(value:int):void;
		/**
		 * Names of the months displayed at the top of the DateChooser control.
		 *  The monthSymbol property is appended to the end of
		 *  the value specified by the monthNames property,
		 *  which is useful in languages such as Japanese.
		 */
		public function get monthNames():Array;
		public function set monthNames(value:Array):void;
		/**
		 * This property is appended to the end of the value specified
		 *  by the monthNames property to define the names
		 *  of the months displayed at the top of the DateChooser control.
		 *  Some languages, such as Japanese, use an extra
		 *  symbol after the month name.
		 */
		public function get monthSymbol():String;
		public function set monthSymbol(value:String):void;
		/**
		 * The set of styles to pass from the DateChooser to the next month button.
		 */
		protected function get nextMonthStyleFilters():Object;
		/**
		 * The set of styles to pass from the DateChooser to the next year button.
		 */
		protected function get nextYearStyleFilters():Object;
		/**
		 * The set of styles to pass from the DateChooser to the previous month button.
		 */
		protected function get prevMonthStyleFilters():Object;
		/**
		 * The set of styles to pass from the DateChooser to the previous year button.
		 */
		protected function get prevYearStyleFilters():Object;
		/**
		 * Range of dates between which dates are selectable.
		 *  For example, a date between 04-12-2006 and 04-12-2007
		 *  is selectable, but dates out of this range are disabled.
		 */
		public function get selectableRange():Object;
		public function set selectableRange(value:Object):void;
		/**
		 * Date selected in the DateChooser control.
		 *  If the incoming Date object has any time values,
		 *  they are zeroed out.
		 */
		public function get selectedDate():Date;
		public function set selectedDate(value:Date):void;
		/**
		 * Selected date ranges.
		 */
		public function get selectedRanges():Array;
		public function set selectedRanges(value:Array):void;
		/**
		 * If true, specifies that today is highlighted
		 *  in the DateChooser control.
		 *  Setting this property changes the appearance of the DateChooser control.
		 */
		public function get showToday():Boolean;
		public function set showToday(value:Boolean):void;
		/**
		 * Enables year navigation. When true
		 *  an up and down button appear to the right
		 *  of the displayed year. You can use these buttons
		 *  to change the current year.
		 *  These button appear to the left of the year in locales where year comes
		 *  before the month in the date format.
		 */
		public function get yearNavigationEnabled():Boolean;
		public function set yearNavigationEnabled(value:Boolean):void;
		/**
		 * This property is appended to the end of the year
		 *  displayed at the top of the DateChooser control.
		 *  Some languages, such as Japanese,
		 *  add a symbol after the year.
		 */
		public function get yearSymbol():String;
		public function set yearSymbol(value:String):void;
		/**
		 * Constructor.
		 */
		public function DateChooser();
	}
}
