package mx.rpc.xml
{
	/**
	 * SchemaManager manages multiple Schema definitions by target namespace. *  * @private
	 */
	public class SchemaManager extends QualifiedResourceManager
	{
		private var namespaceCount : uint;
		/**
		 * A Stack of Schemas which records the current scope and the last Schema     * that was accessed to locate a definition. Multiple Schemas may be     * placed in Scope at any level by adding them to the Stack as an Array.
		 */
		private var schemaStack : Array;
		private var initialScope : *;
		private var _namespaces : Object;
		private var _schemaMarshaller : SchemaMarshaller;
		private var _schemaConstants : SchemaConstants;
		private var _schemaDatatypes : SchemaDatatypes;

		public function get namespaces () : Object;
		public function set namespaces (value:Object) : void;
		/**
		 * The constants for the version of Schema that is to be used      * in the type system associated with this manager, such as a WSDL     * types definition.     *      * FIXME: Verify that it is legal for a type system to refer to two     * different Schemas that use different version of the XML Schema     * specification? If so, then the schemaConstants could be obtained     * from each Schema.
		 */
		public function get schemaConstants () : SchemaConstants;
		public function set schemaConstants (value:SchemaConstants) : void;
		public function get schemaMarshaller () : SchemaMarshaller;
		public function get schemaDatatypes () : SchemaDatatypes;
		/**
		 * Returns the Schema that was last used to retrieve a definition.
		 */
		public function get currentSchema () : Schema;

		public function SchemaManager ();
		public function addNamespaces (map:Object) : void;
		/**
		 * Adds a Schema to the current scope. If a Schema already exists in     * the scope then the scope is promoted to an Array of Schemas.
		 */
		public function addSchema (schema:Schema, toCurrentScope:Boolean = true) : void;
		public function currentScope () : Array;
		/**
		 * Look for the definition of the given QName in all schemas in the current     * scope. If the definition could not be found the function returns null.     *      * @param name The name of the component defined in a schema.     * @param componentTypes A list of structural element types that may have     * the name provided, such as &lt;element&gt;, &lt;complexType&gt;, &lt;simpleType&gt;,     * &lt;attribute&gt; or &lt;attributeGroup&gt;. The first one found is returned.
		 */
		public function getNamedDefinition (name:QName, ...componentTypes:Array) : XML;
		/**
		 * Locate a schema for the given namespace and push it to a     * new scope level.
		 */
		public function pushNamespaceInScope (nsParam:*) : Boolean;
		/**
		 * Push the given Schema to a new scope level, and set it as the     * current schema for that scope.     *      * @param schema The Schema to push to a new scope
		 */
		public function pushSchemaInScope (schema:Schema) : void;
		/**
		 * @private FIXME: Find a better method name and/or document
		 */
		public function getOrCreatePrefix (uri:String) : String;
		public function getQNameForAttribute (ncname:String, form:String = null) : QName;
		public function getQNameForElement (ncname:String, form:String = null) : QName;
		/**
		 * Resolves a prefixed name back into a QName based on the prefix to     * namespace mappings.     *      * @param prefixedName The name to be resolved. Can be prefixed or unqualified.     * @param parent The XML node where prefixedName appears. Allows local xmlns     * declarations to be examined     * @param qualifyToTargetNamespace A switch controlling the behavior for     * unqualified names. If false, unqualified names are assumed to be prefixed     * by "" and a xmlns="..." declaration is looked up. If no xmlns=".."     * declaration is in scope, and the parent node is in the default namespace,     * the prefixedName is resolved to the default namespace. Otherwise, it is     * resolved to the targetNamespace of the current schema. If qualifyToTargetNamespace     * is true, unqualified names are assumed to be in the target namespace of     * the current schema, regardless of declarations for unprefixed namespaces.     * qualifyToTargetNamespace should be true when resolving names coming from     * the following schema attributes: name, ref.
		 */
		public function getQNameForPrefixedName (prefixedName:String, parent:XML = null, qualifyToTargetNamespace:Boolean = false) : QName;
		/**
		 * Converts ActionScript to XML based on default rules     * established for each of the built-in XML Schema types.
		 */
		public function marshall (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * Informs the SchemaManager that the current definition is no     * longer being processed so we release the associated Schema from the     * current scope of qualified definitions.
		 */
		public function releaseScope () : *;
		/**
		 * Reverts to initialScope.
		 */
		public function reset () : void;
		/**
		 * Converts XML to ActionScript based on default rules     * established for each of the built-in XML Schema types.
		 */
		public function unmarshall (value:*, type:QName = null, restriction:XML = null) : *;
	}
}
