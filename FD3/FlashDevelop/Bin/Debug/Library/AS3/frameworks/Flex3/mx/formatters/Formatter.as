/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.formatters {
	import mx.resources.IResourceManager;
	public class Formatter {
		/**
		 * Error message for an invalid format string specified to the formatter.
		 */
		public static function get defaultInvalidFormatError():String;
		public function set defaultInvalidFormatError(value:String):void;
		/**
		 * Error messages for an invalid value specified to the formatter.
		 */
		public static function get defaultInvalidValueError():String;
		public function set defaultInvalidValueError(value:String):void;
		/**
		 * Description saved by the formatter when an error occurs.
		 *  For the possible values of this property,
		 *  see the description of each formatter.
		 */
		public var error:String;
		/**
		 * A reference to the object which manages
		 *  all of the application's localized resources.
		 *  This is a singleton instance which implements
		 *  the IResourceManager interface.
		 */
		protected function set resourceManager(value:IResourceManager):void;
		/**
		 * Constructor.
		 */
		public function Formatter();
		/**
		 * Formats a value and returns a String
		 *  containing the new, formatted, value.
		 *  All subclasses must override this method to implement the formatter.
		 *
		 * @param value             <Object> Value to be formatted.
		 * @return                  <String> The formatted string.
		 */
		public function format(value:Object):String;
		/**
		 * This method is called when a Formatter is constructed,
		 *  and again whenever the ResourceManager dispatches
		 *  a "change" Event to indicate
		 *  that the localized resources have changed in some way.
		 */
		protected function resourcesChanged():void;
	}
}
