/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.logging {
	public class Log {
		/**
		 * Allows the specified target to begin receiving notification of log
		 *  events.
		 *
		 * @param target            <ILoggingTarget> specific target that should capture log events.
		 */
		public static function addTarget(target:ILoggingTarget):void;
		/**
		 * This method removes all of the current loggers from the cache.
		 *  Subsquent calls to the getLogger() method return new instances
		 *  of loggers rather than any previous instances with the same category.
		 *  This method is intended for use in debugging only.
		 */
		public static function flush():void;
		/**
		 * Returns the logger associated with the specified category.
		 *  If the category given doesn't exist a new instance of a logger will be
		 *  returned and associated with that category.
		 *  Categories must be at least one character in length and may not contain
		 *  any blanks or any of the following characters:
		 *  []~$^&\/(){}<>+=`!#%?,:;'"@
		 *  This method will throw an InvalidCategoryError if the
		 *  category specified is malformed.
		 *
		 * @param category          <String> The category of the logger that should be returned.
		 * @return                  <ILogger> An instance of a logger object for the specified name.
		 *                            If the name doesn't exist, a new instance with the specified
		 *                            name is returned.
		 */
		public static function getLogger(category:String):ILogger;
		/**
		 * This method checks the specified string value for illegal characters.
		 *
		 * @param value             <String> The String to check for illegal characters.
		 *                            The following characters are not valid:
		 *                            []~$^&\/(){}<>+=`!#%?,:;'"@
		 * @return                  <Boolean> true if there are any illegal characters found,
		 *                            false otherwise
		 */
		public static function hasIllegalCharacters(value:String):Boolean;
		/**
		 * Indicates whether a debug level log event will be processed by a
		 *  log target.
		 *
		 * @return                  <Boolean> true if a debug level log event will be logged; otherwise false.
		 */
		public static function isDebug():Boolean;
		/**
		 * Indicates whether an error level log event will be processed by a
		 *  log target.
		 *
		 * @return                  <Boolean> true if an error level log event will be logged; otherwise false.
		 */
		public static function isError():Boolean;
		/**
		 * Indicates whether a fatal level log event will be processed by a
		 *  log target.
		 *
		 * @return                  <Boolean> true if a fatal level log event will be logged; otherwise false.
		 */
		public static function isFatal():Boolean;
		/**
		 * Indicates whether an info level log event will be processed by a
		 *  log target.
		 *
		 * @return                  <Boolean> true if an info level log event will be logged; otherwise false.
		 */
		public static function isInfo():Boolean;
		/**
		 * Indicates whether a warn level log event will be processed by a
		 *  log target.
		 *
		 * @return                  <Boolean> true if a warn level log event will be logged; otherwise false.
		 */
		public static function isWarn():Boolean;
		/**
		 * Stops the specified target from receiving notification of log
		 *  events.
		 *
		 * @param target            <ILoggingTarget> specific target that should capture log events.
		 */
		public static function removeTarget(target:ILoggingTarget):void;
	}
}
