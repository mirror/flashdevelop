/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public class DeferredInstanceFromClass implements IDeferredInstance {
		/**
		 * Constructor.
		 *
		 * @param generator         <Class> The class whose instance the getInstance()
		 *                            method creates and returns.
		 */
		public function DeferredInstanceFromClass(generator:Class);
		/**
		 * Creates and returns an instance of the class specified in the
		 *  DeferredInstanceFromClass constructor, if it does not yet exist;
		 *  otherwise, returns the already-created class instance.
		 *
		 * @return                  <Object> An instance of the class specified in the
		 *                            DeferredInstanceFromClass constructor.
		 */
		public function getInstance():Object;
	}
}
