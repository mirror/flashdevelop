/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.resources {
	public interface IResourceBundle {
		/**
		 * A name that identifies this resource bundle,
		 *  such as "MyResources".
		 */
		public function get bundleName():String;
		/**
		 * An object containing key-value pairs for the resources
		 *  in this resource bundle.
		 */
		public function get content():Object;
		/**
		 * The locale for which this bundle's resources have been localized.
		 *  This is a String such as "en_US" for U.S. English.
		 */
		public function get locale():String;
	}
}
