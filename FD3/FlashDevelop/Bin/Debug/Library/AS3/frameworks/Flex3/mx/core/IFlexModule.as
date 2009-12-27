package mx.core
{
	/**
	 *  The IFlexModule interface is used as an optional contract with IFlexModuleFactory.
 *  When an IFlexModule instance is created with the IFlexModuleFactory, the factory
 *  stores a reference to itself after creation.
	 */
	public interface IFlexModule
	{
		/**
		 *  @private
		 */
		public function set moduleFactory (factory:IFlexModuleFactory) : void;
		/**
		 * @private
		 */
		public function get moduleFactory () : IFlexModuleFactory;
	}
}
