/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers {
	import mx.core.Container;
	import mx.managers.IHistoryManagerClient;
	import mx.managers.IFocusManagerComponent;
	import mx.core.IFactory;
	public class Accordion extends Container implements IHistoryManagerClient, IFocusManagerComponent {
		/**
		 * The height of the area, in pixels, in which content is displayed.
		 *  You can override this getter if your content
		 *  does not occupy the entire area of the container.
		 */
		protected function get contentHeight():Number;
		/**
		 * The width of the area, in pixels, in which content is displayed.
		 *  You can override this getter if your content
		 *  does not occupy the entire area of the container.
		 */
		protected function get contentWidth():Number;
		/**
		 * A factory used to create the navigation buttons for each child.
		 *  The default value is a factory which creates a
		 *  mx.containers.accordionClasses.AccordionHeader. The
		 *  created object must be a subclass of Button and implement the
		 *  mx.core.IDataRenderer interface. The data
		 *  property is set to the content associated with the header.
		 */
		public function get headerRenderer():IFactory;
		public function set headerRenderer(value:IFactory):void;
		/**
		 * If set to true, this property enables history management
		 *  within this Accordion container.
		 *  As the user navigates from one child to another,
		 *  the browser remembers which children were visited.
		 *  The user can then click the browser's Back and Forward buttons
		 *  to move through this navigation history.
		 */
		public function get historyManagementEnabled():Boolean;
		public function set historyManagementEnabled(value:Boolean):void;
		/**
		 * If set to true, this Accordion automatically resizes to
		 *  the size of its current child.
		 */
		public function get resizeToContent():Boolean;
		public function set resizeToContent(value:Boolean):void;
		/**
		 * A reference to the currently visible child container.
		 *  The default value is a reference to the first child.
		 *  If there are no children, this property is null.
		 */
		public function get selectedChild():Container;
		public function set selectedChild(value:Container):void;
		/**
		 * The zero-based index of the currently visible child container.
		 *  Child indexes are in the range 0, 1, 2, ..., n - 1, where n is the number
		 *  of children.
		 *  The default value is 0, corresponding to the first child.
		 *  If there are no children, this property is -1.
		 */
		public function get selectedIndex():int;
		public function set selectedIndex(value:int):void;
		/**
		 * Constructor.
		 */
		public function Accordion();
		/**
		 * Returns a reference to the navigator button for a child container.
		 *
		 * @param index             <int> Zero-based index of the child.
		 * @return                  <Button> Button object representing the navigator button.
		 */
		public function getHeaderAt(index:int):Button;
		/**
		 * Loads the state of this object.
		 *
		 * @param state             <Object> State of this object to load.
		 *                            This will be null when loading the initial state of the application.
		 */
		public function loadState(state:Object):void;
		/**
		 * Saves the state of this object.
		 *  The object contains name:value pairs for each property
		 *  to be saved with the state.
		 *
		 * @return                  <Object> The state of this object.
		 */
		public function saveState():Object;
	}
}
