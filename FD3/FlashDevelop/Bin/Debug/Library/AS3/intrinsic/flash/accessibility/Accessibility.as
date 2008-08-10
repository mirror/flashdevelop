/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.accessibility {
	public final  class Accessibility {
		/**
		 * Indicates whether a screen reader is currently active and the player is
		 *  communicating with it. Use this method when you want your application to behave
		 *  differently in the presence of a screen reader.
		 */
		public static function get active():Boolean;
		/**
		 * Tells Flash Player to apply any accessibility changes made by using the DisplayObject.accessibilityProperties property.
		 *  You need to call this method for your changes to take effect.
		 */
		public static function updateProperties():void;
	}
}
