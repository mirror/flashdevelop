package mx.managers.systemClasses
{
	import flash.display.Stage;
	import flash.events.Event;

	/**
	 * An object that filters stage
	 */
	public class StageEventProxy
	{
		private var listener : Function;

		public function StageEventProxy (listener:Function);
		public function stageListener (event:Event) : void;
	}
}
