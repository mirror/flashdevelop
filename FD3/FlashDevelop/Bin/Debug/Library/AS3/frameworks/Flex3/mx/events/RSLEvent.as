/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	public class RSLEvent extends ProgressEvent {
		/**
		 * The error message if the type is RSL_ERROR; otherwise, it is null;
		 */
		public var errorText:String;
		/**
		 * The index number of the RSL currently being downloaded.
		 *  This is a number between 0 and rslTotal - 1.
		 */
		public var rslIndex:int;
		/**
		 * The total number of RSLs being downloaded by the preloader
		 */
		public var rslTotal:int;
		/**
		 * The URLRequest object that represents the location
		 *  of the RSL being downloaded.
		 */
		public var url:URLRequest;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The type of the event. Possible values are:
		 *                            "rslProgress" (RSLEvent.RSL_PROGRESS);
		 *                            "rslComplete" (RSLEvent.RSL_COMPLETE);
		 *                            "rslError" (RSLEvent.RSL_ERROR);
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be cancelled.
		 * @param bytesLoaded       <int (default = -1)> The number of bytes loaded at the time the listener processes the event.
		 * @param bytesTotal        <int (default = -1)> The total number of bytes that will ultimately be loaded if the loading process succeeds.
		 * @param rslIndex          <int (default = -1)> The index number of the RSL relative to the total. This should be a value between 0 and total - 1.
		 * @param rslTotal          <int (default = -1)> The total number of RSLs being loaded.
		 * @param url               <URLRequest (default = null)> The location of the RSL.
		 * @param errorText         <String (default = null)> The error message of the error when type is RSLEvent.RSL_ERROR.
		 */
		public function RSLEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:int = -1, bytesTotal:int = -1, rslIndex:int = -1, rslTotal:int = -1, url:URLRequest = null, errorText:String = null);
		/**
		 * Dispatched when the RSL has finished downloading.
		 *  The RSLEvent.RSL_COMPLETE constant defines the value of the
		 *  type property of the event object for a rslComplete event.
		 */
		public static const RSL_COMPLETE:String = "rslComplete";
		/**
		 * Dispatched when there is an error downloading the RSL.
		 *  The RSLEvent.RSL_ERROR constant defines the value of the
		 *  type property of the event object for a rslError event.
		 */
		public static const RSL_ERROR:String = "rslError";
		/**
		 * Dispatched when the RSL is downloading.
		 *  The RSLEvent.RSL_PROGRESS constant defines the value of the
		 *  type property of the event object for a rslProgress event.
		 */
		public static const RSL_PROGRESS:String = "rslProgress";
	}
}
