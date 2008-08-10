/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers.utilityClasses {
	import flash.events.EventDispatcher;
	import mx.core.IMXMLObject;
	public class ConstraintColumn extends EventDispatcher implements IMXMLObject {
		/**
		 * Number that specifies the explicit width of the ConstraintColumn instance,
		 *  in pixels, in the ConstraintColumn instance's coordinates.
		 */
		public function get explicitWidth():Number;
		public function set explicitWidth(value:Number):void;
		/**
		 * ID of the ConstraintColumn instance. This value becomes the instance name of the
		 *  ConstraintColumn instance and should not contain white space or special characters.
		 */
		public function get id():String;
		public function set id(value:String):void;
		/**
		 * Number that specifies the maximum width of the ConstraintColumn
		 *  instance, in pixels, in the ConstraintColumn instance's coordinates.
		 */
		public function get maxWidth():Number;
		public function set maxWidth(value:Number):void;
		/**
		 * Number that specifies the minimum width of the ConstraintColumn instance,
		 *  in pixels, in the ConstraintColumn instance's coordinates.
		 */
		public function get minWidth():Number;
		public function set minWidth(value:Number):void;
		/**
		 * Number that specifies the width of a component as a percentage of its
		 *  parent container's size. Allowed values are 0-100. The default value is NaN.
		 *  Setting the width property resets this property to NaN.
		 */
		public function get percentWidth():Number;
		public function set percentWidth(value:Number):void;
		/**
		 * Number that specifies the width of the ConstraintColumn instance, in pixels,
		 *  in the parent container's coordinates.
		 */
		public function get width():Number;
		public function set width(value:Number):void;
		/**
		 * Constructor.
		 */
		public function ConstraintColumn();
		/**
		 * Called automatically by the MXML compiler when the ConstraintColumn
		 *  instance is created using an MXML tag.
		 *  If you create the ConstraintColumn instance through ActionScript, you
		 *  must call this method passing in the MXML document and
		 *  null for the id.
		 *
		 * @param document          <Object> The MXML document containing this ConstraintColumn.
		 * @param id                <String> Ignored.
		 */
		public function initialized(document:Object, id:String):void;
		/**
		 * Sizes the constraint column.
		 *
		 * @param w                 <Number> Width of constaint column computed during parent container
		 *                            processing.
		 */
		public function setActualWidth(w:Number):void;
	}
}
