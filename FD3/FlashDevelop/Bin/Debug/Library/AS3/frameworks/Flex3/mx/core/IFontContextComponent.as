package mx.core
{
	/**
	 *  Allows a component to support a font context property.
 *  The property will be set on the component by the framework
 *  as the child is added to  the display list.
 * 
 *  A font context is important for components that create flash.text.TextField
 *  objects with embedded fonts.
 *  If an embedded font is not registered using Font.registerFont(), 
 *  TextField objects can only use embedded fonts if they are created
 *  in the context of the embedded font.
 *  This interface provides for tracking the font context of a component.
	 */
	public interface IFontContextComponent
	{
		/**
		 *  The module factory that provides the font context for this component.
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
	}
}
