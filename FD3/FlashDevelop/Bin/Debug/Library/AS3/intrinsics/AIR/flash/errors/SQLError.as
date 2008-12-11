package flash.errors
{
	/// A SQLError instance provides detailed information about a failed operation.
	public class SQLError extends Error
	{
		/// [AIR] Details of the current error.
		public var details:String;

		/// [AIR] A reference number associated with the specific detail message.
		public var detailID:int;

		/// [AIR] An array of String values that can be used to construct a locale specific detail error message.
		public var detailArguments:Array;

		/// [AIR] A value indicating the operation that was being attempted when the error occurred.
		public var operation:String;

		/// [AIR] Creates a SQLError instance that can be thrown or used with a SQLErrorEvent instance's error property.
		public function SQLError(operation:String, details:String, message:String, id:int=0, detailID:int=-1, detailArgs:Array=null);

		/// [AIR] Returns the string "Error" by default or the value contained in Error.message property, if defined.
		public function toString():String;

	}

}

