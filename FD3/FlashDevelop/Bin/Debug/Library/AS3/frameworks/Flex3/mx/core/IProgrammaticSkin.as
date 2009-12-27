package mx.core
{
	/**
	 *  The IProgrammaticSkin interface defines the interface that skin classes must implement 
 *  if they use the <code>name</code> property skin interface.
	 */
	public interface IProgrammaticSkin
	{
		/**
		 *  @copy mx.skins.ProgrammaticSkin#validateNow()
		 */
		public function validateNow () : void;

		/**
		 *  @copy mx.skins.ProgrammaticSkin#validateDisplayList()
		 */
		public function validateDisplayList () : void;
	}
}
