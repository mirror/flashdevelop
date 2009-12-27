package mx.logging.targets
{
	import flash.net.LocalConnection;
	import flash.events.StatusEvent;
	import flash.events.SecurityErrorEvent;
	import mx.core.mx_internal;

include "../../core/Version.as"
	/**
	 *  Provides a logger target that outputs to a <code>LocalConnection</code>,
 *  connected to the MiniDebug application.
	 */
	public class MiniDebugTarget extends LineFormattedTarget
	{
		/**
		 *  @private
		 */
		private var _lc : LocalConnection;
		/**
		 *  @private
     *  The name of the method that we should call on the remote connection.
		 */
		private var _method : String;
		/**
		 *  @private
     *  The name of the connection that we should send to.
		 */
		private var _connection : String;

		/**
		 *  Constructor.
	 *
	 *  <p>Constructs an instance of a logger target that will send
	 *  the log data to the MiniDebug application.</p>
	 *
     *  @param connection Specifies where to send the logging information.
     *  This value is the name of the connection specified in the
     *  <code>LocalConnection.connect()</code> method call in the remote SWF,
     *  that can receive calls to a <code>log()</code> method with the
     *  following signature: 
     *  <pre>
     *    log(... args:Array)
     *  </pre> 
     *  Each value specified in the <code>args</code> Array is a String.
     *
     *  @param method Specifies what method to call on the remote connection.
		 */
		public function MiniDebugTarget (connection:String = "_mdbtrace", method:String = "trace");

		/**
		 *  @private
     *  This method outputs the specified message directly to the method
     *  specified (passed to the constructor) for the local connection.
     *
	 *  @param message String containing preprocessed log message which may
	 *  include time, date, category, etc. based on property settings,
	 *  such as <code>includeDate</code>, <code>includeCategory</code>, etc.
		 */
		function internalLog (message:String) : void;

		private function onStatus (e:StatusEvent) : void;

		private function onSecurityError (e:SecurityErrorEvent) : void;
	}
}
