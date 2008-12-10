package mx.rpc.xml
{
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.DescribeTypeCache;
	import mx.utils.object_proxy;
	import mx.utils.ObjectProxy;
	import mx.utils.URLUtil;
	import mx.utils.XMLUtil;

	/**
	 * Decodes an XML document to an object graph based on XML Schema definitions. *  * @private
	 */
	public class XMLDecoder extends SchemaProcessor implements IXMLDecoder
	{
		/**
		 * The <code>mx.collections.IList</code> implementation to use when decoding     * an array of values and <code>makeObjectsBindable</code> is set to true.     * The default is <code>mx.collections.ArrayCollection</code>.
		 */
		public static var listClass : Class;
		/**
		 * The current, top level XML document to decode.
		 */
		protected var document : XML;
		private var log : ILogger;
		private var _makeObjectsBindable : Boolean;
		private var _recordXSIType : Boolean;
		private var _typeRegistry : SchemaTypeRegistry;

		/**
		 * When makeObjectsBindable is set to true, anonymous Objects and Arrays     * are wrapped to make them bindable. Objects are wrapped with     * <code>mx.utils.ObjectProxy</code> and Arrays are wrapped with     * <code>mx.collections.ArrayCollection</code>.
		 */
		public function get makeObjectsBindable () : Boolean;
		public function set makeObjectsBindable (value:Boolean) : void;
		/**
		 * When recordXSIType is set to true, if an encoded complexType     * has an <code>xsi:type</code> attribute the type information will be     * recorded on the decoded instance if it is strongly typed and implements     * <code>mx.rpc.xml.IXMLSchemaInstance</code> or is an anonymous     * <code>mx.utils.ObjectProxy</code>. This type information can be used     * to post process the decoded objects and identify which concrete     * implementation of a potentially abstract type was used.     * The default is false.
		 */
		public function get recordXSIType () : Boolean;
		public function set recordXSIType (value:Boolean) : void;
		/**
		 * Maps XML Schema types by QName to ActionScript Classes in order to      * create strongly typed objects when decoding content.
		 */
		public function get typeRegistry () : SchemaTypeRegistry;
		public function set typeRegistry (value:SchemaTypeRegistry) : void;

		public function XMLDecoder ();
		/**
		 * Decodes an XML document to an ActionScript object.     *      * @param xml The XML instance to decode to an ActionScript object.      * This may be an XML instance, an XMLList of length 1 or a String that is     * valid XML.     * @param name The QName of an XML Schema <code>element</code> that     * describes how to decode the value, or the name to be used for the     * decoded value when a type parameter is also specified.     * @param type The QName of an XML Schema <code>simpleType</code> or     * <code>complexType</code> definition that describes how to decode the     * value.     * @param definition If neither a top level element nor type exists in the     * schema to describe how to decode this value, a custom element definition     * can be provided.
		 */
		public function decode (xml:*, name:QName = null, type:QName = null, definition:XML = null) : *;
		/**
		 * All content:     *     (annotation?, (element | any)*)     *      * <ul>     * <li>maxOccurs for 'all' itself must be 1, minOccurs can be 0 or 1</li>     * <li>maxOccurs for element declarations must be 1, minOccurs can be     * 0 or 1</li>     * <li>'all' does not contain other groups and it must not appear in other     * structure groups - it must be at the top level of a complexType.</li>     * </ul>     *      * @private
		 */
		public function decodeAll (definition:XML, parent:*, name:QName, valueElements:XMLList, context:DecodingContext = null, isRequired:Boolean = true) : Boolean;
		public function decodeAnyType (parent:*, name:QName, valueElements:XMLList) : void;
		/**
		 * Decodes <any> elements from the context of a model group. The valueElements     * list contains all top-level values for all elements in the current model     * group. This method picks up the first undecoded value and      *      * Any content:     *    (annotation?)     * @private
		 */
		public function decodeAnyElement (definition:XML, parent:*, name:QName, valueElements:XMLList, context:DecodingContext = null, isRequired:Boolean = true) : Boolean;
		/**
		 * Decodes any attributes using the XML schema rules for attribute     * wildcards.     *      * FIXME: This needs further investigation of the XML schema spec for     * wildcard rules and constraints.     *      * @private
		 */
		public function decodeAnyAttribute (definition:XML, parent:*, value:* = undefined, restriction:XML = null) : void;
		/**
		 * An attribute must be based on a simple type and thus will have simple     * content encoded as a String.     *     * This function is used to encode an <code>attribute</code> that may be     * named and registered as a top-level <code>schema</code> definition or     * in-line from a <code>complexType</code>, <code>extension</code> or     * <restriction> of either a <code>complexType</code> or     * <code>simpleType</code>, or <code>attributeGroup</code>     * definition in any aforementioned parent component.     *      * If the <code>attribute</code> points to a named definition using a      * <code>ref</code> attribute, the reference is resolved to provide the     * real definition of the attribute. If the reference cannot be resolved,     * an error is thrown.     *      * If the attribute defines a <code>fixed</code> constraint then any value     * provided is ignored and the fixed value is used instead. If a value is     * not provided and the attribute defines a <code>default</code>, the     * default is used for the encoded attribute. Otherwise if an attribute is     * marked as <code>optional</code> and a value is not provided it will be     * skipped.     *     * @param parent The parent instance to which these attributes will be added.     * @param definition The XML schema definition of the attribute.     * @param value An object with a property name that matches the resolved     * attribute name. The property value will be used as the encoded attribute     * value.     *      * FIXME: Attributes are expected to be simple values and must be ultimately     * representable as a String. If a complex value is passed to this method     * should we assume that we're always looking for a property with the same     * name as the attribute? We may need to because if we have a ref then the     * name is not known immediately...     *      * @private
		 */
		public function decodeAttribute (definition:XML, parent:*, value:* = undefined, restriction:XML = null) : void;
		/**
		 * An <code>attributeGroup</code> definition may include a number of     * <code>attribute</code> or <code>attributeGroup</code> children, all of     * which ultimately combine to form a flat group of attributes for some     * type. It may also specify <code>anyAttribute</code> which expands     * the definition to accept attributes based on more general criteria     * (such excluding or including attributes on namespace).     *     * This function is used to encode an <code>attributeGroup</code> that may      * be named and registered as a top-level <code>schema</code> definition or     * in-line from a <code>complexType</code>, <code>extension</code> or     * <restriction> of either a <code>complexType</code> or     * <code>simpleType</code>, or even another <code>attributeGroup</code>     * definition in any aforementioned parent component.     *      * If the <code>attributeGroup</code> points to a named definition using a     * ref attribute, the reference is resolved to provide the real definition     * of the attributeGroup. If the reference cannot be resolved, an error is     * thrown.     *      * @param parent The parent instance to which these attributes will be added.     * @param definition The XML schema definition of the attributeGroup.     * @param value An object with property names that match the resolved     * attribute names in the group. The property values will be used as the     * encoded attribute values. This argument may be omitted if each attribute     * in the group has a fixed or default value.     *      * @private
		 */
		public function decodeAttributeGroup (definition:XML, parent:*, value:* = undefined, restriction:XML = null) : void;
		/**
		 * choice:     *    (annotation?, (element | group | choice | sequence | any)*)     *      * @param context A DecodingContext instance. Used to keep track     * of the index of the element being processed in the current model     * group.     *      * @private
		 */
		public function decodeChoice (definition:XML, parent:*, name:QName, valueElements:XMLList, context:DecodingContext = null, isRequired:Boolean = true) : Boolean;
		/**
		 * Derivation by restriction takes an existing type as the base and creates     * a new type by limiting its allowed content to a subset of that allowed     * by the base type. Derivation by extension takes an existing type as the     * base and creates a new type by adding to its allowed content.     *      * complexContent:     * (annotation?, (restriction | extension))     *      * @private
		 */
		public function decodeComplexContent (definition:XML, parent:*, name:QName, value:*, context:DecodingContext) : void;
		/**
		 * complexContent:     *   extension:     *     (annotation?, ((group | all | choice | sequence)?, ((attribute | attributeGroup)*, anyAttribute?), (assert | report)*))     *      * @private
		 */
		public function decodeComplexExtension (definition:XML, parent:*, name:QName, value:*, context:DecodingContext = null) : void;
		/**
		 * complexContent:     *   restriction:     *     (annotation?, (group | all | choice | sequence)?, ((attribute | attributeGroup)*, anyAttribute?), (assert | report)*)     *      * @private
		 */
		public function decodeComplexRestriction (restriction:XML, parent:*, name:QName, value:*) : void;
		/**
		 * @private
		 */
		public function decodeComplexType (definition:XML, parent:*, name:QName, value:*, restriction:XML = null, context:DecodingContext = null) : void;
		/**
		 * Used to decode a local element definition. This element may also simply     * refer to a top level element.     *      * Element content:     * (annotation?, ((simpleType | complexType)?, (unique | key | keyref)*))     *      * FIXME: Support substitutionGroup, block and redefine?     * FIXME: Do we care about abstract or final?     *      * FIXME: Remove isRequired if not necessary...     *      * @private
		 */
		public function decodeGroupElement (definition:XML, parent:*, valueElements:XMLList, context:DecodingContext = null, isRequired:Boolean = true, hasSiblings:Boolean = true) : Boolean;
		/**
		 * Element content:     * (annotation?, ((simpleType | complexType)?, (unique | key | keyref)*))     *      * @private
		 */
		public function decodeElementTopLevel (definition:XML, elementQName:QName, value:*) : *;
		/**
		 * The <code>group</code> element allows partial (or complete) content     * models to be reused in complex types.     *      * group:     * (annotation?, (all | choice | sequence)?)     *      * @private
		 */
		public function decodeGroupReference (definition:XML, parent:*, name:QName, valueElements:XMLList, context:DecodingContext = null, isRequired:Boolean = true) : Boolean;
		/**
		 * sequence:     *    (annotation?, (element | group | choice | sequence | any)*)     *      * @private
		 */
		public function decodeSequence (definition:XML, parent:*, name:QName, valueElements:XMLList, context:DecodingContext = null, isRequired:Boolean = true) : Boolean;
		/**
		 * <code>simpleContent</code> specifies that the content will be simple text     * only, that is it conforms to a simple type and will not contain elements,     * although it may also define attributes.     *      * A simpleContent must be defined with an extension or a restriction. An     * extension specifies the attribute definitions that are to be added to the     * type and the base attribute specifies from which simple data type this     * custom type is defined. A restriction for simpleContent is less common,     * although it may be used to prohibit attributes in derived types also     * with simpleContent.     *      * simpleContent     *     (annotation?, (restriction | extension))     *      * @private
		 */
		public function decodeSimpleContent (definition:XML, parent:*, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * A <code>simpleType</code> may declare a list of space separated     * simple content for a single value.     *      * <list     *     id = ID     *     itemType = QName >     *     Content: (annotation?, simpleType?)     * </list>     *      * @private
		 */
		public function decodeSimpleList (definition:XML, parent:*, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * simpleType:     *   restriction: (annotation?, (simpleType?,     *       (minExclusive | minInclusive | maxExclusive | maxInclusive |     *       totalDigits | fractionDigits | maxScale | minScale | length |     *       minLength | maxLength | enumeration | whiteSpace | pattern)*))     *      * @private
		 */
		public function decodeSimpleRestriction (restriction:XML, parent:*, name:QName, value:*) : void;
		/**
		 * <simpleType     *     final = (#all | List of (list | union | restriction | extension))     *     id = ID     *     name = NCName>     *     Content: (annotation?, (restriction | list | union))     * </simpleType>     *      * @private
		 */
		public function decodeSimpleType (definition:XML, parent:*, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * <union     *     id = ID     *     memberTypes = List of QName >     *     Content: (annotation?, simpleType*)     * </union>     *      * FIXME: This needs a lot of work.     *      * @private
		 */
		public function decodeSimpleUnion (definition:XML, parent:*, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * @private
		 */
		public function decodeType (type:QName, parent:*, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * This function controls the marshalling of XML values into     * ActionScript values for a <code>simpleType</code>.     *      * All simple types are derived from a built-in schema simple types, with     * the parent being <code>allSimpleTypes</code>. Simple types must not     * have complex content as they are also used to describe the values of     * attributes.     *      * If this method is called with the schema <code>anyType</code> and a     * value with complex content it redirects to decodeAny to handle generic     * complex types without a type definition.     *      * @private
		 */
		public function marshallBuiltInType (type:QName, parent:*, name:QName, value:*, restriction:XML = null) : *;
		/**
		 * Resets the decoder to its initial state, including resetting any      * Schema scope to the top level and releases the current XML document by     * setting it to null.
		 */
		public function reset () : void;
		/**
		 * @private
		 */
		public function getAttribute (parent:*, name:*) : *;
		/**
		 * @private
		 */
		public function hasAttribute (parent:*, name:*) : Boolean;
		/**
		 * @private
		 */
		public function setAttribute (parent:*, name:*, value:*) : void;
		/**
		 * @private
		 */
		public function getProperties (value:*) : Array;
		/**
		 * @private
		 */
		public function createContent (type:QName = null) : *;
		/**
		 * @private
		 */
		public function isSimpleValue (value:*) : Boolean;
		/**
		 * If the parent only contains simple content, then that content is     * returned as the value, otherwise getValue is called.     *      * @private
		 */
		public function getSimpleValue (parent:*, name:*) : *;
		/**
		 * @private
		 */
		public function setSimpleValue (parent:*, name:*, value:*, type:Object = null) : void;
		/**
		 * Assuming the parent is XML, the decoder looks for child element(s) with     * the given name. If a single child element exists that contains simple     * content, the simple content is returned unwrapped.     * @see #parseValue
		 */
		public function getValue (parent:*, name:*, index:Number = -1) : *;
		/**
		 * @private
		 */
		public function hasValue (parent:*, name:*) : Boolean;
		/**
		 * @private
		 */
		public function setValue (parent:*, name:*, value:*, type:Object = null) : void;
		/**
		 * If an array value is required (as when decoding an element     * with maxOccurs > 1), we need to create an empty Array or the     * appropriate instance of IList. The optional parameter unwrap     * can be set to true to indicate that the array should be the     * parent object itself, and not a property on the parent.     *      * @param type Optional. The XML Schema type for the property     * that holds this iterable value. The SchemaTypeRegistry will be checked     * to see if a custom collection Class has been registered for that     * type.     *      * @private
		 */
		public function createIterableValue (type:Object = null) : *;
		/**
		 * Returns the appropriate values from the list of encoded elements in a    * model group. In the base case, start from the current index and return    * consequent elements with the given name. If context.anyIndex > -1 an <any>    * definition has already decoded some values, so we start at anyIndex until    * we find a value by the same name, possibly one that has already been    * decoded. If that is the case, the previously decoded value is removed from    * the parent.    * @private
		 */
		protected function getApplicableValues (parent:*, valueElements:XMLList, name:QName, context:DecodingContext, maxOccurs:uint) : XMLList;
		/**
		 * Tests whether a given namespace is included in a wildcard definition. If     * no restrictions are provided the default behavior is to include all     * namespaces.
		 */
		protected function includeNamespace (namespaceURI:String, includedNamespaces:Array = null) : Boolean;
		/**
		 * This method primarily exists to give subclasses a chance to post-process     * returned value(s) before the decoder processes them. This particular     * implementation checks to see if the value is not a list of values (i.e.     * it existed as a single child element) and contains only simple content -     * if so, the simple content is returned unwrapped.     *      * @private
		 */
		protected function parseValue (name:*, value:XMLList) : *;
		protected function isXSINil (value:*) : Boolean;
		/**
		 * This function determines whether a given value is already iterable     * and if not, wraps the value in a suitable iterable implementation. If     * the value needs to be wrapped, makeObjectsBindable set to false will     * just wrap the value in an Array where as makeObjectsBindable set to true     * will wrap the value in the current listClass implementation, which     * by default is an ArrayCollection.     *      * @param value The value to promote to an iterable type, such as an Array.     * @param type Optional. The XML Schema type for the property that     * will hold this iterable value.     *      * @private
		 */
		protected function promoteValueToArray (value:*, type:Object = null) : *;
		/**
		 * Search for an XSI type attribute on an XML value.     *      * @private
		 */
		protected function getXSIType (value:*) : QName;
		/**
		 * We record the qualified type used for anonymous objects wrapped in     * ObjectProxy or for strongly typed objects that implement     * IXMLSchemaInstance.     *      * @private
		 */
		protected function setXSIType (value:*, type:QName) : void;
		/**
		 * @private
		 */
		protected function getExistingValue (parent:*, propertyName:String) : *;
		/**
		 * Noop. Method exists to give a chance to subclasses to pre-process the     * encoded XML.     * @private
		 */
		protected function preProcessXML (root:XML) : void;
	}
}
