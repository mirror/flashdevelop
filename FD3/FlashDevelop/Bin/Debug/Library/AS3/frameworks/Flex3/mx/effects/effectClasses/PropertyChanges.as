/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.effectClasses {
	public class PropertyChanges {
		/**
		 * An Object containing the ending properties of the target
		 *  component modified by the change in view state.
		 */
		public var end:Object;
		/**
		 * An Object containing the starting properties of the target
		 *  component modified by the change in view state.
		 */
		public var start:Object;
		/**
		 * A target component of a transition.
		 *  The start and end fields
		 *  of the PropertyChanges object define how the target component
		 *  is modified by the change to the view state.
		 */
		public var target:Object;
		/**
		 * The PropertyChanges constructor.
		 *
		 * @param target            <Object> Object that is a target of an effect.
		 */
		public function PropertyChanges(target:Object);
	}
}
