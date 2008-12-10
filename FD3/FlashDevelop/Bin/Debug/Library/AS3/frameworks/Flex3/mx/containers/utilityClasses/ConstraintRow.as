package mx.containers.utilityClasses
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import mx.core.IInvalidating;
	import mx.core.mx_internal;
	import mx.core.IMXMLObject;
	import flash.events.EventDispatcher;

	/**
	 *  ConstraintRow class partitions an absolutely *  positioned container in the horizontal plane.  *  *  ConstraintRow instances have 3 sizing options: fixed, percentage,   *  and content. These options dictate the position of the constraint row,  *  the amount of space the constraint row takes in the container, and  *  how the constraint row deals with a change in the size of the container.
	 */
	public class ConstraintRow extends EventDispatcher implements IMXMLObject
	{
		local var contentSize : Boolean;
		/**
		 *  @private
		 */
		private var _container : IInvalidating;
		/**
		 *  @private     *  Storage for the height property.
		 */
		local var _height : Number;
		/**
		 *  @private     *  Storage for the explicitHeight property.
		 */
		private var _explicitHeight : Number;
		/**
		 *  @private
		 */
		private var _id : String;
		/**
		 *  @private     *  Storage for the maxHeight property.
		 */
		private var _explicitMaxHeight : Number;
		/**
		 *  @private     *  Storage for the minHeight property.
		 */
		private var _explicitMinHeight : Number;
		/**
		 *  @private     *  Storage for the percentHeight property.
		 */
		private var _percentHeight : Number;
		private var _y : Number;

		/**
		 *  The container being partitioned by this ConstraintRow instance.
		 */
		public function get container () : IInvalidating;
		/**
		 *  @private
		 */
		public function set container (value:IInvalidating) : void;
		/**
		 *  Number that specifies the height of the ConstraintRow instance, in pixels,     *  in the parent's coordinates.     *
		 */
		public function get height () : Number;
		/**
		 *  @private
		 */
		public function set height (value:Number) : void;
		/**
		 *  Number that specifies the explicit height of the      *  ConstraintRow instance, in pixels, in the ConstraintRow      *  instance's coordinates.     *
		 */
		public function get explicitHeight () : Number;
		/**
		 *  @private
		 */
		public function set explicitHeight (value:Number) : void;
		/**
		 *  ID of the ConstraintRow instance. This value becomes the instance name      *  of the constraint row and should not contain white space or special      *  characters.
		 */
		public function get id () : String;
		/**
		 *  @private
		 */
		public function set id (value:String) : void;
		/**
		 *  Number that specifies the maximum height of the ConstraintRow instance,     *  in pixels, in the ConstraintRow instance's coordinates.     *
		 */
		public function get maxHeight () : Number;
		/**
		 *  @private
		 */
		public function set maxHeight (value:Number) : void;
		/**
		 *  Number that specifies the minimum height of the ConstraintRow instance,     *  in pixels, in the ConstraintRow instance's coordinates.     *
		 */
		public function get minHeight () : Number;
		/**
		 *  @private
		 */
		public function set minHeight (value:Number) : void;
		/**
		 *  Number that specifies the height of a component as a percentage     *  of its parent's size. Allowed values are 0-100. The default value is NaN.     *  Setting the <code>width</code> property resets this property to NaN.
		 */
		public function get percentHeight () : Number;
		/**
		 *  @private
		 */
		public function set percentHeight (value:Number) : void;
		/**
		 *  @private
		 */
		public function get y () : Number;
		/**
		 *  @private
		 */
		public function set y (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function ConstraintRow ();
		/**
		 *  Called automatically by the MXML compiler when the ConstraintRow      *  instance is created using an MXML tag.        *  If you create the constraint row through ActionScript, you       *  must call this method passing in the MXML document and       *  <code>null</code> for the <code>id</code>.      *      *  @param document The MXML document containing this ConstraintRow.      *      *  @param id Ignored.
		 */
		public function initialized (document:Object, id:String) : void;
		/**
		 *  Sizes the ConstraintRow     *     *  @param height Height of constaint row computed during parent container     *  processing.
		 */
		public function setActualHeight (h:Number) : void;
	}
}
