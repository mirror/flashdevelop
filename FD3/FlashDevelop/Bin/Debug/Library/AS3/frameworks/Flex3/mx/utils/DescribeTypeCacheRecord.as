package mx.utils
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 *  This class represents a single cache entry, this gets created
 *  as part of the <code>describeType</code> method call on the 
 *  <code>DescribeTypeCache</code>  class.
	 */
	flash_proxy dynamic class DescribeTypeCacheRecord extends Proxy
	{
		/**
		 *  @private
		 */
		private var cache : Object;
		/**
		 *  @private
		 */
		public var typeDescription : XML;
		/**
		 *  @private
		 */
		public var typeName : String;

		/**
		 *  @private
		 */
		public function DescribeTypeCacheRecord ();

		/**
		 *  @private
		 */
		flash_proxy function getProperty (name:*) : *;

		/**
		 *  @private
		 */
		flash_proxy function hasProperty (name:*) : Boolean;
	}
}
