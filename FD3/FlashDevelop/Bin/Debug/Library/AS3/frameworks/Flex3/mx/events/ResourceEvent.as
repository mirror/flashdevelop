/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.ProgressEvent;
	public class ResourceEvent extends ProgressEvent {
		/**
		 * The error message if the type is ERROR;
		 *  otherwise, it is null.
		 */
		public var errorText:String;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The value of the type property of the event object. Possible values are:
		 *                            "progress" (ResourceEvent.PROGRESS)
		 *                            "complete" (ResourceEvent.COMPLETE)
		 *                            "error" (ResourceEvent.ERROR)
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object
		 *                            participates in the bubbling stage of the event flow.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be cancelled.
		 * @param bytesLoaded       <uint (default = 0)> The number of bytes loaded
		 *                            at the time the listener processes the event.
		 * @param bytesTotal        <uint (default = 0)> The total number of bytes
		 *                            that will ultimately be loaded if the loading process succeeds.
		 * @param errorText         <String (default = null)> The error message of the error
		 *                            when type is ResourceEvent.ERROR.
		 */
		public function ResourceEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:uint = 0, bytesTotal:uint = 0, errorText:String = null);
		/**
		 * Dispatched when the resource module SWF file has finished loading.
		 *  The ResourceEvent.COMPLETE constant defines the value of the
		 *  type property of the event object for a complete event.
		 */
		public static const COMPLETE:String = "complete";
		/**
		 * Dispatched when there is an error loading the resource module SWF file.
		 *  The ResourceEvent.ERROR constant defines the value of the
		 *  type property of the event object for a error event.
		 */
		public static const ERROR:String = "error";
		/**
		 * Dispatched when the resource module SWF file is loading.
		 *  The ResourceEvent.PROGRESS constant defines the value of the
		 *  type property of the event object for a progress event.
		 */
		public static const PROGRESS:String = "progress";
	}
}
