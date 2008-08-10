/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.net {
	import flash.events.EventDispatcher;
	public class URLLoader extends EventDispatcher {
		/**
		 * Indicates the number of bytes that have been loaded thus far
		 *  during the load operation.
		 */
		public var bytesLoaded:uint = 0;
		/**
		 * Indicates the total number of bytes in the downloaded data.
		 *  This property contains 0 while the load operation is in progress
		 *  and is populated when the operation is complete.
		 *  Also, a missing Content-Length header will result in bytesTotal being indeterminate.
		 */
		public var bytesTotal:uint = 0;
		/**
		 * The data received from the load operation. This property
		 *  is populated only when the load operation is complete.
		 */
		public var data:*;
		/**
		 * Controls whether the downloaded data is received as
		 *  text (URLLoaderDataFormat.TEXT), raw binary data
		 *  (URLLoaderDataFormat.BINARY), or URL-encoded variables
		 *  (URLLoaderDataFormat.VARIABLES).
		 */
		public var dataFormat:String = "text";
		/**
		 * Creates a URLLoader object.
		 *
		 * @param request           <URLRequest (default = null)> A URLRequest object specifying
		 *                            the URL to download.  If this parameter is omitted,
		 *                            no load operation begins.  If
		 *                            specified, the load operation begins
		 *                            immediately (see the load entry for more information).
		 */
		public function URLLoader(request:URLRequest = null);
		/**
		 * Registers an event listener object with an EventDispatcher object so that the listener
		 *  receives notification of an event. You can register event listeners on all nodes in the
		 *  display list for a specific type of event, phase, and priority.
		 *
		 * @param type              <String> The type of event.
		 * @param listener          <Function> The listener function that processes the event. This function must accept
		 *                            an Event object as its only parameter and must return nothing, as this example shows:
		 *                            function(evt:Event):void
		 *                            The function can have any name.
		 * @param useCapture        <Boolean (default = false)> Determines whether the listener works in the capture phase or the
		 *                            target and bubbling phases. If useCapture is set to true,
		 *                            the listener processes the event only during the capture phase and not in the
		 *                            target or bubbling phase. If useCapture is false, the
		 *                            listener processes the event only during the target or bubbling phase. To listen for
		 *                            the event in all three phases, call addEventListener twice, once with
		 *                            useCapture set to true, then again with
		 *                            useCapture set to false.
		 * @param priority          <int (default = 0)> The priority level of the event listener. The priority is designated by
		 *                            a signed 32-bit integer. The higher the number, the higher the priority. All listeners
		 *                            with priority n are processed before listeners of priority n-1. If two
		 *                            or more listeners share the same priority, they are processed in the order in which they
		 *                            were added. The default priority is 0.
		 * @param useWeakReference  <Boolean (default = false)> Determines whether the reference to the listener is strong or
		 *                            weak. A strong reference (the default) prevents your listener from being garbage-collected.
		 *                            A weak reference does not. Class-level member functions are not subject to garbage
		 *                            collection, so you can set useWeakReference to true for
		 *                            class-level member functions without subjecting them to garbage collection. If you set
		 *                            useWeakReference to true for a listener that is a nested inner
		 *                            function, the function will be garbage-collected and no longer persistent. If you create
		 *                            references to the inner function (save it in another variable) then it is not
		 *                            garbage-collected and stays persistent.
		 */
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		/**
		 * Closes the load operation in progress.  Any load
		 *  operation in progress is immediately terminated.
		 *  If no URL is currently being streamed, an invalid stream error is thrown.
		 */
		public function close():void;
		/**
		 * Sends and loads data from the specified URL. The data can be received as
		 *  text, raw binary data, or URL-encoded variables, depending on the
		 *  value you set for the dataFormat property. Note that
		 *  the default value of the dataFormat property is text.
		 *  If you want to send data to the specified URL, you can set the data
		 *  property in the URLRequest object.
		 *
		 * @param request           <URLRequest> A URLRequest object specifying the URL to download.
		 */
		public function load(request:URLRequest):void;
	}
}
