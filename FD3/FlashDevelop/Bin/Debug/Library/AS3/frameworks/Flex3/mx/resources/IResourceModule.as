package mx.resources
{
	/**
	 *  @private
 *  When the MXML compiler compiles a resource module, the class
 *  that it autogenerates to represent the module implements this interface.
	 */
	public interface IResourceModule
	{
		/**
		 *  An Array of ResourceBundle instances, containing one for each
	 *  of the resource bundle classes in this resource module.
	 *  
	 *  <p>The order of ResourceBundle instances in this Array
	 *  is not specified.</p>
		 */
		public function get resourceBundles () : Array;
	}
}
