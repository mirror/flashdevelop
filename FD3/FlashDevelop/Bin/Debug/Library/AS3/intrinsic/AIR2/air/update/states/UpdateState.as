package air.update.states
{
	public class UpdateState extends Object
	{
		public static const AVAILABLE : int;
		public static const BEFORE_CHECKING : int;
		public static const CHECKING : int;
		public static const DOWNLOADED : int;
		public static const DOWNLOADING : int;
		public static const INITIALIZING : int;
		public static const INSTALLING : int;
		public static const PENDING_INSTALLING : int;
		public static const READY : int;
		public static const UNINITIALIZED : int;

		public static function getStateName (state:int) : String;

		public function UpdateState ();
	}
}
