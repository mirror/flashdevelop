package mx.messaging.management
{
	import mx.utils.ObjectUtil;

	/**
	 * Client representation of the name for server-side management controls.
	 */
	public class ObjectName
	{
		/**
		 * The canonical form of the name; a string representation with 	 * the properties sorted in lexical order.
		 */
		public var canonicalName : String;
		/**
		 * A string representation of the list of key properties, with the key properties sorted in lexical order.
		 */
		public var canonicalKeyPropertyListString : String;
		/**
		 * Indicates if the object name is a pattern.
		 */
		public var pattern : Boolean;
		/**
		 * Indicates if the object name is a pattern on the domain part.
		 */
		public var domainPattern : Boolean;
		/**
		 * Indicates if the object name is a pattern on the key properties.
		 */
		public var propertyPattern : Boolean;
		/**
		 * The domain part.
		 */
		public var domain : String;
		/**
		 * The key properties as an Object, keyed by property name.
		 */
		public var keyPropertyList : Object;
		/**
		 * A string representation of the list of key properties.
		 */
		public var keyPropertyListString : String;

		/**
		 *  Creates a new instance of an empty ObjectName.
		 */
		public function ObjectName ();
		/**
		 * Returns the value associated with the specified property key.	 *	 * @param The property key.
		 */
		public function getKeyProperty (property:String) : Object;
		/**
		 *  This method will return a string representation of the object name.     *      *  @return String representation of the object name.
		 */
		public function toString () : String;
	}
}
