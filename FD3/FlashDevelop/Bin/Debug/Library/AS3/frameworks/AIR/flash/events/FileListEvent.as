/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	public class FileListEvent extends Event {
		/**
		 * An array of File objects representing the files and directories found or selected.
		 */
		public var files:Array;
		/**
		 * The constructor function for a FileListEvent object.
		 *
		 * @param type              <String> The type of the event.
		 * @param bubbles           <Boolean (default = false)> Determines whether the event object bubbles (false for a FileListEvent object).
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled (false for a FileListEvent object).
		 * @param files             <Array (default = null)> An array of File objects.
		 */
		public function FileListEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, files:Array = null);
		/**
		 * The FileListEvent.DIRECTORY_LISTING constant defines the value of the
		 *  type property of the event object for a directoryListing event.
		 */
		public static const DIRECTORY_LISTING:String = "directoryListing";
		/**
		 * The FileListEvent.SELECT_MULTIPLE constant defines the value of the
		 *  type property of the event object for a selectMultiple event.
		 *  PropertyValue
		 *  bubblesfalse
		 *  cancelablefalse; there is no default behavior to cancel.
		 *  filesAn array of File objects representing the files selected.
		 *  targetThe FileListEvent object.
		 */
		public static const SELECT_MULTIPLE:String = "selectMultiple";
	}
}
