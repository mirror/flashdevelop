package mx.rpc.xml
{
	/**
	 * This internal utility class is used by XMLDecoder, to store some properties * relevant to the current context, such as which is the current element from * an XMLList of values, which elements were deserialized by <any> definitions, etc. * * @private
	 */
	public class DecodingContext
	{
		public var index : int;
		public var hasContextSiblings : Boolean;
		public var anyIndex : int;

		public function DecodingContext ();
	}
}
