/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.xml {
	public class XMLDocument extends XMLNode {
		/**
		 * Specifies information about the XML document's DOCTYPE declaration.
		 *  After the XML text has been parsed into an XMLDocument object, the
		 *  XMLDocument.docTypeDecl property of the XMLDocument object is set to the
		 *  text of the XML document's DOCTYPE declaration
		 *  (for example, <!DOCTYPE greeting SYSTEM "hello.dtd">).
		 *  This property is set using a string representation of the DOCTYPE declaration,
		 *  not an XMLNode object.
		 */
		public var docTypeDecl:Object = null;
		/**
		 * An Object containing the nodes of the XML that have an id attribute assigned.
		 *  The names of the properties of the object (each containing a node) match the values of the
		 *  id attributes.
		 */
		public var idMap:Object;
		/**
		 * When set to true, text nodes that contain only white space are discarded during the parsing process. Text nodes with leading or trailing white space are unaffected. The default setting is false.
		 */
		public var ignoreWhite:Boolean = false;
		/**
		 * A string that specifies information about a document's XML declaration.
		 *  After the XML document is parsed into an XMLDocument object, this property is set
		 *  to the text of the document's XML declaration. This property is set using a string
		 *  representation of the XML declaration, not an XMLNode object. If no XML declaration
		 *  is encountered during a parse operation, the property is set to null.
		 *  The XMLDocument.toString() method outputs the contents of the
		 *  XML.xmlDecl property before any other text in the XML object.
		 *  If the XML.xmlDecl property contains null,
		 *  no XML declaration is output.
		 */
		public var xmlDecl:Object = null;
		/**
		 * Creates a new XMLDocument object. You must use the constructor to create an XMLDocument object before you call any of the methods of the XMLDocument class.
		 *
		 * @param source            <String (default = null)> The XML text parsed to create the new XMLDocument object.
		 */
		public function XMLDocument(source:String = null);
		/**
		 * Creates a new XMLNode object with the name specified in the parameter.
		 *  The new node initially has no parent, no children, and no siblings.
		 *  The method returns a reference to the newly created XMLNode object
		 *  that represents the element. This method and the XMLDocument.createTextNode()
		 *  method are the constructor methods for creating nodes for an XMLDocument object.
		 *
		 * @param name              <String> The tag name of the XMLDocument element being created.
		 * @return                  <XMLNode> An XMLNode object.
		 */
		public function createElement(name:String):XMLNode;
		/**
		 * Creates a new XML text node with the specified text. The new node initially has no parent, and text nodes cannot have children or siblings. This method returns a reference to the XMLDocument object that represents the new text node. This method and the XMLDocument.createElement() method are the constructor methods for creating nodes for an XMLDocument object.
		 *
		 * @param text              <String> The text used to create the new text node.
		 * @return                  <XMLNode> An XMLNode object.
		 */
		public function createTextNode(text:String):XMLNode;
		/**
		 * Parses the XML text specified in the value parameter
		 *  and populates the specified XMLDocument object with the resulting XML tree. Any existing trees in the XMLDocument object are discarded.
		 *
		 * @param source            <String> The XML text to be parsed and passed to the specified XMLDocument object.
		 */
		public function parseXML(source:String):void;
		/**
		 * Returns a string representation of the XML object.
		 *
		 * @return                  <String> A string representation of the XML object.
		 */
		public override function toString():String;
	}
}
