/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.logging.targets {
	public class MiniDebugTarget extends LineFormattedTarget {
		/**
		 * Constructor.
		 *
		 * @param connection        <String (default = "_mdbtrace")> Specifies where to send the logging information.
		 *                            This value is the name of the connection specified in the
		 *                            LocalConnection.connect() method call in the remote SWF,
		 *                            that can receive calls to a log() method with the
		 *                            following signature:
		 *                            log(... args:Array)
		 *                            Each value specified in the args Array is a String.
		 * @param method            <String (default = "trace")> Specifies what method to call on the remote connection.
		 */
		public function MiniDebugTarget(connection:String = "_mdbtrace", method:String = "trace");
	}
}
