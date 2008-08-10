/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package air.net {
	import flash.events.EventDispatcher;
	public dynamic  class ServiceMonitor extends EventDispatcher {
		/**
		 * Whether the service is currently considered "available."
		 */
		public function get available():Boolean;
		public function set available(value:Boolean):void;
		/**
		 * The time of the last status update.
		 */
		public function get lastStatusUpdate():Date;
		/**
		 * The interval, in milliseconds, for polling the server.
		 */
		public function get pollInterval():Number;
		public function set pollInterval(value:Number):void;
		/**
		 * Whether the monitor has been started.
		 */
		public function get running():Boolean;
		/**
		 * Creates a ServiceMonitor object.
		 */
		public function ServiceMonitor();
		/**
		 * Checks the status of the service.
		 */
		protected function checkStatus():void;
		/**
		 * Adds public ServiceMonitor methods to a JavaScript constructor function's prototype.
		 *
		 * @param constructorFunction<Object> The JavaScript object's prototype property. For example, if the JavaScript
		 *                            object that you are using to serve as a specializer object is named MyHTTPMonitor, pass
		 *                            MyHTTPMonitor.prototype as the value for this parameter.
		 */
		public static function makeJavascriptSubclass(constructorFunction:Object):void;
		/**
		 * Starts the service monitor.
		 */
		public function start():void;
		/**
		 * Stops monitoring the service.
		 */
		public function stop():void;
		/**
		 * Returns the string representation of the specified object.
		 *
		 * @return                  <String> A string representation of the object.
		 */
		public override function toString():String;
	}
}
