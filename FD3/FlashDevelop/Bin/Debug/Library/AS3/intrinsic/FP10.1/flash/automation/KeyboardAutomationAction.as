package flash.automation
{
	public class KeyboardAutomationAction extends AutomationAction
	{
		public static const KEY_DOWN : String;
		public static const KEY_UP : String;

		public function get keyCode () : uint;
		public function set keyCode (value:uint) : void;

		public function KeyboardAutomationAction (type:String, keyCode:uint = 0);
	}
}
