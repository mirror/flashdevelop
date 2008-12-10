package mx.binding
{
	import mx.events.PropertyChangeEvent;

	/**
	 *  @private *  Bindability information for children (properties or methods) *  of a given class, based on the describeType() structure for that class.
	 */
	public class BindabilityInfo
	{
		/**
		 *  Name of [Bindable] metadata.
		 */
		public static const BINDABLE : String = "Bindable";
		/**
		 *  Name of [Managed] metadata.
		 */
		public static const MANAGED : String = "Managed";
		/**
		 *  Name of [ChangeEvent] metadata.
		 */
		public static const CHANGE_EVENT : String = "ChangeEvent";
		/**
		 *  Name of [NonCommittingChangeEvent] metadata.
		 */
		public static const NON_COMMITTING_CHANGE_EVENT : String = "NonCommittingChangeEvent";
		/**
		 *  Name of describeType() <accessor> element.
		 */
		public static const ACCESSOR : String = "accessor";
		/**
		 *  Name of describeType() <method> element.
		 */
		public static const METHOD : String = "method";
		/**
		 *  @private
		 */
		private var typeDescription : XML;
		/**
		 *  @private	 *  event name -> true
		 */
		private var classChangeEvents : Object;
		/**
		 *  @private	 *  child name -> { event name -> true }
		 */
		private var childChangeEvents : Object;

		/**
		 *  Constructor.
		 */
		public function BindabilityInfo (typeDescription:XML);
		/**
		 *  Object containing { eventName: true } for each change event	 *  (class- or child-level) that applies to the specified child.
		 */
		public function getChangeEvents (childName:String) : Object;
		/**
		 *  @private	 *  Build or return cached class change events object.
		 */
		private function getClassChangeEvents () : Object;
		/**
		 *  @private
		 */
		private function addBindabilityEvents (metadata:XMLList, eventListObj:Object) : void;
		/**
		 *  @private	 *  Transfer change events from a list of change-event-carrying metadata	 *  to an event list object.	 *  Note: metadata's first arg value is assumed to be change event name.
		 */
		private function addChangeEvents (metadata:XMLList, eventListObj:Object, isCommit:Boolean) : void;
		/**
		 *  @private	 *  Copy properties from one object to another.
		 */
		private function copyProps (from:Object, to:Object) : Object;
	}
}
