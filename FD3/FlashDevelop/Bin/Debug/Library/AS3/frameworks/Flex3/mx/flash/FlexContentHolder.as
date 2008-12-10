package mx.flash
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;

	/**
	 *  The FlexContentHolder class is for internal use only.
	 */
	public dynamic class FlexContentHolder extends ContainerMovieClip
	{
		private var flexContent : IUIComponent;
		private var pendingFlexContent : IUIComponent;

		/**
		 *  @inheritDoc
		 */
		public function get content () : IUIComponent;
		public function set content (value:IUIComponent) : void;

		/**
		 *  Constructor.
		 */
		public function FlexContentHolder ();
		/**
		 *  Initialize the object.     *     *  @see mx.core.UIComponent#initialize()
		 */
		public function initialize () : void;
		/**
		 *  Sets the actual size of this object.     *     *  <p>This method is mainly for use in implementing the     *  <code>updateDisplayList()</code> method, which is where     *  this object's actual size is computed based on     *  its explicit size, parent-relative (percent) size,     *  and measured size.     *  Apply this actual size to the object     *  by calling the <code>setActualSize()</code> method.</p>     *     *  <p>In other situations, you should be setting properties     *  such as <code>width</code>, <code>height</code>,     *  <code>percentWidth</code>, or <code>percentHeight</code>     *  rather than calling this method.</p>     *      *  @param newWidth The new width for this object.     *      *  @param newHeight The new height for this object.
		 */
		public function setActualSize (newWidth:Number, newHeight:Number) : void;
		/**
		 *  Notify parent that the size of this object has changed.
		 */
		protected function notifySizeChanged () : void;
		/**
		 *  Utility function that prepares Flex content to be used as a child of     *  this component.      *  Set the <code>content</code> property rather than calling     *  this method directly.
		 */
		protected function setFlexContent (value:IUIComponent) : void;
		/**
		 *  @private
		 */
		protected function sizeFlexContent () : void;
	}
}
