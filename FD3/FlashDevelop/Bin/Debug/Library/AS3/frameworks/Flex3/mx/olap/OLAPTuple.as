/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public class OLAPTuple implements IOLAPTuple {
		/**
		 * The user added members of this tuple, as a list of IOLAPMember instances.
		 */
		public function get explicitMembers():IList;
		/**
		 * Constructor
		 */
		public function OLAPTuple();
		/**
		 * Adds a new member to the tuple.
		 *
		 * @param member            <IOLAPElement> The member to add.
		 *                            If member is a dimension or hierarchy, its default member
		 *                            is added. If member is an instance of IOLAPMember,
		 *                            it is added directly.
		 */
		public function addMember(member:IOLAPElement):void;
		/**
		 * Adds a list of members to the tuple.
		 *  This method can be called when many members need to be added to the tuple.
		 *
		 * @param value             <IList> The members to add, as a list of IOLAPMember instances.
		 */
		public function addMembers(value:IList):void;
	}
}
