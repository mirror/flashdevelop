/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public final  class Boolean {
		/**
		 * Creates a Boolean object with the specified value. If you omit the expression
		 *  parameter, the Boolean object is initialized with a value of false. If you
		 *  specify a value for the expression parameter, the method evaluates it and returns the result
		 *  as a Boolean value according to the rules in the global Boolean() function.
		 *
		 * @param expression        <Object (default = false)> Any expression.
		 */
		public function Boolean(expression:Object = false);
		/**
		 * Returns the string representation ("true" or
		 *  "false") of the Boolean object. The output is not localized, and is "true" or
		 *  "false" regardless of the system language.
		 *
		 * @return                  <String> The string "true" or "false".
		 */
		AS3 function toString():String;
		/**
		 * Returns true if the value of the specified Boolean
		 *  object is true; false otherwise.
		 *
		 * @return                  <Boolean> A Boolean value.
		 */
		AS3 function valueOf():Boolean;
	}
}
