/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers {
	import mx.core.Container;
	import mx.managers.IHistoryManagerClient;
	public class ViewStack extends Container implements IHistoryManagerClient {
		/**
		 * The height of the area, in pixels, in which content is displayed.
		 *  You can override this getter if your content
		 *  does not occupy the entire area of the ViewStack container.
		 */
		protected function get contentHeight():Number;
		/**
		 * The width of the area, in pixels, in which content is displayed.
		 *  You can override this getter if your content
		 *  does not occupy the entire area of the ViewStack container.
		 */
		protected function get contentWidth():Number;
		/**
		 * The x coordinate of the area of the ViewStack container
		 *  in which content is displayed, in pixels.
		 *  The default value is equal to the value of the
		 *  paddingLeft style property,
		 *  which has a default value of 0.
		 *  Override the get() method if you do not want
		 *  your content to start layout at x = 0.
		 */
		protected function get contentX():Number;
		/**
		 * The y coordinate of the area of the ViewStack container
		 *  in which content is displayed, in pixels.
		 *  The default value is equal to the value of the
		 *  paddingTop style property,
		 *  which has a default value of 0.
		 *  Override the get() method if you do not want
		 *  your content to start layout at y = 0.
		 */
		protected function get contentY():Number;
		/**
		 * If true, enables history management
		 *  within this ViewStack container.
		 *  As the user navigates from one child to another,
		 *  the browser remembers which children were visited.
		 *  The user can then click the browser's Back and Forward buttons
		 *  to move through this navigation history.
		 */
		public function get historyManagementEnabled():Boolean;
		public function set historyManagementEnabled(value:Boolean):void;
		/**
		 * If true, the ViewStack container automatically
		 *  resizes to the size of its current child.
		 */
		public function get resizeToContent():Boolean;
		public function set resizeToContent(value:Boolean):void;
		/**
		 * A reference to the currently visible child container.
		 *  The default is a reference to the first child.
		 *  If there are no children, this property is null.
		 */
		public function get selectedChild():Container;
		public function set selectedChild(value:Container):void;
		/**
		 * The zero-based index of the currently visible child container.
		 *  Child indexes are in the range 0, 1, 2, ..., n - 1,
		 *  where n is the number of children.
		 *  The default value is 0, corresponding to the first child.
		 *  If there are no children, the value of this property is -1.
		 */
		public function get selectedIndex():int;
		public function set selectedIndex(value:int):void;
		/**
		 * Constructor.
		 */
		public function ViewStack();
		/**
		 * Commits the selected index. This function is called during the commit
		 *  properties phase when the selectedIndex (or selectedItem) property
		 *  has changed.
		 *
		 * @param newIndex          <int> 
		 */
		protected function commitSelectedIndex(newIndex:int):void;
		/**
		 * Loads the state of this object.
		 *
		 * @param state             <Object> State of this object to load.
		 *                            This will be null when loading the initial state of the application.
		 */
		public function loadState(state:Object):void;
		/**
		 * Calculates the default sizes and minimum and maximum values of the
		 *  ViewStack container.
		 *  For more information about the measure() method,
		 *  see the UIComponent.measure() method.
		 */
		protected override function measure():void;
		/**
		 * Saves the state of this object.
		 *  The object contains name:value pairs for each property
		 *  to be saved with the state.
		 *
		 * @return                  <Object> The state of this object.
		 */
		public function saveState():Object;
		/**
		 * Responds to size changes by setting the positions and sizes
		 *  of this container's children.
		 *  For more information about the updateDisplayList() method,
		 *  see the UIComponent.updateDisplayList() method.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void;
	}
}
