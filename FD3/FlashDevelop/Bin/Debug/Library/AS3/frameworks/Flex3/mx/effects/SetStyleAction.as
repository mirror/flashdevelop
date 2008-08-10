/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public class SetStyleAction extends Effect {
		/**
		 * The name of the style property being changed.
		 *  By default, Flex determines this value from the SetStyle
		 *  property definition in the view state definition.
		 */
		public var name:String;
		/**
		 * Contains the style properties modified by this effect.
		 *  This getter method overrides the superclass method.
		 */
		public function get relevantStyles():Array;
		public function set relevantStyles(value:Array):void;
		/**
		 * The new value for the style property.
		 *  By default, Flex determines this value from the SetStyle
		 *  property definition in the view state definition.
		 */
		public var value:*;
		/**
		 * Constructor.
		 *
		 * @param target            <Object (default = null)> The Object to animate with this effect.
		 */
		public function SetStyleAction(target:Object = null);
	}
}
