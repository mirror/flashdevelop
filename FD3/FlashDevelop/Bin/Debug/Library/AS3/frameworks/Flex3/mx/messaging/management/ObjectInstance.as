package mx.messaging.management
{
	import mx.utils.ObjectUtil;

	/**
	 * Client representation of an object name instance for server-side management controls.
	 */
	public class ObjectInstance
	{
		/**
		 * The object name.
		 */
		public var objectName : ObjectName;
		/**
		 * The class name.
		 */
		public var className : String;

		/**
		 *  Creates a new instance of an empty ObjectInstance.
		 */
		public function ObjectInstance ();
		/**
		 *  Returns a string representation of the object name instance.     *      *  @return String representation of the object name instance.
		 */
		public function toString () : String;
	}
}
