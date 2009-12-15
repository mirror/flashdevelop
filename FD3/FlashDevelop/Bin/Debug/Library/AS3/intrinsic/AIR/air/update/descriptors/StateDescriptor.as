package air.update.descriptors
{
	import air.update.logging.Logger;
	import air.update.descriptors.StateDescriptor;
	import flash.filesystem.File;

	public class StateDescriptor extends Object
	{
		public static const NAMESPACE_STATE_1_0 : Namespace;

		public function get currentVersion () : String;
		public function set currentVersion (value:String) : void;

		public function get failedUpdates () : Array;

		public function get lastCheckDate () : Date;
		public function set lastCheckDate (value:Date) : void;

		public function get previousVersion () : String;
		public function set previousVersion (value:String) : void;

		public function get storage () : File;
		public function set storage (value:File) : void;

		public function get updaterLaunched () : Boolean;
		public function set updaterLaunched (value:Boolean) : void;

		public function addFailedUpdate (value:String) : void;

		public static function defaultState () : StateDescriptor;

		public function getXML () : XML;

		public static function isThisVersion (ns:Namespace) : Boolean;

		public function removeAllFailedUpdates () : void;

		public function StateDescriptor (xml:XML);

		public function validate () : void;
	}
}
