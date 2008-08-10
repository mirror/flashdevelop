/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	public class AutomationID {
		/**
		 * The number of parts in this id.
		 */
		public function get length():int;
		/**
		 * Constructor.
		 */
		public function AutomationID();
		/**
		 * Adds a parts to the front of the id.
		 *
		 * @param p                 <AutomationIDPart> Map of properties.
		 */
		public function addFirst(p:AutomationIDPart):void;
		/**
		 * Adds a parts to the end of the id.
		 *
		 * @param p                 <AutomationIDPart> Map of properties.
		 */
		public function addLast(p:AutomationIDPart):void;
		/**
		 * Concatenates another id to this id. Returns a new id,
		 *  and does not mutate this instance.
		 *
		 * @param other             <AutomationID> id to concatenate.
		 * @return                  <AutomationID> This id concatenated with the other id.
		 */
		public function concat(other:AutomationID):AutomationID;
		/**
		 * Compares this object with the given AutomationID.
		 *
		 * @param other             <AutomationID> AutomationID object which needs to be compared.
		 * @return                  <Boolean> true if they are equal, false otherwise.
		 */
		public function equals(other:AutomationID):Boolean;
		/**
		 * Indicates if there are more parts of the id.
		 *
		 * @return                  <Boolean> true if there are no more parts of the id,
		 *                            false otherwise.
		 */
		public function isEmpty():Boolean;
		/**
		 * Parses the string and returns an id.
		 *
		 * @param s                 <String> Serialized form of the id as provided by  the toString() method.
		 * @return                  <AutomationID> Parsed id.
		 */
		public static function parse(s:String):AutomationID;
		/**
		 * Returns the first object in the id
		 *
		 * @return                  <AutomationIDPart> First object in the id.
		 */
		public function peekFirst():AutomationIDPart;
		/**
		 * Returns the last object in the id
		 *
		 * @return                  <AutomationIDPart> Last object in the id.
		 */
		public function peekLast():AutomationIDPart;
		/**
		 * Removes the first object from this id.
		 *
		 * @return                  <AutomationIDPart> First object in this id.
		 */
		public function removeFirst():AutomationIDPart;
		/**
		 * Removes the last object from this id.
		 *
		 * @return                  <AutomationIDPart> Last object in this id.
		 */
		public function removeLast():AutomationIDPart;
		/**
		 * Serializes the id to a string.
		 *
		 * @return                  <String> The serialized id.
		 */
		public function toString():String;
	}
}
