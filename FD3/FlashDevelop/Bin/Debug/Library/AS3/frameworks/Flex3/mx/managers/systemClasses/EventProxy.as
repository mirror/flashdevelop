package mx.managers.systemClasses
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mx.events.SandboxMouseEvent;
	import mx.utils.EventUtil;
	import mx.managers.ISystemManager;

	/**
	 * An object that marshals events to other sandboxes
	 */
	public class EventProxy extends EventDispatcher
	{
		private var systemManager : ISystemManager;

		public function EventProxy (systemManager:ISystemManager);

		public function marshalListener (event:Event) : void;
	}
}
