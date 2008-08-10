/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public final dynamic  class XML {
		/**
		 * Determines whether XML comments are ignored
		 *  when XML objects parse the source XML data. By default, the comments are ignored
		 *  (true). To include XML comments, set this property to false.
		 *  The ignoreComments property is used only during the XML parsing, not during
		 *  the call to any method such as myXMLObject.child(*).toXMLString().
		 *  If the source XML includes comment nodes, they are kept or discarded during the XML parsing.
		 */
		public static function get ignoreComments():Boolean;
		public function set ignoreComments(value:Boolean):void;
		/**
		 * Determines whether XML
		 *  processing instructions are ignored when XML objects parse the source XML data.
		 *  By default, the processing instructions are ignored (true). To include XML
		 *  processing instructions, set this property to false. The
		 *  ignoreProcessingInstructions property is used only during the XML parsing,
		 *  not during the call to any method such as myXMLObject.child(*).toXMLString().
		 *  If the source XML includes processing instructions nodes, they are kept or discarded during
		 *  the XML parsing.
		 */
		public static function get ignoreProcessingInstructions():Boolean;
		public function set ignoreProcessingInstructions(value:Boolean):void;
		/**
		 * Determines whether white space characters
		 *  at the beginning and end of text nodes are ignored during parsing. By default,
		 *  white space is ignored (true). If a text node is 100% white space and the
		 *  ignoreWhitespace property is set to true, then the node is not created.
		 *  To show white space in a text node, set the ignoreWhitespace property to
		 *  false.
		 */
		public static function get ignoreWhitespace():Boolean;
		public function set ignoreWhitespace(value:Boolean):void;
		/**
		 * Determines the amount of indentation applied by
		 *  the toString() and toXMLString() methods when
		 *  the XML.prettyPrinting property is set to true.
		 *  Indentation is applied with the space character, not the tab character.
		 *  The default value is 2.
		 */
		public static function get prettyIndent():int;
		public function set prettyIndent(value:int):void;
		/**
		 * Determines whether the toString()
		 *  and toXMLString() methods normalize white space characters between some tags.
		 *  The default value is true.
		 */
		public static function get prettyPrinting():Boolean;
		public function set prettyPrinting(value:Boolean):void;
		/**
		 * Creates a new XML object. You must use the constructor to create an
		 *  XML object before you call any of the methods of the XML class.
		 *
		 * @param value             <Object> Any object that can be converted to XML with the top-level
		 *                            XML() function.
		 */
		public function XML(value:Object);
		/**
		 * Adds a namespace to the set of in-scope namespaces for the XML object. If the namespace already
		 *  exists in the in-scope namespaces for the XML object (with a prefix matching that of the given
		 *  parameter), then the prefix of the existing namespace is set to undefined. If the input parameter
		 *  is a Namespace object, it's used directly. If it's a QName object, the input parameter's
		 *  URI is used to create a new namespace; otherwise, it's converted to a String and a namespace is created from
		 *  the String.
		 *
		 * @param ns                <Object> The namespace to add to the XML object.
		 * @return                  <XML> The new XML object, with the namespace added.
		 */
		AS3 function addNamespace(ns:Object):XML;
		/**
		 * Appends the given child to the end of the XML object's properties.
		 *  The appendChild() method takes an XML object, an XMLList object, or
		 *  any other data type that is then converted to a String.
		 *
		 * @param child             <Object> The XML object to append.
		 * @return                  <XML> The resulting XML object.
		 */
		AS3 function appendChild(child:Object):XML;
		/**
		 * Returns the XML value of the attribute that has the name matching the attributeName
		 *  parameter. Attributes are found within XML elements.
		 *  In the following example, the element has an attribute named "gender"
		 *  with the value "boy": <first gender="boy">John</first>.
		 *
		 * @param attributeName     <*> The name of the attribute.
		 * @return                  <XMLList> An XMLList object or an empty XMLList object. Returns an empty XMLList object
		 *                            when an attribute value has not been defined.
		 */
		AS3 function attribute(attributeName:*):XMLList;
		/**
		 * Returns a list of attribute values for the given XML object. Use the name()
		 *  method with the attributes() method to return the name of an attribute.
		 *  Use @* to return the names of all attributes.
		 *
		 * @return                  <XMLList> The list of attribute values.
		 */
		AS3 function attributes():XMLList;
		/**
		 * Lists the children of an XML object. An XML child is an XML element, text node, comment,
		 *  or processing instruction.
		 *
		 * @param propertyName      <Object> The element name or integer of the XML child.
		 * @return                  <XMLList> An XMLList object of child nodes that match the input parameter.
		 */
		AS3 function child(propertyName:Object):XMLList;
		/**
		 * Identifies the zero-indexed position of this XML object within the context of its parent.
		 *
		 * @return                  <int> The position of the object. Returns -1 as well as positive integers.
		 */
		AS3 function childIndex():int;
		/**
		 * Lists the children of the XML object in the sequence in which they appear. An XML child
		 *  is an XML element, text node, comment, or processing instruction.
		 *
		 * @return                  <XMLList> An XMLList object of the XML object's children.
		 */
		AS3 function children():XMLList;
		/**
		 * Lists the properties of the XML object that contain XML comments.
		 *
		 * @return                  <XMLList> An XMLList object of the properties that contain comments.
		 */
		AS3 function comments():XMLList;
		/**
		 * Compares the XML object against the given value parameter.
		 *
		 * @param value             <XML> A value to compare against the current XML object.
		 * @return                  <Boolean> If the XML object matches the value parameter, then true; otherwise false.
		 */
		AS3 function contains(value:XML):Boolean;
		/**
		 * Returns a copy of the given XML object. The copy is a duplicate of the entire tree of nodes.
		 *  The copied XML object has no parent and returns null if you attempt to call the
		 *  parent() method.
		 *
		 * @return                  <XML> The copy of the object.
		 */
		AS3 function copy():XML;
		/**
		 * Returns an object with the following properties set to the default values: ignoreComments,
		 *  ignoreProcessingInstructions, ignoreWhitespace, prettyIndent, and
		 *  prettyPrinting. The default values are as follows:
		 *  ignoreComments = true
		 *  ignoreProcessingInstructions = true
		 *  ignoreWhitespace = true
		 *  prettyIndent = 2
		 *  prettyPrinting = true
		 *
		 * @return                  <Object> An object with properties set to the default settings.
		 */
		AS3 static function defaultSettings():Object;
		/**
		 * Returns all descendants (children, grandchildren, great-grandchildren, and so on) of the
		 *  XML object that have the given name parameter. The name parameter
		 *  is optional. The name parameter can be a QName object, a String data type
		 *  or any other data type that is then converted to a String data type.
		 *
		 * @param name              <Object (default = *)> The name of the element to match.
		 * @return                  <XMLList> An XMLList object of matching descendants. If there are no descendants, returns an
		 *                            empty XMLList object.
		 */
		AS3 function descendants(name:Object = *):XMLList;
		/**
		 * Lists the elements of an XML object. An element consists of a start and an end tag;
		 *  for example <first></first>. The name parameter
		 *  is optional. The name parameter can be a QName object, a String data type,
		 *  or any other data type that is then converted to a String data type. Use the name parameter to list a specific element. For example,
		 *  the element "first" returns "John" in this example:
		 *  <first>John</first>.
		 *
		 * @param name              <Object (default = *)> The name of the element. An element's name is surrounded by angle brackets.
		 *                            For example, "first" is the name in this example:
		 *                            <first></first>.
		 * @return                  <XMLList> An XMLList object of the element's content. The element's content falls between the start and
		 *                            end tags. If you use the asterisk (*) to call all elements, both the
		 *                            element's tags and content are returned.
		 */
		AS3 function elements(name:Object = *):XMLList;
		/**
		 * Checks to see whether the XML object contains complex content. An XML object contains complex content if
		 *  it has child elements. XML objects that representing attributes, comments, processing instructions,
		 *  and text nodes do not have complex content. However, an object that contains these can
		 *  still be considered to contain complex content (if the object has child elements).
		 *
		 * @return                  <Boolean> If the XML object contains complex content, true; otherwise false.
		 */
		AS3 function hasComplexContent():Boolean;
		/**
		 * Checks to see whether the object has the property specified by the p parameter.
		 *
		 * @param p                 <String> The property to match.
		 * @return                  <Boolean> If the property exists, true; otherwise false.
		 */
		AS3 function hasOwnProperty(p:String):Boolean;
		/**
		 * Checks to see whether the XML object contains simple content. An XML object contains simple content
		 *  if it represents a text node, an attribute node, or an XML element that has no child elements.
		 *  XML objects that represent comments and processing instructions do not contain simple
		 *  content.
		 *
		 * @return                  <Boolean> If the XML object contains simple content, true; otherwise false.
		 */
		AS3 function hasSimpleContent():Boolean;
		/**
		 * Lists the namespaces for the XML object, based on the object's parent.
		 *
		 * @return                  <Array> An array of Namespace objects.
		 */
		AS3 function inScopeNamespaces():Array;
		/**
		 * Inserts the given child2 parameter after the child1 parameter in this XML object and returns the
		 *  resulting object. If the child1 parameter is null, the method
		 *  inserts the contents of child2
		 *  before all children of the XML object
		 *  (in other words, after none). If child1 is provided, but it does not
		 *  exist in the XML object, the XML object is not modified and undefined is
		 *  returned.
		 *
		 * @param child1            <Object> The object in the source object that you insert before child2.
		 * @param child2            <Object> The object to insert.
		 * @return                  <*> The resulting XML object or undefined.
		 */
		AS3 function insertChildAfter(child1:Object, child2:Object):*;
		/**
		 * Inserts the given child2 parameter before the child1 parameter
		 *  in this XML object and returns the resulting object. If the child1 parameter
		 *  is null, the method inserts the contents of
		 *  child2
		 *  after all children of the XML object (in other words, before
		 *  none). If child1 is provided, but it does not exist in the XML object,
		 *  the XML object is not modified and undefined is returned.
		 *
		 * @param child1            <Object> The object in the source object that you insert after child2.
		 * @param child2            <Object> The object to insert.
		 * @return                  <*> The resulting XML object or undefined.
		 */
		AS3 function insertChildBefore(child1:Object, child2:Object):*;
		/**
		 * For XML objects, this method always returns the integer 1.
		 *  The length() method of the XMLList class returns a value of 1 for
		 *  an XMLList object that contains only one value.
		 *
		 * @return                  <int> Always returns 1 for any XML object.
		 */
		AS3 function length():int;
		/**
		 * Gives the local name portion of the qualified name of the XML object.
		 *
		 * @return                  <Object> The local name as either a String or null.
		 */
		AS3 function localName():Object;
		/**
		 * Gives the qualified name for the XML object.
		 *
		 * @return                  <Object> The qualified name is either a QName or null.
		 */
		AS3 function name():Object;
		/**
		 * If no parameter is provided, gives the namespace associated with the qualified name of
		 *  this XML object. If a prefix parameter is specified, the method returns the namespace
		 *  that matches the prefix parameter and that is in scope for the XML object. If there is no
		 *  such namespace, the method returns undefined.
		 *
		 * @param prefix            <String (default = null)> The prefix you want to match.
		 * @return                  <*> Returns null, undefined, or a namespace.
		 */
		AS3 function namespace(prefix:String = null):*;
		/**
		 * Lists namespace declarations associated with the XML object in the context of its parent.
		 *
		 * @return                  <Array> An array of Namespace objects.
		 */
		AS3 function namespaceDeclarations():Array;
		/**
		 * Specifies the type of node: text, comment, processing-instruction,
		 *  attribute, or element.
		 *
		 * @return                  <String> The node type used.
		 */
		AS3 function nodeKind():String;
		/**
		 * For the XML object and all descendant XML objects, merges adjacent text nodes and
		 *  eliminates empty text nodes.
		 *
		 * @return                  <XML> The resulting normalized XML object.
		 */
		AS3 function normalize():XML;
		/**
		 * Returns the parent of the XML object. If the XML object has no parent, the method returns
		 *  undefined.
		 *
		 * @return                  <*> The parent XML object. Returns either a String or null.
		 */
		AS3 function parent():*;
		/**
		 * Inserts a copy of the provided child object into the XML element before any existing XML
		 *  properties for that element.
		 *
		 * @param value             <Object> The object to insert.
		 * @return                  <XML> The resulting XML object.
		 */
		AS3 function prependChild(value:Object):XML;
		/**
		 * If a name parameter is provided, lists all the children of the XML object
		 *  that contain processing instructions with that name. With no parameters, the method
		 *  lists all the children of the XML object that contain any processing instructions.
		 *
		 * @param name              <String (default = "*")> The name of the processing instructions to match.
		 * @return                  <XMLList> A list of matching child objects.
		 */
		AS3 function processingInstructions(name:String = "*"):XMLList;
		/**
		 * Checks whether the property p is in the set of properties that can be iterated in a
		 *  for..in statement applied to the XML object. Returns true only
		 *  if toString(p) == "0".
		 *
		 * @param p                 <String> The property that you want to check.
		 * @return                  <Boolean> If the property can be iterated in a for..in statement, true;
		 *                            otherwise, false.
		 */
		AS3 function propertyIsEnumerable(p:String):Boolean;
		/**
		 * Removes the given namespace for this object and all descendants. The removeNamespace()
		 *  method does not remove a namespace if it is referenced by the object's qualified name or the
		 *  qualified name of the object's attributes.
		 *
		 * @param ns                <Namespace> The namespace to remove.
		 * @return                  <XML> A copy of the resulting XML object.
		 */
		AS3 function removeNamespace(ns:Namespace):XML;
		/**
		 * Replaces the properties specified by the propertyName parameter
		 *  with the given value parameter.
		 *  If no properties match propertyName, the XML object is left unmodified.
		 *
		 * @param propertyName      <Object> Can be a
		 *                            numeric value, an unqualified name for a set of XML elements, a qualified name for a set of
		 *                            XML elements, or the asterisk wildcard ("*").
		 *                            Use an unqualified name to identify XML elements in the default namespace.
		 * @param value             <XML> The replacement value. This can be an XML object, an XMLList object, or any value
		 *                            that can be converted with toString().
		 * @return                  <XML> The resulting XML object, with the matching properties replaced.
		 */
		AS3 function replace(propertyName:Object, value:XML):XML;
		/**
		 * Replaces the child properties of the XML object with the specified set of XML properties,
		 *  provided in the value parameter.
		 *
		 * @param value             <Object> The replacement XML properties. Can be a single XML object or an XMLList object.
		 * @return                  <XML> The resulting XML object.
		 */
		AS3 function setChildren(value:Object):XML;
		/**
		 * Changes the local name of the XML object to the given name parameter.
		 *
		 * @param name              <String> The replacement name for the local name.
		 */
		AS3 function setLocalName(name:String):void;
		/**
		 * Sets the name of the XML object to the given qualified name or attribute name.
		 *
		 * @param name              <String> The new name for the object.
		 */
		AS3 function setName(name:String):void;
		/**
		 * Sets the namespace associated with the XML object.
		 *
		 * @param ns                <Namespace> The new namespace.
		 */
		AS3 function setNamespace(ns:Namespace):void;
		/**
		 * Sets values for the following XML properties: ignoreComments,
		 *  ignoreProcessingInstructions, ignoreWhitespace,
		 *  prettyIndent, and prettyPrinting.
		 *  The following are the default settings, which are applied if no setObj parameter
		 *  is provided:
		 *  XML.ignoreComments = true
		 *  XML.ignoreProcessingInstructions = true
		 *  XML.ignoreWhitespace = true
		 *  XML.prettyIndent = 2
		 *  XML.prettyPrinting = true
		 */
		AS3 static function setSettings(... rest):void;
		/**
		 * Retrieves the following properties: ignoreComments,
		 *  ignoreProcessingInstructions, ignoreWhitespace,
		 *  prettyIndent, and prettyPrinting.
		 *
		 * @return                  <Object> An object with the following XML properties:
		 *                            ignoreComments
		 *                            ignoreProcessingInstructions
		 *                            ignoreWhitespace
		 *                            prettyIndent
		 *                            prettyPrinting
		 */
		AS3 static function settings():Object;
		/**
		 * Returns an XMLList object of all XML properties of the XML object that represent XML text nodes.
		 *
		 * @return                  <XMLList> The list of properties.
		 */
		AS3 function text():XMLList;
		/**
		 * Returns a string representation of the XML object. The rules for this conversion depend on whether
		 *  the XML object has simple content or complex content:
		 *  If the XML object has simple content, toString() returns the String contents of the
		 *  XML object with  the following stripped out: the start tag, attributes, namespace declarations, and
		 *  end tag.
		 *  If the XML object has complex content, toString() returns an XML encoded String
		 *  representing the entire XML object, including the start tag, attributes, namespace declarations,
		 *  and end tag.
		 *
		 * @return                  <String> The string representation of the XML object.
		 */
		AS3 function toString():String;
		/**
		 * Returns a string representation of the XML object. Unlike the toString() method,
		 *  the toXMLString() method always returns the start tag, attributes,
		 *  and end tag of the XML object, regardless of whether the XML object has simple content or complex
		 *  content. (The toString() method strips out these items for XML objects that contain
		 *  simple content.)
		 *
		 * @return                  <String> The string representation of the XML object.
		 */
		AS3 function toXMLString():String;
		/**
		 * Returns the XML object.
		 *
		 * @return                  <XML> The primitive value of an XML instance.
		 */
		AS3 function valueOf():XML;
	}
}
