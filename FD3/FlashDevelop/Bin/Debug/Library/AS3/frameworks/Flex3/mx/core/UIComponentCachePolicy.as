package mx.core
{
include "../core/Version.as"
	/**
	 *  The ContainerCreationPolicy class defines the constant values
 *  for the <code>cachePolicy</code> property of the UIComponent class.
 *
 *  @see mx.core.UIComponent#cachePolicy
	 */
	public class UIComponentCachePolicy
	{
		/**
		 *  Specifies that the Flex framework should use heuristics
	 *  to decide whether to cache the object as a bitmap.
		 */
		public static const AUTO : String = "auto";
		/**
		 *  Specifies that the Flex framework should never attempt
	 *  to cache the object as a bitmap.
		 */
		public static const OFF : String = "off";
		/**
		 *  Specifies that the Flex framework should always cache
	 *  the object as a bitmap.
		 */
		public static const ON : String = "on";
	}
}
