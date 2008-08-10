/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	public class XMLListCollection extends ListCollectionView {
		/**
		 * The underlying XMLList for this collection.
		 *  The XMLListCollection object does not represent any changes that
		 *  you make directly to the source XMLList object.
		 *  Always use the XMLListCollection methods to modify the collection.
		 */
		public function get source():XMLList;
		public function set source(value:XMLList):void;
		/**
		 * Constructor.
		 *
		 * @param source            <XMLList (default = null)> The XMLList object containing the data to be represented
		 *                            by the XMLListCollection object.
		 */
		public function XMLListCollection(source:XMLList = null);
		/**
		 * Calls the attribute() method of each XML object in the
		 *  XMLList and returns an XMLList of the results, which
		 *  match the given attributeName.
		 *
		 * @param attributeName     <Object> The attribute that you want to match in the XML
		 *                            objects of the XMLList.
		 * @return                  <XMLList> The XMLList of matching XML objects.
		 */
		public function attribute(attributeName:Object):XMLList;
		/**
		 * Calls the attributes() method of each XML object in the
		 *  XMLList object and returns an XMList of attributes for each XML object.
		 *
		 * @return                  <XMLList> The XMLList containing the resulting XML objects, listing
		 *                            the attributes.
		 */
		public function attributes():XMLList;
		/**
		 * Calls the child() method of each XML object in the XMLList
		 *  and returns an XMLList containing the children of with the specified property
		 *  name, in order.
		 *
		 * @param propertyName      <Object> The propery to match.
		 * @return                  <XMLList> An XMLList of matching children of the XML objects in the
		 *                            original XMLList.
		 */
		public function child(propertyName:Object):XMLList;
		/**
		 * Calls the children() method of each XML object in the XMLList and
		 *  returns an XMLList containing the results.
		 *
		 * @return                  <XMLList> An XMLList of children of the XML objects in the original XMLList.
		 */
		public function children():XMLList;
		/**
		 * Returns a deep copy of the XMLList object.
		 *
		 * @return                  <XMLList> The copy of the XMLList object.
		 */
		public function copy():XMLList;
		/**
		 * Calls the descendants() method of each XML object in the
		 *  XMLList and returns an XMLList containing the results.
		 *  The name parameter is passed to the XML object's
		 *  descendants() method.
		 *  If you do not specify a parameter, the string "*" is passed to the
		 *  descendants() method.
		 *
		 * @param name              <Object (default = *)> The name of the elements to match.
		 * @return                  <XMLList> XMLList of the matching descendents (children, grandchildren,
		 *                            etc.) of the XML objects in the original XMLList.
		 */
		public function descendants(name:Object = *):XMLList;
		/**
		 * Calls the elements() method of each XML object in the XMLList.
		 *  The name parameter is passed to the XML object's
		 *  elements() method.
		 *  If you do not specify a parameter, the string "*" is passed to the
		 *  elements() method.
		 *
		 * @param name              <String (default = "*")> The name of the elements to match.
		 * @return                  <XMLList> XMLList of the matching child elements of the XML objects in the
		 *                            original XMLList.
		 */
		public function elements(name:String = "*"):XMLList;
		/**
		 * Calls the text() method of each XML object in
		 *  the XMLList and returns an XMLList containing the results.
		 */
		public function text():XMLList;
		/**
		 * Returns a string representation of the XMLList by calling the
		 *  toString() method for each XML object in the XMLList.
		 *  If the prettyPrinting property of the XML
		 *  class is set to true, then the results for each XML object
		 *  in the XMLList are separated by the return character.
		 *  Otherwise, if prettyPrinting is set to false,
		 *  then the results are simply concatenated, without separating return characters.
		 */
		public override function toString():String;
		/**
		 * Returns a string representation of the XMLList by calling the
		 *  toXMLString() method for each XML object in the XMLList.
		 *  If the prettyPrinting property of the XML
		 *  class is set to true, then the results for each XML object
		 *  in the XMLList are separated by the return character.
		 *  Otherwise, if prettyPrinting is set to false,
		 *  then the results are concatenated, without separating return
		 *  characters.
		 *
		 * @return                  <String> The string representation of the XMLList.
		 */
		public function toXMLString():String;
	}
}
