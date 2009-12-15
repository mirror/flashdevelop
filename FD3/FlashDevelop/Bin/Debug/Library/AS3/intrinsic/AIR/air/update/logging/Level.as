package air.update.logging
{
	public class Level extends Object
	{
		public static const ALL : int;
		public static const CONFIG : int;
		public static const FINE : int;
		public static const FINER : int;
		public static const FINEST : int;
		public static const INFO : int;
		public static const OFF : int;
		public static const SEVERE : int;
		public static const WARNING : int;

		public static function getName (level:int) : String;

		public function Level ();
	}
}
