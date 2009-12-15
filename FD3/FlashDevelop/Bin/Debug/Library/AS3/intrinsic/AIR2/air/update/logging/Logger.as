package air.update.logging
{
	import flash.utils.Dictionary;
	import air.update.logging.Logger;

	public class Logger extends Object
	{
		public static function get level () : int;
		public static function set level (value:int) : void;

		public function config (...rest) : void;

		public function fine (...rest) : void;

		public function finer (...rest) : void;

		public function finest (...rest) : void;

		public static function getLogger (name:String) : Logger;

		public function info (...rest) : void;

		public function isLoggable (logLevel:int) : Boolean;

		public function log (logLevel:int, ...rest) : void;

		public function Logger (name:String);

		public function severe (...rest) : void;

		public function warning (...rest) : void;
	}
}
