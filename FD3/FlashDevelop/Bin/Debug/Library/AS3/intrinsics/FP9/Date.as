package 
{
	/// The Date class represents date and time information.
	public class Date
	{
		/// The full year (a four-digit number, such as 2000) of a Date object according to local time.
		public var fullYear:Number;

		/// The month (0 for January, 1 for February, and so on) portion of a  Date object according to local time.
		public var month:Number;

		/// The day of the month (an integer from 1 to 31) specified by a Date object according to local time.
		public var date:Number;

		/// The hour (an integer from 0 to 23) of the day portion of a Date object according to local time.
		public var hours:Number;

		/// The minutes (an integer from 0 to 59) portion of a Date object according to local time.
		public var minutes:Number;

		/// The seconds (an integer from 0 to 59) portion of a Date object according to local time.
		public var seconds:Number;

		/// The milliseconds (an integer from 0 to 999) portion of a Date object according to local time.
		public var milliseconds:Number;

		/// The four-digit year of a Date object according to universal time (UTC).
		public var fullYearUTC:Number;

		/// The month (0 [January] to 11 [December]) portion of a Date object according to universal time (UTC).
		public var monthUTC:Number;

		/// The day of the month (an integer from 1 to 31) of a Date object according to universal time (UTC).
		public var dateUTC:Number;

		/// The hour (an integer from 0 to 23) of the day of a Date object according to universal time (UTC).
		public var hoursUTC:Number;

		/// The minutes (an integer from 0 to 59) portion of a Date object according to universal time (UTC).
		public var minutesUTC:Number;

		/// The seconds (an integer from 0 to 59) portion of a Date object according to universal time (UTC).
		public var secondsUTC:Number;

		/// The milliseconds (an integer from 0 to 999) portion of a Date object according to universal time (UTC).
		public var millisecondsUTC:Number;

		/// The number of milliseconds since midnight January 1, 1970, universal time, for a Date object.
		public var time:Number;

		/// The difference, in minutes, between universal time (UTC) and the computer's local time.
		public var timezoneOffset:Number;

		/// The day of the week (0 for Sunday, 1 for Monday, and so on) specified by this Date according to local time.
		public var day:Number;

		/// The day of the week (0 for Sunday, 1 for Monday, and so on) of this Date  according to universal time (UTC).
		public var dayUTC:Number;

		/// Constructs a new Date object that holds the specified date and time.
		public function Date(yearOrTimevalue:Object, month:Number, date:Number=1, hour:Number=0, minute:Number=0, second:Number=0, millisecond:Number=0);

		/// Returns the number of milliseconds between midnight on January 1, 1970, universal time, and the time specified in the parameters.
		public static function UTC(year:Number, month:Number, date:Number=1, hour:Number=0, minute:Number=0, second:Number=0, millisecond:Number=0):Number;

		/// Returns the day of the month (an integer from 1 to 31) specified by a Date object according to local time.
		public function getDate():Number;

		/// Returns the day of the week (0 for Sunday, 1 for Monday, and so on) specified by this Date according to local time.
		public function getDay():Number;

		/// Returns the full year (a four-digit number, such as 2000) of a Date object according to local time.
		public function getFullYear():Number;

		/// Returns the hour (an integer from 0 to 23) of the day portion of a Date object according to local time.
		public function getHours():Number;

		/// Returns the milliseconds (an integer from 0 to 999) portion of a Date object according to local time.
		public function getMilliseconds():Number;

		/// Returns the minutes (an integer from 0 to 59) portion of a Date object according to local time.
		public function getMinutes():Number;

		/// Returns the month (0 for January, 1 for February, and so on) portion of this  Date according to local time.
		public function getMonth():Number;

		/// Returns the seconds (an integer from 0 to 59) portion of a Date object according to local time.
		public function getSeconds():Number;

		/// Returns the number of milliseconds since midnight January 1, 1970, universal time, for a Date object.
		public function getTime():Number;

		/// Returns the difference, in minutes, between universal time (UTC) and the computer's local time.
		public function getTimezoneOffset():Number;

		/// Returns the day of the month (an integer from 1 to 31) of a Date object, according to universal time (UTC).
		public function getUTCDate():Number;

		/// Returns the day of the week (0 for Sunday, 1 for Monday, and so on) of this Date  according to universal time (UTC).
		public function getUTCDay():Number;

		/// Returns the four-digit year of a Date object according to universal time (UTC).
		public function getUTCFullYear():Number;

		/// Returns the hour (an integer from 0 to 23) of the day of a Date object according to universal time (UTC).
		public function getUTCHours():Number;

		/// Returns the milliseconds (an integer from 0 to 999) portion of a Date object according to universal time (UTC).
		public function getUTCMilliseconds():Number;

		/// Returns the minutes (an integer from 0 to 59) portion of a Date object according to universal time (UTC).
		public function getUTCMinutes():Number;

		/// Returns the month (0 [January] to 11 [December]) portion of a Date object according to universal time (UTC).
		public function getUTCMonth():Number;

		/// Returns the seconds (an integer from 0 to 59) portion of a Date object according to universal time (UTC).
		public function getUTCSeconds():Number;

		/// Converts a string representing a date into a number equaling the number of milliseconds elapsed since January 1, 1970, UTC.
		public static function parse(date:String):Number;

		/// Sets the day of the month, according to local time, and returns the new time in milliseconds.
		public function setDate(day:Number):Number;

		/// Sets the year, according to local time, and returns the new time in milliseconds.
		public function setFullYear(year:Number, month:Number, day:Number):Number;

		/// Sets the hour, according to local time, and returns the new time in milliseconds.
		public function setHours(hour:Number, minute:Number, second:Number, millisecond:Number):Number;

		/// Sets the milliseconds, according to local time, and returns the new time in milliseconds.
		public function setMilliseconds(millisecond:Number):Number;

		/// Sets the minutes, according to local time, and returns the new time in milliseconds.
		public function setMinutes(minute:Number, second:Number, millisecond:Number):Number;

		/// Sets the month and optionally the day of the month, according to local time, and returns the new time in milliseconds.
		public function setMonth(month:Number, day:Number):Number;

		/// Sets the seconds, according to local time, and returns the new time in milliseconds.
		public function setSeconds(second:Number, millisecond:Number):Number;

		/// Sets the date in milliseconds since midnight on January 1, 1970, and returns the new time in milliseconds.
		public function setTime(millisecond:Number):Number;

		/// Sets the day of the month, in universal time (UTC), and returns the new time in milliseconds.
		public function setUTCDate(day:Number):Number;

		/// Sets the year, in universal time (UTC), and returns the new time in milliseconds.
		public function setUTCFullYear(year:Number, month:Number, day:Number):Number;

		/// Sets the hour, in universal time (UTC), and returns the new time in milliseconds.
		public function setUTCHours(hour:Number, minute:Number, second:Number, millisecond:Number):Number;

		/// Sets the milliseconds, in universal time (UTC), and returns the new time in milliseconds.
		public function setUTCMilliseconds(millisecond:Number):Number;

		/// Sets the minutes, in universal time (UTC), and returns the new time in milliseconds.
		public function setUTCMinutes(minute:Number, second:Number, millisecond:Number):Number;

		/// Sets the month, and optionally the day, in universal time(UTC) and returns the new time in milliseconds.
		public function setUTCMonth(month:Number, day:Number):Number;

		/// Sets the seconds, and optionally the milliseconds, in universal time (UTC) and returns the new time in milliseconds.
		public function setUTCSeconds(second:Number, millisecond:Number):Number;

		/// Returns a string representation of the day and date only, and does not include the time or timezone.
		public function toDateString():String;

		/// Returns a String representation of the time and timezone only, and does not include the day and date.
		public function toTimeString():String;

		/// Returns a String representation of the day, date, time, given in local time.
		public function toLocaleString():String;

		/// Returns a String representation of the day and date only, and does not include the time or timezone.
		public function toLocaleDateString():String;

		/// Returns a String representation of the time only, and does not include the day, date, year, or timezone.
		public function toLocaleTimeString():String;

		/// Returns a String representation of the day, date, and time in universal time (UTC).
		public function toUTCString():String;

		/// Returns a String representation of the day, date, time, and timezone.
		public function toString():String;

		/// Returns the number of milliseconds since midnight January 1, 1970, universal time, for a Date object.
		public function valueOf():Number;

	}

}

