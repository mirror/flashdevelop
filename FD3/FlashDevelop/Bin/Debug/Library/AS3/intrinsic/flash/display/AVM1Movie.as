/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/*** Fixed manually [philippe 2008-Jun*15] ****************/
/**********************************************************/
package flash.display {
	public class AVM1Movie extends DisplayObject {
		/**
		 * Registers an ActionScript method as callable from the container.
		 *
		 * @param functionName      <String> The name by which the container can invoke
		 *                            the function.
		 * @param closure           <Function> The function closure to invoke.  This could be a
		 *                            free-standing function, or it could be a method closure
		 *                            referencing a method of an object instance.  By passing
		 *                            a method closure, you can direct the callback
		 *                            at a method of a particular object instance.
		 */
		public function addCallback (functionName:String, closure:Function) : void;
		/**
		 * Calls a function exposed by the AVM1Movie, passing zero or
		 *  more arguments.  If the function is not available, the call returns
		 *  null; otherwise it returns the value provided by the function.
		 *
		 * @param functionName      <String> The alphanumeric name of the function to call in the container.
		 * @return                  <*> The response received from the container. If the call failed- for example, if there is no such
		 *                            function in the container, the interface is not available, or there is a security issue
		 *                            - null is returned and an error is thrown.
		 */
		 public function call (functionName:String) : *;
	}
}
