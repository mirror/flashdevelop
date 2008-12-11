package 
{
	/// The Namespace class contains methods and properties for defining and working with namespaces.
	public class Namespace
	{
		/// The prefix of the namespace.
		public var prefix:*;

		/// The Uniform Resource Identifier (URI) of the namespace.
		public var uri:String;

		/// Creates a Namespace object, given the uriValue.
		public function Namespace(uriValue:*);

		/// Creates a Namespace object, given the prefixValue and uriValue.
		public function Namespace(prefixValue:*, uriValue:*);

		/// Equivalent to the Namespace.uri property.
		public function toString():String;

		/// Equivalent to the Namespace.uri property.
		public function valueOf():String;

	}

}

