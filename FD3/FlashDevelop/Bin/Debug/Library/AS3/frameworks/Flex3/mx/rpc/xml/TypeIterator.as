package mx.rpc.xml
{
	import mx.collections.IList;
	import mx.utils.object_proxy;

	/**
	 * A helper class to iterate over an Array, IList, or XMLList. *  * @private
	 */
	public class TypeIterator
	{
		private var _value : *;
		private var counter : uint;

		public function get length () : uint;
		public function get value () : *;

		public function TypeIterator (value:*);
		public function hasNext () : Boolean;
		public function next () : *;
		public function reset () : void;
		public static function getItemAt (value:*, index:uint) : *;
		public static function getLength (value:*) : uint;
		public static function isIterable (value:*) : Boolean;
		public static function push (parent:*, value:*) : uint;
	}
}
