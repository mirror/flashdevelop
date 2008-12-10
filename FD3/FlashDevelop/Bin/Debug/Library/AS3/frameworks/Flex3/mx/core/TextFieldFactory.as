package mx.core
{
	import flash.text.TextField;
	import flash.utils.Dictionary;

	/**
	 *  @private *  Singleton to create TextFields in the context of various ModuleFactories.  *  One module factory will have at most one TextField created for it. *  The text fields are only used for measurement; *  they are not on the display list.
	 */
	public class TextFieldFactory implements ITextFieldFactory
	{
		/**
		 *  @private	 * 	 *  This classes singleton.
		 */
		private static var instance : ITextFieldFactory;
		/**
		 *  @private	 * 	 *  Cache of textFields. Limit of one per module factory.
		 */
		private var textFields : Dictionary;

		/**
		 *  @private
		 */
		public static function getInstance () : ITextFieldFactory;
		/**
		 *  @private	 *  Creates a TextField in the context of the specified IFlexModuleFactory.	 *	 *  @param moduleFactory The moduleFactory requesting the TextField.	 *	 *	@return A text field for a given moduleFactory.
		 */
		public function createTextField (moduleFactory:IFlexModuleFactory) : TextField;
	}
}
