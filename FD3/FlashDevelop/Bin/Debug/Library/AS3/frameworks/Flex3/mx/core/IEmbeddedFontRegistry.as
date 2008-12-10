﻿package mx.core
{
	/**
	 *  @private *  Interface to a registery of fonts embedded in SWF files.
	 */
	public interface IEmbeddedFontRegistry
	{
		/**
		 *  Registers a font and associates it with a moduleFactory.     *      *  @param font Describes attributes of the font to register.	 *     *  @param moduleFactory The moduleFactory where the font is embedded.
		 */
		public function registerFont (font:EmbeddedFont, moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  Deregisters a font.	 *	 *  <p>The <code>moduleFactory</code> is provided to resolve the case	 *  where multiple fonts are registered with the same attributes.</p>	 *      *  @param font Describes attributes of the font to register.	 *     *  @param moduleFactory moduleFactory where the font is embedded.
		 */
		public function deregisterFont (font:EmbeddedFont, moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  Finds the <code>moduleFactory</code> associated with a font.	 *	 *  <p>The <code>moduleFactory</code> is used to resolve the case     *  where multiple fonts are registered with the same attributes.</p>     *      *  @param font Describes attributes of the font to register.	 *	 *  @param defaultModuleFactory Used to resolve conflicts in the case	 *  where the same font is registered for multiple module factories.	 *  If one of the module factories of a font is associated with	 *  defaultModuleFactory, then that moduleFactory is returned.	 *  Otherwise the most recently registered moduleFactory will be chosen.     *      *  @return moduleFactory that can be used to create an object	 *  in the context of the font.      *  null if the font is not found in the registry.
		 */
		public function getAssociatedModuleFactory (font:EmbeddedFont, defaultModuleFactory:IFlexModuleFactory) : IFlexModuleFactory;
		/**
		 *  Gets an array of all the fonts that have been registered.	 *	 *  <p>Each element in the array is of type EmbeddedFont.</p>     *      *  @return Array of EmbeddedFont objects.	 *  Fonts that have been registered multiple times will appear	 *  multiple times in the array.
		 */
		public function getFonts () : Array;
	}
}
