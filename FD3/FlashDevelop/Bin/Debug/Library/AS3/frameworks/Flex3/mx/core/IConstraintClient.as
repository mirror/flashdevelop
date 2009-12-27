package mx.core
{
	/**
	 *  The IConstraintClient interface defines the interface for components that
 *  support layout constraints. This interface is only used by implementations
 *  of constraint-based layout.
	 */
	public interface IConstraintClient
	{
		/**
		 *  Returns the specified constraint value.
     *
     *  @param constraintName name of the constraint value. Constraint parameters are
     *  "<code>baseline</code>", "<code>bottom</code>", "<code>horizontalCenter</code>", 
     *  "<code>left</code>", "<code>right</code>", "<code>top</code>", and 
     *  "<code>verticalCenter</code>".
     *
     *  <p>For more information about these parameters, see the Canvas and Panel containers and 
     *  Styles Metadata AnchorStyles.</p>
     *
     *  @return The constraint value, or null if it is not defined.
     *
     *  @see mx.containers.Canvas
     *  @see mx.containers.Panel
		 */
		public function getConstraintValue (constraintName:String) : *;

		/**
		 *  Sets the specified constraint value.
     *
     *  @param constraintName name of the constraint value. Constraint parameters are
     *  "<code>baseline</code>", "<code>bottom</code>", "<code>horizontalCenter</code>", 
     *  "<code>left</code>", "<code>right</code>", "<code>top</code>", and 
     *  "<code>verticalCenter</code>".
     *
     *  <p>For more information about these parameters, see the Canvas and Panel containers and 
     *  Styles Metadata AnchorStyles.</p>
     *
     *  @param value The new value for the constraint.
     *
     *  @see mx.containers.Canvas
     *  @see mx.containers.Panel
		 */
		public function setConstraintValue (constraintName:String, value:*) : void;
	}
}
