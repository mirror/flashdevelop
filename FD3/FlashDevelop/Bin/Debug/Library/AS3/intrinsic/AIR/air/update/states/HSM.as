package air.update.states
{
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.events.Event;

	public class HSM extends EventDispatcher
	{
		public function dispatch (event:Event) : void;

		public function HSM (initialState:Function);

		public function init () : void;
	}
}
