package flash.display
{
	public class AVM1Movie extends DisplayObject
	{
		public function addCallback (functionName:String, closure:Function) : void;

		public function AVM1Movie ();

		public function call (functionName:String) : *;
	}
}
