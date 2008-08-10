/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public class AddChildAction extends Effect {
		/**
		 * The index of the child within the parent.
		 *  A value of -1 means add the child as the last child of the parent.
		 */
		public var index:int = -1;
		/**
		 * The position of the child in the display list, relative to the
		 *  object specified by the relativeTo property.
		 *  Valid values are "before", "after",
		 *  "firstChild", "lastChild", and "index",
		 *  where "index" specifies to use the index property
		 *  to determine the position of the child.
		 */
		public var position:String = "index";
		/**
		 * The location where the child component is added.
		 *  By default, Flex determines this value from the AddChild
		 *  property definition in the view state definition.
		 */
		public var relativeTo:DisplayObjectContainer;
		/**
		 * Constructor.
		 *
		 * @param target            <Object (default = null)> The Object to animate with this effect.
		 */
		public function AddChildAction(target:Object = null);
	}
}
