/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	public interface IAutomationObjectHelper {
		/**
		 * Indicates whether recording is taking place, true,
		 *  or not, false.
		 */
		public function get recording():Boolean;
		/**
		 * Indicates whether replay is taking place, true,
		 *  or not, false.
		 */
		public function get replaying():Boolean;
		/**
		 * Adds a synchronization object to the automation manager.
		 *  The automation manager waits until the isComplete method
		 *  returns true
		 *  before proceeding with the next replay event.
		 *
		 * @param isComplete        <Function> Function that indicates whether the synchronized
		 *                            operation is completed.
		 * @param target            <Object (default = null)> If null, all replay is stalled until
		 *                            the isComplete method returns true,
		 *                            otherwise the automation manager will only wait
		 *                            if the next operation is on the target.
		 */
		public function addSynchronization(isComplete:Function, target:Object = null):void;
		/**
		 * Returns the parent which is compositing the given object.
		 *
		 * @param obj               <IAutomationObject> Object whose compositing parent is to be determined.
		 * @return                  <IAutomationObject> The parent IAutomationObject.
		 */
		public function getAutomationComposite(obj:IAutomationObject):IAutomationObject;
		/**
		 * Creates an id for a given child within a parent.
		 *
		 * @param parent            <IAutomationObject> Parent of object for which to create and id.
		 * @param child             <IAutomationObject> Object for which to create an id.
		 * @param automationNameCallback<Function (default = null)> A user-supplied function used
		 *                            to determine the child's automationName.
		 * @param automationIndexCallback<Function (default = null)> A user-supplied function used
		 *                            to determine the child's automationIndex.
		 * @return                  <AutomationIDPart> An AutomationIDPart object representing the child within the parent.
		 */
		public function helpCreateIDPart(parent:IAutomationObject, child:IAutomationObject, automationNameCallback:Function = null, automationIndexCallback:Function = null):AutomationIDPart;
		/**
		 * Returns an Array of children within a parent which match the id.
		 *
		 * @param parent            <IAutomationObject> Parent object under which the id needs to be resolved.
		 * @param part              <Object> AutomationIDPart object representing the child.
		 * @return                  <Array> Array of children which match the id of part.
		 */
		public function helpResolveIDPart(parent:IAutomationObject, part:Object):Array;
		/**
		 * Determines whether a object is a composite or not.
		 *  If a object is not reachable through the automation APIs
		 *  from the top application then it is considered to be a composite.
		 *
		 * @param obj               <IAutomationObject> Object whose compositeness is to be determined.
		 * @return                  <Boolean> true if the object is a composite.
		 */
		public function isAutomationComposite(obj:IAutomationObject):Boolean;
		/**
		 * Dispatches a MouseEvent.MOUSE_DOWN, MouseEvent.MOUSE_UP,
		 *  and MouseEvent.CLICK from the specified IInteractionReplayer with the
		 *  specified modifiers.
		 *
		 * @param to                <IEventDispatcher> Event dispatcher.
		 * @param sourceEvent       <MouseEvent (default = null)> Mouse event.
		 * @return                  <Boolean> true if the events were dispatched.
		 */
		public function replayClick(to:IEventDispatcher, sourceEvent:MouseEvent = null):Boolean;
		/**
		 * Replays a click event somewhere off the edge of the stage.
		 *  use this method to simulate the mouseDownOutside event.
		 *
		 * @return                  <Boolean> true if the event was dispatched.
		 */
		public function replayClickOffStage():Boolean;
		/**
		 * Dispatches a KeyboardEvent.KEY_DOWN and
		 *  KeyboardEvent.KEY_UP event
		 *  for the specified KeyboardEvent object.
		 *
		 * @param to                <IEventDispatcher> Event dispatcher.
		 * @param event             <KeyboardEvent> Keyboard event.
		 * @return                  <Boolean> true if the events were dispatched.
		 */
		public function replayKeyboardEvent(to:IEventDispatcher, event:KeyboardEvent):Boolean;
		/**
		 * Dispatches a KeyboardEvent.KEY_DOWN and
		 *  KeyboardEvent.KEY_UP event
		 *  from the specified IInteractionReplayer, for the specified key, with the
		 *  specified modifiers.
		 *
		 * @param to                <IEventDispatcher> Key code for key pressed.
		 * @param keyCode           <uint> Boolean indicating whether Ctrl key pressed.
		 * @param ctrlKey           <Boolean (default = false)> Boolean indicating whether Shift key pressed.
		 * @param shiftKey          <Boolean (default = false)> Boolean indicating whether Alt key pressed.
		 * @param altKey            <Boolean (default = false)> 
		 * @return                  <Boolean> true if the events were dispatched.
		 */
		public function replayKeyDownKeyUp(to:IEventDispatcher, keyCode:uint, ctrlKey:Boolean = false, shiftKey:Boolean = false, altKey:Boolean = false):Boolean;
		/**
		 * Dispatches a MouseEvent while simulating mouse capture.
		 *
		 * @param target            <IEventDispatcher> Event dispatcher.
		 * @param event             <MouseEvent> Mouse event.
		 * @return                  <Boolean> true if the event was dispatched.
		 */
		public function replayMouseEvent(target:IEventDispatcher, event:MouseEvent):Boolean;
	}
}
