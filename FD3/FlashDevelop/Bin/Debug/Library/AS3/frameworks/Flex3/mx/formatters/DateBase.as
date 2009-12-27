package mx.formatters
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

include "../core/Version.as"
	/**
	 *  The DateBase class contains the localized string information
 *  used by the mx.formatters.DateFormatter class and the parsing function
 *  that renders the pattern.
 *  This is a helper class for the DateFormatter class that is not usually
 *  used independently.
 *
 *  @see mx.formatters.DateFormatter
	 */
	public class DateBase
	{
		/**
		 *  @private
		 */
		private static var initialized : Boolean;
		/**
		 *  @private
	 *  Storage for the resourceManager getter.
	 *  This gets initialized on first access,
	 *  not at static initialization time, in order to ensure
	 *  that the Singleton registry has already been initialized.
		 */
		private static var _resourceManager : IResourceManager;
		/**
		 *  @private
	 *  Storage for the dayNamesLong property.
		 */
		private static var _dayNamesLong : Array;
		/**
		 *  @private
		 */
		private static var dayNamesLongOverride : Array;
		/**
		 *  @private
	 *  Storage for the dayNamesShort property.
		 */
		private static var _dayNamesShort : Array;
		/**
		 *  @private
		 */
		private static var dayNamesShortOverride : Array;
		/**
		 *  @private
	 *  Storage for the monthNamesLong property.
		 */
		private static var _monthNamesLong : Array;
		/**
		 *  @private
		 */
		private static var monthNamesLongOverride : Array;
		/**
		 *  @private
	 *  Storage for the monthNamesShort property.
		 */
		private static var _monthNamesShort : Array;
		/**
		 *  @private
		 */
		private static var monthNamesShortOverride : Array;
		/**
		 *  @private
	 *  Storage for the timeOfDay property.
		 */
		private static var _timeOfDay : Array;
		/**
		 *  @private
		 */
		private static var timeOfDayOverride : Array;

		/**
		 *  @private
     *  A reference to the object which manages
     *  all of the application's localized resources.
     *  This is a singleton instance which implements
     *  the IResourceManager interface.
		 */
		private static function get resourceManager () : IResourceManager;

		/**
		 *  Long format of day names.
	 * 
	 *  @default [Sunday", "Monday", "Tuesday", "Wednesday",
	 *  "Thursday", "Friday", "Saturday"]
		 */
		public static function get dayNamesLong () : Array;
		/**
		 *  @private
		 */
		public static function set dayNamesLong (value:/*String*/Array) : void;

		/**
		 *  Short format of day names.
	 * 
	 *  @default ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
		 */
		public static function get dayNamesShort () : Array;
		/**
		 *  @private
		 */
		public static function set dayNamesShort (value:/*String*/Array) : void;

		/**
		 *  @private
		 */
		static function get defaultStringKey () : Array;

		/**
		 *  Long format of month names.
	 *
	 *  @default ["January", "February", "March", "April", "May", "June", 
	 *  "July", "August", "September", "October", "November", "December"].
		 */
		public static function get monthNamesLong () : Array;
		/**
		 *  @private
		 */
		public static function set monthNamesLong (value:/*String*/Array) : void;

		/**
		 *  Short format of month names.
	 *
	 *  @default ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
	 *  "Jul", "Aug", "Sep", "Oct","Nov", "Dec"]
		 */
		public static function get monthNamesShort () : Array;
		/**
		 *  @private
		 */
		public static function set monthNamesShort (value:/*String*/Array) : void;

		/**
		 *  Time of day names.
	 * 
	 *  @default ["AM", "PM"]
		 */
		public static function get timeOfDay () : Array;
		/**
		 *  @private
		 */
		public static function set timeOfDay (value:Array) : void;

		/**
		 *  @private
		 */
		private static function initialize () : void;

		/**
		 *  @private
		 */
		private static function static_resourcesChanged () : void;

		/**
		 *  @private
	 *  Parses token objects and renders the elements of the formatted String.
	 *  For details about token objects, see StringFormatter.
	 *
	 *  @param date Date object.
	 *
	 *  @param tokenInfo Array object that contains token object descriptions.
	 *
	 *  @return Formatted string.
		 */
		static function extractTokenDate (date:Date, tokenInfo:Object) : String;

		/**
		 *  @private
	 *  Makes a given length of digits longer by padding with zeroes.
	 *
	 *  @param value Value to pad.
	 *
	 *  @param key Length of the string to pad.
	 *
	 *  @return Formatted string.
		 */
		private static function setValue (value:Object, key:int) : String;

		/**
		 *  @private
		 */
		private static function static_resourceManager_changeHandler (event:Event) : void;
	}
}
