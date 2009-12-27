package mx.managers
{
include "../core/Version.as"
	/**
	 *  The CursorManagerPriority class defines the constant values for the 
 *  <code>priority</code> argument to the 
 *  <code>CursorManager.setCursor()</code> method. 
 *
 *  @see mx.managers.CursorManager
	 */
	public class CursorManagerPriority
	{
		/**
		 *  Constant that specifies the highest cursor priority when passed
	 *  as the <code>priority</code> argument to <code>setCursor()</code>.
		 */
		public static const HIGH : int = 1;
		/**
		 *  Constant that specifies a medium cursor priority when passed 
	 *  as the <code>priority</code> argument to <code>setCursor()</code>.
		 */
		public static const MEDIUM : int = 2;
		/**
		 *  Constant that specifies the lowest cursor priority when passed
	 *  as the <code>priority</code> argument to <code>setCursor()</code>.
		 */
		public static const LOW : int = 3;
	}
}
