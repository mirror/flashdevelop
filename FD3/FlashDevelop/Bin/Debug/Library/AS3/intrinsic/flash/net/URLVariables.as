/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	public dynamic  class URLVariables {
		/**
		 * Creates a new URLVariables object. You pass URLVariables
		 *  objects to the data property of URLRequest objects.
		 *
		 * @param source            <String (default = null)> A URL-encoded string containing name/value pairs.
		 */
		public function URLVariables(source:String = null);
		/**
		 * Converts the variable string to properties of the specified URLVariables object.
		 *
		 * @param source            <String> A URL-encoded query string containing name/value pairs.
		 */
		public function decode(source:String):void;
		/**
		 * Returns a string containing all enumerable variables,
		 *  in the MIME content encoding application/x-www-form-urlencoded.
		 *
		 * @return                  <String> A URL-encoded string containing name/value pairs.
		 */
		public function toString():String;
	}
}
