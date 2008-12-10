package mx.states
{
	import mx.core.UIComponent;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;

	/**
	 *  The SetStyle class specifies a style that is in effect only during the parent view state. *  You use this class in the <code>overrides</code> property of the State class. * *  @mxml * *  <p>The <code>&lt;mx:SetStyle&gt;</code> tag *  has the following attributes:</p> *   *  <pre> *  &lt;mx:SetStyle *   <b>Properties</b> *   name="null" *   target="null" *   value"null" *  /&gt; *  </pre> * *  @see mx.states.State *  @see mx.states.SetEventHandler *  @see mx.states.SetProperty *  @see mx.effects.SetStyleAction * *  @includeExample examples/StatesExample.mxml
	 */
	public class SetStyle implements IOverride
	{
		/**
		 *  @private     *  This is a table of related properties.     *  Whenever the property being overridden is found in this table,     *  the related property is also saved and restored.
		 */
		private static const RELATED_PROPERTIES : Object;
		/**
		 *  @private     *  Storage for the old style value.
		 */
		private var oldValue : Object;
		/**
		 *  @private     *  Storage for the old related property values, if used.
		 */
		private var oldRelatedValues : Array;
		/**
		 *     *  The name of the style to change.     *  You must set this property, either in      *  the SetStyle constructor or by setting     *  the property value directly.
		 */
		public var name : String;
		/**
		 *     *  The object whose style is being changed.     *  If the property value is <code>null</code>, Flex uses the     *  immediate parent of the State object.     *      *  @default null
		 */
		public var target : IStyleClient;
		/**
		 *     *  The new value for the style.     *     *  @default null
		 */
		public var value : Object;

		/**
		 *  IOverride interface method; this class implements it as an empty method.     *      *  @copy IOverride#initialize()
		 */
		public function initialize () : void;
		/**
		 *  @inheritDoc
		 */
		public function apply (parent:UIComponent) : void;
		/**
		 *  @inheritDoc
		 */
		public function remove (parent:UIComponent) : void;
		/**
		 *  @private     *  Converts a value to a Boolean true/false.
		 */
		private function toBoolean (value:Object) : Boolean;
	}
}
