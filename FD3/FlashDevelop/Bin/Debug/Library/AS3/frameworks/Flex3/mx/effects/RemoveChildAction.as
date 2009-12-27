package mx.effects
{
	import mx.core.mx_internal;
	import mx.effects.effectClasses.PropertyChanges;
	import mx.effects.effectClasses.RemoveChildActionInstance;

	[Exclude(name="duration", kind="property")] 

include "../core/Version.as"
	/**
	 *  The RemoveChildAction class defines an action effect that corresponds
 *  to the RemoveChild property of a view state definition.
 *  You use a RemoveChildAction effect within a transition definition
 *  to control when the view state change defined by a RemoveChild property
 *  occurs during the transition.
 *  
 *  @mxml
 *
 *  <p>The <code>&lt;mx:RemoveChildAction&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and adds the following tag attributes:</p>

 *  <pre>
 *  &lt;mx:RemoveChildAction
 *    <b>Properties</b>
 *    id="ID"
 *  /&gt;
 *  </pre>
 *  
 *  @see mx.effects.effectClasses.RemoveChildActionInstance
 *  @see mx.states.RemoveChild
 *
 *  @includeExample ../states/examples/TransitionExample.mxml
	 */
	public class RemoveChildAction extends Effect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function RemoveChildAction (target:Object = null);

		/**
		 *  @private
		 */
		public function getAffectedProperties () : Array;

		/**
		 *  @private
		 */
		private function propChangesSortHandler (first:PropertyChanges, second:PropertyChanges) : Number;

		/**
		 *  @private
		 */
		function applyStartValues (propChanges:Array, targets:Array) : void;

		/**
		 *  @private
		 */
		protected function getValueFromTarget (target:Object, property:String) : *;

		/**
		 *  @private
		 */
		protected function applyValueToTarget (target:Object, property:String, value:*, props:Object) : void;
	}
}
