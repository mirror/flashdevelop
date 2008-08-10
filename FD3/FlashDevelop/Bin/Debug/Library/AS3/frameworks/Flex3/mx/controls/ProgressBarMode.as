/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	public final  class ProgressBarMode {
		/**
		 * The control specified by the source property must
		 *  dispatch progress and completed events.
		 *  The ProgressBar uses these events to update its status.
		 */
		public static const EVENT:String = "event";
		/**
		 * You manually update the ProgressBar status. In this mode, you
		 *  specify the maximum and minimum
		 *  properties and use the setProgress() method
		 *  to specify the status. This mode is often used when the
		 *  indeterminate property is true.
		 */
		public static const MANUAL:String = "manual";
		/**
		 * The source property must specify an object that
		 *  exposes the getBytesLoaded() and
		 *  getBytesTotal() methods.  The ProgressBar control
		 *  calls these methods to update its status.
		 */
		public static const POLLED:String = "polled";
	}
}
