/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	public class OLAPTrace {
		/**
		 * The current trace level, which determines the amount of trace information
		 *  written to the log file, TRACE_LEVEL_1 writes the least amount of
		 *  information to the log file, and TRACE_LEVEL_3 writes the most.
		 */
		public static var traceLevel:int = 1;
		/**
		 * Set to true to enable trace output.
		 */
		public static var traceOn:Boolean = true;
		/**
		 * Writes trace information to the log file
		 *
		 * @param msg               <String> The trace message.
		 * @param level             <int (default = 1)> The trace level of the message.
		 *                            Only trace messages with a level argument less than traceLevel
		 *                            are sent to the log file.
		 */
		public static function traceMsg(msg:String, level:int = 1):void;
		/**
		 * Specifies to write minimal trace information to the log file.
		 */
		public static const TRACE_LEVEL_1:int = 1;
		/**
		 * Specifies to write more trace information to the log file than TRACE_LEVEL_1.
		 */
		public static const TRACE_LEVEL_2:int = 2;
		/**
		 * Specifies to write the most trace information to the log file.
		 */
		public static const TRACE_LEVEL_3:int = 3;
	}
}
