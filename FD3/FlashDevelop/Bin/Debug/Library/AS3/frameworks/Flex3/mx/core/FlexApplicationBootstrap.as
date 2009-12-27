package mx.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import mx.events.FlexEvent;

include "../core/Version.as"
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
