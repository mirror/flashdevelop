/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.xml {
	public class QualifiedResourceManager {
		/**
		 * This Array is used to preserve order in which resources were
		 *  added so as to support the order in which they are searched.
		 */
		protected var resources:Array;
		/**
		 * Maps Namespace.uri to an Array of
		 *  resources.
		 */
		protected var resourcesMap:Object;
		/**
		 */
		public function QualifiedResourceManager();
		/**
		 * Adds a resource to a potential Array of resources for a
		 *  given namespace.
		 *
		 * @param ns                <Namespace> 
		 * @param resource          <Object> 
		 */
		public function addResource(ns:Namespace, resource:Object):void;
		/**
		 * Gets an Array of all resources.
		 */
		public function getResources():Array;
		/**
		 * Gets an Array of resources for a given target namespace.
		 *
		 * @param ns                <Namespace> 
		 */
		public function getResourcesForNamespace(ns:Namespace):Array;
		/**
		 * @param uri               <String> 
		 */
		public function getResourcesForURI(uri:String):Array;
	}
}
