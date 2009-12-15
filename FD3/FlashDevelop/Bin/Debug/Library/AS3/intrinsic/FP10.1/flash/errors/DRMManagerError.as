package flash.errors
{
	/// The DRMManager dispatches a DRMManagerError event to report errors.
	public class DRMManagerError extends Error
	{
		/// The specific error number.
		public function get subErrorID () : int;

		/// Creates a new instance of the DRMManagerError class.
		public function DRMManagerError (message:String, id:int, subErrorID:int);

		/// Returns the string "Error" by default or the value contained in the Error.message property, if defined.
		public function toString () : String;
	}
}
