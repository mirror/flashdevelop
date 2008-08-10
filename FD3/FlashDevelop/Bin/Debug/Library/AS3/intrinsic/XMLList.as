/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public final dynamic  class XMLList {
		/**
		 * Creates a new XMLList object.
		 *
		 * @param value             <Object> Any object that can be converted to an XMLList object by using the top-level XMLList() function.
		 */
		public function XMLList(value:Object);
		/**
		 * Calls the attribute() method of each XML object and returns an XMLList object
		 *  of the results. The results match the given attributeName parameter. If there is no
		 *  match, the attribute() method returns an empty XMLList object.
		 *
		 * @param attributeName     <*> The name of the attribute that you want to include in an XMLList object.
		 * @return                  <XMLList> An XMLList object of matching XML objects or an empty XMLList object.
		 */
		AS3 function attribute(attributeName:*):XMLList;
		/**
		 * Calls the attributes() method of each XML object and
		 *  returns an XMLList object of attributes for each XML object.
		 *
		 * @return                  <XMLList> An XMLList object of attributes for each XML object.
		 */
		AS3 function attributes():XMLList;
		/**
		 * Calls the child() method of each XML object and returns an XMLList object that
		 *  contains the results in order.
		 *
		 * @param propertyName      <Object> The element name or integer of the XML child.
		 * @return                  <XMLList> An XMLList object of child nodes that match the input parameter.
		 */
		AS3 function child(propertyName:Object):XMLList;
		/**
		 * Calls the children() method of each XML object and
		 *  returns an XMLList object that contains the results.
		 *
		 * @return                  <XMLList> An XMLList object of the children in the XML objects.
		 */
		AS3 function children():XMLList;
		/**
		 * Calls the comments() method of each XML object and returns
		 *  an XMLList of comments.
		 *
		 * @return                  <XMLList> An XMLList of the comments in the XML objects.
		 */
		AS3 function comments():XMLList;
		/**
		 * Checks whether the XMLList object contains an XML object that is equal to the given
		 *  value parameter.
		 *
		 * @param value             <XML> An XML object to compare against the current XMLList object.
		 * @return                  <Boolean> If the XMLList contains the XML object declared in the value parameter,
		 *                            then true; otherwise false.
		 */
		AS3 function contains(value:XML):Boolean;
		/**
		 * Returns a copy of the given XMLList object. The copy is a duplicate of the entire tree of nodes.
		 *  The copied XML object has no parent and returns null if you attempt to call the parent() method.
		 *
		 * @return                  <XMLList> The copy of the XMLList object.
		 */
		AS3 function copy():XMLList;
		/**
		 * Returns all descendants (children, grandchildren, great-grandchildren, and so on) of the XML object
		 *  that have the given name parameter. The name parameter can be a
		 *  QName object, a String data type, or any other data type that is then converted to a String
		 *  data type.
		 *
		 * @param name              <Object (default = *)> The name of the element to match.
		 * @return                  <XMLList> An XMLList object of the matching descendants (children, grandchildren, and so on) of the XML objects
		 *                            in the original list. If there are no descendants, returns an empty XMLList object.
		 */
		AS3 function descendants(name:Object = *):XMLList;
		/**
		 * Calls the elements() method of each XML object. The name parameter is
		 *  passed to the descendants() method. If no parameter is passed, the string "*" is passed to the
		 *  descendants() method.
		 *
		 * @param name              <Object (default = *)> The name of the elements to match.
		 * @return                  <XMLList> An XMLList object of the matching child elements of the XML objects.
		 */
		AS3 function elements(name:Object = *):XMLList;
		/**
		 * Checks whether the XMLList object contains complex content. An XMLList object is
		 *  considered to contain complex content if it is not empty and either of the following conditions is true:
		 *  The XMLList object contains a single XML item with complex content.
		 *  The XMLList object contains elements.
		 *
		 * @return                  <Boolean> If the XMLList object contains complex content, then true; otherwise false.
		 */
		AS3 function hasComplexContent():Boolean;
		/**
		 * Checks for the property specified by p.
		 *
		 * @param p                 <String> The property to match.
		 * @return                  <Boolean> If the parameter exists, then true; otherwise false.
		 */
		AS3 function hasOwnProperty(p:String):Boolean;
		/**
		 * Checks whether the XMLList object contains simple content. An XMLList object is
		 *  considered to contain simple content if one or more of the following
		 *  conditions is true:
		 *  The XMLList object is empty
		 *  The XMLList object contains a single XML item with simple content
		 *  The XMLList object contains no elements
		 *
		 * @return                  <Boolean> If the XMLList contains simple content, then true; otherwise false.
		 */
		AS3 function hasSimpleContent():Boolean;
		/**
		 * Returns the number of properties in the XMLList object.
		 *
		 * @return                  <int> The number of properties in the XMLList object.
		 */
		AS3 function length():int;
		/**
		 * Merges adjacent text nodes and eliminates empty text nodes for each
		 *  of the following: all text nodes in the XMLList, all the XML objects
		 *  contained in the XMLList, and the descendants of all the XML objects in
		 *  the XMLList.
		 *
		 * @return                  <XMLList> The normalized XMLList object.
		 */
		AS3 function normalize():XMLList;
		/**
		 * Returns the parent of the XMLList object if all items in the XMLList object have the same parent.
		 *  If the XMLList object has no parent or different parents, the method returns undefined.
		 *
		 * @return                  <Object> Returns the parent XML object.
		 */
		AS3 function parent():Object;
		/**
		 * If a name parameter is provided, lists all the children of the XMLList object that
		 *  contain processing instructions with that name. With no parameters, the method lists all the
		 *  children of the XMLList object that contain any processing instructions.
		 *
		 * @param name              <String (default = "*")> The name of the processing instructions to match.
		 * @return                  <XMLList> An XMLList object that contains the processing instructions for each XML object.
		 */
		AS3 function processingInstructions(name:String = "*"):XMLList;
		/**
		 * Checks whether the property p is in the set of properties that can be iterated in a for..in statement
		 *  applied to the XMLList object. This is true only if toNumber(p) is greater than or equal to 0
		 *  and less than the length of the XMLList object.
		 *
		 * @param p                 <String> The index of a property to check.
		 * @return                  <Boolean> If the property can be iterated in a for..in statement, then true; otherwise false.
		 */
		AS3 function propertyIsEnumerable(p:String):Boolean;
		/**
		 * Calls the text() method of each XML
		 *  object and returns an XMLList object that contains the results.
		 *
		 * @return                  <XMLList> An XMLList object of all XML properties of the XMLList object that represent XML text nodes.
		 */
		AS3 function text():XMLList;
		/**
		 * Returns a string representation of all the XML objects in an XMLList object. The rules for
		 *  this conversion depend on whether the XML object has simple content or complex content:
		 *  If the XML object has simple content, toString() returns the string contents of the
		 *  XML object with  the following stripped out: the start tag, attributes, namespace declarations, and
		 *  end tag.
		 *  If the XML object has complex content, toString() returns an XML encoded string
		 *  representing the entire XML object, including the start tag, attributes, namespace declarations,
		 *  and end tag.
		 *
		 * @return                  <String> The string representation of the XML object.
		 */
		AS3 function toString():String;
		/**
		 * Returns a string representation of all the XML objects in an XMLList object.
		 *  Unlike the toString() method, the toXMLString()
		 *  method always returns the start tag, attributes,
		 *  and end tag of the XML object, regardless of whether the XML object has simple content
		 *  or complex content. (The toString() method strips out these items for XML
		 *  objects that contain simple content.)
		 *
		 * @return                  <String> The string representation of the XML object.
		 */
		AS3 function toXMLString():String;
		/**
		 * Returns the XMLList object.
		 *
		 * @return                  <XMLList> Returns the current XMLList object.
		 */
		AS3 function valueOf():XMLList;
	}
}
