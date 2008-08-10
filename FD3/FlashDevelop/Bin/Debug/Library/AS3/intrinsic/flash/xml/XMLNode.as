/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.xml {
	public class XMLNode {
		/**
		 * An object containing all of the attributes of the specified XMLNode instance. The
		 *  XMLNode.attributes object contains one variable for each attribute of the XMLNode instance.
		 *  Because these variables are defined as part of the object, they are generally referred to as
		 *  properties of the object. The value of each attribute is stored in the corresponding property as a
		 *  string.
		 */
		public function get attributes():Object;
		public function set attributes(value:Object):void;
		/**
		 * An array of the specified XMLNode object's children. Each element in the array is a reference
		 *  to an XMLNode object that represents a child node. This is a read-only property and cannot be
		 *  used to manipulate child nodes. Use the appendChild(), insertBefore(),
		 *  and removeNode()  methods to manipulate child nodes.
		 */
		public function get childNodes():Array;
		/**
		 * Evaluates the specified XMLDocument object and references the first child in the parent node's child list.
		 *  This property is null if the node does not have children. This property is
		 *  undefined if the node is a text node. This is a read-only property and cannot be used
		 *  to manipulate child nodes; use the appendChild(), insertBefore(), and
		 *  removeNode() methods to manipulate child nodes.
		 */
		public var firstChild:XMLNode;
		/**
		 * An XMLNode value that references the last child in the node's child list. The
		 *  XMLNode.lastChild property is null if the node does not have children.
		 *  This property cannot be used to manipulate child nodes; use the appendChild(),
		 *  insertBefore(), and removeNode() methods to manipulate child nodes.
		 */
		public var lastChild:XMLNode;
		/**
		 * The local name portion of the XML node's name. This is the element name without
		 *  the namespace prefix. For example, the node
		 *  <contact:mailbox/>bob@example.com</contact:mailbox>
		 *  has the local name "mailbox", and the prefix "contact", which comprise the full
		 *  element name "contact.mailbox".
		 */
		public function get localName():String;
		/**
		 * If the XML node has a prefix, namespaceURI is the value of the xmlns
		 *  declaration for that prefix (the URI), which is typically called the namespace URI.
		 *  The xmlns declaration is in the current node or in a node higher in the XML
		 *  hierarchy.
		 */
		public function get namespaceURI():String;
		/**
		 * An XMLNode value that references the next sibling in the parent node's child list. This property is
		 *  null if the node does not have a next sibling node. This property cannot be used to
		 *  manipulate child nodes; use the appendChild(), insertBefore(), and
		 *  removeNode() methods to manipulate child nodes.
		 */
		public var nextSibling:XMLNode;
		/**
		 * A string representing the node name of the XMLNode object. If the XMLNode object is an XML
		 *  element (nodeType == 1), nodeName is the name of the tag that
		 *  represents the node in the XML file. For example, TITLE is the nodeName
		 *  of an HTML TITLE tag. If the XMLNode object is a text node
		 *  (nodeType == 3), nodeName is null.
		 */
		public var nodeName:String;
		/**
		 * A nodeType constant value, either XMLNodeType.ELEMENT_NODE for an XML element or
		 *  XMLNodeType.TEXT_NODE for a text node.
		 */
		public var nodeType:uint;
		/**
		 * The node value of the XMLDocument object. If the XMLDocument object is a text node, the nodeType
		 *  is 3, and the nodeValue is the text of the node. If the XMLDocument object is an XML element
		 *  (nodeType is 1), nodeValue is null and read-only.
		 */
		public var nodeValue:String;
		/**
		 * An XMLNode value that references the parent node of the specified XML object, or returns
		 *  null if the node has no parent. This is a read-only property and cannot be used to
		 *  manipulate child nodes; use the appendChild(), insertBefore(), and
		 *  removeNode() methods to manipulate child nodes.
		 */
		public var parentNode:XMLNode;
		/**
		 * The prefix portion of the XML node name. For example, the node
		 *  <contact:mailbox/>bob@example.com</contact:mailbox> prefix
		 *  "contact" and the local name "mailbox", which comprise the full element name "contact.mailbox".
		 */
		public function get prefix():String;
		/**
		 * An XMLNode value that references the previous sibling in the parent node's child list.
		 *  The property has a value of null if the node does not have a previous sibling node. This property
		 *  cannot be used to manipulate child nodes; use the appendChild(),
		 *  insertBefore(), and removeNode() methods to manipulate child nodes.
		 */
		public var previousSibling:XMLNode;
		/**
		 * Creates a new XMLNode object. You must use the constructor to create an XMLNode object before you
		 *  call any of the methods of the XMLNode class.
		 *
		 * @param type              <uint> The node type: either 1 for an XML element or 3 for a text node.
		 * @param value             <String> The XML text parsed to create the new XMLNode object.
		 */
		public function XMLNode(type:uint, value:String);
		/**
		 * Appends the specified node to the XML object's child list. This method operates directly on the
		 *  node referenced by the childNode parameter; it does not append a copy of the
		 *  node. If the node to be appended already exists in another tree structure, appending the node to the
		 *  new location will remove it from its current location. If the childNode
		 *  parameter refers to a node that already exists in another XML tree structure, the appended child node
		 *  is placed in the new tree structure after it is removed from its existing parent node.
		 *
		 * @param node              <XMLNode> An XMLNode that represents the node to be moved from its current location to the child
		 *                            list of the my_xml object.
		 */
		public function appendChild(node:XMLNode):void;
		/**
		 * Constructs and returns a new XML node of the same type, name, value, and attributes as the
		 *  specified XML object. If deep is set to true, all child nodes are
		 *  recursively cloned, resulting in an exact copy of the original object's document tree.
		 *
		 * @param deep              <Boolean> A Boolean value; if set to true, the children of the specified XML object will be recursively cloned.
		 * @return                  <XMLNode> An XMLNode Object.
		 */
		public function cloneNode(deep:Boolean):XMLNode;
		/**
		 * Returns the namespace URI that is associated with the specified prefix for the node. To determine
		 *  the URI, getPrefixForNamespace() searches up the XML hierarchy from the node, as
		 *  necessary, and returns the namespace URI of the first xmlns declaration for the
		 *  given prefix.
		 *
		 * @param prefix            <String> The prefix for which the method returns the associated namespace.
		 * @return                  <String> The namespace that is associated with the specified prefix.
		 */
		public function getNamespaceForPrefix(prefix:String):String;
		/**
		 * Returns the prefix that is associated with the specified namespace URI for the node. To determine
		 *  the prefix, getPrefixForNamespace() searches up the XML hierarchy from the node, as
		 *  necessary, and returns the prefix of the first xmlns declaration with a namespace URI
		 *  that matches ns.
		 *
		 * @param ns                <String> The namespace URI for which the method returns the associated prefix.
		 * @return                  <String> The prefix associated with the specified namespace.
		 */
		public function getPrefixForNamespace(ns:String):String;
		/**
		 * Indicates whether the specified XMLNode object has child nodes. This property is true if the
		 *  specified XMLNode object has child nodes; otherwise, it is false.
		 *
		 * @return                  <Boolean> Returns true if the
		 *                            specified XMLNode object has child nodes; otherwise, false.
		 */
		public function hasChildNodes():Boolean;
		/**
		 * Inserts a new child node into the XML object's child list, before the
		 *  beforeNode node. If the beforeNode parameter is undefined
		 *  or null, the node is added using the appendChild() method. If beforeNode
		 *  is not a child of my_xml, the insertion fails.
		 *
		 * @param node              <XMLNode> The XMLNode object to be inserted.
		 * @param before            <XMLNode> The XMLNode object before the insertion point for the childNode.
		 */
		public function insertBefore(node:XMLNode, before:XMLNode):void;
		/**
		 * Removes the specified XML object from its parent. Also deletes all descendants of the node.
		 */
		public function removeNode():void;
		/**
		 * Evaluates the specified XMLNode object, constructs a textual representation of the XML structure,
		 *  including the node, children, and attributes, and returns the result as a string.
		 *
		 * @return                  <String> The string representing the XMLNode object.
		 */
		public function toString():String;
	}
}
