package mx.effects
{
	import flash.display.DisplayObjectContainer;
	import mx.core.mx_internal;
	import mx.effects.effectClasses.AddChildActionInstance;
	import mx.effects.effectClasses.PropertyChanges;

	/**
	 *  The AddChildAction class defines an action effect that corresponds *  to the <code>AddChild</code> property of a view state definition. *  You use an AddChildAction effect within a transition definition *  to control when the view state change defined by an AddChild property *  occurs during the transition. *   *  @mxml * *  <p>The <code>&lt;mx:AddChildAction&gt;</code> tag *  inherits all of the tag attributes of its superclass, *  and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:AddChildAction *    <b>Properties</b> *    id="ID" *    index="-1" *    relativeTo="" *    position="index" *  /&gt; *  </pre> *   *  @see mx.effects.effectClasses.AddChildActionInstance *  @see mx.states.AddChild * *  @includeExample ../states/examples/TransitionExample.mxml
	 */
	public class AddChildAction extends Effect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;
		/**
		 *  @private
		 */
		private var localPropertyChanges : Array;
		/**
		 *  The index of the child within the parent.	 *  A value of -1 means add the child as the last child of the parent.	 *	 *  @default -1
		 */
		public var index : int;
		/**
		 *  The location where the child component is added.	 *  By default, Flex determines this value from the <code>AddChild</code>	 *  property definition in the view state definition.
		 */
		public var relativeTo : DisplayObjectContainer;
		/**
		 *  The position of the child in the display list, relative to the	 *  object specified by the <code>relativeTo</code> property.	 *  Valid values are <code>"before"</code>, <code>"after"</code>, 	 *  <code>"firstChild"</code>, <code>"lastChild"</code>, and <code>"index"</code>,	 *  where <code>"index"</code> specifies to use the <code>index</code> property 	 *  to determine the position of the child.	 *	 *  @default "index"
		 */
		public var position : String;

		/**
		 *  Constructor.	 *	 *  @param target The Object to animate with this effect.
		 */
		public function AddChildAction (target:Object = null);
		/**
		 *  @private
		 */
		public function getAffectedProperties () : Array;
		/**
		 *  @private
		 */
		private function getPropertyChanges (target:Object) : PropertyChanges;
		/**
		 *  @private
		 */
		private function targetSortHandler (first:Object, second:Object) : Number;
		/**
		 *  @private
		 */
		public function createInstances (targets:Array = null) : Array;
		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
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
