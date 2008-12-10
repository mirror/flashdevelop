package mx.states
{
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The SetProperty class specifies a property value that is in effect only  *  during the parent view state. *  You use this class in the <code>overrides</code> property of the State class. *  *  @mxml * *  <p>The <code>&lt;mx:SetProperty&gt;</code> tag *  has the following attributes:</p> *   *  <pre> *  &lt;mx:SetProperty *   <b>Properties</b> *   name="null" *   target="null" *   value="undefined" *  /&gt; *  </pre> * *  @see mx.states.State *  @see mx.states.SetEventHandler *  @see mx.states.SetStyle *  @see mx.effects.SetPropertyAction * *  @includeExample examples/StatesExample.mxml
	 */
	public class SetProperty implements IOverride
	{
		/**
		 *  @private     *  This is a table of pseudonyms.     *  Whenever the property being overridden is found in this table,     *  the pseudonym is saved/restored instead.
		 */
		private static const PSEUDONYMS : Object;
		/**
		 *  @private     *  This is a table of related properties.     *  Whenever the property being overridden is found in this table,     *  the related property is also saved and restored.
		 */
		private const RELATED_PROPERTIES : Object;
		/**
		 *  @private     *  Storage for the old property value.
		 */
		private var oldValue : Object;
		/**
		 *  @private     *  Storage for the old related property values, if used.
		 */
		private var oldRelatedValues : Array;
		/**
		 *  The name of the property to change.     *  You must set this property, either in      *  the SetProperty constructor or by setting     *  the property value directly.
		 */
		public var name : String;
		/**
		 *  The object containing the property to be changed.     *  If the property value is <code>null</code>, Flex uses the     *  immediate parent of the State object.     *     *  @default null
		 */
		public var target : Object;
		/**
		 *  The new value for the property.     *     *  @default undefined
		 */
		public var value : *;

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
		 *  @private     *  Sets the property to a value, coercing if necessary.
		 */
		private function setPropertyValue (obj:Object, name:String, value:*, valueForType:Object) : void;
		/**
		 *  @private     *  Converts a value to a Boolean true/false.
		 */
		private function toBoolean (value:Object) : Boolean;
	}
}
