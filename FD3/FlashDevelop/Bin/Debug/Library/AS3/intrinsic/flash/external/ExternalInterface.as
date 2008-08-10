/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.external {
	public final  class ExternalInterface {
		/**
		 * Indicates whether this player is in a container that offers an external interface.
		 *  If the external interface is available, this property is true; otherwise,
		 *  it is false.
		 */
		public static function get available():Boolean;
		/**
		 * Indicates whether the external interface should attempt to pass ActionScript exceptions to the
		 *  current browser and JavaScript exceptions to Flash Player. You must explicitly set this property
		 *  to true to catch JavaScript exceptions in ActionScript and to catch ActionScript exceptions
		 *  in JavaScript.
		 */
		public static var marshallExceptions:Boolean = false;
		/**
		 * Returns the id attribute of the object tag in Internet Explorer,
		 *  or the name attribute of the embed tag in Netscape.
		 */
		public static function get objectID():String;
		/**
		 * Registers an ActionScript method as callable from the container.
		 *  After a successful invocation of addCallBack(), the registered function in
		 *  Flash Player can be called by JavaScript or ActiveX code in the container.
		 *
		 * @param functionName      <String> The name by which the container can invoke
		 *                            the function.
		 * @param closure           <Function> The function closure to invoke.  This could be a
		 *                            free-standing function, or it could be a method closure
		 *                            referencing a method of an object instance.  By passing
		 *                            a method closure, you can direct the callback
		 *                            at a method of a particular object instance.
		 */
		public static function addCallback(functionName:String, closure:Function):void;
		/**
		 * Calls a function exposed by the Flash Player container, passing zero or
		 *  more arguments.  If the function is not available, the call returns
		 *  null; otherwise it returns the value provided by the function.
		 *  Recursion is not permitted on Opera or Netscape browsers; on these browsers a recursive call
		 *  produces a null response. (Recursion is supported on Internet Explorer and Firefox browsers.)
		 *
		 * @param functionName      <String> The alphanumeric name of the function to call in the container.
		 * @return                  <*> The response received from the container. If the call failed- for example, if there is no such
		 *                            function in the container, the interface is not available, a recursion occurred (with a Netscape
		 *                            or Opera browser), or there is a security issue- null is returned and an error is thrown.
		 */
		public static function call(functionName:String, ... arguments):*;
	}
}
