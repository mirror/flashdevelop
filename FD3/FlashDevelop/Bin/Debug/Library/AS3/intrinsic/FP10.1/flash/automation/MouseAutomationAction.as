package flash.automation
{
	public class MouseAutomationAction extends AutomationAction
	{
		public static const MIDDLE_MOUSE_DOWN : String;
		public static const MIDDLE_MOUSE_UP : String;
		public static const MOUSE_DOWN : String;
		public static const MOUSE_MOVE : String;
		public static const MOUSE_UP : String;
		public static const MOUSE_WHEEL : String;
		public static const RIGHT_MOUSE_DOWN : String;
		public static const RIGHT_MOUSE_UP : String;

		public function get delta () : int;
		public function set delta (value:int) : void;

		public function get stageX () : Number;
		public function set stageX (value:Number) : void;

		public function get stageY () : Number;
		public function set stageY (value:Number) : void;

		public function MouseAutomationAction (type:String, stageX:Number = 0, stageY:Number = 0, delta:int = 0);
	}
}
