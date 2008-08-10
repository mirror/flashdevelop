/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers.utilityClasses {
	import flash.events.EventDispatcher;
	import mx.core.IMXMLObject;
	public class ConstraintRow extends EventDispatcher implements IMXMLObject {
		/**
		 * Number that specifies the explicit height of the
		 *  ConstraintRow instance, in pixels, in the ConstraintRow
		 *  instance's coordinates.
		 */
		public function get explicitHeight():Number;
		public function set explicitHeight(value:Number):void;
		/**
		 * Number that specifies the height of the ConstraintRow instance, in pixels,
		 *  in the parent's coordinates.
		 */
		public function get height():Number;
		public function set height(value:Number):void;
		/**
		 * ID of the ConstraintRow instance. This value becomes the instance name
		 *  of the constraint row and should not contain white space or special
		 *  characters.
		 */
		public function get id():String;
		public function set id(value:String):void;
		/**
		 * Number that specifies the maximum height of the ConstraintRow instance,
		 *  in pixels, in the ConstraintRow instance's coordinates.
		 */
		public function get maxHeight():Number;
		public function set maxHeight(value:Number):void;
		/**
		 * Number that specifies the minimum height of the ConstraintRow instance,
		 *  in pixels, in the ConstraintRow instance's coordinates.
		 */
		public function get minHeight():Number;
		public function set minHeight(value:Number):void;
		/**
		 * Number that specifies the height of a component as a percentage
		 *  of its parent's size. Allowed values are 0-100. The default value is NaN.
		 *  Setting the width property resets this property to NaN.
		 */
		public function get percentHeight():Number;
		public function set percentHeight(value:Number):void;
		/**
		 * Constructor.
		 */
		public function ConstraintRow();
		/**
		 * Called automatically by the MXML compiler when the ConstraintRow
		 *  instance is created using an MXML tag.
		 *  If you create the constraint row through ActionScript, you
		 *  must call this method passing in the MXML document and
		 *  null for the id.
		 *
		 * @param document          <Object> The MXML document containing this ConstraintRow.
		 * @param id                <String> Ignored.
		 */
		public function initialized(document:Object, id:String):void;
		/**
		 * Sizes the ConstraintRow
		 *
		 * @param h                 <Number> Height of constaint row computed during parent container
		 *                            processing.
		 */
		public function setActualHeight(h:Number):void;
	}
}
