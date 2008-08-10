/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public dynamic  class Function {
		/**
		 * Specifies the value of thisObject to be used within any function that ActionScript calls.
		 *  This method also specifies the parameters to be passed to any called function. Because apply()
		 *  is a method of the Function class, it is also a method of every Function object in ActionScript.
		 *
		 * @param thisArg           <* (default = NaN)> The object to which the function is applied.
		 * @param argArray          <* (default = NaN)> An array whose elements are passed to the function as parameters.
		 * @return                  <*> Any value that the called function specifies.
		 */
		AS3 function apply(thisArg:*, argArray:*):*;
		/**
		 * Invokes the function represented by a Function object. Every function in ActionScript
		 *  is represented by a Function object, so all functions support this method.
		 *
		 * @param thisArg           <* (default = NaN)> An object that specifies the value of thisObject within the function body.
		 */
		AS3 function call(thisArg:*, ... args):*;
	}
}
