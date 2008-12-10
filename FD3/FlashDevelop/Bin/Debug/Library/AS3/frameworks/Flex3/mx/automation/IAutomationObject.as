package mx.automation
{
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	/**
	 * The IAutomationObject interface defines the interface  * for a delegate object that implements automation * for a component.
	 */
	public interface IAutomationObject
	{
		/**
		 *  The delegate object that is handling the automation-related functionality.     *  Automation sets this when it creates the delegate object.
		 */
		public function get automationDelegate () : Object;
		/**
		 *  @private
		 */
		public function set automationDelegate (delegate:Object) : void;
		/**
		 *  Name that can be used as an identifier for this object.
		 */
		public function get automationName () : String;
		/**
		 *  @private
		 */
		public function set automationName (name:String) : void;
		/**
		 *  This value generally corresponds to the rendered appearance of the      *  object and should be usable for correlating the identifier with     *  the object as it appears visually within the application.
		 */
		public function get automationValue () : Array;
		/**
		 *  The number of automation children this container has.     *  This sum should not include any composite children, though     *  it does include those children not significant within the     *  automation hierarchy.
		 */
		public function get numAutomationChildren () : int;
		/**
		 *  A flag that determines if an automation object     *  shows in the automation hierarchy.     *  Children of containers that are not visible in the hierarchy     *  appear as children of the next highest visible parent.     *  Typically containers used for layout, such as boxes and Canvas,     *  do not appear in the hierarchy.     *     *  <p>Some controls force their children to appear     *  in the hierarchy when appropriate.     *  For example a List will always force item renderers,     *  including boxes, to appear in the hierarchy.     *  Implementers must support setting this property     *  to <code>true</code>.</p>
		 */
		public function get showInAutomationHierarchy () : Boolean;
		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;
		/**
		 * An implementation of the <code>IAutomationTabularData</code> interface, which      * can be used to retrieve the data.     *      * @return An implementation of the <code>IAutomationTabularData</code> interface.
		 */
		public function get automationTabularData () : Object;

		/**
		 *  Returns a set of properties that identify the child within      *  this container.  These values should not change during the     *  lifespan of the application.     *       *  @param child Child for which to provide the id.     *      *  @return Sets of properties describing the child which can     *          later be used to resolve the component.
		 */
		public function createAutomationIDPart (child:IAutomationObject) : Object;
		/**
		 *  Resolves a child by using the id provided. The id is a set      *  of properties as provided by the <code>createAutomationIDPart()</code> method.     *     *  @param criteria Set of properties describing the child.     *         The criteria can contain regular expression values     *         resulting in multiple children being matched.     *  @return Array of children that matched the criteria     *          or <code>null</code> if no children could not be resolved.
		 */
		public function resolveAutomationIDPart (criteria:Object) : Array;
		/**
		 *  Provides the automation object at the specified index.  This list     *  should not include any children that are composites.     *     *  @param index The index of the child to return     *      *  @return The child at the specified index.
		 */
		public function getAutomationChildAt (index:int) : IAutomationObject;
		/**
		 *  Replays the specified event.  A component author should probably call      *  super.replayAutomatableEvent in case default replay behavior has been defined      *  in a superclass.     *     *  @param event The event to replay.     *     *  @return <code>true</code> if a replay was successful.
		 */
		public function replayAutomatableEvent (event:Event) : Boolean;
	}
}
