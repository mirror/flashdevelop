package mx.controls
{
	import flash.display.DisplayObject;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import mx.core.EdgeMetrics;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IRectangularBorder;
	import mx.core.IToolTip;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.styles.ISimpleStyleClient;

include "../styles/metadata/BorderStyles.as"
include "../styles/metadata/LeadingStyle.as"
include "../styles/metadata/PaddingStyles.as"
include "../styles/metadata/TextStyles.as"
include "../core/Version.as"
	/**
	 *  The ToolTip control lets you provide helpful information to your users.
 *  When a user moves the mouse pointer over a graphical component, the ToolTip
 *  control pops up and displays text that provides information about the
 *  component.
 *  You can use ToolTips to guide users as they work with your application
 *  or customize the ToolTip controls to provide additional functionality.
 *
 *  @see mx.managers.ToolTipManager
 *  @see mx.styles.CSSStyleDeclaration
	 */
	public class ToolTip extends UIComponent implements IToolTip
	{
		/**
		 *  Maximum width in pixels for new ToolTip controls.
		 */
		public static var maxWidth : Number;
		/**
		 *  The internal object that draws the border.
		 */
		var border : IFlexDisplayObject;
		/**
		 *  @private
     *  Storage for the text property.
		 */
		private var _text : String;
		/**
		 *  @private
		 */
		private var textChanged : Boolean;
		/**
		 *  The internal UITextField that renders the text of this ToolTip.
		 */
		protected var textField : IUITextField;

		/**
		 *  @private
		 */
		private function get borderMetrics () : EdgeMetrics;

		/**
		 *  @private
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;

		/**
		 *  The text displayed by the ToolTip.
     *
     *  @default null
		 */
		public function get text () : String;
		/**
		 *  @private
		 */
		public function set text (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function ToolTip ();

		/**
		 *  @private
		 */
		protected function createChildren () : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  @private
		 */
		protected function measure () : void;

		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
     *  Creates the text field child and adds it as a child of this component.
     * 
     *  @param childIndex The index of where to add the child.
     *  If -1, the text field is appended to the end of the list.
		 */
		function createTextField (childIndex:int) : void;

		/**
		 *  @private
     *  Removes the text field from this component.
		 */
		function removeTextField () : void;

		/**
		 *  @private
		 */
		function getTextField () : IUITextField;
	}
}
