/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	public class DescribeTypeCache {
		/**
		 * Calls flash.utils.describeType() for the first time and caches
		 *  the return value so that subsequent calls return faster.
		 *
		 * @param o                 <*> 
		 */
		public static function describeType(o:*):DescribeTypeCacheRecord;
		/**
		 * registerCacheHandler lets you add function handler for specific strings.
		 *  These functions get called when the user refers to these values on a
		 *  instance of DescribeTypeCacheRecord.
		 *
		 * @param valueName         <String> String that specifies the value for which the handler must be set.
		 * @param handler           <Function> Function that should be called when user references valueName.
		 */
		public static function registerCacheHandler(valueName:String, handler:Function):void;
	}
}
