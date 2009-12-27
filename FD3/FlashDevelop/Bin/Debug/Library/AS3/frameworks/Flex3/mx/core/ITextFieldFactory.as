package mx.core
{
	import flash.text.TextField;

	/**
	 *  @private
 *  Interface to create text fields.
 *  Text fields are re-used so there are no more than one per module factory.
	 */
	public interface ITextFieldFactory
	{
		/**
		 *  Creates a TextField object in the context
	 *  of a specified module factory.
	 * 
	 *  @param moduleFactory May not be null.
	 *
	 *  @return A TextField created in the context of the module factory.
		 */
		public function createTextField (moduleFactory:IFlexModuleFactory) : TextField;
	}
}
