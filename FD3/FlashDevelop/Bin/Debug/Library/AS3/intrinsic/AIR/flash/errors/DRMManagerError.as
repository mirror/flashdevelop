package flash.errors
{
	public class DRMManagerError extends Error
	{
		public function get subErrorID () : int;

		public function toString () : String;
	}
}
