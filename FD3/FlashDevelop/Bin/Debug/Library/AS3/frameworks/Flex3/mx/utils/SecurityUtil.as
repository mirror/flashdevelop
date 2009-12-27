package mx.utils
{
	import flash.events.IEventDispatcher;
	import mx.core.ISWFBridgeProvider;

include "../core/Version.as"
	/**
	 *  Utilities for working with security-related issues.
	 */
	public class SecurityUtil
	{
		/**
		 *  Tests if there is mutual trust between the parent and child of the specified bridge.
	 * 
	 *  @param bp The provider of the bridge that connects the two applications.
	 * 
	 *  @return <code>true</code> if there is mutual trust; otherwise <code>false</code>.
		 */
		public static function hasMutualTrustBetweenParentAndChild (bp:ISWFBridgeProvider) : Boolean;
	}
}
