package air.update.ui
{
	import flash.events.EventDispatcher;
	import air.update.logging.Logger;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.NativeWindow;
	import air.update.ui.UpdaterUI;

	public class EmbeddedUILoader extends EventDispatcher
	{
		public function set applicationUpdater (value:UpdaterUI) : void;

		public function get initialized () : Boolean;

		public function addResources (lang:String, res:Object) : void;

		public function EmbeddedUILoader ();

		public function getLocaleChain () : Array;

		public function hideWindow () : void;

		public function load () : void;

		public function setLocaleChain (locale:Array) : void;

		public function showWindow () : void;

		public function unload () : void;
	}
}
