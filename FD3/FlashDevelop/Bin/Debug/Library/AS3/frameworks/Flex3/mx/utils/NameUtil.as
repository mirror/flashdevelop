/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	import flash.display.DisplayObject;
	public class NameUtil {
		/**
		 * Creates a unique name for any Object instance, such as "Button12", by
		 *  combining the unqualified class name with an incrementing counter.
		 *
		 * @param object            <Object> Object requiring a name.
		 * @return                  <String> String containing the unique name.
		 */
		public static function createUniqueName(object:Object):String;
		/**
		 * Returns a string, such as
		 *  "MyApplication0.addressForm.lastName.TextField17",
		 *  for a DisplayObject object that indicates its position in the
		 *  hierarchy of DisplayObject objects in an application.
		 *
		 * @param displayObject     <DisplayObject> A DisplayObject object whose hierarchy in the application
		 *                            is desired.
		 * @return                  <String> String containing the position of displayObject
		 *                            in the hierarchy of DisplayObject objects in an application.
		 */
		public static function displayObjectToString(displayObject:DisplayObject):String;
	}
}
