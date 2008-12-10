package mx.states
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import mx.core.mx_internal;
	import mx.core.UIComponent;

	/**
	 * *  The RemoveChild class removes a child display object, such as a component,  *  from a container as part of a view state. *  The child is only removed from the display list, it is not deleted. *  You use this class in the <code>overrides</code> property of the State class. * *  @mxml * *  <p>The <code>&lt;mx:RemoveChild&gt;</code> tag *  has the following attributes:</p> *   *  <pre> *  &lt;mx:RemoveChild *  <b>Properties</b> *  target="null" *  /&gt; *  </pre> * *  @see mx.states.State *  @see mx.states.AddChild *  @see mx.states.Transition *  @see mx.effects.RemoveChildAction * *  @includeExample examples/StatesExample.mxml
	 */
	public class RemoveChild implements IOverride
	{
		/**
		 *  @private     *  Parent of the removed child.
		 */
		private var oldParent : DisplayObjectContainer;
		/**
		 *  @private     *  Index of the removed child.
		 */
		private var oldIndex : int;
		/**
		 *  @private
		 */
		private var removed : Boolean;
		/**
		 *  The child to remove from the view.
		 */
		public var target : DisplayObject;

		/**
		 *  Constructor.	 *	 *  @param target The child to remove from the view.
		 */
		public function RemoveChild (target:DisplayObject = null);
		/**
		 *  IOverride interface method; this class implements it as an empty method.	 * 	 *  @copy IOverride#initialize()
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
	}
}
