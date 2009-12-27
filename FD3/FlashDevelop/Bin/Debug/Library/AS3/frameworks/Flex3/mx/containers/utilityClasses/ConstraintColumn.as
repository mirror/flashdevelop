package mx.containers.utilityClasses
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import mx.core.IInvalidating;
	import mx.core.mx_internal;
	import mx.core.IMXMLObject;
	import flash.events.EventDispatcher;

	[Exclude(name="container", kind="property")] 

include "../../core/Version.as"
	/**
	 *  The ConstraintColumn class partitions an absolutely
 *  positioned container in the vertical plane. 
 * 
 *  ConstraintColumn instances have 3 sizing options: fixed, percentage, and 
 *  content. These options dictate the position of the 
 *  constraint column, the amount of space the constraint column 
 *  takes in the container, and how the constraint column deals with 
 *  changes in the size of the container.
	 */
	public class ConstraintColumn extends EventDispatcher implements IMXMLObject
	{
		var contentSize : Boolean;
		/**
		 *  @private
		 */
		private var _container : IInvalidating;
		/**
		 *  @private
		 */
		private var _id : String;
		/**
		 *  @private
     *  Storage for the maxWidth property.
		 */
		private var _explicitMaxWidth : Number;
		/**
		 *  @private
     *  Storage for the minWidth property.
		 */
		private var _explicitMinWidth : Number;
		/**
		 *  @private
     *  Storage for the width property.
		 */
		var _width : Number;
		/**
		 *  @private
     *  Storage for the explicitWidth property.
		 */
		private var _explicitWidth : Number;
		/**
		 *  @private
     *  Storage for the percentWidth property.
		 */
		private var _percentWidth : Number;
		private var _x : Number;

		/**
		 *  The container which this ConstraintColumn instance is 
     *  partitioning.
		 */
		public function get container () : IInvalidating;
		/**
		 *  @private
		 */
		public function set container (value:IInvalidating) : void;

		/**
		 *  ID of the ConstraintColumn instance. This value becomes the instance name of the
     *  ConstraintColumn instance and should not contain white space or special characters.
		 */
		public function get id () : String;
		/**
		 *  @private
		 */
		public function set id (value:String) : void;

		/**
		 *  Number that specifies the maximum width of the ConstraintColumn 
     *  instance, in pixels, in the ConstraintColumn instance's coordinates.
     *
		 */
		public function get maxWidth () : Number;
		/**
		 *  @private
		 */
		public function set maxWidth (value:Number) : void;

		/**
		 *  Number that specifies the minimum width of the ConstraintColumn instance,
     *  in pixels, in the ConstraintColumn instance's coordinates.
     *
		 */
		public function get minWidth () : Number;
		/**
		 *  @private
		 */
		public function set minWidth (value:Number) : void;

		/**
		 *  Number that specifies the width of the ConstraintColumn instance, in pixels,
     *  in the parent container's coordinates.
     *
		 */
		public function get width () : Number;
		/**
		 *  @private
		 */
		public function set width (value:Number) : void;

		/**
		 *  Number that specifies the explicit width of the ConstraintColumn instance, 
     *  in pixels, in the ConstraintColumn instance's coordinates.
		 */
		public function get explicitWidth () : Number;
		/**
		 *  @private
		 */
		public function set explicitWidth (value:Number) : void;

		/**
		 *  Number that specifies the width of a component as a percentage of its 
     *  parent container's size. Allowed values are 0-100. The default value is NaN.
     *  Setting the <code>width</code> property resets this property to NaN.
		 */
		public function get percentWidth () : Number;
		/**
		 *  @private
		 */
		public function set percentWidth (value:Number) : void;

		/**
		 *  @private
		 */
		public function get x () : Number;
		/**
		 *  @private
		 */
		public function set x (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function ConstraintColumn ();

		/**
		 *  Called automatically by the MXML compiler when the ConstraintColumn
      *  instance is created using an MXML tag.  
      *  If you create the ConstraintColumn instance through ActionScript, you 
      *  must call this method passing in the MXML document and 
      *  <code>null</code> for the <code>id</code>.
      *
      *  @param document The MXML document containing this ConstraintColumn.
      *
      *  @param id Ignored.
		 */
		public function initialized (document:Object, id:String) : void;

		/**
		 *  Sizes the constraint column.
	 *
	 *  @param width Width of constaint column computed during parent container
	 *  processing.
		 */
		public function setActualWidth (w:Number) : void;
	}
}
