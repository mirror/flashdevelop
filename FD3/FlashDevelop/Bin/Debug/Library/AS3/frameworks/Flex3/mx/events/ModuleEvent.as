/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.ProgressEvent;
	import mx.modules.IModuleInfo;
	public class ModuleEvent extends ProgressEvent {
		/**
		 * The error message if the type is ModuleEvent.ERROR;
		 *  otherwise, it is null.
		 */
		public var errorText:String;
		/**
		 * The target, which is an instance of an
		 *  interface for a particular module.
		 */
		public function get module():IModuleInfo;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The type of event. Possible values are:
		 *                            "progress" (ModuleEvent.PROGRESS);
		 *                            "ready" (ModuleEvent.READY);
		 *                            "setup" (ModuleEvent.SETUP);
		 *                            "error" (ModuleEvent.ERROR);
		 *                            "unload" (ModuleEvent.UNLOAD);
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object
		 *                            participates in the bubbling stage of the event flow.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be cancelled
		 *                            during event propagation.
		 * @param bytesLoaded       <uint (default = 0)> The number of bytes loaded
		 *                            at the time the listener processes the event.
		 * @param bytesTotal        <uint (default = 0)> The total number of bytes
		 *                            that will be loaded if the loading process succeeds.
		 * @param errorText         <String (default = null)> The error message when the event type
		 *                            is ModuleEvent.ERROR.
		 * @param module            <IModuleInfo (default = null)> 
		 */
		public function ModuleEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:uint = 0, bytesTotal:uint = 0, errorText:String = null, module:IModuleInfo = null);
		/**
		 * Dispatched when there is an error downloading the module.
		 *  The ModuleEvent.ERROR constant defines the value of the
		 *  type property of the event object for an error event.
		 */
		public static const ERROR:String = "error";
		/**
		 * Dispatched when the module is in the process of downloading. This module is
		 *  dispatched at regular intervals during the download process.
		 *  The ModuleEvent.PROGRESS constant defines the value of the
		 *  type property of the event object for a progress event.
		 */
		public static const PROGRESS:String = "progress";
		/**
		 * Dispatched when the module has finished downloading.
		 *  The ModuleEvent.READY constant defines the value of the
		 *  type property of the event object for a complete event.
		 */
		public static const READY:String = "ready";
		/**
		 * Dispatched when enough of a module has been downloaded that you can get information
		 *  about the module. You do this by calling the IFlexModuleFactory.info()
		 *  method on the module.
		 *  The ModuleEvent.SETUP constant defines the value of the
		 *  type property of the event object for a setup event.
		 */
		public static const SETUP:String = "setup";
		/**
		 * Dispatched when the module is unloaded.
		 *  The ModuleEvent.UNLOAD constant defines the value of the
		 *  type property of the event object for an unload event.
		 */
		public static const UNLOAD:String = "unload";
	}
}
