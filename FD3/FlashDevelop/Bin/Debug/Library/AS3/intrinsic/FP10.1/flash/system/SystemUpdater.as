package flash.system
{
	import flash.events.EventDispatcher;
	import adobe.utils.ProductManager;
	import flash.events.Event;

	public class SystemUpdater extends EventDispatcher
	{
		public function cancel () : void;

		public function SystemUpdater ();

		public function update (type:String) : void;
	}
}
