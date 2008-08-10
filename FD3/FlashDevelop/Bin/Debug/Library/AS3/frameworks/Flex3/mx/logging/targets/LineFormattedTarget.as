/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.logging.targets {
	import mx.logging.AbstractTarget;
	import mx.logging.LogEvent;
	public class LineFormattedTarget extends AbstractTarget {
		/**
		 * The separator string to use between fields (the default is " ")
		 */
		public var fieldSeparator:String = " ";
		/**
		 * Indicates if the category for this target should added to the trace.
		 */
		public var includeCategory:Boolean;
		/**
		 * Indicates if the date should be added to the trace.
		 */
		public var includeDate:Boolean;
		/**
		 * Indicates if the level for the event should added to the trace.
		 */
		public var includeLevel:Boolean;
		/**
		 * Indicates if the time should be added to the trace.
		 */
		public var includeTime:Boolean;
		/**
		 * Constructor.
		 */
		public function LineFormattedTarget();
		/**
		 * This method handles a LogEvent from an associated logger.
		 *  A target uses this method to translate the event into the appropriate
		 *  format for transmission, storage, or display.
		 *  This method is called only if the event's level is in range of the
		 *  target's level.
		 *
		 * @param event             <LogEvent> The LogEvent handled by this method.
		 */
		public override function logEvent(event:LogEvent):void;
	}
}
