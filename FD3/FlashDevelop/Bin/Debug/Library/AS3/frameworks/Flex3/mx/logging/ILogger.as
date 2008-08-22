/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.logging {
	import flash.events.IEventDispatcher;
	public interface ILogger extends IEventDispatcher {
		/**
		 * The category value for the logger.
		 */
		public function get category():String;
		/**
		 * Logs the specified data using the LogEventLevel.DEBUG
		 *  level.
		 *  LogEventLevel.DEBUG designates informational level
		 *  messages that are fine grained and most helpful when debugging
		 *  an application.
		 *
		 * @param message           <String> The information to log.
		 *                            This string can contain special marker characters of the form {x},
		 *                            where x is a zero based index that will be replaced with
		 *                            the additional parameters found at that index if specified.
		 */
		public function debug(message:String, ... rest):void;
		/**
		 * Logs the specified data using the LogEventLevel.ERROR
		 *  level.
		 *  LogEventLevel.ERROR designates error events
		 *  that might still allow the application to continue running.
		 *
		 * @param message           <String> The information to log.
		 *                            This String can contain special marker characters of the form {x},
		 *                            where x is a zero based index that will be replaced with
		 *                            the additional parameters found at that index if specified.
		 */
		public function error(message:String, ... rest):void;
		/**
		 * Logs the specified data using the LogEventLevel.FATAL
		 *  level.
		 *  LogEventLevel.FATAL designates events that are very
		 *  harmful and will eventually lead to application failure
		 *
		 * @param message           <String> The information to log.
		 *                            This String can contain special marker characters of the form {x},
		 *                            where x is a zero based index that will be replaced with
		 *                            the additional parameters found at that index if specified.
		 */
		public function fatal(message:String, ... rest):void;
		/**
		 * Logs the specified data using the LogEvent.INFO level.
		 *  LogEventLevel.INFO designates informational messages that
		 *  highlight the progress of the application at coarse-grained level.
		 *
		 * @param message           <String> The information to log.
		 *                            This String can contain special marker characters of the form {x},
		 *                            where x is a zero based index that will be replaced with
		 *                            the additional parameters found at that index if specified.
		 */
		public function info(message:String, ... rest):void;
		/**
		 * Logs the specified data at the given level.
		 *
		 * @param level             <int> The level this information should be logged at.
		 *                            Valid values are:
		 *                            LogEventLevel.FATAL designates events that are very
		 *                            harmful and will eventually lead to application failure
		 *                            LogEventLevel.ERROR designates error events
		 *                            that might still allow the application to continue running.
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
		 * @param message           <String> The information to log.
		 *                            This String can contain special marker characters of the form {x},
		 *                            where x is a zero based index that will be replaced with
		 *                            the additional parameters found at that index if specified.
		 */
		public function log(level:int, message:String, ... rest):void;
		/**
		 * Logs the specified data using the LogEventLevel.WARN level.
		 *  LogEventLevel.WARN designates events that could be harmful
		 *  to the application operation.
		 *
		 * @param message           <String> The information to log.
		 *                            This String can contain special marker characters of the form {x},
		 *                            where x is a zero based index that will be replaced with
		 *                            the additional parameters found at that index if specified.
		 */
		public function warn(message:String, ... rest):void;
	}
}
