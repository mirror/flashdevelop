package mx.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import mx.events.FlexEvent;

	/**
	 *  @private
	 */
	public class FlexApplicationBootstrap extends FlexModuleFactory
	{
		/**
		 *  Constructor.
		 */
		public function FlexApplicationBootstrap ();
		/**
		 *  @private
		 */
		public function readyHandler (event:Event) : void;
	}
}
