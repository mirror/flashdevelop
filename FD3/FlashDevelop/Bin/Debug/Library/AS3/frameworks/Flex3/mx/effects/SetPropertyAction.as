package mx.effects
{
	import mx.effects.effectClasses.SetPropertyActionInstance;

	[Exclude(name="duration", kind="property")] 

include "../core/Version.as"
	/**
	 *  The SetPropertyAction class defines an action effect that corresponds
 *  to the <code>SetProperty property</code> of a view state definition.
 *  You use a SetPropertyAction effect within a transition definition
 *  to control when the view state change defined by a
 *  <code>SetProperty</code> property occurs during the transition.
 *  
 *  @mxml
 *
 *  <p>The <code>&lt;mx:SetPropertyAction&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and adds the following tag attributes:</p>
 * 
 *  <pre>
 *  &lt;mx:SetPropertyAction
 *    <b>Properties</b>
 *    id="ID"
 *    name=""
 *    value=""
 *  /&gt;
 *  </pre>
 *  
 *  @see mx.effects.effectClasses.SetPropertyActionInstance
 *  @see mx.states.SetProperty
 *
 *  @includeExample ../states/examples/TransitionExample.mxml
	 */
	public class SetPropertyAction extends Effect
	{
		/**
		 *  The name of the property being changed.
	 *  By default, Flex determines this value from the
	 *  <code>SetProperty</code> property definition
	 *  in the view state definition.
		 */
		public var name : String;
		/**
		 *  The new value for the property.
	 *  By default, Flex determines this value from the
	 *  <code>SetProperty</code> property definition
	 *  in the view state definition.
		 */
		public var value : *;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function SetPropertyAction (target:Object = null);

		/**
		 *  @private
		 */
		public function getAffectedProperties () : Array;

		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
	}
}
