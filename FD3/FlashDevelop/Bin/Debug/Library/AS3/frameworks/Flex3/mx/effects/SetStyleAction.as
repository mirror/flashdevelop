package mx.effects
{
	import mx.effects.effectClasses.SetStyleActionInstance;

	/**
	 *  The SetStyleAction class defines an action effect that corresponds *  to the SetStyle property of a view state definition. *  You use an SetStyleAction effect within a transition definition *  to control when the view state change defined by a  *  <code>SetStyle</code> property occurs during the transition. *   *  @mxml * *  <p>The <code>&lt;mx:SetStyleAction&gt;</code> tag *  inherits all of the tag attributes of its superclass, *  and adds the following tag attributes:</p> *   *  <pre> *  &lt;mx:SetStyleAction *    <b>Properties</b> *    id="ID" *    style="" *    value="" *  /&gt; *  </pre> *   *  @see mx.effects.effectClasses.SetStyleActionInstance *  @see mx.states.SetStyle * *  @includeExample ../states/examples/TransitionExample.mxml
	 */
	public class SetStyleAction extends Effect
	{
		/**
		 *  The name of the style property being changed.	 *  By default, Flex determines this value from the <code>SetStyle</code>	 *  property definition in the view state definition.
		 */
		public var name : String;
		/**
		 *  The new value for the style property.	 *  By default, Flex determines this value from the <code>SetStyle</code>	 *  property definition in the view state definition.
		 */
		public var value : *;

		/**
		 *  Contains the style properties modified by this effect. 	 *  This getter method overrides the superclass method.	 *	 *  <p>If you create a subclass of this class to create a custom effect, 	 *  you must override this method 	 *  and return an Array that contains a list of the style properties 	 *  modified by your subclass.</p>	 *	 *  @return An Array of Strings specifying the names of the 	 *  style properties modified by this effect.	 *	 *  @see mx.effects.Effect#getAffectedProperties()
		 */
		public function get relevantStyles () : Array;

		/**
		 *  Constructor.	 *	 *  @param target The Object to animate with this effect.
		 */
		public function SetStyleAction (target:Object = null);
		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
	}
}
