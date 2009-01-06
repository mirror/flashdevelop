package flash.html
{
	import flash.html.HTMLLoader;

	public class HTMLPopupWindow extends Object
	{
		public function close () : void;

		public function HTMLPopupWindow (owner:HTMLLoader, closePopupWindowIfNeededClosure:Function, computedFontSize:Number);

		public function isActive () : Boolean;
	}
}
