package mx.styles
{
	import flash.events.IEventDispatcher;

	/**
	 *  @private
 *  This interface was used by Flex 2.0.1.
 *  Flex 3 now uses IStyleManager2 instead.
	 */
	public interface IStyleManager
	{
		public function get inheritingStyles () : Object;
		public function set inheritingStyles (value:Object) : void;

		public function get stylesRoot () : Object;
		public function set stylesRoot (value:Object) : void;

		public function get typeSelectorCache () : Object;
		public function set typeSelectorCache (value:Object) : void;

		public function getStyleDeclaration (selector:String) : CSSStyleDeclaration;

		public function setStyleDeclaration (selector:String, styleDeclaration:CSSStyleDeclaration, update:Boolean) : void;

		public function clearStyleDeclaration (selector:String, update:Boolean) : void;

		public function registerInheritingStyle (styleName:String) : void;

		public function isInheritingStyle (styleName:String) : Boolean;

		public function isInheritingTextFormatStyle (styleName:String) : Boolean;

		public function registerSizeInvalidatingStyle (styleName:String) : void;

		public function isSizeInvalidatingStyle (styleName:String) : Boolean;

		public function registerParentSizeInvalidatingStyle (styleName:String) : void;

		public function isParentSizeInvalidatingStyle (styleName:String) : Boolean;

		public function registerParentDisplayListInvalidatingStyle (styleName:String) : void;

		public function isParentDisplayListInvalidatingStyle (styleName:String) : Boolean;

		public function registerColorName (colorName:String, colorValue:uint) : void;

		public function isColorName (colorName:String) : Boolean;

		public function getColorName (colorName:Object) : uint;

		public function getColorNames (colors:Array) : void;

		/// of Number or String
		public function isValidStyleValue (value:*) : Boolean;

		public function loadStyleDeclarations (url:String, update:Boolean = true, trustContent:Boolean = false) : IEventDispatcher;

		public function unloadStyleDeclarations (url:String, update:Boolean = true) : void;

		public function initProtoChainRoots () : void;

		public function styleDeclarationsChanged () : void;
	}
}
