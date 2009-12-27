package mx.containers.errors
{
include "../../core/Version.as"
	/**
	 *  This error is thrown when a constraint expression is not configured properly;
 *  for example, if the GridColumn reference is invalid.
	 */
	public class ConstraintError extends Error
	{
		/**
		 *  Constructor.
	 *
	 *  @param message A message providing information about the error cause.
		 */
		public function ConstraintError (message:String);
	}
}
