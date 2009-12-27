package mx.styles
{
	/**
	 * Simple interface that defines an <code>unload()</code> method.
 * You can cast an object to an IStyleModule type so that there is no dependency on the StyleModule
 * type in the loading application.
	 */
	public interface IStyleModule
	{
		/**
		 * Unloads the style module.
		 */
		public function unload () : void;
	}
}
