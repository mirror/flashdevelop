/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public final dynamic  class Date {
		/**
		 * The day of the month (an integer from 1 to 31) specified by a Date object
		 *  according to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 */
		AS3 function get date():Number;
		AS3 function set date(value:Number):void;
		/**
		 * The day of the month (an integer from 1 to 31) of a Date object
		 *  according to universal time (UTC).
		 */
		AS3 function get dateUTC():Number;
		AS3 function set dateUTC(value:Number):void;
		/**
		 * The day of the week (0 for Sunday, 1 for Monday, and so on) specified by this
		 *  Date according to local time. Local time is determined by the operating
		 *  system on which Flash Player is running.
		 */
		AS3 function get day():Number;
		/**
		 * The day of the week (0 for Sunday, 1 for Monday, and so on) of this Date
		 *  according to universal time (UTC).
		 */
		AS3 function get dayUTC():Number;
		/**
		 * The full year (a four-digit number, such as 2000) of a Date object
		 *  according to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 */
		AS3 function get fullYear():Number;
		AS3 function set fullYear(value:Number):void;
		/**
		 * The four-digit year of a Date object according to universal time (UTC).
		 */
		AS3 function get fullYearUTC():Number;
		AS3 function set fullYearUTC(value:Number):void;
		/**
		 * The hour (an integer from 0 to 23) of the day portion of a Date object
		 *  according to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 */
		AS3 function get hours():Number;
		AS3 function set hours(value:Number):void;
		/**
		 * The hour (an integer from 0 to 23) of the day of a Date object
		 *  according to universal time (UTC).
		 */
		AS3 function get hoursUTC():Number;
		AS3 function set hoursUTC(value:Number):void;
		/**
		 * The milliseconds (an integer from 0 to 999) portion of a Date object
		 *  according to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 */
		AS3 function get milliseconds():Number;
		AS3 function set milliseconds(value:Number):void;
		/**
		 * The milliseconds (an integer from 0 to 999) portion of a Date object
		 *  according to universal time (UTC).
		 */
		AS3 function get millisecondsUTC():Number;
		AS3 function set millisecondsUTC(value:Number):void;
		/**
		 * The minutes (an integer from 0 to 59) portion of a Date object
		 *  according to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 */
		AS3 function get minutes():Number;
		AS3 function set minutes(value:Number):void;
		/**
		 * The minutes (an integer from 0 to 59) portion of a Date object
		 *  according to universal time (UTC).
		 */
		AS3 function get minutesUTC():Number;
		AS3 function set minutesUTC(value:Number):void;
		/**
		 * The month (0 for January, 1 for February, and so on) portion of a
		 *  Date object according to local time. Local time is determined by the operating system
		 *  on which Flash Player is running.
		 */
		AS3 function get month():Number;
		AS3 function set month(value:Number):void;
		/**
		 * The month (0 [January] to 11 [December]) portion of a Date object
		 *  according to universal time (UTC).
		 */
		AS3 function get monthUTC():Number;
		AS3 function set monthUTC(value:Number):void;
		/**
		 * The seconds (an integer from 0 to 59) portion of a Date object
		 *  according to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 */
		AS3 function get seconds():Number;
		AS3 function set seconds(value:Number):void;
		/**
		 * The seconds (an integer from 0 to 59) portion of a Date object
		 *  according to universal time (UTC).
		 */
		AS3 function get secondsUTC():Number;
		AS3 function set secondsUTC(value:Number):void;
		/**
		 * The number of milliseconds since midnight January 1, 1970, universal time,
		 *  for a Date object. Use this method to represent a specific instant in time
		 *  when comparing two or more Date objects.
		 */
		AS3 function get time():Number;
		AS3 function set time(value:Number):void;
		/**
		 * The difference, in minutes, between universal time (UTC) and the computer's local time.
		 *  Specifically, this value is the number of minutes you need to add to the computer's local
		 *  time to equal UTC. If your computer's time is set later than UTC, the value will be negative.
		 */
		AS3 function get timezoneOffset():Number;
		/**
		 * Constructs a new Date object that holds the specified date and time.
		 *
		 * @param yearOrTimevalue   <Object> If other parameters are specified, this number represents a
		 *                            year (such as 1965); otherwise, it represents a time value. If the number represents a year, a
		 *                            value of 0 to 99 indicates 1900 through 1999; otherwise all four digits of the year must be
		 *                            specified. If the number represents a time value (no other parameters are specified), it is the
		 *                            number of milliseconds before or after 0:00:00 GMT January 1, 1970; a negative values represents
		 *                            a time before 0:00:00 GMT January 1, 1970, and a positive value represents a time after.
		 * @param month             <Number> An integer from 0 (January) to 11 (December).
		 * @param date              <Number (default = 1)> An integer from 1 to 31.
		 * @param hour              <Number (default = 0)> An integer from 0 (midnight) to 23 (11 p.m.).
		 * @param minute            <Number (default = 0)> An integer from 0 to 59.
		 * @param second            <Number (default = 0)> An integer from 0 to 59.
		 * @param millisecond       <Number (default = 0)> An integer from 0 to 999 of milliseconds.
		 */
		public function Date(yearOrTimevalue:Object, month:Number, date:Number = 1, hour:Number = 0, minute:Number = 0, second:Number = 0, millisecond:Number = 0);
		/**
		 * Returns the day of the month (an integer from 1 to 31) specified by a Date object
		 *  according to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 *
		 * @return                  <Number> The day of the month (1 - 31) a Date object represents.
		 */
		AS3 function getDate():Number;
		/**
		 * Returns the day of the week (0 for Sunday, 1 for Monday, and so on) specified by this
		 *  Date according to local time. Local time is determined by the operating
		 *  system on which Flash Player is running.
		 *
		 * @return                  <Number> A numeric version of the day of the week (0 - 6) a Date object
		 *                            represents.
		 */
		AS3 function getDay():Number;
		/**
		 * Returns the full year (a four-digit number, such as 2000) of a Date object
		 *  according to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 *
		 * @return                  <Number> The full year a Date object represents.
		 */
		AS3 function getFullYear():Number;
		/**
		 * Returns the hour (an integer from 0 to 23) of the day portion of a Date object
		 *  according to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 *
		 * @return                  <Number> The hour (0 - 23) of the day a Date object represents.
		 */
		AS3 function getHours():Number;
		/**
		 * Returns the milliseconds (an integer from 0 to 999) portion of a Date object
		 *  according to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 *
		 * @return                  <Number> The milliseconds portion of a Date object.
		 */
		AS3 function getMilliseconds():Number;
		/**
		 * Returns the minutes (an integer from 0 to 59) portion of a Date object
		 *  according to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 *
		 * @return                  <Number> The minutes portion of a Date object.
		 */
		AS3 function getMinutes():Number;
		/**
		 * Returns the month (0 for January, 1 for February, and so on) portion of this
		 *  Date according to local time. Local time is determined by the operating system
		 *  on which Flash Player is running.
		 *
		 * @return                  <Number> The month (0 - 11) portion of a Date object.
		 */
		AS3 function getMonth():Number;
		/**
		 * Returns the seconds (an integer from 0 to 59) portion of a Date object
		 *  according to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 *
		 * @return                  <Number> The seconds (0 to 59) portion of a Date object.
		 */
		AS3 function getSeconds():Number;
		/**
		 * Returns the number of milliseconds since midnight January 1, 1970, universal time,
		 *  for a Date object. Use this method to represent a specific instant in time
		 *  when comparing two or more Date objects.
		 *
		 * @return                  <Number> The number of milliseconds since Jan 1, 1970 that a Date object represents.
		 */
		AS3 function getTime():Number;
		/**
		 * Returns the difference, in minutes, between universal
		 *  time (UTC) and the computer's local time.
		 *
		 * @return                  <Number> The minutes you need to add to the computer's local time value to equal UTC. If
		 *                            your computer's time is set later than UTC, the return value will be negative.
		 */
		AS3 function getTimezoneOffset():Number;
		/**
		 * Returns the day of the month (an integer from 1 to 31) of a Date object,
		 *  according to universal time (UTC).
		 *
		 * @return                  <Number> The UTC day of the month (1 to 31) that a Date object represents.
		 */
		AS3 function getUTCDate():Number;
		/**
		 * Returns the day of the week (0 for Sunday, 1 for Monday, and so on) of this Date
		 *  according to universal time (UTC).
		 *
		 * @return                  <Number> The UTC day of the week (0 to 6) that a Date object represents.
		 */
		AS3 function getUTCDay():Number;
		/**
		 * Returns the four-digit year of a Date object according to universal time (UTC).
		 *
		 * @return                  <Number> The UTC four-digit year a Date object represents.
		 */
		AS3 function getUTCFullYear():Number;
		/**
		 * Returns the hour (an integer from 0 to 23) of the day of a Date object
		 *  according to universal time (UTC).
		 *
		 * @return                  <Number> The UTC hour of the day (0 to 23) a Date object represents.
		 */
		AS3 function getUTCHours():Number;
		/**
		 * Returns the milliseconds (an integer from 0 to 999) portion of a Date object
		 *  according to universal time (UTC).
		 *
		 * @return                  <Number> The UTC milliseconds portion of a Date object.
		 */
		AS3 function getUTCMilliseconds():Number;
		/**
		 * Returns the minutes (an integer from 0 to 59) portion of a Date object
		 *  according to universal time (UTC).
		 *
		 * @return                  <Number> The UTC minutes portion of a Date object.
		 */
		AS3 function getUTCMinutes():Number;
		/**
		 * Returns the month (0 [January] to 11 [December]) portion of a Date object
		 *  according to universal time (UTC).
		 *
		 * @return                  <Number> The UTC month portion of a Date object.
		 */
		AS3 function getUTCMonth():Number;
		/**
		 * Returns the seconds (an integer from 0 to 59) portion of a Date object
		 *  according to universal time (UTC).
		 *
		 * @return                  <Number> The UTC seconds portion of a Date object.
		 */
		AS3 function getUTCSeconds():Number;
		/**
		 * Converts a string representing a date into a number equaling the number of milliseconds
		 *  elapsed since January 1, 1970, UTC.
		 *
		 * @param date              <String> A string representation of a date, which conforms to the format for the output of
		 *                            Date.toString(). The date format for the output of Date.toString() is:
		 *                            Day Mon DD HH:MM:SS TZD YYYY
		 *                            For example:
		 *                            Wed Apr 12 15:30:17 GMT-0700 2006
		 *                            The Time Zone Designation (TZD) is always in the form GMT-HHMM or UTC-HHMM indicating the
		 *                            hour and minute offset relative to Greenwich Mean Time (GMT), which is now also called universal time (UTC).
		 *                            The year month and day terms can be separated by a forward slash (/) or by spaces, but never by a
		 *                            dash (-). Other supported formats include the following (you can include partial representations of these
		 *                            formats; that is, just the month, day, and year):
		 *                            MM/DD/YYYY HH:MM:SS TZD
		 *                            HH:MM:SS TZD Day Mon/DD/YYYY
		 *                            Mon DD YYYY HH:MM:SS TZD
		 *                            Day Mon DD HH:MM:SS TZD YYYY
		 *                            Day DD Mon HH:MM:SS TZD YYYY
		 *                            Mon/DD/YYYY HH:MM:SS TZD
		 *                            YYYY/MM/DD HH:MM:SS TZD
		 * @return                  <Number> A number representing the milliseconds elapsed since January 1, 1970, UTC.
		 */
		public static function parse(date:String):Number;
		/**
		 * Sets the day of the month, according to local time, and returns the new time in
		 *  milliseconds. Local time is determined by the operating system on which Flash Player
		 *  is running.
		 *
		 * @param day               <Number> An integer from 1 to 31.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setDate(day:Number):Number;
		/**
		 * Sets the year, according to local time, and returns the new time in milliseconds. If
		 *  the month and day parameters are specified,
		 *  they are set to local time. Local time is determined by the operating system on which
		 *  Flash Player is running.
		 *
		 * @param year              <Number> A four-digit number specifying a year. Two-digit numbers do not represent
		 *                            four-digit years; for example, 99 is not the year 1999, but the year 99.
		 * @param month             <Number> An integer from 0 (January) to 11 (December).
		 * @param day               <Number> A number from 1 to 31.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setFullYear(year:Number, month:Number, day:Number):Number;
		/**
		 * Sets the hour, according to local time, and returns the new time in milliseconds.
		 *  Local time is determined by the operating system on which Flash Player is running.
		 *
		 * @param hour              <Number> An integer from 0 (midnight) to 23 (11 p.m.).
		 * @param minute            <Number> An integer from 0 to 59.
		 * @param second            <Number> An integer from 0 to 59.
		 * @param millisecond       <Number> An integer from 0 to 999.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setHours(hour:Number, minute:Number, second:Number, millisecond:Number):Number;
		/**
		 * Sets the milliseconds, according to local time, and returns the new time in
		 *  milliseconds. Local time is determined by the operating system on which Flash Player
		 *  is running.
		 *
		 * @param millisecond       <Number> An integer from 0 to 999.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setMilliseconds(millisecond:Number):Number;
		/**
		 * Sets the minutes, according to local time, and returns the new time in milliseconds.
		 *  Local time is determined by the operating system on which Flash Player is running.
		 *
		 * @param minute            <Number> An integer from 0 to 59.
		 * @param second            <Number> An integer from 0 to 59.
		 * @param millisecond       <Number> An integer from 0 to 999.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setMinutes(minute:Number, second:Number, millisecond:Number):Number;
		/**
		 * Sets the month and optionally the day of the month, according to local time, and
		 *  returns the new time in milliseconds. Local time is determined by the operating
		 *  system on which Flash Player is running.
		 *
		 * @param month             <Number> An integer from 0 (January) to 11 (December).
		 * @param day               <Number> An integer from 1 to 31.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setMonth(month:Number, day:Number):Number;
		/**
		 * Sets the seconds, according to local time, and returns the new time in milliseconds.
		 *  Local time is determined by the operating system on which Flash Player is running.
		 *
		 * @param second            <Number> An integer from 0 to 59.
		 * @param millisecond       <Number> An integer from 0 to 999.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setSeconds(second:Number, millisecond:Number):Number;
		/**
		 * Sets the date in milliseconds since midnight on January 1, 1970, and returns the new
		 *  time in milliseconds.
		 *
		 * @param millisecond       <Number> An integer value where 0 is midnight on January 1, universal time (UTC).
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setTime(millisecond:Number):Number;
		/**
		 * Sets the day of the month, in universal time (UTC), and returns the new time in
		 *  milliseconds. Calling this method does not modify the other fields of a Date
		 *  object, but the Date.getUTCDay() and Date.getDay() methods can report
		 *  a new value if the day of the week changes as a result of calling this method.
		 *
		 * @param day               <Number> A number; an integer from 1 to 31.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setUTCDate(day:Number):Number;
		/**
		 * Sets the year, in universal time (UTC), and returns the new time in milliseconds.
		 *
		 * @param year              <Number> An integer that represents the year specified as a full four-digit year,
		 *                            such as 2000.
		 * @param month             <Number> An integer from 0 (January) to 11 (December).
		 * @param day               <Number> An integer from 1 to 31.
		 * @return                  <Number> An integer.
		 */
		AS3 function setUTCFullYear(year:Number, month:Number, day:Number):Number;
		/**
		 * Sets the hour, in universal time (UTC), and returns the new time in milliseconds.
		 *  Optionally, the minutes, seconds, and milliseconds can be specified.
		 *
		 * @param hour              <Number> An integer from 0 (midnight) to 23 (11 p.m.).
		 * @param minute            <Number> An integer from 0 to 59.
		 * @param second            <Number> An integer from 0 to 59.
		 * @param millisecond       <Number> An integer from 0 to 999.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setUTCHours(hour:Number, minute:Number, second:Number, millisecond:Number):Number;
		/**
		 * Sets the milliseconds, in universal time (UTC), and returns the new time in milliseconds.
		 *
		 * @param millisecond       <Number> An integer from 0 to 999.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setUTCMilliseconds(millisecond:Number):Number;
		/**
		 * Sets the minutes, in universal time (UTC), and returns the new time in milliseconds.
		 *  Optionally, you can specify the seconds and milliseconds.
		 *
		 * @param minute            <Number> An integer from 0 to 59.
		 * @param second            <Number> An integer from 0 to 59.
		 * @param millisecond       <Number> An integer from 0 to 999.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setUTCMinutes(minute:Number, second:Number, millisecond:Number):Number;
		/**
		 * Sets the month, and optionally the day, in universal time(UTC) and returns the new
		 *  time in milliseconds. Calling this method does not modify the other fields, but the
		 *  Date.getUTCDay() and Date.getDay() methods might report a new
		 *  value if the day of the week changes as a result of calling this method.
		 *
		 * @param month             <Number> An integer from 0 (January) to 11 (December).
		 * @param day               <Number> An integer from 1 to 31.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setUTCMonth(month:Number, day:Number):Number;
		/**
		 * Sets the seconds, and optionally the milliseconds, in universal time (UTC) and
		 *  returns the new time in milliseconds.
		 *
		 * @param second            <Number> An integer from 0 to 59.
		 * @param millisecond       <Number> An integer from 0 to 999.
		 * @return                  <Number> The new time, in milliseconds.
		 */
		AS3 function setUTCSeconds(second:Number, millisecond:Number):Number;
		/**
		 * Returns a string representation of the day and date only, and does not include the time or timezone.
		 *  Contrast with the following methods:
		 *  Date.toTimeString(), which returns only the time and timezone
		 *  Date.toString(), which returns not only the day and date, but also the time and timezone.
		 *
		 * @return                  <String> The string representation of day and date only.
		 */
		AS3 function toDateString():String;
		/**
		 * Returns a String representation of the day and date only, and does not include the time or timezone.
		 *  This method returns the same value as Date.toDateString.
		 *  Contrast with the following methods:
		 *  Date.toTimeString(), which returns only the time and timezone
		 *  Date.toString(), which returns not only the day and date, but also the
		 *  time and timezone.
		 *
		 * @return                  <String> The String representation of day and date only.
		 */
		AS3 function toLocaleDateString():String;
		/**
		 * Returns a String representation of the day, date, time, given in local time.
		 *  Contrast with the Date.toString() method, which returns the same information (plus the timezone)
		 *  with the year listed at the end of the string.
		 *
		 * @return                  <String> A string representation of a Date object in the local timezone.
		 */
		AS3 function toLocaleString():String;
		/**
		 * Returns a String representation of the time only, and does not include the day, date, year, or timezone.
		 *  Contrast with the Date.toTimeString() method, which returns the time and timezone.
		 *
		 * @return                  <String> The string representation of time and timezone only.
		 */
		AS3 function toLocaleTimeString():String;
		/**
		 * Returns a String representation of the day, date, time, and timezone.
		 *
		 * @return                  <String> The string representation of a Date object.
		 */
		AS3 function toString():String;
		/**
		 * Returns a String representation of the time and timezone only, and does not include the day and date.
		 *  Contrast with the Date.toDateString() method, which returns only the day and date.
		 *
		 * @return                  <String> The string representation of time and timezone only.
		 */
		AS3 function toTimeString():String;
		/**
		 * Returns a String representation of the day, date, and time in universal time (UTC).
		 *  For example, the date February 1, 2005 is returned as Tue Feb 1 00:00:00 2005 UTC.
		 *
		 * @return                  <String> The string representation of a Date object in UTC time.
		 */
		AS3 function toUTCString():String;
		/**
		 * Returns the number of milliseconds between midnight on January 1, 1970, universal time,
		 *  and the time specified in the parameters. This method uses universal time, whereas the
		 *  Date constructor uses local time.
		 *
		 * @param year              <Number> A four-digit integer that represents the year (for example, 2000).
		 * @param month             <Number> An integer from 0 (January) to 11 (December).
		 * @param date              <Number (default = 1)> An integer from 1 to 31.
		 * @param hour              <Number (default = 0)> An integer from 0 (midnight) to 23 (11 p.m.).
		 * @param minute            <Number (default = 0)> An integer from 0 to 59.
		 * @param second            <Number (default = 0)> An integer from 0 to 59.
		 * @param millisecond       <Number (default = 0)> An integer from 0 to 999.
		 * @return                  <Number> The number of milliseconds since January 1, 1970 and the specified date and time.
		 */
		public static function UTC(year:Number, month:Number, date:Number = 1, hour:Number = 0, minute:Number = 0, second:Number = 0, millisecond:Number = 0):Number;
		/**
		 * Returns the number of milliseconds since midnight January 1, 1970, universal time,
		 *  for a Date object.
		 *
		 * @return                  <Number> The number of milliseconds since January 1, 1970 that a Date object represents.
		 */
		AS3 function valueOf():Number;
	}
}
