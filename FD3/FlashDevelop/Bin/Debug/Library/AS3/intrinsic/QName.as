package 
{
	/// QName objects represent qualified names of XML elements and attributes.
	public class QName
	{
		/// The local name of the QName object.
		public var localName:String;

		/// The Uniform Resource Identifier (URI) of the QName object.
		public var uri:*;

		/// Creates a QName object with a URI object from a Namespace object and a localName from a QName object.
		public function QName(uri:Namespace, localName:QName);

		/// Creates a QName object that is a copy of another QName object.
		public function QName(qname:QName);

		/// Returns a string composed of the URI, and the local name for the QName object, separated by "::".
		public function toString():String;

		/// Returns the QName object.
		public function valueOf():QName;

	}

}

