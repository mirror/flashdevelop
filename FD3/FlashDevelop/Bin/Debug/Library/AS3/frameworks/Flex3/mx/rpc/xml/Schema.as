package mx.rpc.xml
{
	/**
	 * Manages an XML Schema Definition. Schemas can import other schemas. *  * @private
	 */
	public class Schema
	{
		public var attributeFormDefault : String;
		public var blockDefault : String;
		public var elementFormDefault : String;
		public var finalDefault : String;
		private var importsManager : QualifiedResourceManager;
		private var _namespaces : Object;
		private var _schemaConstants : SchemaConstants;
		private var _schemaDatatypes : SchemaDatatypes;
		private var _targetNamespace : Namespace;
		private var _xml : XML;

		/**
		 * Maps a namespace prefix (as a <code>String</code>) to a     * <code>Namespace</code> (i.e. this helps to resolve a prefix to a URI).
		 */
		public function get namespaces () : Object;
		public function set namespaces (value:Object) : void;
		/**
		 * The targetNamespace of this Schema. A targetNamespace establishes a     * scope for the collection of type definitions and element declarations     * to distinguish them from in-built XML Schema types and other collections     * of types.
		 */
		public function get targetNamespace () : Namespace;
		public function set targetNamespace (tns:Namespace) : void;
		/**
		 * Constants for the particular version of XML Schema that was used     * to define this Schema.
		 */
		public function get schemaConstants () : SchemaConstants;
		/**
		 * Datatype constants for the particular version of XML Schema that was     * used to define this Schema.
		 */
		public function get schemaDatatypes () : SchemaDatatypes;
		/**
		 * The raw XML definition of this Schema.
		 */
		public function get xml () : XML;
		public function set xml (value:XML) : void;

		public function Schema (xml:XML = null);
		/**
		 FIXME:        1. Validate that the targetNamespace matches the one defined on the           import XML        2. Also, check that the schema being added does not cause a cyclic        relationship.
		 */
		public function addImport (targetNamespace:Namespace, schema:Schema) : void;
		public function addInclude (fragment:XMLList) : void;
		public function getNamedDefinition (name:QName, ...componentTypes:Array) : Object;
	}
}
