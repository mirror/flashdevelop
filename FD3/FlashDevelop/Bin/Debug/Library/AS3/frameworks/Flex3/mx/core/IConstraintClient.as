/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public interface IConstraintClient {
		/**
		 * Returns the specified constraint value.
		 *
		 * @param constraintName    <String> name of the constraint value. Constraint parameters are
		 *                            "baseline", "bottom", "horizontalCenter",
		 *                            "left", "right", "top", and
		 *                            "verticalCenter".
		 *                            For more information about these parameters, see the Canvas and Panel containers and
		 *                            Styles Metadata AnchorStyles.
		 * @return                  <*> The constraint value, or null if it is not defined.
		 */
		public function getConstraintValue(constraintName:String):*;
		/**
		 * Sets the specified constraint value.
		 *
		 * @param constraintName    <String> name of the constraint value. Constraint parameters are
		 *                            "baseline", "bottom", "horizontalCenter",
		 *                            "left", "right", "top", and
		 *                            "verticalCenter".
		 *                            For more information about these parameters, see the Canvas and Panel containers and
		 *                            Styles Metadata AnchorStyles.
		 * @param value             <*> The new value for the constraint.
		 */
		public function setConstraintValue(constraintName:String, value:*):void;
	}
}
