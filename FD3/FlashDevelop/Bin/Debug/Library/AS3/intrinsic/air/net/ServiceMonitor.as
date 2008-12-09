package air.net
{
	/// The ServiceMonitor class implements the framework for monitoring the status and availability of network services.
	public class ServiceMonitor extends flash.events.EventDispatcher
	{
		/** 
		 * [AIR] Indicates that the service status has changed.
		 * @eventType flash.events.StatusEvent.STATUS
		 */
		[Event(name="status", type="flash.events.StatusEvent")]

		/// [AIR] The interval, in milliseconds, for polling the server.
		public var pollInterval:Number;

		/// [AIR] Whether the monitor has been started.
		public var running:Boolean;

		/// [AIR] Whether the service is currently considered "available." The initial value is false until either a status check sets the property to true or the property is initialized to true explicitly. Typically, this property is set by the checkStatus() implementation in a subclass or specializer, but if the application has independent information about a service's availability (for example, a request just succeeded or failed), the property can be set explicitly.
		public var available:Boolean;

		/// [AIR] The time of the last status update.
		public var lastStatusUpdate:Date;

		/// [AIR] Creates a ServiceMonitor object.
		public function ServiceMonitor();

		/// [AIR] Starts the service monitor.
		public function start():void;

		/// [AIR] Stops monitoring the service.
		public function stop():void;

		/// [AIR] Checks the status of the service.
		public function checkStatus():void;

		/// [AIR] Returns the string representation of the specified object.
		public function toString():String;

		/// [AIR] Adds public ServiceMonitor methods to a JavaScript constructor function's prototype.
		public static function makeJavascriptSubclass(constructorFunction:Object):void;

	}

}

