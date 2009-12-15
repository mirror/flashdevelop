package flash.html
{
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.html.HTMLLoader;

	public class HTMLPopupWindow extends Object
	{
		public function close () : void;

		public function HTMLPopupWindow (owner:HTMLLoader, closePopupWindowIfNeededClosure:Function, setDeactivateClosure:Function, computedFontSize:Number);

		public function isActive () : Boolean;
	}
}
