/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers {
	import mx.managers.IFocusManagerComponent;
	public class TabNavigator extends ViewStack implements IFocusManagerComponent {
		/**
		 * A reference to the TabBar inside this TabNavigator.
		 */
		protected var tabBar:TabBar;
		/**
		 * The set of styles to pass from the TabNavigator to the tabBar.
		 */
		protected function get tabBarStyleFilters():Object;
		/**
		 * Constructor.
		 */
		public function TabNavigator();
		/**
		 * Returns the tab of the navigator's TabBar control at the specified
		 *  index.
		 *
		 * @param index             <int> Index in the navigator's TabBar control.
		 * @return                  <Button> The tab at the specified index.
		 */
		public function getTabAt(index:int):Button;
		/**
		 * Calculates the default sizes and mininum and maximum values of this
		 *  TabNavigator container.
		 *  See the UIComponent.measure() method for more information
		 *  about the measure() method.
		 */
		protected override function measure():void;
		/**
		 * Responds to size changes by setting the positions and sizes
		 *  of this container's tabs and children.
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
