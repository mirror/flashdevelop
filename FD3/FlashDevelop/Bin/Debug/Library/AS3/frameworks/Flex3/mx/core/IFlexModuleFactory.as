/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public interface IFlexModuleFactory {
		/**
		 * A factory method that requests
		 *  an instance of a definition known to the module.
		 *
		 * @return                  <Object> An instance of the module, or null.
		 */
		public function create(... parameters):Object;
		/**
		 * Returns a block of key/value pairs
		 *  that hold static data known to the module.
		 *  This method always succeeds, but can return an empty object.
		 *
		 * @return                  <Object> An object containing key/value pairs. Typically, this object
		 *                            contains information about the module or modules created by this
		 *                            factory; for example:
		 *                            return {"description": "This module returns 42."};
		 *                            Other common values in the returned object include the following:
		 *                            fonts: A list of embedded font faces.
		 *                            rsls: A list of run-time shared libraries.
		 *                            mixins: A list of classes initialized at startup.
		 */
		public function info():Object;
	}
}
