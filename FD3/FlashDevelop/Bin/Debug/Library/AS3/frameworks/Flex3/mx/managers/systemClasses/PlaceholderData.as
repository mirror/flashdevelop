package mx.managers.systemClasses
{
	import flash.events.IEventDispatcher;

	/**
	 * Simple class to track placeholders for RemotePopups.
	 */
	public class PlaceholderData extends Object
	{
		public var id : String;
		public var bridge : IEventDispatcher;
		public var data : Object;

		public function PlaceholderData (id:String, bridge:IEventDispatcher, data:Object);
	}
}
