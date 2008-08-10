/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.containers.Box;
	import flash.events.MouseEvent;
	public class NavBar extends Box {
		/**
		 * Data used to populate the navigator control.
		 *  The type of data can either be a ViewStack container or an Array.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * Name of the field in the dataProvider object
		 *  to display as the icon for each navigation item.
		 */
		public function get iconField():String;
		public function set iconField(value:String):void;
		/**
		 * Name of the field in the dataProvider object
		 *  to display as the label for each navigation item.
		 */
		public function get labelField():String;
		public function set labelField(value:String):void;
		/**
		 * A user-supplied function to run on each item to determine its label.
		 *  By default, the component looks for a property named label
		 *  on each data provider item and displays it.
		 *  However, some data sets do not have a label property
		 *  nor do they have another property that can be used for displaying.
		 *  An example is a data set that has lastName and firstName fields
		 *  but you want to display full names.
		 */
		public function get labelFunction():Function;
		public function set labelFunction(value:Function):void;
		/**
		 * Index of the active navigation item,
		 *  where the first item is at an index of 0.
		 */
		public function get selectedIndex():int;
		public function set selectedIndex(value:int):void;
		/**
		 * Name of the the field in the dataProvider object
		 *  to display as the tooltip label.
		 */
		public function get toolTipField():String;
		public function set toolTipField(value:String):void;
		/**
		 * Constructor.
		 */
		public function NavBar();
		/**
		 * Handles the MouseEvent.CLICK event
		 *  for the items in the NavBar control. This handler
		 *  dispatches the itemClick event for the NavBar control.
		 *
		 * @param event             <MouseEvent> The event object.
		 */
		protected function clickHandler(event:MouseEvent):void;
		/**
		 * Creates the individual navigator items.
		 *  By default, this method performs no action.
		 *  You can override this method in a
		 *  subclass to create a navigator item based on the type of
		 *  navigator items in your subclass.
		 *
		 * @param label             <String> The label for the created navigator item.
		 * @param icon              <Class (default = null)> The icon for the created navigator item.
		 *                            Typically, this is an icon that you have embedded in the application.
		 * @return                  <IFlexDisplayObject> The created navigator item.
		 */
		protected function createNavItem(label:String, icon:Class = null):IFlexDisplayObject;
		/**
		 * Highlights the selected navigator item.
		 *  By default, this method performs no action.
		 *  You can override this method in a subclass to
		 *  highlight the selected navigator item.
		 *
		 * @param index             <int> The index of the selected item in the NavBar control.
		 *                            The first item is at an index of 0.
		 */
		protected function hiliteSelectedNavItem(index:int):void;
		/**
		 * Returns the string the renderer would display for the given data object
		 *  based on the labelField and labelFunction properties.
		 *  If the method cannot convert the parameter to a string, it returns a
		 *  single space.
		 *
		 * @param data              <Object> Object to be rendered.
		 * @return                  <String> The string to be displayed based on the data.
		 */
		public function itemToLabel(data:Object):String;
		/**
		 * Resets the navigator bar to its default state.
		 *  By default, this method performs no action.
		 *  You can override this method in a subclass to
		 *  reset the navigator bar to a default state.
		 */
		protected function resetNavItems():void;
		/**
		 * Resets the icon of a navigator item in the
		 *  NavBar control.
		 *  You can override this method in a subclass to
		 *  set the icon of a navigator item based on the type of
		 *  navigator items in your subclass.
		 *
		 * @param index             <int> The index of the navigator item in the NavBar control.
		 *                            The first navigator item is at an index of 0.
		 * @param icon              <Class> The new icon for the navigator item.
		 *                            Typically, this is an icon that you have embedded in the application.
		 */
		protected function updateNavItemIcon(index:int, icon:Class):void;
		/**
		 * Sets the label property of a navigator item in the
		 *  NavBar control.
		 *  You can override this method in a subclass to
		 *  set the label of a navigator item based on the type of
		 *  navigator items in your subclass.
		 *
		 * @param index             <int> The index of the navigator item in the NavBar control.
		 *                            The first navigator item is at an index of 0.
		 * @param label             <String> The new label text for the navigator item.
		 */
		protected function updateNavItemLabel(index:int, label:String):void;
	}
}
