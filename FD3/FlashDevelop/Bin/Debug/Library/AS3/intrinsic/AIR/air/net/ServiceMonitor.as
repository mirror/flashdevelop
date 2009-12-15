package air.net
{
	import flash.events.EventDispatcher;
	import air.net.ServiceMonitor;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;

	/**
	 * Indicates that the service status has changed.
	 * @eventType flash.events.StatusEvent.STATUS
	 */
	[Event(name="status", type="flash.events.StatusEvent")] 

	/// The ServiceMonitor class implements the framework for monitoring the status and availability of network services.
	public class ServiceMonitor extends EventDispatcher
	{
		/// Whether the service is currently considered "available." The initial value is false until either a status check sets the property to true or the property is initialized to true explicitly. Typically, this property is set by the checkStatus() implementation in a subclass or specializer, but if the application has independent information about a service's availability (for example, a request just succeeded or failed), the property can be set explicitly.
		public function get available () : Boolean;
		public function set available (value:Boolean) : void;

		/// The time of the last status update.
		public function get lastStatusUpdate () : Date;

		/// The interval, in milliseconds, for polling the server.
		public function get pollInterval () : Number;
		public function set pollInterval (value:Number) : void;

		/// Whether the monitor has been started.
		public function get running () : Boolean;

		/// Adds public ServiceMonitor methods to a JavaScript constructor function's prototype.
		public static function makeJavascriptSubclass (constructorFunction:Object) : void;

		/// Creates a ServiceMonitor object.
		public function ServiceMonitor ();

		/// Starts the service monitor.
		public function start () : void;

		/// Stops monitoring the service.
		public function stop () : void;

		/// Returns the string representation of the specified object.
		public function toString () : String;
	}
}
