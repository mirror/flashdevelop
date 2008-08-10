/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.system {
	public final  class ApplicationDomain {
		/**
		 * Gets the current application domain in which your code is executing.
		 */
		public static function get currentDomain():ApplicationDomain;
		/**
		 * Gets the parent domain of this application domain.
		 */
		public function get parentDomain():ApplicationDomain;
		/**
		 * Creates a new application domain.
		 *
		 * @param parentDomain      <ApplicationDomain (default = null)> If no parent domain is passed in, this application domain takes the system domain as its parent.
		 */
		public function ApplicationDomain(parentDomain:ApplicationDomain = null);
		/**
		 * Gets a public definition from the specified application domain.
		 *  The definition can be that of a class, a namespace, or a function.
		 *
		 * @param name              <String> The name of the definition.
		 * @return                  <Object> The object associated with the definition.
		 */
		public function getDefinition(name:String):Object;
		/**
		 * Checks to see if a public definition exists within the specified application domain.
		 *  The definition can be that of a class, a namespace, or a function.
		 *
		 * @param name              <String> The name of the definition.
		 * @return                  <Boolean> A value of true if the specified definition exists; otherwise, false.
		 */
		public function hasDefinition(name:String):Boolean;
	}
}
