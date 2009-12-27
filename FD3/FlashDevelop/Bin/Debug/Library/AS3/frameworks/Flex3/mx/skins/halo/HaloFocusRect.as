package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleClient;
	import mx.utils.GraphicsUtil;

include "../../core/Version.as"
	/**
	 *  Defines the skin for the focus indicator. This is the rectangle that appears around a control when it has focus.
	 */
	public class HaloFocusRect extends ProgrammaticSkin implements IStyleClient
	{
		/**
		 *  @private
		 */
		private var _focusColor : Number;

		/**
		 *  @private
		 */
		public function get className () : String;

		/**
		 *  @private
		 */
		public function get inheritingStyles () : Object;
		/**
		 *  @private
		 */
		public function set inheritingStyles (value:Object) : void;

		/**
		 *  @private
		 */
		public function get nonInheritingStyles () : Object;
		/**
		 *  @private
		 */
		public function set nonInheritingStyles (value:Object) : void;

		/**
		 *  @private
		 */
		public function get styleDeclaration () : CSSStyleDeclaration;
		/**
		 *  @private
		 */
		public function set styleDeclaration (value:CSSStyleDeclaration) : void;

		/**
		 *  Constructor.
		 */
		public function HaloFocusRect ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;

		/**
		 *  @private
		 */
		public function getStyle (styleProp:String) : *;

		/**
		 *  @private
		 */
		public function setStyle (styleProp:String, newValue:*) : void;

		/**
		 *  @private
		 */
		public function clearStyle (styleProp:String) : void;

		/**
		 *  @private
		 */
		public function getClassStyleDeclarations () : Array;

		/**
		 *  @private
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;

		/**
		 *  @private
		 */
		public function regenerateStyleCache (recursive:Boolean) : void;

		/**
		 *  @private
		 */
		public function registerEffects (effects:Array) : void;
	}
}
