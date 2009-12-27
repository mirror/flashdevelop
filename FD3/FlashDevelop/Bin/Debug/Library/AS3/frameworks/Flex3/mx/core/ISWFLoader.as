﻿package mx.core
{
	import flash.geom.Rectangle;
	import mx.core.ISWFBridgeProvider;

	/**
	 *  The ISWFLoader interface defines an API with special properties
 *  and method required when loading compatible applications and untrusted applications.
	 */
	public interface ISWFLoader extends ISWFBridgeProvider
	{
		/**
		 *  A flag that indicates whether the content is loaded so that it can
     *  interoperate with applications that were built with a different verion of Flex.  
     *  Compatibility with other Flex Applications is accomplished by loading
     *  the application into a sibling (or peer) ApplicationDomain.
     *  This flag is ignored if the sub application is loaded into a different
     *  SecurityDomain than the main application.
     *  If <code>true</code>, the content loads into a sibling ApplicationDomain. 
     *  If <code>false</code>, the content loaded into a child ApplicationDomain.
     *
     *  @default false
		 */
		public function get loadForCompatibility () : Boolean;
		/**
		 *  @private
		 */
		public function set loadForCompatibility (value:Boolean) : void;

		/**
		 *  Get the bounds of the loaded application that are visible to the user
     *  on the screen.
     * 
     *  @param allApplications Determine if the visible rectangle is calculated based only on the 
     *  display objects in this application or all parent applications as well.
     *  Including more parent applications might reduce the visible area returned.
     *  If <code>true</code>, then all applications are used to find the visible
     *  area, otherwise only the display objects in this application are used.
     * 
     *  @return A <code>Rectangle</code> that includes the visible portion of this 
     *  object. The rectangle uses global coordinates.
		 */
		public function getVisibleApplicationRect (allApplications:Boolean = false) : Rectangle;
	}
}
