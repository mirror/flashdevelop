/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.logging {
	public interface ILoggingTarget {
		/**
		 * In addition to the level setting, filters are used to
		 *  provide a psuedo-hierarchical mapping for processing only those events
		 *  for a given category.
		 */
		public function get filters():Array;
		public function set filters(value:Array):void;
		/**
		 * Provides access to the level this target is currently set at.
		 *  Value values are:
		 *  LogEventLevel.FATAL designates events that are very
		 *  harmful and will eventually lead to application failure
		 *  LogEventLevel.ERROR designates error events that might
		 *  still allow the application to continue running.
		 *  LogEventLevel.WARN designates events that could be
		 *  harmful to the application operation
		 *  LogEventLevel.INFO designates informational messages
		 *  that highlight the progress of the application at
		 *  coarse-grained level.
		 *  LogEventLevel.DEBUG designates informational
		 *  level messages that are fine grained and most helpful when
		 *  debugging an application.
		 *  LogEventLevel.ALL intended to force a target to
		 *  process all messages.
		 */
		public function get level():int;
		public function set level(value:int):void;
		/**
		 * Sets up this target with the specified logger.
		 *  This allows this target to receive log events from the specified logger.
		 *
		 * @param logger            <ILogger> The ILogger that this target listens to.
		 */
		public function addLogger(logger:ILogger):void;
		/**
		 * Stops this target from receiving events from the specified logger.
		 *
		 * @param logger            <ILogger> The ILogger that this target ignores.
		 */
		public function removeLogger(logger:ILogger):void;
	}
}
