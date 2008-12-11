package 
{
	/// The XML class contains methods and properties for working with XML objects.
	public class XML
	{
		/// Determines whether XML comments are ignored when XML objects parse the source XML data.
		public var ignoreComments:Boolean;

		/// Determines whether XML processing instructions are ignored when XML objects parse the source XML data.
		public var ignoreProcessingInstructions:Boolean;

		/// Determines whether white space characters at the beginning and end of text nodes are ignored during parsing.
		public var ignoreWhitespace:Boolean;

		/// Determines whether the toString() and toXMLString() methods normalize white space characters between some tags.
		public var prettyPrinting:Boolean;

		/// Determines the amount of indentation applied by the toString() and toXMLString() methods when the XML.prettyPrinting property is set to true.
		public var prettyIndent:int;

		/// Creates a new XML object.
		public function XML(value:Object);

		/// Adds a namespace to the set of in-scope namespaces for the XML object.
		public function addNamespace(ns:Object):XML;

		/// Appends the given child to the end of the XML object's properties.
		public function appendChild(child:Object):XML;

		/// Returns the XML value of the attribute that has the name matching the attributeName parameter.
		public function attribute(attributeName:*):XMLList;

		/// Returns a list of attribute values for the given XML object.
		public function attributes():XMLList;

		/// Lists the children of an XML object.
		public function child(propertyName:Object):XMLList;

		/// Identifies the zero-indexed position of this XML object within the context of its parent.
		public function childIndex():int;

		/// Lists the children of the XML object in the sequence in which they appear.
		public function children():XMLList;

		/// Lists the properties of the XML object that contain XML comments.
		public function comments():XMLList;

		/// Compares the XML object against the given value parameter.
		public function contains(value:XML):Boolean;

		/// Returns a copy of the given XML object.
		public function copy():XML;

		/// Returns all descendants (children, grandchildren, great-grandchildren, and so on) of the XML object that have the given name parameter.
		public function descendants(name:Object=*):XMLList;

		/// Returns an object with the following properties set to the default values: ignoreComments, ignoreProcessingInstructions, ignoreWhitespace, prettyIndent, and prettyPrinting.
		public static function defaultSettings():Object;

		/// Lists the elements of an XML object.
		public function elements(name:Object=*):XMLList;

		/// Checks to see whether the object has the property specified by the p parameter.
		public function hasOwnProperty(p:String):Boolean;

		/// Checks to see whether the XML object contains complex content.
		public function hasComplexContent():Boolean;

		/// Checks to see whether the XML object contains simple content.
		public function hasSimpleContent():Boolean;

		/// Lists the namespaces for the XML object, based on the object's parent.
		public function inScopeNamespaces():Array;

		/// Inserts the given child2 parameter after the child1 parameter in this XML object and returns the resulting object.
		public function insertChildAfter(child1:Object, child2:Object):void;

		/// Inserts the given child2 parameter before the child1 parameter in this XML object and returns the resulting object.
		public function insertChildBefore(child1:Object, child2:Object):void;

		/// For XML objects, this method always returns the integer 1.
		public function length():int;

		/// Gives the local name portion of the qualified name of the XML object.
		public function localName():Object;

		/// Gives the qualified name for the XML object.
		public function name():Object;

		/// If no parameter is provided, gives the namespace associated with the qualified name of this XML object.
		public function namespace(prefix:String=null):void;

		/// Lists namespace declarations associated with the XML object in the context of its parent.
		public function namespaceDeclarations():Array;

		/// Specifies the type of node: text, comment, processing-instruction, attribute, or element.
		public function nodeKind():String;

		/// For the XML object and all descendant XML objects, merges adjacent text nodes and eliminates empty text nodes.
		public function normalize():XML;

		/// Returns the parent of the XML object.
		public function parent():void;

		/// If a name parameter is provided, lists all the children of the XML object that contain processing instructions with that name.
		public function processingInstructions(name:String=*):XMLList;

		/// Inserts a copy of the provided child object into the XML element before any existing XML properties for that element.
		public function prependChild(value:Object):XML;

		/// Checks whether the property p is in the set of properties that can be iterated in a for..in statement applied to the XML object.
		public function propertyIsEnumerable(p:String):Boolean;

		/// Removes the given namespace for this object and all descendants.
		public function removeNamespace(ns:Namespace):XML;

		/// Replaces the properties specified by the propertyName parameter with the given value parameter.
		public function replace(propertyName:Object, value:XML):XML;

		/// Replaces the child properties of the XML object with the specified set of XML properties, provided in the value parameter.
		public function setChildren(value:Object):XML;

		/// Changes the local name of the XML object to the given name parameter.
		public function setLocalName(name:String):void;

		/// Sets the name of the XML object to the given qualified name or attribute name.
		public function setName(name:String):void;

		/// Sets the namespace associated with the XML object.
		public function setNamespace(ns:Namespace):void;

		/// Sets values for the following XML properties: ignoreComments, ignoreProcessingInstructions, ignoreWhitespace, prettyIndent, and prettyPrinting.
		public static function setSettings(...rest):void;

		/// Retrieves the following properties: ignoreComments, ignoreProcessingInstructions, ignoreWhitespace, prettyIndent, and prettyPrinting.
		public static function settings():Object;

		/// Returns an XMLList object of all XML properties of the XML object that represent XML text nodes.
		public function text():XMLList;

		/// Returns a string representation of the XML object.
		public function toString():String;

		/// Returns a string representation of the XML object.
		public function toXMLString():String;

		/// Returns the XML object.
		public function valueOf():XML;

	}

}

