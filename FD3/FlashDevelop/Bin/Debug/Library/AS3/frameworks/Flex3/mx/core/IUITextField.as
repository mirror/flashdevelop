package mx.core
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import mx.automation.IAutomationObject;
	import mx.managers.IToolTipManagerClient;
	import mx.styles.ISimpleStyleClient;

include "ITextFieldInterface.as"
include "IInteractiveObjectInterface.as"
	/**
	 *  The IUITextField interface defines the basic set of APIs
 *  for UITextField instances.
	 */
	public interface IUITextField extends IIMESupport
	{
		/**
		 *  @copy mx.core.UITextField#ignorePadding
		 */
		public function get ignorePadding () : Boolean;
		public function set ignorePadding (value:Boolean) : void;

		/**
		 *  @copy mx.core.UITextField#inheritingStyles
		 */
		public function get inheritingStyles () : Object;
		public function set inheritingStyles (value:Object) : void;

		/**
		 *  @copy mx.core.UITextField#nestLevel
		 */
		public function get nestLevel () : int;
		public function set nestLevel (value:int) : void;

		/**
		 *  @copy mx.core.UITextField#nonInheritingStyles
		 */
		public function get nonInheritingStyles () : Object;
		public function set nonInheritingStyles (value:Object) : void;

		/**
		 *  @copy mx.core.UITextField#nonZeroTextHeight
		 */
		public function get nonZeroTextHeight () : Number;

		/**
		 *  @copy mx.core.UITextField#getStyle()
		 */
		public function getStyle (styleProp:String) : *;

		/**
		 *  @copy mx.core.UITextField#getUITextFormat()
		 */
		public function getUITextFormat () : UITextFormat;

		/**
		 *  @copy mx.core.UITextField#setColor()
		 */
		public function setColor (color:uint) : void;

		/**
		 *  @copy mx.core.UITextField#setFocus()
		 */
		public function setFocus () : void;

		/**
		 *  @copy mx.core.UITextField#truncateToFit()
		 */
		public function truncateToFit (truncationIndicator:String = null) : Boolean;
	}
}
