package mx.controls.scrollClasses
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import mx.controls.Button;
	import mx.core.mx_internal;
	import mx.events.ScrollEventDetail;
	import mx.managers.ISystemManager;

	/**
	 *  The ScrollThumb class defines the thumb of a ScrollBar control.  * *  @see mx.controls.scrollClasses.ScrollBar *  @see mx.controls.HScrollBar *  @see mx.controls.VScrollBar
	 */
	public class ScrollThumb extends Button
	{
		/**
		 *  @private
		 */
		private var ymin : Number;
		/**
		 *  @private
		 */
		private var ymax : Number;
		/**
		 *  @private
		 */
		private var datamin : Number;
		/**
		 *  @private
		 */
		private var datamax : Number;
		/**
		 *  @private	 *  Last position of the thumb.
		 */
		private var lastY : Number;

		/**
		 *  Constructor.
		 */
		public function ScrollThumb ();
		/**
		 *  @private
		 */
		function buttonReleased () : void;
		/**
		 *  @private	 *  Set the range of motion for the thumb:	 *  how far it can move and what data values that covers.
		 */
		function setRange (ymin:Number, ymax:Number, datamin:Number, datamax:Number) : void;
		/**
		 *  @private	 *  Stop dragging the thumb around.
		 */
		private function stopDragThumb () : void;
		/**
		 *  @private	 *  User pressed on the thumb, so start tracking in case they drag it.
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private	 *  Drag the thumb around and update the scroll bar accordingly.
		 */
		private function mouseMoveHandler (event:MouseEvent) : void;
	}
}
