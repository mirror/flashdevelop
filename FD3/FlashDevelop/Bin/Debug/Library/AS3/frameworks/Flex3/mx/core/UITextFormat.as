/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import flash.text.TextFormat;
	import mx.managers.ISystemManager;
	public class UITextFormat extends TextFormat {
		/**
		 * Defines the anti-aliasing setting for the UITextField class.
		 *  The possible values are "normal"
		 *  (flash.text.AntiAliasType.NORMAL)
		 *  and "advanced"
		 *  (flash.text.AntiAliasType.ADVANCED).
		 */
		public var antiAliasType:String;
		/**
		 * Defines the grid-fitting setting for the UITextField class.
		 *  The possible values are "none"
		 *  (flash.text.GridFitType.NONE),
		 *  "pixel"
		 *  (flash.text.GridFitType.PIXEL),
		 *  and "subpixel"
		 *  (flash.text.GridFitType.SUBPIXEL).
		 */
		public var gridFitType:String;
		/**
		 * The moduleFactory used to create TextFields for embedded fonts.
		 */
		public function get moduleFactory():IFlexModuleFactory;
		public function set moduleFactory(value:IFlexModuleFactory):void;
		/**
		 * Defines the sharpness setting for the UITextField class.
		 *  This property specifies the sharpness of the glyph edges.
		 *  The possible values are Numbers from -400 through 400.
		 */
		public var sharpness:Number;
		/**
		 * Defines the thickness setting for the UITextField class.
		 *  This property specifies the thickness of the glyph edges.
		 *  The possible values are Numbers from -200 to 200.
		 */
		public var thickness:Number;
		/**
		 * Constructor.
		 *
		 * @param systemManager     <ISystemManager> A SystemManager object.
		 *                            The SystemManager keeps track of which fonts are embedded.
		 *                            Typically this is the SystemManager obtained from the
		 *                            systemManager property of UIComponent.
		 * @param font              <String (default = null)> A String specifying the name of a font,
		 *                            or null to indicate that this UITextFormat
		 *                            doesn't specify this property.
		 *                            This parameter is optional, with a default value of null.
		 * @param size              <Object (default = null)> A Number specifying a font size in pixels,
		 *                            or null to indicate that this UITextFormat
		 *                            doesn't specify this property.
		 *                            This parameter is optional, with a default value of null.
		 * @param color             <Object (default = null)> An unsigned integer specifying the RGB color of the text,
		 *                            such as 0xFF0000 for red, or null to indicate
		 *                            that is UITextFormat doesn't specify this property.
		 *                            This parameter is optional, with a default value of null.
		 * @param bold              <Object (default = null)> A Boolean flag specifying whether the text is bold,
		 *                            or null to indicate that this UITextFormat
		 *                            doesn't specify this property.
		 *                            This parameter is optional, with a default value of null.
		 * @param italic            <Object (default = null)> A Boolean flag specifying whether the text is italic,
		 *                            or null to indicate that this UITextFormat
		 *                            doesn't specify this property.
		 *                            This parameter is optional, with a default value of null.
		 * @param underline         <Object (default = null)> A Boolean flag specifying whether the text is underlined,
		 *                            or null to indicate that this UITextFormat
		 *                            doesn't specify this property.
		 *                            This parameter is optional, with a default value of null.
		 * @param url               <String (default = null)> A String specifying the URL to which the text is
		 *                            hyperlinked, or null to indicate that this UITextFormat
		 *                            doesn't specify this property.
		 *                            This parameter is optional, with a default value of null.
		 * @param target            <String (default = null)> A String specifying the target window
		 *                            where the hyperlinked URL is displayed.
		 *                            If the target window is null or an empty string,
		 *                            the hyperlinked page is displayed in the same browser window.
		 *                            If the urlString parameter is null
		 *                            or an empty string, this property has no effect.
		 *                            This parameter is optional, with a default value of null.
		 * @param align             <String (default = null)> A String specifying the alignment of the paragraph,
		 *                            as a flash.text.TextFormatAlign value, or null to indicate
		 *                            that this UITextFormat doesn't specify this property.
		 *                            This parameter is optional, with a default value of null.
		 * @param leftMargin        <Object (default = null)> A Number specifying the left margin of the paragraph,
		 *                            in pixels, or null to indicate that this UITextFormat
		 *                            doesn't specify this property.
		 *                            This parameter is optional, with a default value of null.
		 * @param rightMargin       <Object (default = null)> A Number specifying the right margin of the paragraph,
		 *                            in pixels, or null to indicate that this UITextFormat
		 *                            doesn't specify this property.
		 *                            This parameter is optional, with a default value of null.
		 * @param indent            <Object (default = null)> A Number specifying the indentation from the left
		 *                            margin to the first character in the paragraph, in pixels,
		 *                            or null to indicate that this UITextFormat
		 *                            doesn't specify this property.
		 *                            This parameter is optional, with a default value of null.
		 * @param leading           <Object (default = null)> A Number specifying the amount of additional vertical
		 *                            space between lines, or null to indicate
		 *                            that this UITextFormat doesn't specify this property.
		 *                            This parameter is optional, with a default value of null.
		 */
		public function UITextFormat(systemManager:ISystemManager, font:String = null, size:Object = null, color:Object = null, bold:Object = null, italic:Object = null, underline:Object = null, url:String = null, target:String = null, align:String = null, leftMargin:Object = null, rightMargin:Object = null, indent:Object = null, leading:Object = null);
		/**
		 * Returns measurement information for the specified HTML text,
		 *  which may contain HTML tags such as <font>
		 *  and <b>, assuming that it is displayed
		 *  in a single-line UITextField, and using this UITextFormat object
		 *  to define the text format.
		 *
		 * @param htmlText          <String> A String specifying the HTML text to measure.
		 * @param roundUp           <Boolean (default = true)> A Boolean flag specifying whether to round up the
		 *                            the measured width and height to the nearest integer.
		 *                            Rounding up is appropriate in most circumstances.
		 * @return                  <TextLineMetrics> A TextLineMetrics object containing the text measurements.
		 */
		public function measureHTMLText(htmlText:String, roundUp:Boolean = true):TextLineMetrics;
		/**
		 * Returns measurement information for the specified text,
		 *  assuming that it is displayed in a single-line UITextField component,
		 *  and using this UITextFormat object to define the text format.
		 *
		 * @param text              <String> A String specifying the text to measure.
		 * @param roundUp           <Boolean (default = true)> A Boolean flag specifying whether to round up the
		 *                            the measured width and height to the nearest integer.
		 *                            Rounding up is appropriate in most circumstances.
		 * @return                  <TextLineMetrics> A TextLineMetrics object containing the text measurements.
		 */
		public function measureText(text:String, roundUp:Boolean = true):TextLineMetrics;
	}
}
