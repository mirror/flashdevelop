package mx.styles
{
	import mx.core.mx_internal;
	import mx.core.FlexVersion;

	/**
	 *  Wraps an object that implements the IStyleClient interface. This interface *  supports a <code>filterMap</code> property that contains style-source/style-destination pairs. *  *  @see mx.styles.IStyleClient
	 */
	public class StyleProxy implements IStyleClient
	{
		/**
		 *  @private     *  Storage for the filterMap property.
		 */
		private var _filterMap : Object;
		/**
		 *  @private     *  Storage for the filterMap property.
		 */
		private var _source : IStyleClient;

		/**
		 *  @copy mx.styles.IStyleClient#className
		 */
		public function get className () : String;
		/**
		 *  A set of string pairs. The first item of the string pair is the name of the style      *  in the source component. The second item of the String pair is the name of the style      *  in the subcomponent. With this object, you can map a particular style in the parent component      *  to a different style in the subcomponent. This is useful if both the parent      *  component and the subcomponent share the same style, but you want to be able to      *  control the values seperately.
		 */
		public function get filterMap () : Object;
		/**
		 *  @private
		 */
		public function set filterMap (value:Object) : void;
		/**
		 *  @copy mx.styles.IStyleClient#inheritingStyles
		 */
		public function get inheritingStyles () : Object;
		/**
		 *  @private
		 */
		public function set inheritingStyles (value:Object) : void;
		/**
		 *  @copy mx.styles.IStyleClient#nonInheritingStyles
		 */
		public function get nonInheritingStyles () : Object;
		/**
		 *  @private
		 */
		public function set nonInheritingStyles (value:Object) : void;
		/**
		 *  The object that implements the IStyleClient interface. This is the object     *  that is being proxied.
		 */
		public function get source () : IStyleClient;
		/**
		 *  @private
		 */
		public function set source (value:IStyleClient) : void;
		/**
		 *  @copy mx.styles.IStyleClient#styleDeclaration
		 */
		public function get styleDeclaration () : CSSStyleDeclaration;
		/**
		 *  @private
		 */
		public function set styleDeclaration (value:CSSStyleDeclaration) : void;
		/**
		 *  @copy mx.styles.ISimpleStyleClient#styleName
		 */
		public function get styleName () : Object;
		/**
		 *  @private
		 */
		public function set styleName (value:Object) : void;

		/**
		 *  Constructor.     *       *  @param source The object that implements the IStyleClient interface.     *  @param filterMap The set of styles to pass from the source to the subcomponent.
		 */
		public function StyleProxy (source:IStyleClient, filterMap:Object);
		/**
		 *  @copy mx.styles.ISimpleStyleClient#styleChanged()
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @copy mx.styles.IStyleClient#getStyle()
		 */
		public function getStyle (styleProp:String) : *;
		/**
		 *  @copy mx.styles.IStyleClient#setStyle()
		 */
		public function setStyle (styleProp:String, newValue:*) : void;
		/**
		 *  @copy mx.styles.IStyleClient#clearStyle()
		 */
		public function clearStyle (styleProp:String) : void;
		/**
		 *  @copy mx.styles.IStyleClient#getClassStyleDeclarations()
		 */
		public function getClassStyleDeclarations () : Array;
		/**
		 *  @copy mx.styles.IStyleClient#notifyStyleChangeInChildren()
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		/**
		 *  @copy mx.styles.IStyleClient#regenerateStyleCache()
		 */
		public function regenerateStyleCache (recursive:Boolean) : void;
		/**
		 *  @copy mx.styles.IStyleClient#registerEffects()
		 */
		public function registerEffects (effects:Array) : void;
	}
}
