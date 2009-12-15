package mx.core.windowClasses
{
	import mx.core.UIComponent;
	import mx.core.IUITextField;
	import mx.core.IFlexDisplayObject;

	public class StatusBar extends UIComponent
	{
		public var statusBarBackground : IFlexDisplayObject;
		public var statusTextField : IUITextField;
		public static const VERSION : String;

		public function get status () : String;
		public function set status (value:String) : void;

		public function StatusBar ();

		public function styleChanged (styleProp:String) : void;
	}
}
