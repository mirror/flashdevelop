package mx.rpc.xml
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * XMLDecoder uses this class to map an XML Schema type by QName to an * ActionScript Class so that it can create strongly typed objects when * decoding content. If the type is unqualified the QName uri may * be left null or set to the empty String. * <p> * It is important to note that the desired Class must be linked into the SWF * and possess a default constructor in order for the XMLDecoder to create a * new instance of the type, otherwise an anonymous Object will be used to * hold the decoded properties. * </p>
	 */
	public class SchemaTypeRegistry
	{
		private var classMap : Object;
		private var collectionMap : Object;
		private static var _instance : SchemaTypeRegistry;

		/**
		 * Returns the sole instance of this singleton class, creating it if it     * does not already exist.     *     * @return Returns the sole instance of this singleton class, creating it     * if it does not already exist.
		 */
		public static function getInstance () : SchemaTypeRegistry;
		/**
		 * @private
		 */
		public function SchemaTypeRegistry ();
		/**
		 * Looks for a registered Class for the given type.     * @param type The QName or String representing the type name.     * @return Returns the Class for the given type, or null of the type     * has not been registered.
		 */
		public function getClass (type:Object) : Class;
		/**
		 * Returns the Class for the collection type represented by the given     * Qname or String.     *     * @param type The QName or String representing the collection type name.     *     * @return Returns the Class for the collection type represented by      * the given Qname or String.
		 */
		public function getCollectionClass (type:Object) : Class;
		/**
		 * Maps a type QName to a Class definition. The definition can be a String     * representation of the fully qualified class name or an instance of the     * Class itself.     * @param type The QName or String representation of the type name.     * @param definition The Class itself or class name as a String.
		 */
		public function registerClass (type:Object, definition:Object) : void;
		/**
		 * Maps a type name to a collection Class. A collection is either the      * top level Array type, or an implementation of <code>mx.collections.IList</code>.      * The definition can be a String representation of the fully qualified     * class name or an instance of the Class itself.     *     * @param type The QName or String representation of the type name.     *     * @param definition The Class itself or class name as a String.
		 */
		public function registerCollectionClass (type:Object, definition:Object) : void;
		/**
		 * Removes a Class from the registry for the given type.     * @param type The QName or String representation of the type name.
		 */
		public function unregisterClass (type:Object) : void;
		/**
		 * Removes a collection Class from the registry for the given type.     * @param type The QName or String representation of the collection type     * name.
		 */
		public function unregisterCollectionClass (type:Object) : void;
		/**
		 * @private     * Converts the given type name into a consistent String representation     * that serves as the key to the type map.     * @param type The QName or String representation of the type name.
		 */
		private function getKey (type:Object) : String;
		/**
		 * @private
		 */
		private function register (type:Object, definition:Object, map:Object) : void;
	}
}
