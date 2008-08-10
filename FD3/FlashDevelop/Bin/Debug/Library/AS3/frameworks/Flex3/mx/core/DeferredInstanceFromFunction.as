/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public class DeferredInstanceFromFunction implements IDeferredInstance {
		/**
		 * Constructor.
		 *
		 * @param generator         <Function> A function that creates and returns an instance
		 *                            of the required object.
		 */
		public function DeferredInstanceFromFunction(generator:Function);
		/**
		 * Returns a reference to an instance of the desired object.
		 *  If no instance of the required object exists, calls the function
		 *  specified in this class' generator constructor parameter.
		 *
		 * @return                  <Object> An instance of the object.
		 */
		public function getInstance():Object;
	}
}
