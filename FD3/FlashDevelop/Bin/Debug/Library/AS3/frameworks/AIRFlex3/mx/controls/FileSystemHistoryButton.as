package mx.controls
{
	import mx.controls.Menu;
	import mx.events.MenuEvent;
	import mx.core.IUIComponent;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;

	public class FileSystemHistoryButton extends PopUpButton
	{
		public var helper : FileSystemControlHelper;
		public static const VERSION : String;

		public function get dataProvider () : Object;
		public function set dataProvider (value:Object) : void;

		public function FileSystemHistoryButton ();

		public function getPopUp () : IUIComponent;
	}
}
