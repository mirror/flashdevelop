/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import mx.automation.events.AutomationReplayEvent;
	public interface IAutomationManager extends <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * The automation environment for this automation manager.
		 *  The automation environment provides information about the
		 *  objects and properties of testable components needed for communicating
		 *  with agent tools.
		 *  The value of this property must implement the IAutomationEnvironment interface.
		 */
		public function get automationEnvironment():Object;
		public function set automationEnvironment(value:Object):void;
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
		 * Sets the automation manager to record mode.
		 */
		public function beginRecording():void;
		/**
		 * Returns an id for the given object that can be used
		 *  with the resolveID() method.
		 *
		 * @param obj               <IAutomationObject> Automation object.
		 * @param relativeToParent  <IAutomationObject (default = null)> Parent of the automation object.
		 * @return                  <AutomationID> AutomationID object which represents the Automation object.
		 */
		public function createID(obj:IAutomationObject, relativeToParent:IAutomationObject = null):AutomationID;
		/**
		 * Returns an id part for the given object that can be used in resolveIDPart.
		 *
		 * @param obj               <IAutomationObject> The automation object.
		 * @param parent            <IAutomationObject (default = null)> Parent of the automation object.
		 * @return                  <AutomationIDPart> AutomationIDPart object which represents the Automation object.
		 */
		public function createIDPart(obj:IAutomationObject, parent:IAutomationObject = null):AutomationIDPart;
		/**
		 * Decrement the cache counter. The cache is cleared when
		 *  the count reaches zero.
		 *
		 * @param clearNow          <Boolean (default = false)> If true, clear the cache regardless of the cache counter.
		 * @return                  <int> Current cache counter.
		 */
		public function decrementCacheCounter(clearNow:Boolean = false):int;
		/**
		 * Takes the automation manager out of record mode.
		 */
		public function endRecording():void;
		/**
		 * Returns the text to display as the type of the object.
		 *
		 * @param obj               <IAutomationObject> Automation object.
		 * @return                  <String> Type of the object.
		 */
		public function getAutomationClassName(obj:IAutomationObject):String;
		/**
		 * Returns the text to display as the description for the object.
		 *
		 * @param obj               <IAutomationObject> Automation object.
		 * @return                  <String> Text description of the Automation object.
		 */
		public function getAutomationName(obj:IAutomationObject):String;
		/**
		 * Returns all children of this object that are visible within the testing
		 *  hierarchy. If a child is not visible within the hierarchy,
		 *  returns the children of the invisible child.
		 *
		 * @param obj               <IAutomationObject> Object for which to get the children.
		 * @param ignoreShowInHierarchy<Boolean (default = false)> 
		 * @return                  <Array> Array of children.
		 */
		public function getChildren(obj:IAutomationObject, ignoreShowInHierarchy:Boolean = false):Array;
		/**
		 * Returns all children of this object that are visible within the testing
		 *  hierarchy and meet the criteria in the automation part.
		 *  If a child is not visible within the hierarchy, this method
		 *  returns the children of the invisible child.
		 *
		 * @param obj               <IAutomationObject> Object for which to get the children.
		 * @param part              <AutomationIDPart (default = null)> Criteria of which children to return.
		 * @param ignoreShowInHierarchy<Boolean (default = false)> Boolean that determines whether object is ignored
		 *                            within the automation hierarchy. The default value is false.
		 * @return                  <Array> Array of children matching the criteria.
		 */
		public function getChildrenFromIDPart(obj:IAutomationObject, part:AutomationIDPart = null, ignoreShowInHierarchy:Boolean = false):Array;
		/**
		 * Returns the automation object under the given coordinate.
		 *
		 * @param x                 <int> The x coordinate.
		 * @param y                 <int> The y coordinate.
		 * @return                  <IAutomationObject> Automation object at that point.
		 */
		public function getElementFromPoint(x:int, y:int):IAutomationObject;
		/**
		 * Returns the next parent that is visible within the automation hierarchy.
		 *
		 * @param obj               <IAutomationObject> Automation object.
		 * @param parentToStopAt    <IAutomationObject (default = null)> Parent of the given automation object.
		 * @param ignoreShowInHierarchy<Boolean (default = false)> Boolean that determines whether object is ignored
		 *                            within the automation hierarchy. The default value is false.
		 * @return                  <IAutomationObject> Nearest parent of the object visible within the automation
		 *                            hierarchy.
		 */
		public function getParent(obj:IAutomationObject, parentToStopAt:IAutomationObject = null, ignoreShowInHierarchy:Boolean = false):IAutomationObject;
		/**
		 * Returns the values for a set of properties.
		 *
		 * @param obj               <IAutomationObject> Object for which to get the properties.
		 * @param names             <Array (default = null)> Names of the properties to evaluation on the object.
		 * @param forVerification   <Boolean (default = true)> If true, only include verification properties.
		 * @param forDescription    <Boolean (default = true)> If true, only include description properties.
		 * @return                  <Array> Array of objects that contain each property value and descriptor.
		 */
		public function getProperties(obj:IAutomationObject, names:Array = null, forVerification:Boolean = true, forDescription:Boolean = true):Array;
		/**
		 * The display rectangle enclosing the DisplayObject.
		 *
		 * @param obj               <DisplayObject> DisplayObject whose rectangle is desired.
		 * @return                  <Array> An array of four integers: top, left, width and height.
		 */
		public function getRectangle(obj:DisplayObject):Array;
		/**
		 * Returns the object implementing the IAutomationTabularData interface through which
		 *  the tabular data can be obtained.
		 *
		 * @param obj               <IAutomationObject> An IAutomationObject.
		 * @return                  <IAutomationTabularData> An object implementing the IAutomationTabularData interface.
		 */
		public function getTabularData(obj:IAutomationObject):IAutomationTabularData;
		/**
		 * Increments the cache counter. The automation mechanism
		 *  cache's both an object's properties and children. The cache
		 *  exists for both performance reasons, and so that an objects state
		 *  prior to a recording can be captured. Each call to the
		 *  incrementCacheCounter() method
		 *  increments a counter and each call to the
		 *  decrementCacheCounter() method
		 *  decrements the cache counter. When the counter reaches zero the
		 *  cache is cleared.
		 *
		 * @return                  <int> the current cache counter.
		 */
		public function incrementCacheCounter():int;
		/**
		 * Tests if the provided target needs to wait until a previous
		 *  operation completes.
		 *
		 * @param target            <IAutomationObject> Target to check for synchronization or
		 *                            null to synchronize on any running operations.
		 * @return                  <Boolean> true if synchronization is complete, false otherwise.
		 */
		public function isSynchronized(target:IAutomationObject):Boolean;
		/**
		 * Returns true if an object and all of its parents are visible.
		 *
		 * @param obj               <DisplayObject> DisplayObject.
		 * @return                  <Boolean> true if an object and all of its parents are visible.
		 */
		public function isVisible(obj:DisplayObject):Boolean;
		/**
		 * Records the event.
		 *
		 * @param recorder          <IAutomationObject> The automation object on which the event is to be recorded.
		 * @param event             <Event> The actual event which needs to be recorded.
		 * @param cacheable         <Boolean (default = false)> Used to control the caching of the event that should be recorded.
		 *                            During a mouse-down, mouse-up sequence, the automation mechanism tries to record the most
		 *                            important or suitable event rather than all the events.
		 *                            For example suppose you have a List control which has a button in its item renderer.
		 *                            When the user clicks on the button, the automation mechanism only records
		 *                            the click event for the button, but ignores the select event
		 *                            generated from the List control.
		 */
		public function recordAutomatableEvent(recorder:IAutomationObject, event:Event, cacheable:Boolean = false):void;
		/**
		 * Replays the specified event. A component author should call
		 *  the super.replayAutomatableEvent() method
		 *  in case default replay behavior has been defined in a superclass.
		 *
		 * @param event             <AutomationReplayEvent> Event to replay.
		 * @return                  <Boolean> true if the replay was successful.
		 */
		public function replayAutomatableEvent(event:AutomationReplayEvent):Boolean;
		/**
		 * Resolves an id to automation objects.
		 *
		 * @param rid               <AutomationID> Automation id of the automation object.
		 * @param currentParent     <IAutomationObject (default = null)> Current parent of the automation object.
		 * @return                  <Array> An Array containing all the objects matching the rid.
		 */
		public function resolveID(rid:AutomationID, currentParent:IAutomationObject = null):Array;
		/**
		 * Resolves an id part to an Array of automation objects.
		 *
		 * @param parent            <IAutomationObject> Parent of the automation object.
		 * @param part              <AutomationIDPart> id part of the automation object.
		 * @return                  <Array> Array of automation objects which match part.
		 */
		public function resolveIDPart(parent:IAutomationObject, part:AutomationIDPart):Array;
		/**
		 * Resolves an id part to an automation object within the parent.
		 *
		 * @param parent            <IAutomationObject> Parent of the automation object.
		 * @param part              <AutomationIDPart> id part of the automation object.
		 * @return                  <IAutomationObject> IAutomationObject which matches with the part.
		 *                            If no object
		 *                            is found or multiple objects are found, throw an exception.
		 */
		public function resolveIDPartToSingleObject(parent:IAutomationObject, part:AutomationIDPart):IAutomationObject;
		/**
		 * Resolves an id to an automation object.
		 *
		 * @param rid               <AutomationID> Automation id of the automation object.
		 * @param currentParent     <IAutomationObject (default = null)> Current parent of the automation object.
		 * @return                  <IAutomationObject> IAutomationObject which matches with the rid.
		 *                            If no object
		 *                            is found or multiple objects are found, throw an exception.
		 */
		public function resolveIDToSingleObject(rid:AutomationID, currentParent:IAutomationObject = null):IAutomationObject;
		/**
		 * Indicates whether an automation object should be visible within
		 *  the hierarchy.
		 *
		 * @param obj               <IAutomationObject> The automation object.
		 * @return                  <Boolean> true if the object should be shown within the
		 *                            automation hierarchy.
		 */
		public function showInHierarchy(obj:IAutomationObject):Boolean;
	}
}
