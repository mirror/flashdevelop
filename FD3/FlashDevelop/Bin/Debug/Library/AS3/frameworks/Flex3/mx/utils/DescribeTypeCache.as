package mx.utils
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import mx.binding.BindabilityInfo;

include "../core/Version.as"
	/**
	 *  DescribeTypeCache is a convenience class that is used to 
 *  cache the return values of <code>flash.utils.describeType()</code>
 *  so that calls made subsequent times return faster.
 *
 *  This class also lets you set handler functions for specific value types.
 *  These will get called when the user tries to access these values on
 *  the <code>DescribeTypeCacheRecord</code> class.
 * 
 *  @see mx.utils.DescribeTypeCacheRecord
	 */
	public class DescribeTypeCache
	{
		/**
		 *  @private
		 */
		private static var typeCache : Object;
		/**
		 *  @private
		 */
		private static var cacheHandlers : Object;

		/**
		 *  Calls <code>flash.utils.describeType()</code> for the first time and caches
         *  the return value so that subsequent calls return faster. 
         *
         *  @param o Can be either a string describing a fully qualified class name or any 
         *  ActionScript value, including all available ActionScript types, object instances,
         *  primitive types (such as <code>uint</code>), and class objects.
         *
         *  @return Returns the cached record.
         *
         *  @see flash.utils#describeType()
		 */
		public static function describeType (o:*) : DescribeTypeCacheRecord;

		/**
		 *  registerCacheHandler lets you add function handler for specific strings.
         *  These functions get called when the user refers to these values on a
         *  instance of <code>DescribeTypeCacheRecord</code>.
	 *
	 *  @param valueName String that specifies the value for which the handler must be set.
         *  @param handler Function that should be called when user references valueName.
		 */
		public static function registerCacheHandler (valueName:String, handler:Function) : void;

		/**
		 *  @private
		 */
		static function extractValue (valueName:String, record:DescribeTypeCacheRecord) : *;

		/**
		 *  @private
		 */
		private static function bindabilityInfoHandler (record:DescribeTypeCacheRecord) : *;
	}
}
