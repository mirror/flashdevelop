/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.states {
	public class Transition {
		/**
		 * The IEffect object to play when you apply the transition. Typically,
		 *  this is a composite effect object, such as the Parallel or Sequence effect,
		 *  that contains multiple effects.
		 */
		public var effect:IEffect;
		/**
		 * A String specifying the view state that your are changing from when
		 *  you apply the transition. The default value is "*", meaning any view state.
		 */
		public var fromState:String = "*";
		/**
		 * A String specifying the view state that you are changing to when
		 *  you apply the transition. The default value is "*", meaning any view state.
		 */
		public var toState:String = "*";
		/**
		 * Constructor.
		 */
		public function Transition();
	}
}
