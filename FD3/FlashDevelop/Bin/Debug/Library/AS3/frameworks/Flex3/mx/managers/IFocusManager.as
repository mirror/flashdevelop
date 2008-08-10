/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	import mx.core.IButton;
	import flash.display.Sprite;
	import flash.display.InteractiveObject;
	public interface IFocusManager {
		/**
		 * A reference to the original default Button control.
		 *  Pressing the Enter key while the focus is on any control
		 *  activates the Button control by dispatching a click event
		 *  on the Button control, just as if it was clicked with the mouse.
		 *  The actual default Button control changes if focus is given to another
		 *  Button control, but switches back to the original if focus is not
		 *  on a button.
		 */
		public function get defaultButton():IButton;
		public function set defaultButton(value:IButton):void;
		/**
		 * A flag that indicates whether the FocusManager should
		 *  check for the Enter key being pressed to activate the default button.
		 *  TextArea and other components that want to recognize
		 *  the Enter key
		 *  set this property to false to disable the Enter
		 *  key from dispatching a click event on the
		 *  default button, if it exists.
		 */
		public function get defaultButtonEnabled():Boolean;
		public function set defaultButtonEnabled(value:Boolean):void;
		/**
		 * A single Sprite that is moved from container to container
		 *  as the focus moves to those containers.
		 *  The Sprite is used as the parent of the visual indicator
		 *  that a component has focus.
		 */
		public function get focusPane():Sprite;
		public function set focusPane(value:Sprite):void;
		/**
		 * The next unique tab index to use in this tab loop.
		 */
		public function get nextTabIndex():int;
		/**
		 * A flag that indicates whether to display an indicator that
		 *  a component has focus.
		 *  If true a component receiving focus
		 *  draws a visible indicator that it has focus.
		 */
		public function get showFocusIndicator():Boolean;
		public function set showFocusIndicator(value:Boolean):void;
		/**
		 * The SystemManager activates and deactivates a FocusManager
		 *  if more than one IFocusManagerContainer is visible at the same time.
		 *  If the mouse is clicked in an IFocusManagerContainer with a deactivated
		 *  FocusManager, the SystemManager will call
		 *  the activate() method on that FocusManager.
		 *  The FocusManager that was activated will have its deactivate() method
		 *  called prior to the activation of another FocusManager.
		 */
		public function activate():void;
		/**
		 * The SystemManager activates and deactivates a FocusManager
		 *  if more than one IFocusManagerContainer is visible at the same time.
		 *  If the mouse is clicked in an IFocusManagerContainer with a deactivated
		 *  FocusManager, the SystemManager will call
		 *  the activate() method on that FocusManager.
		 *  The FocusManager that was activated will have its deactivate() method
		 *  called prior to the activation of another FocusManager.
		 */
		public function deactivate():void;
		/**
		 * Returns the IFocusManagerComponent that contains the given object, if any.
		 *  Because the player can set focus to a subcomponent of a Flex component
		 *  this method determines which IFocusManagerComponent has focus from
		 *  the component perspective.
		 *
		 * @param o                 <InteractiveObject> An object that can have player-level focus.
		 * @return                  <IFocusManagerComponent> The IFOcusManagerComponent containing o or
		 *                            null
		 */
		public function findFocusManagerComponent(o:InteractiveObject):IFocusManagerComponent;
		/**
		 * Gets the IFocusManagerComponent component that currently has the focus.
		 *  Calling this method is recommended instead of using the Stage object
		 *  because it indicates which component has focus.
		 *  The Stage might return a subcomponent in that component.
		 *
		 * @return                  <IFocusManagerComponent> IFocusManagerComponent object that has focus.
		 */
		public function getFocus():IFocusManagerComponent;
		/**
		 * Returns the IFocusManagerComponent that would receive focus
		 *  if the user pressed the Tab key to navigate to another component.
		 *  It will return the same component as the current focused component
		 *  if there are no other valid components in the application.
		 *
		 * @param backward          <Boolean (default = false)> If true, return the object
		 *                            as if the Shift-Tab keys were pressed.
		 * @return                  <IFocusManagerComponent> The component that would receive focus.
		 */
		public function getNextFocusManagerComponent(backward:Boolean = false):IFocusManagerComponent;
		/**
		 * Sets showFocusIndicator to false
		 *  and removes the visual focus indicator from the focused object, if any.
		 */
		public function hideFocus():void;
		/**
		 * Sets focus to an IFocusManagerComponent component.  Does not check for
		 *  the components visibility, enabled state, or any other conditions.
		 *
		 * @param o                 <IFocusManagerComponent> A component that can receive focus.
		 */
		public function setFocus(o:IFocusManagerComponent):void;
		/**
		 * Sets showFocusIndicator to true
		 *  and draws the visual focus indicator on the focused object, if any.
		 */
		public function showFocus():void;
	}
}
