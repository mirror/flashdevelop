/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.logging {
	import flash.events.Event;
	public class LogEvent extends Event {
		/**
		 * Provides access to the level for this log event.
		 *  Valid values are:
		 *  LogEventLogEventLevel.INFO designates informational messages
		 *  that highlight the progress of the application at
		 *  coarse-grained level.
		 *  LogEventLevel.DEBUG designates informational
		 *  level messages that are fine grained and most helpful when
		 *  debugging an application.
		 *  LogEventLevel.ERROR designates error events that might
		 *  still allow the application to continue running.
		 *  LogEventLevel.WARN designates events that could be
		 *  harmful to the application operation.
		 *  LogEventLevel.FATAL designates events that are very
		 *  harmful and will eventually lead to application failure.
		 */
		public var level:int;
		/**
		 * Provides access to the message that was logged.
		 */
		public var message:String;
		/**
		 * Constructor.
		 *
		 * @param message           <String (default = "")> String containing the log data.
		 * @param level             <int (default = 0)> The level for this log event.
		 *                            Valid values are:
		 *                            LogEventLevel.FATAL designates events that are very
		 *                            harmful and will eventually lead to application failure
		 *                            LogEventLevel.ERROR designates error events that might
		 *                            still allow the application to continue running.
		 *                            LogEventLevel.WARN designates events that could be
		 *                            harmful to the application operation
		 *                            LogEventLevel.INFO designates informational messages
		 *                            that highlight the progress of the application at
		 *                            coarse-grained level.
		 *                            LogEventLevel.DEBUG designates informational
		 *                            level messages that are fine grained and most helpful when
		 *                            debugging an application.
		 *                            LogEventLevel.ALL intended to force a target to
		 *                            process all messages.
		 */
		public function LogEvent(message:String = "", level:int = 0);
		/**
		 * Returns a string value representing the level specified.
		 *
		 * @param value             <uint> level a string is desired for.
		 * @return                  <String> The level specified in English.
		 */
		public static function getLevelString(value:uint):String;
		/**
		 * Event type constant; identifies a logging event.
		 */
		public static const LOG:String = "log";
	}
}
