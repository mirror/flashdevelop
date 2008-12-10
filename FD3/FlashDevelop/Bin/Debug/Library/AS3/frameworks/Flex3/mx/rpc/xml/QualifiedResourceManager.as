package mx.rpc.xml
{
	/**
	 * QualifiedResourceManager is a helper class that simply maintains * the order that resources were added and maps a target namespace to * one or more resources.
	 */
	public class QualifiedResourceManager
	{
		/**
		 * This Array is used to preserve order in which resources were     * added so as to support the order in which they are searched.
		 */
		protected var resources : Array;
		/**
		 * Maps <code>Namespace.uri</code> to an <code>Array</code> of     * resources.
		 */
		protected var resourcesMap : Object;

		/**
		 * Constructor.
		 */
		public function QualifiedResourceManager ();
		/**
		 * Adds a resource to a potential Array of resources for a     * given namespace.     *     * @param ns The namespace for the Array of resources.     *     * @param resource The resource to add.
		 */
		public function addResource (ns:Namespace, resource:Object) : void;
		/**
		 * Returns an Array of resources for a given target namespace.     *     * @param The namespace for the Array of resources.     *     * @return An Array of resources.
		 */
		public function getResourcesForNamespace (ns:Namespace) : Array;
		/**
		 * Returns an Array of resources for a given target URI.     *     * @param uri The URI for the Array of resources.     *     * @return An Array of resources.
		 */
		public function getResourcesForURI (uri:String) : Array;
		/**
		 * Gets an Array of all resources.     *     * @return An Array of resources.
		 */
		public function getResources () : Array;
	}
}
