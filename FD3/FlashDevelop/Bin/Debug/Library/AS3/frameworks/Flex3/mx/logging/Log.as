package mx.logging
{
	import mx.logging.errors.InvalidCategoryError;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

include "../core/Version.as"
	/**
	 *  Provides pseudo-hierarchical logging capabilities with multiple format and
 *  output options.
 *  The log system consists of two major components, the logger and a target.
 *  You can use the logger to send information to a target.
 *  The target is responsible for formatting and general output of the log data.
 *  <p>
 *  Loggers are singleton instances created for a particular category of
 *  information.
 *  Typically, the category is the package name of the component
 *  that desires to log information.
 *  The category provides users the ability to specify what log information they
 *  are interested in.
 *  Multiple categories can be selected and combined with regular expressions.
 *  This allows for both broad and narrow logging information to be acquired.
 *  For example, you might be interested in all logging information under
 *  the "mx.messaging" and "mx.rpc" packages and want the output from these
 *  packages to be formatted as XML.
 *  To get the all of the logging information under the "mx.messaging" category
 *  including sub-packages and components a wildcard expression is required, such as
 *  "mx.messaging.~~".
 *  See the code example below for more details.
 *  </p>
 *  <p>Targets provide the output mechanism of the data being logged.
 *  This mechanism typically includes formatting, transmission, or storage, but
 *  can be anything possible under the VM.
 *  There are two targets provided: <code>MiniDebugTarget</code> and 
 *  <code>TraceTarget</code>.
 *  Each of these writers take the current log information and "sends" it
 *  somewhere for display and/or storage.
 *  Targets also provide the specification of what log data to output.
 *  </p>
 *
 *  @example
 *  <pre>
 *  ... 
 *  import mx.logging.targets.*;
 *  import mx.logging.*;
 *
 *  private function initLogging():void {
 *      // Create a target.
 *      var logTarget:TraceTarget = new TraceTarget();
 *
 *      // Log only messages for the classes in the mx.rpc.* and 
 *      // mx.messaging packages.
 *      logTarget.filters=["mx.rpc.*","mx.messaging.*"];
 *
 *      // Log all log levels.
 *      logTarget.level = LogEventLevel.ALL;
 *
 *      // Add date, time, category, and log level to the output.
 *      logTarget.includeDate = true;
 *      logTarget.includeTime = true;
 *      logTarget.includeCategory = true;
 *      logTarget.includeLevel = true;
 *
 *      // Begin logging.
 *      Log.addTarget(logTarget);
 *  } 
 *  ...
 *  </pre>
	 */
	public class Log
	{
		/**
		 *  @private
     *  Sentinal value for the target log level to indicate no logging.
		 */
		private static var NONE : int;
		/**
		 *  @private
     *  The most verbose supported log level among registered targets.
		 */
		private static var _targetLevel : int;
		/**
		 *  @private
     *  An associative Array of existing loggers keyed by category
		 */
		private static var _loggers : Array;
		/**
		 *  @private
     *  Array of targets that should be searched any time
     *  a new logger is created.
		 */
		private static var _targets : Array;
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
     *  A reference to the object which manages
     *  all of the application's localized resources.
     *  This is a singleton instance which implements
     *  the IResourceManager interface.
		 */
		private static function get resourceManager () : IResourceManager;

		/**
		 *  Indicates whether a fatal level log event will be processed by a
     *  log target.
     *
     *  @return true if a fatal level log event will be logged; otherwise false.
		 */
		public static function isFatal () : Boolean;

		/**
		 *  Indicates whether an error level log event will be processed by a
     *  log target.
     *
     *  @return true if an error level log event will be logged; otherwise false.
		 */
		public static function isError () : Boolean;

		/**
		 *  Indicates whether a warn level log event will be processed by a
     *  log target.
     *
     *  @return true if a warn level log event will be logged; otherwise false.
		 */
		public static function isWarn () : Boolean;

		/**
		 *  Indicates whether an info level log event will be processed by a
     *  log target.
     *
     *  @return true if an info level log event will be logged; otherwise false.
		 */
		public static function isInfo () : Boolean;

		/**
		 *  Indicates whether a debug level log event will be processed by a
     *  log target.
     *
     *  @return true if a debug level log event will be logged; otherwise false.
		 */
		public static function isDebug () : Boolean;

		/**
		 *  Allows the specified target to begin receiving notification of log
     *  events.
     *
     *  @param The specific target that should capture log events.
		 */
		public static function addTarget (target:ILoggingTarget) : void;

		/**
		 *  Stops the specified target from receiving notification of log
     *  events.
     *
     *  @param The specific target that should capture log events.
		 */
		public static function removeTarget (target:ILoggingTarget) : void;

		/**
		 *  Returns the logger associated with the specified category.
     *  If the category given doesn't exist a new instance of a logger will be
     *  returned and associated with that category.
     *  Categories must be at least one character in length and may not contain
     *  any blanks or any of the following characters:
     *  []~$^&amp;\/(){}&lt;&gt;+=`!#%?,:;'"&#64;
     *  This method will throw an <code>InvalidCategoryError</code> if the
     *  category specified is malformed.
     *
     *  @param category The category of the logger that should be returned.
     *
     *  @return An instance of a logger object for the specified name.
     *  If the name doesn't exist, a new instance with the specified
     *  name is returned.
		 */
		public static function getLogger (category:String) : ILogger;

		/**
		 *  This method removes all of the current loggers from the cache.
     *  Subsquent calls to the <code>getLogger()</code> method return new instances
     *  of loggers rather than any previous instances with the same category.
     *  This method is intended for use in debugging only.
		 */
		public static function flush () : void;

		/**
		 *  This method checks the specified string value for illegal characters.
     *
     *  @param value The String to check for illegal characters.
     *            The following characters are not valid:
     *                []~$^&amp;\/(){}&lt;&gt;+=`!#%?,:;'"&#64;
     *  @return   <code>true</code> if there are any illegal characters found,
     *            <code>false</code> otherwise
		 */
		public static function hasIllegalCharacters (value:String) : Boolean;

		/**
		 *  This method checks that the specified category matches any of the filter
     *  expressions provided in the <code>filters</code> Array.
     *
     *  @param category The category to match against
     *  @param filters A list of Strings to check category against.
     *  @return <code>true</code> if the specified category matches any of the
     *            filter expressions found in the filters list, <code>false</code>
     *            otherwise.
     *  @private
		 */
		private static function categoryMatchInFilterList (category:String, filters:Array) : Boolean;

		/**
		 *  This method will ensure that a valid category string has been specified.
     *  If the category is not valid an <code>InvalidCategoryError</code> will
     *  be thrown.
     *  Categories can not contain any blanks or any of the following characters:
     *    []`*~,!#$%^&amp;()]{}+=\|'";?&gt;&lt;./&#64; or be less than 1 character in length.
     *  @private
		 */
		private static function checkCategory (category:String) : void;

		/**
		 *  @private
     *  This method resets the Log's target level to the most verbose log level
     *  for the currently registered targets.
		 */
		private static function resetTargetLevel () : void;
	}
}
