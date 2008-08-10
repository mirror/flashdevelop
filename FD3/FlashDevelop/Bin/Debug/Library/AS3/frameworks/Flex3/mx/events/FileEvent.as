/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-03 13:18] ***/
/**********************************************************/
package mx.events {
	public class FileEvent extends Event {
		/**
		 * The File instance associated with this event.
		 */
		public var file:File;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type;
		 *                            indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event
		 *                            can bubble up the  display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param file              <File (default = null)> The File instance associated with this event.
		 */
		public function FileEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, file:File = null);
		/**
		 * The FileEvent.DIRECTORY_CHANGE constant defines the value of the
		 *  type property of the event object for a
		 *  directoryChange event.
		 */
		public static const DIRECTORY_CHANGE:String = "directoryChange";
		/**
		 * The FileEvent.DIRECTORY_CHANGING constant defines the value of the
		 *  type property of the event object for a
		 *  directoryChanging event.
		 */
		public static const DIRECTORY_CHANGING:String = "directoryChanging";
		/**
		 * The FileEvent.DIRECTORY_CLOSING constant defines the value of the
		 *  type property of the event object for a
		 *  directoryClosing event.
		 */
		public static const DIRECTORY_CLOSING:String = "directoryClosing";
		/**
		 * The FileEvent.DIRECTORY_OPENING constant defines the value of the
		 *  type property of the event object for a
		 *  directoryOpening event.
		 */
		public static const DIRECTORY_OPENING:String = "directoryOpening";
		/**
		 * The FileEvent.FILE_CHOOSE constant defines the value of the
		 *  type property of the event object for a
		 *  fileChoose event.
		 */
		public static const FILE_CHOOSE:String = "fileChoose";
	}
}
