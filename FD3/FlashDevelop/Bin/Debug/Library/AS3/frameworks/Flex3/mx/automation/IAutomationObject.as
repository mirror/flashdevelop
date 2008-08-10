/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	import flash.events.Event;
	public interface IAutomationObject {
		/**
		 * The delegate object that is handling the automation-related functionality.
		 *  Automation sets this when it creates the delegate object.
		 */
		public function get automationDelegate():Object;
		public function set automationDelegate(value:Object):void;
		/**
		 * Name that can be used as an identifier for this object.
		 */
		public function get automationName():String;
		public function set automationName(value:String):void;
		/**
		 * An implementation of the IAutomationTabularData interface, which
		 *  can be used to retrieve the data.
		 */
		public function get automationTabularData():Object;
		/**
		 * This value generally corresponds to the rendered appearance of the
		 *  object and should be usable for correlating the identifier with
		 *  the object as it appears visually within the application.
		 */
		public function get automationValue():Array;
		/**
		 * The number of automation children this container has.
		 *  This sum should not include any composite children, though
		 *  it does include those children not significant within the
		 *  automation hierarchy.
		 */
		public function get numAutomationChildren():int;
		/**
		 * A flag that determines if an automation object
		 *  shows in the automation hierarchy.
		 *  Children of containers that are not visible in the hierarchy
		 *  appear as children of the next highest visible parent.
		 *  Typically containers used for layout, such as boxes and Canvas,
		 *  do not appear in the hierarchy.
		 */
		public function get showInAutomationHierarchy():Boolean;
		public function set showInAutomationHierarchy(value:Boolean):void;
		/**
		 * Returns a set of properties that identify the child within
		 *  this container.  These values should not change during the
		 *  lifespan of the application.
		 *
		 * @param child             <IAutomationObject> Child for which to provide the id.
		 * @return                  <Object> Sets of properties describing the child which can
		 *                            later be used to resolve the component.
		 */
		public function createAutomationIDPart(child:IAutomationObject):Object;
		/**
		 * Provides the automation object at the specified index.  This list
		 *  should not include any children that are composites.
		 *
		 * @param index             <int> The index of the child to return
		 * @return                  <IAutomationObject> The child at the specified index.
		 */
		public function getAutomationChildAt(index:int):IAutomationObject;
		/**
		 * Replays the specified event.  A component author should probably call
		 *  super.replayAutomatableEvent in case default replay behavior has been defined
		 *  in a superclass.
		 *
		 * @param event             <Event> The event to replay.
		 * @return                  <Boolean> true if a replay was successful.
		 */
		public function replayAutomatableEvent(event:Event):Boolean;
		/**
		 * Resolves a child by using the id provided. The id is a set
		 *  of properties as provided by the createAutomationIDPart() method.
		 *
		 * @param criteria          <Object> Set of properties describing the child.
		 *                            The criteria can contain regular expression values
		 *                            resulting in multiple children being matched.
		 * @return                  <Array> Array of children that matched the criteria
		 *                            or null if no children could not be resolved.
		 */
		public function resolveAutomationIDPart(criteria:Object):Array;
	}
}
