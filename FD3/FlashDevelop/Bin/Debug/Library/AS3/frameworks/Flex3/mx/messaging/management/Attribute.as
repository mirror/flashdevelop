package mx.messaging.management
{
	import mx.utils.ObjectUtil;

	/**
	 * Client representation of a MBean attribute.
	 */
	public class Attribute
	{
		/**
		 * The attribute name.
		 */
		public var name : String;
		/**
		 * The attribute value.
		 */
		public var value : Object;

		/**
		 *  Creates a new instance of an empty Attribute.
		 */
		public function Attribute ();
		/**
		 *  Returns a string representation of the attribute.     *      *  @return String representation of the attribute.
		 */
		public function toString () : String;
	}
}
