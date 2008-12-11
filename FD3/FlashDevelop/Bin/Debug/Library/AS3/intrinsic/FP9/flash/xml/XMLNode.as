package flash.xml
{
	/// The XMLNode class represents the legacy XML object that was present in ActionScript 2.0 and that was renamed in ActionScript 3.0.
	public class XMLNode
	{
		/// A nodeType constant value, either XMLNodeType.ELEMENT_NODE for an XML element or XMLNodeType.TEXT_NODE for a text node.
		public var nodeType:uint;

		/// An XMLNode value that references the previous sibling in the parent node's child list.
		public var previousSibling:flash.xml.XMLNode;

		/// An XMLNode value that references the next sibling in the parent node's child list.
		public var nextSibling:flash.xml.XMLNode;

		/// An XMLNode value that references the parent node of the specified XML object, or returns null if the node has no parent.
		public var parentNode:flash.xml.XMLNode;

		/// Evaluates the specified XMLDocument object and references the first child in the parent node's child list.
		public var firstChild:flash.xml.XMLNode;

		/// An XMLNode value that references the last child in the node's child list.
		public var lastChild:flash.xml.XMLNode;

		/// A string representing the node name of the XMLNode object.
		public var nodeName:String;

		/// The node value of the XMLDocument object.
		public var nodeValue:String;

		/// An array of the specified XMLNode object's children.
		public var childNodes:Array;

		/// An object containing all of the attributes of the specified XMLNode instance.
		public var attributes:Object;

		/// The local name portion of the XML node's name.
		public var localName:String;

		/// The prefix portion of the XML node name.
		public var prefix:String;

		/// If the XML node has a prefix, namespaceURI is the value of the xmlns declaration for that prefix (the URI), which is typically called the namespace URI.
		public var namespaceURI:String;

		/// Creates a new XMLNode object.
		public function XMLNode(type:uint, value:String);

		/// Indicates whether the specified XMLNode object has child nodes.
		public function hasChildNodes():Boolean;

		/// Constructs and returns a new XML node of the same type, name, value, and attributes as the specified XML object.
		public function cloneNode(deep:Boolean):flash.xml.XMLNode;

		/// Removes the specified XML object from its parent.
		public function removeNode():void;

		/// Inserts a new child node into the XML object's child list, before the beforeNode node.
		public function insertBefore(node:flash.xml.XMLNode, before:flash.xml.XMLNode):void;

		/// Appends the specified node to the XML object's child list.
		public function appendChild(node:flash.xml.XMLNode):void;

		/// Evaluates the specified XMLNode object, constructs a textual representation of the XML structure, including the node, children, and attributes, and returns the result as a string.
		public function toString():String;

		/// Returns the namespace URI that is associated with the specified prefix for the node.
		public function getNamespaceForPrefix(prefix:String):String;

		/// Returns the prefix that is associated with the specified namespace URI for the node.
		public function getPrefixForNamespace(ns:String):String;

	}

}

