package mx.logging.targets
{
	import mx.core.mx_internal;
	import mx.logging.AbstractTarget;
	import mx.logging.ILogger;
	import mx.logging.LogEvent;

	/**
	 *  All logger target implementations that have a formatted line style output *  should extend this class. *  It provides default behavior for including date, time, category, and level *  within the output. *
	 */
	public class LineFormattedTarget extends AbstractTarget
	{
		/**
		 *  The separator string to use between fields (the default is " ")
		 */
		public var fieldSeparator : String;
		/**
		 *  Indicates if the category for this target should added to the trace.
		 */
		public var includeCategory : Boolean;
		/**
		 *  Indicates if the date should be added to the trace.
		 */
		public var includeDate : Boolean;
		/**
		 *  Indicates if the level for the event should added to the trace.
		 */
		public var includeLevel : Boolean;
		/**
		 *  Indicates if the time should be added to the trace.
		 */
		public var includeTime : Boolean;

		/**
		 *  Constructor.     *     *  <p>Constructs an instance of a logger target that will format     *  the message data on a single line.</p>
		 */
		public function LineFormattedTarget ();
		/**
		 *  This method handles a <code>LogEvent</code> from an associated logger.     *  A target uses this method to translate the event into the appropriate     *  format for transmission, storage, or display.     *  This method is called only if the event's level is in range of the     *  target's level.     *      *  @param event The <code>LogEvent</code> handled by this method.
		 */
		public function logEvent (event:LogEvent) : void;
		/**
		 *  @private
		 */
		private function padTime (num:Number, millis:Boolean = false) : String;
		/**
		 *  Descendants of this class should override this method to direct the      *  specified message to the desired output.     *     *  @param  message String containing preprocessed log message which may     *              include time, date, category, etc. based on property settings,     *              such as <code>includeDate</code>, <code>includeCategory</code>,     *          etc.
		 */
		function internalLog (message:String) : void;
	}
}
