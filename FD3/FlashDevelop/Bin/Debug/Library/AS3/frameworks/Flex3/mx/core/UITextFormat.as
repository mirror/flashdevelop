package mx.core
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManagerGlobals;

	/**
	 *  The UITextFormat class represents character formatting information *  for the UITextField class. *  The UITextField class defines the component used by many Flex composite *  components to display text. * *  <p>The UITextFormat class extends the flash.text.TextFormat class *  to add the text measurement methods <code>measureText()</code> *  and <code>measureHTMLText()</code> and to add properties for *  controlling the advanced anti-aliasing of fonts.</p> * *  @see mx.core.UITextField
	 */
	public class UITextFormat extends TextFormat
	{
		/**
		 *  @private     *  Storage for the embeddedFontRegistry property.     *  This gets initialized on first access,     *  not at static initialization time, in order to ensure     *  that the Singleton registry has been initialized.
		 */
		private static var _embeddedFontRegistry : IEmbeddedFontRegistry;
		/**
		 *  @private     *  Storage for the textFieldFactory property.     *  This gets initialized on first access,     *  not at static initialization time, in order to ensure     *  that the Singleton registry has already been initialized.
		 */
		private static var _textFieldFactory : ITextFieldFactory;
		/**
		 *  @private
		 */
		private var systemManager : ISystemManager;
		/**
		 * @private     *      * Cache last value of embedded font.
		 */
		private var cachedEmbeddedFont : EmbeddedFont;
		/**
		 *  Defines the anti-aliasing setting for the UITextField class.     *  The possible values are <code>"normal"</code>      *  (<code>flash.text.AntiAliasType.NORMAL</code>)      *  and <code>"advanced"</code>      *  (<code>flash.text.AntiAliasType.ADVANCED</code>).      *       *  <p>The default value is <code>"advanced"</code>,      *  which enables advanced anti-aliasing      *  for the embedded font.      *  Set this property to <code>"normal"</code>     *  to disable the advanced anti-aliasing.</p>     *       *  <p>This property has no effect for system fonts.</p>     *       *  <p>This property applies to all the text in a UITextField object;      *  you cannot apply it to some characters and not others.</p>     *      *  @default "advanced"     *     *  @see flash.text.AntiAliasType
		 */
		public var antiAliasType : String;
		/**
		 *  Defines the grid-fitting setting for the UITextField class.     *  The possible values are <code>"none"</code>      *  (<code>flash.text.GridFitType.NONE</code>),      *  <code>"pixel"</code>      *  (<code>flash.text.GridFitType.PIXEL</code>),     *  and <code>"subpixel"</code>      *  (<code>flash.text.GridFitType.SUBPIXEL</code>).      *       *  <p>This property only applies when you are using an     *  embedded font and the <code>fontAntiAliasType</code>     *  property is set to <code>"advanced"</code>.</p>     *       *  <p>This property has no effect for system fonts.</p>     *      *  <p>This property applies to all the text in a UITextField object;      *  you cannot apply it to some characters and not others.</p>     *      *  @default "pixel"     *     *  @see flash.text.GridFitType
		 */
		public var gridFitType : String;
		/**
		 *  @private     *  Storage for the moduleFactory property.
		 */
		private var _moduleFactory : IFlexModuleFactory;
		/**
		 *  Defines the sharpness setting for the UITextField class.     *  This property specifies the sharpness of the glyph edges.      *  The possible values are Numbers from -400 through 400.      *       *  <p>This property only applies when you are using an      *  embedded font and the <code>fontAntiAliasType</code>     *  property is set to <code>"advanced"</code>.</p>     *       *  <p>This property has no effect for system fonts.</p>     *      *  <p>This property applies to all the text in a UITextField object;      *  you cannot apply it to some characters and not others.</p>     *       *  @default 0     *  @see flash.text.TextField
		 */
		public var sharpness : Number;
		/**
		 *  Defines the thickness setting for the UITextField class.     *  This property specifies the thickness of the glyph edges.     *  The possible values are Numbers from -200 to 200.      *       *  <p>This property only applies when you are using an      *  embedded font and the <code>fontAntiAliasType</code>     *  property is set to <code>"advanced"</code>.</p>     *       *  <p>This property has no effect for system fonts.</p>     *      *  <p>This property applies to all the text in a UITextField object;      *  you cannot apply it to some characters and not others.</p>     *       *  @default 0     *  @see flash.text.TextField
		 */
		public var thickness : Number;

		/**
		 *  @private     *  A reference to the embedded font registry.     *  Single registry in the system.     *  Used to look up the moduleFactory of a font.
		 */
		private static function get embeddedFontRegistry () : IEmbeddedFontRegistry;
		/**
		 *  @private     *  Factory for text fields used to measure text.     *  Created in the context of module factories     *  so the text field has access to an embedded font, if needed.
		 */
		private static function get textFieldFactory () : ITextFieldFactory;
		/**
		 *  The moduleFactory used to create TextFields for embedded fonts.
		 */
		public function get moduleFactory () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set moduleFactory (value:IFlexModuleFactory) : void;

		/**
		 *  Constructor.     *     *  @param systemManager A SystemManager object.     *  The SystemManager keeps track of which fonts are embedded.     *  Typically this is the SystemManager obtained from the     *  <code>systemManager</code> property of UIComponent.     *     *  @param font A String specifying the name of a font,     *  or <code>null</code> to indicate that this UITextFormat     *  doesn't specify this property.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @param size A Number specifying a font size in pixels,     *  or <code>null</code> to indicate that this UITextFormat     *  doesn't specify this property.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @param color An unsigned integer specifying the RGB color of the text,     *  such as 0xFF0000 for red, or <code>null</code> to indicate     *  that is UITextFormat doesn't specify this property.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @param bold A Boolean flag specifying whether the text is bold,     *  or <code>null</code> to indicate that this UITextFormat     *  doesn't specify this property.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @param italic A Boolean flag specifying whether the text is italic,     *  or <code>null</code> to indicate that this UITextFormat     *  doesn't specify this property.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @param italic A Boolean flag specifying whether the text is underlined,     *  or <code>null</code> to indicate that this UITextFormat     *  doesn't specify this property.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @param urlString A String specifying the URL to which the text is     *  hyperlinked, or <code>null</code> to indicate that this UITextFormat     *  doesn't specify this property.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @param target A String specifying the target window     *  where the hyperlinked URL is displayed.      *  If the target window is <code>null</code> or an empty string,     *  the hyperlinked page is displayed in the same browser window.     *  If the <code>urlString</code> parameter is <code>null</code>     *  or an empty string, this property has no effect.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @param align A String specifying the alignment of the paragraph,     *  as a flash.text.TextFormatAlign value, or <code>null</code> to indicate     *  that this UITextFormat doesn't specify this property.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @param leftMargin A Number specifying the left margin of the paragraph,     *  in pixels, or <code>null</code> to indicate that this UITextFormat     *  doesn't specify this property.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @param rightMargin A Number specifying the right margin of the paragraph,     *  in pixels, or <code>null</code> to indicate that this UITextFormat     *  doesn't specify this property.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @param indent A Number specifying the indentation from the left     *  margin to the first character in the paragraph, in pixels,     *  or <code>null</code> to indicate that this UITextFormat     *  doesn't specify this property.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @param leading A Number specifying the amount of additional vertical     *  space between lines, or <code>null</code> to indicate     *  that this UITextFormat doesn't specify this property.     *  This parameter is optional, with a default value of <code>null</code>.     *     *  @see fl
		 */
		public function UITextFormat (systemManager:ISystemManager, font:String = null, size:Object = null, color:Object = null, bold:Object = null, italic:Object = null, underline:Object = null, url:String = null, target:String = null, align:String = null, leftMargin:Object = null, rightMargin:Object = null, indent:Object = null, leading:Object = null);
		/**
		 *  Returns measurement information for the specified text,      *  assuming that it is displayed in a single-line UITextField component,      *  and using this UITextFormat object to define the text format.      *     *  @param text A String specifying the text to measure.     *       *  @param roundUp A Boolean flag specifying whether to round up the     *  the measured width and height to the nearest integer.     *  Rounding up is appropriate in most circumstances.     *       *  @return A TextLineMetrics object containing the text measurements.     *     *  @see flash.text.TextLineMetrics
		 */
		public function measureText (text:String, roundUp:Boolean = true) : TextLineMetrics;
		/**
		 *  Returns measurement information for the specified HTML text,      *  which may contain HTML tags such as <code>&lt;font&gt;</code>     *  and <code>&lt;b&gt;</code>, assuming that it is displayed     *  in a single-line UITextField, and using this UITextFormat object     *  to define the text format.     *     *  @param text A String specifying the HTML text to measure.     *       *  @param roundUp A Boolean flag specifying whether to round up the     *  the measured width and height to the nearest integer.     *  Rounding up is appropriate in most circumstances.     *      *  @return A TextLineMetrics object containing the text measurements.     *     *  @see flash.text.TextLineMetrics
		 */
		public function measureHTMLText (htmlText:String, roundUp:Boolean = true) : TextLineMetrics;
		/**
		 *  @private
		 */
		private function measure (s:String, html:Boolean, roundUp:Boolean) : TextLineMetrics;
		/**
		 * @private     *      * Get the embedded font for a set of font attributes.
		 */
		private function getEmbeddedFont (fontName:String, bold:Boolean, italic:Boolean) : EmbeddedFont;
		/**
		 *  @private
		 */
		function copyFrom (source:TextFormat) : void;
	}
}
