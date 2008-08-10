/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.managers.IFocusManagerComponent;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.IFactory;
	import mx.controls.listClasses.BaseListData;
	public class DateField extends ComboBase implements IDataRenderer, IDropInListItemRenderer, IFocusManagerComponent, IListItemRenderer {
		/**
		 * The data property lets you pass a value
		 *  to the component when you use it in an item renderer or item editor.
		 *  You typically use data binding to bind a field of the data
		 *  property to a property of this component.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * Weekday names for DateChooser control.
		 *  Setting this property changes the day labels
		 *  of the DateChooser control.
		 *  Sunday is the first day (at index 0).
		 *  The rest of the week names follow in the normal order.
		 */
		public function get dayNames():Array;
		public function set dayNames(value:Array):void;
		/**
		 * Days to disable in a week.
		 *  All the dates in a month, for the specified day, are disabled.
		 *  This property immediately changes the user interface
		 *  of the DateChooser control.
		 *  The elements of this Array can have values from 0 (Sunday)
		 *  to 6 (Saturday).
		 *  For example, a value of [0, 6] disables
		 *  Sunday and Saturday.
		 */
		public function get disabledDays():Array;
		public function set disabledDays(value:Array):void;
		/**
		 * Disables single and multiple days.
		 */
		public function get disabledRanges():Array;
		public function set disabledRanges(value:Array):void;
		/**
		 * Used with the displayedYear property,
		 *  the displayedMonth property
		 *  specifies the month displayed in the DateChooser control.
		 *  Month numbers are zero-based, so January is 0 and December is 11.
		 *  Setting this property immediately changes the appearance
		 *  of the DateChooser control.
		 *  The default value is the month number of today's date.
		 */
		public function get displayedMonth():int;
		public function set displayedMonth(value:int):void;
		/**
		 * Used with the displayedMonth property,
		 *  the displayedYear property determines
		 *  which year is displayed in the DateChooser control.
		 *  Setting this property immediately changes the appearance
		 *  of the DateChooser control.
		 */
		public function get displayedYear():int;
		public function set displayedYear(value:int):void;
		/**
		 * Contains a reference to the DateChooser control
		 *  contained by the DateField control.  The class used
		 *  can be set with dropdownFactory as long as
		 *  it extends DateChooser.
		 */
		public function get dropdown():DateChooser;
		/**
		 * The IFactory that creates a DateChooser-derived instance to use
		 *  as the date-chooser
		 *  The default value is an IFactory for DateChooser
		 */
		public function get dropdownFactory():IFactory;
		public function set dropdownFactory(value:IFactory):void;
		/**
		 * Day of the week (0-6, where 0 is the first element
		 *  of the dayNames Array) to display in the first column
		 *  of the  DateChooser control.
		 *  Setting this property changes the order of the day columns.
		 */
		public function get firstDayOfWeek():Object;
		public function set firstDayOfWeek(value:Object):void;
		/**
		 * The format of the displayed date in the text field.
		 *  This property can contain any combination of "MM",
		 *  "DD", "YY", "YYYY",
		 *  delimiter, and punctuation characters.
		 */
		public function get formatString():String;
		public function set formatString(value:String):void;
		/**
		 * Function used to format the date displayed
		 *  in the text field of the DateField control.
		 *  If no function is specified, the default format is used.
		 */
		public function get labelFunction():Function;
		public function set labelFunction(value:Function):void;
		/**
		 * When a component is used as a drop-in item renderer or drop-in
		 *  item editor, Flex initializes the listData property
		 *  of the component with the appropriate data from the List control.
		 *  The component can then use the listData property
		 *  to initialize the data property of the drop-in
		 *  item renderer or drop-in item editor.
		 */
		public function get listData():BaseListData;
		public function set listData(value:BaseListData):void;
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
		 * Names of the months displayed at the top of the control.
		 *  The monthSymbol property is appended to the end of
		 *  the value specified by the monthNames property,
		 *  which is useful in languages such as Japanese.
		 */
		public function get monthNames():Array;
		public function set monthNames(value:Array):void;
		/**
		 * This property is appended to the end of the value specified
		 *  by the monthNames property to define the names
		 *  of the months displayed at the top of the control.
		 *  Some languages, such as Japanese, use an extra
		 *  symbol after the month name.
		 */
		public function get monthSymbol():String;
		public function set monthSymbol(value:String):void;
		/**
		 * Function used to parse the date entered as text
		 *  in the text field area of the DateField control and return a
		 *  Date object to the control.
		 *  If no function is specified, Flex uses
		 *  the default function.
		 *  If you set the parseFunction property, it should
		 *  typically perform the reverse of the function specified to
		 *  the labelFunction property.
		 */
		public function get parseFunction():Function;
		public function set parseFunction(value:Function):void;
		/**
		 * Range of dates between which dates are selectable.
		 *  For example, a date between 04-12-2006 and 04-12-2007
		 *  is selectable, but dates out of this range are disabled.
		 */
		public function get selectableRange():Object;
		public function set selectableRange(value:Object):void;
		/**
		 * Date as selected in the DateChooser control.
		 *  Accepts a Date object as a parameter. If the incoming Date
		 *  object has any time values, they are zeroed out.
		 */
		public function get selectedDate():Date;
		public function set selectedDate(value:Date):void;
		/**
		 * If true, specifies that today is highlighted
		 *  in the DateChooser control.
		 *  Setting this property immediately changes the appearance
		 *  of the DateChooser control.
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
		 *  displayed at the top of the control.
		 *  Some languages, such as Japanese,
		 *  add a symbol after the year.
		 */
		public function get yearSymbol():String;
		public function set yearSymbol(value:String):void;
		/**
		 * Constructor
		 */
		public function DateField();
		/**
		 * Closes the DateChooser control.
		 */
		public function close():void;
		/**
		 * Formats a Date into a String according to the outputFormat argument.
		 *  The outputFormat argument contains a pattern in which
		 *  the value String is formatted.
		 *  It can contain "M","D","Y",
		 *  and delimiter and punctuation characters.
		 *
		 * @param value             <Date> Date value to format.
		 * @param outputFormat      <String> String defining the date format.
		 * @return                  <String> The formatted date as a String.
		 */
		public static function dateToString(value:Date, outputFormat:String):String;
		/**
		 * Opens the DateChooser control.
		 */
		public function open():void;
		/**
		 * Parses a String object that contains a date, and returns a Date
		 *  object corresponding to the String.
		 *  The inputFormat argument contains the pattern
		 *  in which the valueString String is formatted.
		 *  It can contain "M","D","Y",
		 *  and delimiter and punctuation characters.
		 *  The function does not check for the validity of the Date object.
		 *  If the value of the date, month, or year is NaN, this method returns null.
		 *
		 * @param valueString       <String> Date value to format.
		 * @param inputFormat       <String> String defining the date format.
		 * @return                  <Date> The formatted date as a Date object.
		 */
		public static function stringToDate(valueString:String, inputFormat:String):Date;
	}
}
