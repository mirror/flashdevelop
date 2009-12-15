package mx.core.windowClasses
{
	import mx.core.UIComponent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import mx.core.IUITextField;
	import mx.controls.Button;
	import flash.events.MouseEvent;
	import mx.core.IFlexDisplayObject;
	import mx.core.IWindow;

	public class TitleBar extends UIComponent
	{
		public var closeButton : Button;
		public var maximizeButton : Button;
		public var minimizeButton : Button;
		public var titleBarBackground : IFlexDisplayObject;
		public var titleIconObject : Object;
		public var titleTextField : IUITextField;
		public static const VERSION : String;

		public function get title () : String;
		public function set title (value:String) : void;

		public function get titleIcon () : Class;
		public function set titleIcon (value:Class) : void;

		public function styleChanged (styleProp:String) : void;

		public function TitleBar ();
	}
}
