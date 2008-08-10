/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.ProgressEvent;
	public class StyleEvent extends ProgressEvent {
		/**
		 * The error message if the type is ERROR;
		 *  otherwise, it is null.
		 */
		public var errorText:String;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The type of the event. Possible values are:
		 *                            "progress" (StyleEvent.PROGRESS);
		 *                            "complete" (StyleEvent.COMPLETE);
		 *                            "error" (StyleEvent.ERROR);
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object
		 *                            participates in the bubbling stage of the event flow.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be cancelled.
		 * @param bytesLoaded       <uint (default = 0)> The number of bytes loaded
		 *                            at the time the listener processes the event.
		 * @param bytesTotal        <uint (default = 0)> The total number of bytes
		 *                            that will ultimately be loaded if the loading process succeeds.
		 * @param errorText         <String (default = null)> The error message of the error
		 *                            when type is StyleEvent.ERROR.
		 */
		public function StyleEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:uint = 0, bytesTotal:uint = 0, errorText:String = null);
		/**
		 * Dispatched when the style SWF has finished downloading.
		 *  The StyleEvent.COMPLETE constant defines the value of the
		 *  type property of the event object for a styleComplete event.
		 */
		public static const COMPLETE:String = "complete";
		/**
		 * Dispatched when there is an error downloading the style SWF.
		 *  The StyleEvent.ERROR constant defines the value of the
		 *  type property of the event object for a styleError event.
		 */
		public static const ERROR:String = "error";
		/**
		 * Dispatched when the style SWF is downloading.
		 *  The StyleEvent.PROGRESS constant defines the value of the
		 *  type property of the event object for a styleProgress event.
		 */
		public static const PROGRESS:String = "progress";
	}
}
