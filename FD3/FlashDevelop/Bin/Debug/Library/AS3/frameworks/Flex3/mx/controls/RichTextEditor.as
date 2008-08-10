/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.containers.Panel;
	import mx.controls.textClasses.TextRange;
	public class RichTextEditor extends Panel {
		/**
		 * The ToolTip that appears when the user hovers over the text alignment buttons. All the buttons
		 *  share the same ToolTip. To view ToolTips, you must also set the showToolTips
		 *  property of the RichTextEditor control to true.
		 */
		public var alignToolTip:String;
		/**
		 * The ToolTip that appears when the user hovers over the text bold button. To view ToolTips,
		 *  you must also set the showToolTips property of the RichTextEditor control to true.
		 */
		public var boldToolTip:String;
		/**
		 * The ToolTip that appears when the user hovers over the bulleted list button. To view ToolTips,
		 *  you must also set the showToolTips property of the RichTextEditor control to true.
		 */
		public var bulletToolTip:String;
		/**
		 * The ToolTip that appears when the user hovers over the ColorPicker control. To view ToolTips,
		 *  you must also set the showToolTips property of the RichTextEditor control to true.
		 */
		public var colorPickerToolTip:String;
		/**
		 * The default protocol string to use at the start of link text.
		 *  This string appears in the LinkTextInput subcontrol, so users do
		 *  not have to type the protocol identifier when entering link text.
		 */
		public var defaultLinkProtocol:String;
		/**
		 * The ToolTip that appears when the user hovers over the font drop-down list. To view ToolTips,
		 *  you must also set the showToolTips property of the RichTextEditor control to true.
		 */
		public var fontFamilyToolTip:String;
		/**
		 * The ToolTip that appears when the user hovers over the font size drop-down list. To view ToolTips,
		 *  you must also set the showToolTips property of the RichTextEditor control to true.
		 */
		public var fontSizeToolTip:String;
		/**
		 * Text containing HTML markup that displays in the RichTextEditor
		 *  control's TextArea subcontrol.
		 *  You cannot set this property and the text property simultaneously.
		 *  If you set one property, it replaces any value set using  the other property.
		 *  You can get both properties; the htmlText property always returns
		 *  a String containing HTML markup that represents the current text formatting.
		 *  For more information on using this property, see the TextArea documentation.
		 */
		public var htmlText:String;
		/**
		 * The ToolTip that appears when the user hovers over the text italic button. To view ToolTips,
		 *  you must also set the showToolTips property of the RichTextEditor control to true.
		 */
		public var italicToolTip:String;
		/**
		 * The ToolTip that appears when the user hovers over the link text input field. To view ToolTips,
		 *  you must also set the showToolTips property of the RichTextEditor control to true.
		 */
		public var linkToolTip:String;
		/**
		 * A TextRange object containing the selected text in the TextArea subcontrol.
		 */
		public function get selection():TextRange;
		/**
		 * Specifies whether to display the control bar that contains the text
		 *  formatting controls.
		 */
		public var showControlBar:Boolean;
		/**
		 * Specifies whether to display tooltips for the text formatting controls.
		 */
		public var showToolTips:Boolean;
		/**
		 * Plain text without markup that displays in the RichTextEditor control's TextArea subcontrol.
		 *  You cannot set this property and the htmlText property simultaneously.
		 *  If you set one property, it replaces any value set using the other property.
		 *  You can get both properties; the text property always returns a plain
		 *  text String with no formatting information.
		 *  For more information on using this property, see the TextArea documentation.
		 */
		public var text:String;
		/**
		 * The ToolTip that appears when the user hovers over the text underline button. To view ToolTips,
		 *  you must also set the showToolTips property of the RichTextEditor control to true.
		 */
		public var underlineToolTip:String;
	}
}
