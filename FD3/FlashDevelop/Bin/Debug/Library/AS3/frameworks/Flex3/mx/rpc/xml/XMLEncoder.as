package mx.rpc.xml
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import mx.collections.ArrayCollection;
	import mx.utils.DescribeTypeCache;
	import mx.utils.object_proxy;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;
	import mx.collections.IList;

	/**
	 * Encodes an ActionScript Object graph to XML based on an XML Schema. *  * @private
	 */
	public class XMLEncoder extends SchemaProcessor implements IXMLEncoder
	{
		private var _strictNillability : Boolean;
		private var _xmlSpecialCharsFilter : Function;

		/**
		 *
		 */
		public function get strictNillability () : Boolean;
		/**
		 *
		 */
		public function set strictNillability (strict:Boolean) : void;
		/**
		 * Function to be used for escaping XML special characters in simple content.     * Returns default implementation in this class.
		 */
		public function get xmlSpecialCharsFilter () : Function;
		/**
		 *
		 */
		public function set xmlSpecialCharsFilter (func:Function) : void;

		public function XMLEncoder ();
		/**
		 * Encodes an ActionScript value as XML.     *      * @param value The ActionScript value to encode as XML.     * @param name The QName of an XML Schema <code>element</code> that     * describes how to encode the value, or the name to be used for the     * encoded XML node when a type parameter is also specified.     * @param type The QName of an XML Schema <code>simpleType</code> or     * <code>complexType</code> definition that describes how to encode the     * @param definition If neither a top level element nor type exists in the     * schema to describe how to encode this value, a custom element definition     * can be provided.
		 */
		public function encode (value:*, name:QName = null, type:QName = null, definition:XML = null) : XMLList;
		/**
		 * All content:     *     (annotation?, (element | any)*)     *      * FIXME: This needs work, right now it treats all as a sequence.     * @private
		 */
		public function encodeAll (definition:XML, parent:XMLList, name:QName, value:*, isRequired:Boolean = true) : Boolean;
		/**
		 * Encodes any complex object values as attributes using the XML schema     * rules for attribute wildcards.     *      * FIXME: This needs further investigation of the XML schema spec for     * wildcard rules and constraints.     *      * @private
		 */
		public function encodeAnyAttribute (definition:XML, parent:XML, name:QName, value:* = undefined, restriction:XML = null) : void;
		/**
		 * Encodes elements based on wildcard rules.     *      * Any content:     *    (annotation?)     * @private     *
		 */
		public function encodeAnyElement (definition:XML, siblings:XMLList, name:QName, value:*, isRequired:Boolean = true, encodedVals:Dictionary = null) : Boolean;
		/**
		 * An attribute must be based on a simple type and thus will have simple     * content encoded as a String.     *     * This function is used to encode an <code>attribute</code> that may be     * named and registered as a top-level <code>schema</code> definition or     * in-line from a <code>complexType</code>, <code>extension</code> or     * <restriction> of either a <code>complexType</code> or     * <code>simpleType</code>, or <code>attributeGroup</code>     * definition in any aforementioned parent component.     *      * If the <code>attribute</code> points to a named definition using a      * <code>ref</code> attribute, the reference is resolved to provide the     * real definition of the attribute. If the reference cannot be resolved,     * an error is thrown.     *      * If the attribute defines a <code>fixed</code> constraint then any value     * provided is ignored and the fixed value is used instead. If a value is     * not provided and the attribute defines a <code>default</code>, the     * default is used for the encoded attribute. Otherwise if an attribute is     * marked as <code>optional</code> and a value is not provided it will be     * skipped.     *     * @param parent The parent instance to which these attributes will be added.     * @param definition The XML schema definition of the attribute.     * @param value An object with a property name that matches the resolved     * attribute name. The property value will be used as the encoded attribute     * value.     *      * FIXME: Attributes are expected to be simple values and must be ultimately     * representable as a String. If a complex value is passed to this method     * should we assume that we're always looking for a property with the same     * name as the attribute? We may need to because if we have a ref then the     * name is not known immediately...     *      * @private
		 */
		public function encodeAttribute (definition:XML, parent:XML, name:QName, value:* = undefined, restriction:XML = null) : void;
		/**
		 * An <code>attributeGroup</code> definition may include a number of     * <code>attribute</code> or <code>attributeGroup</code> children, all of     * which ultimately combine to form a flat group of attributes for some     * type. It may also specify <code>anyAttribute</code> which expands     * the definition to accept attributes based on more general criteria     * (such excluding or including attributes on namespace).     *     * This function is used to encode an <code>attributeGroup</code> that may      * be named and registered as a top-level <code>schema</code> definition or     * in-line from a <code>complexType</code>, <code>extension</code> or     * <restriction> of either a <code>complexType</code> or     * <code>simpleType</code>, or even another <code>attributeGroup</code>     * definition in any aforementioned parent component.     *      * If the <code>attributeGroup</code> points to a named definition using a     * ref attribute, the reference is resolved to provide the real definition     * of the attributeGroup. If the reference cannot be resolved, an error is     * thrown.     *      * @param parent The parent instance to which these attributes will be added.     * @param definition The XML schema definition of the attributeGroup.     * @param value An object with property names that match the resolved     * attribute names in the group. The property values will be used as the     * encoded attribute values. This argument may be omitted if each attribute     * in the group has a fixed or default value.     *      * @private
		 */
		public function encodeAttributeGroup (definition:XML, parent:XML, name:QName, value:* = undefined, restriction:XML = null) : void;
		/**
		 * choice:     *    (annotation?, (element | group | choice | sequence | any)*)     *      * @private
		 */
		public function encodeChoice (definition:XML, parent:XMLList, name:QName, value:*, isRequired:Boolean = true) : Boolean;
		/**
		 * Derivation by restriction takes an existing type as the base and creates     * a new type by limiting its allowed content to a subset of that allowed     * by the base type. Derivation by extension takes an existing type as the     * base and creates a new type by adding to its allowed content.     *      * complexContent:     * (annotation?, (restriction | extension))     *      * @private
		 */
		public function encodeComplexContent (definition:XML, parent:XML, name:QName, value:*) : void;
		/**
		 * complexContent:     *   extension:     *     (annotation?, ((group | all | choice | sequence)?, ((attribute | attributeGroup)*, anyAttribute?), (assert | report)*))     *      * @private
		 */
		public function encodeComplexExtension (definition:XML, parent:XML, name:QName, value:*) : void;
		/**
		 * complexContent:     *   restriction:     *     (annotation?, (group | all | choice | sequence)?, ((attribute | attributeGroup)*, anyAttribute?), (assert | report)*)     *      * @private
		 */
		public function encodeComplexRestriction (restriction:XML, parent:XML, name:QName, value:*) : void;
		public function encodeComplexType (definition:XML, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * Used to encode a local element definition (inside a model group).     * Handles restrictions on omittability and occurence counts in the     * context of the parent model group.     * Delegates actual encoding to encodeElementTopLevel once all the     * context around the element is known.     *      * @param definition The XML Schema definition of the local element.     * @param parent The XMLList of values encoded in the current level. The     * new encoded node should be appended to this XMLList.     * @param name The QName to be used for the encoded XML node.     * @param value The ActionScript value to encode as XML.     * @param isRequired A flag indicating wether the element should meet     * its local occurence bounds. For example, the local element may have     * minOccurs=1, but be only one of many elements in a choice group, in     * which case it is valid not to satisfy the minOccurs requirement.     *      * @return Wether or not the value provided      *      * FIXME: Support substitutionGroup, block and redefine?     * FIXME: Do we care about abstract or final?     * @private
		 */
		public function encodeGroupElement (definition:XML, siblings:XMLList, name:QName, value:*, isRequired:Boolean = true) : Boolean;
		/**
		 * Element content:     * (annotation?, ((simpleType | complexType)?, (unique | key | keyref)*))     *      * @private
		 */
		public function encodeElementTopLevel (definition:XML, elementQName:QName, value:*) : XML;
		/**
		 * The <code>group</code> element allows partial (or complete) content     * models to be reused in complex types. When used inside a choice,     * sequence, complexType, extension or restriction element, it must      * have a ref attribute, specifying the name of a global definition     * of a named model group.     *      * group:     * (annotation?, (all | choice | sequence)?)     *      * @private
		 */
		public function encodeGroupReference (definition:XML, parent:XMLList, name:QName, value:*, isRequired:Boolean = true) : Boolean;
		/**
		 * sequence:     *    (annotation?, (element | group | choice | sequence | any)*)     *      * @private
		 */
		public function encodeSequence (definition:XML, siblings:XMLList, name:QName, value:*, isRequired:Boolean = true) : Boolean;
		/**
		 * <code>simpleContent</code> specifies that the content will be simple text     * only, that is it conforms to a simple type and will not contain elements,     * although it may also define attributes.     *      * A simpleContent must be defined with an extension or a restriction. An     * extension specifies the attribute definitions that are to be added to the     * type and the base attribute specifies from which simple data type this     * custom type is defined. A restriction for simpleContent is less common,     * although it may be used to prohibit attributes in derived types also     * with simpleContent.     *      * simpleContent     *     (annotation?, (restriction | extension))     *      * @private
		 */
		public function encodeSimpleContent (definition:XML, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * A <code>simpleType</code> may declare a list of space separated     * simple content for a single value.     *      * <list     *     id = ID     *     itemType = QName >     *     Content: (annotation?, simpleType?)     * </list>     *      * @private
		 */
		public function encodeSimpleList (definition:XML, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * simpleType:     *   restriction: (annotation?, (simpleType?,     *       (minExclusive | minInclusive | maxExclusive | maxInclusive |     *       totalDigits | fractionDigits | maxScale | minScale | length |     *       minLength | maxLength | enumeration | whiteSpace | pattern)*))     *      * @private
		 */
		public function encodeSimpleRestriction (restriction:XML, parent:XML, name:QName, value:*) : void;
		/**
		 * <simpleType     *     final = (#all | List of (list | union | restriction | extension))     *     id = ID     *     name = NCName>     *     Content: (annotation?, (restriction | list | union))     * </simpleType>     *      * @private
		 */
		public function encodeSimpleType (definition:XML, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * <union     *     id = ID     *     memberTypes = List of QName >     *     Content: (annotation?, simpleType*)     * </union>     *      * FIXME: This needs a lot of work.     *      * @private
		 */
		public function encodeSimpleUnion (definition:XML, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * Allow instance specific overrides for concrete type information as     * abstract complexTypes may require a concrete xsi:type definition.     *      * @param parent A reference to the parent XML. Must not be null.     *     * @private
		 */
		public function encodeType (type:QName, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * Sets the xsi:nil attribute when necessary     *      * @param definition The Schema definition of the expected type. If     * nillable is strictly enforced, this definition must explicitly     * specify nillable=true.     *      * @param name The name of the element to be created     *      * @param value The value to check     *      * @return content The element where xsi:nil was set, or null if xsi:nil was     * not set.
		 */
		public function encodeXSINil (definition:XML, name:QName, value:*, isRequired:Boolean = true) : XML;
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
		public function setAttribute (parent:XML, name:*, value:*) : void;
		/**
		 * @private
		 */
		public function getProperties (value:*) : Array;
		/**
		 * Returns a single XML node with the given name     *      * @private
		 */
		public function createElement (name:*) : XML;
		/**
		 * @private
		 */
		public function getSimpleValue (parent:*, name:*) : *;
		/**
		 * Determines whether a value should be representable as a single, simple     * value, otherwise the object is regarded as "complex" and contains     * child values referenced by index or name.     *      * @private
		 */
		public function isSimpleValue (value:*) : Boolean;
		/**
		 * @private
		 */
		public function getValue (parent:*, name:*) : *;
		/**
		 * @private
		 */
		public function hasValue (parent:*, name:*) : Boolean;
		/**
		 * @private
		 */
		public function containsNodeByName (list:XMLList, name:QName, strict:Boolean = false) : Boolean;
		/**
		 * Looks up value by name on a complex parent object, considering that the     * name might have to be prepended with an underscore.     * @private
		 */
		public function resolveNamedProperty (parent:*, name:*) : *;
		/**
		 * Assigns value to an XML node.     *      * @param parent The node to assign to. Must be either XML or XMLList.     * If XMLList, it must contain at least one XML element. The value is     * assigned on the last element in the list. If XML, the value is assigned     * directly on parent.     * @param value The value to assign on the parent. If null, the xsi:nil     * attribute is set on the parent. If XML or XMLList, the value is appended     * as child node(s) on the parent. Otherwise the string representation of the     * value is appended as a text node. A value that is explicitly undefined is     * skipped.     *      * @private
		 */
		public function setValue (parent:*, value:*) : void;
		/**
		 * Appends a value (or list of values) directly as     * members of the parent XMLList. Effectively merges     * two XMLLists.     *      * @private
		 */
		public function appendValue (parent:XMLList, value:*) : void;
		/**
		 * Checks to see whether a value defines a custom XSI type to be used     * during encoding, otherwise the default type is returned.
		 */
		protected function getXSIType (value:*) : QName;
		/**
		 * Record custom XSI type information for this XML node by adding an     * xsi:type attribute with the value set to the qualified type name.
		 */
		protected function setXSIType (parent:XML, type:QName) : void;
		/**
		 * @private
		 */
		protected function deriveXSIType (parent:XML, type:QName, value:*) : void;
		/**
		 * @private     * Default implementation of xmlSpecialCharsFilter. Escapes "&" and "<".
		 */
		private function escapeXML (value:Object) : String;
	}
}
