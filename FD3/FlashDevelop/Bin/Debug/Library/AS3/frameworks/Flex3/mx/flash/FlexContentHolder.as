/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.flash {
	import mx.core.IUIComponent;
	public dynamic  class FlexContentHolder extends ContainerMovieClip {
		/**
		 * The Flex content to display inside this container.
		 */
		public function get content():IUIComponent;
		public function set content(value:IUIComponent):void;
		/**
		 * Constructor.
		 */
		public function FlexContentHolder();
		/**
		 * Initialize the object.
		 */
		public override function initialize():void;
		/**
		 * Notify parent that the size of this object has changed.
		 */
		protected override function notifySizeChanged():void;
		/**
		 * Sets the actual size of this object.
		 *
		 * @param newWidth          <Number> The new width for this object.
		 * @param newHeight         <Number> The new height for this object.
		 */
		public override function setActualSize(newWidth:Number, newHeight:Number):void;
		/**
		 * Utility function that prepares Flex content to be used as a child of
		 *  this component.
		 *  Set the content property rather than calling
		 *  this method directly.
		 *
		 * @param value             <IUIComponent> 
		 */
		protected function setFlexContent(value:IUIComponent):void;
	}
}
