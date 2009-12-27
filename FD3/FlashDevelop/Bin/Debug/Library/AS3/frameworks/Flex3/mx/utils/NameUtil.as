package mx.utils
{
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	import mx.core.IRepeaterClient;

include "../core/Version.as"
	/**
	 *  The NameUtil utility class defines static methods for
 *  creating names for Flex objects.
 *  You do not create instances of NameUtil;
 *  instead you call static methods of the class, such as 
 *  the <code>NameUtil.createName()</code> method.
	 */
	public class NameUtil
	{
		/**
		 *  @private
		 */
		private static var counter : int;

		/**
		 *  Creates a unique name for any Object instance, such as "Button12", by
	 *  combining the unqualified class name with an incrementing counter.
	 *
	 *  @param object Object requiring a name.
	 *
	 *  @return String containing the unique name.
		 */
		public static function createUniqueName (object:Object) : String;

		/**
		 *  Returns a string, such as
	 *  "MyApplication0.addressForm.lastName.TextField17",
	 *  for a DisplayObject object that indicates its position in the
	 *  hierarchy of DisplayObject objects in an application.
	 *
	 *  @param displayObject A DisplayObject object whose hierarchy in the application
	 *  is desired. 
	 *
	 *  @return String containing the position of <code>displayObject</code> 
	 *  in the hierarchy of DisplayObject objects in an application.
		 */
		public static function displayObjectToString (displayObject:DisplayObject) : String;
	}
}
