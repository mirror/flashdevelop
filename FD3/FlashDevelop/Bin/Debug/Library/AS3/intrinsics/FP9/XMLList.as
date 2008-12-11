package 
{
	/// The XMLList class contains methods for working with one or more XML elements.
	public class XMLList
	{
		/// Creates a new XMLList object.
		public function XMLList(value:Object);

		/// Calls the attribute() method of each XML object and returns an XMLList object of the results.
		public function attribute(attributeName:*):XMLList;

		/// Calls the attributes() method of each XML object and returns an XMLList object of attributes for each XML object.
		public function attributes():XMLList;

		/// Calls the child() method of each XML object and returns an XMLList object that contains the results in order.
		public function child(propertyName:Object):XMLList;

		/// Calls the children() method of each XML object and returns an XMLList object that contains the results.
		public function children():XMLList;

		/// Calls the comments() method of each XML object and returns an XMLList of comments.
		public function comments():XMLList;

		/// Checks whether the XMLList object contains an XML object that is equal to the given value parameter.
		public function contains(value:XML):Boolean;

		/// Returns a copy of the given XMLList object.
		public function copy():XMLList;

		/// Returns all descendants (children, grandchildren, great-grandchildren, and so on) of the XML object that have the given name parameter.
		public function descendants(name:Object=*):XMLList;

		/// Calls the elements() method of each XML object.
		public function elements(name:Object=*):XMLList;

		/// Checks for the property specified by p.
		public function hasOwnProperty(p:String):Boolean;

		/// Checks whether the XMLList object contains complex content.
		public function hasComplexContent():Boolean;

		/// Checks whether the XMLList object contains simple content.
		public function hasSimpleContent():Boolean;

		/// Returns the number of properties in the XMLList object.
		public function length():int;

		/// Merges adjacent text nodes and eliminates empty text nodes for each of the following: all text nodes in the XMLList, all the XML objects contained in the XMLList, and the descendants of all the XML objects in the XMLList.
		public function normalize():XMLList;

		/// Returns the parent of the XMLList object if all items in the XMLList object have the same parent.
		public function parent():Object;

		/// If a name parameter is provided, lists all the children of the XMLList object that contain processing instructions with that name.
		public function processingInstructions(name:String=*):XMLList;

		/// Checks whether the property p is in the set of properties that can be iterated in a for..in statement applied to the XMLList object.
		public function propertyIsEnumerable(p:String):Boolean;

		/// Calls the text() method of each XML object and returns an XMLList object that contains the results.
		public function text():XMLList;

		/// Returns a string representation of all the XML objects in an XMLList object.
		public function toString():String;

		/// Returns a string representation of all the XML objects in an XMLList object.
		public function toXMLString():String;

		/// Returns the XMLList object.
		public function valueOf():XMLList;

	}

}

