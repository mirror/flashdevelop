/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public final  class Namespace {
		/**
		 * The prefix of the namespace.
		 */
		public function get prefix():String;
		public function set prefix(value:String):void;
		/**
		 * The Uniform Resource Identifier (URI) of the namespace.
		 */
		public function get uri():String;
		public function set uri(value:String):void;
		/**
		 * Creates a Namespace object.
		 *  The values assigned to the uri and prefix properties
		 *  of the new Namespace object depend on the type of value passed for the uriValue parameter:
		 *  If no value is passed, the prefix and uri properties are set to an empty string.
		 *  If the value is a Namespace object, a copy of the object is created.
		 *  If the value is a QName object, the uri property is set to the uri property of the QName object.
		 *
		 * @param uriValue          <*> The Uniform Resource Identifier (URI) of the namespace.
		 */
		public function Namespace(uriValue:*);
		/**
		 * Creates a Namespace object according to the values of the prefixValue and uriValue parameters.
		 *  This constructor requires both parameters.
		 *
		 * @param prefixValue       <*> The prefix to use for the namespace.
		 * @param uriValue          <*> The Uniform Resource Identifier (URI) of the namespace.
		 */
		public function Namespace(prefixValue:*, uriValue:*);
		/**
		 * Equivalent to the Namespace.uri property.
		 *
		 * @return                  <String> The Uniform Resource Identifier (URI) of the namespace, as a string.
		 */
		AS3 function toString():String;
		/**
		 * Returns the URI value of the specified object.
		 *
		 * @return                  <String> The Uniform Resource Identifier (URI) of the namespace, as a string.
		 */
		AS3 function valueOf():String;
	}
}
