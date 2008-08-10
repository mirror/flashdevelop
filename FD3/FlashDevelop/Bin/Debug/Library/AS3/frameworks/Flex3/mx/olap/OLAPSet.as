/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public class OLAPSet implements IOLAPSet {
		/**
		 * The tuples contained by this set instance,
		 *  as an Array of IOLAPTuple instances.
		 */
		public function get tuples():Array;
		/**
		 * Constructor
		 */
		public function OLAPSet();
		/**
		 * Adds a new member to the set.
		 *
		 * @param element           <IOLAPElement> The member to add.
		 *                            If element is a hierarchy or level, its members
		 *                            are added. If element is an instance of IOLAPMember,
		 *                            it is added directly.
		 *                            A new tuple is created for each member.
		 */
		public function addElement(element:IOLAPElement):void;
		/**
		 * Adds a list of members to the set.
		 *  This method can be called when members or children of a hierarchy
		 *  or member need to be added to the set.
		 *
		 * @param elements          <IList> The members to add, as a list of IOLAPMember instances.
		 *                            A new tuple is created for each member.
		 */
		public function addElements(elements:IList):void;
		/**
		 * Adds a new tuple to the set.
		 *
		 * @param tuple             <IOLAPTuple> The tuple to add.
		 */
		public function addTuple(tuple:IOLAPTuple):void;
		/**
		 * Returns information about the relative location of
		 *  two members in the set.
		 *
		 * @param m1                <IOLAPMember> The first member.
		 * @param m2                <IOLAPMember> The second member.
		 * @return                  <int> The following:
		 *                            0 if the members are at the same level
		 *                            1 if m2 is higher in the hierarchy than m1
		 *                            -1 if m1 is higher in the hierarchy than m2
		 */
		protected function compareMembers(m1:IOLAPMember, m2:IOLAPMember):int;
		/**
		 * Returns a new IOLAPSet instance that contains a crossjoin of this
		 *  IOLAPSet instance and input.
		 *
		 * @param input             <IOLAPSet> An IOLAPSet instance.
		 * @return                  <IOLAPSet> An IOLAPSet instance that contains a crossjoin of this
		 *                            IOLAPSet instance and input.
		 */
		public function crossJoin(input:IOLAPSet):IOLAPSet;
		/**
		 * Returns the common IOLAPHierarchy instance for two tuples,
		 *  or null if the tuples do not share a hierarchy.
		 *
		 * @param t1                <OLAPTuple> The first tuple.
		 * @param t2                <OLAPTuple> The second tuple.
		 * @return                  <IOLAPHierarchy> The common IOLAPHierarchy instance for the two tuples,
		 *                            or null if the tuples do not share a hierarchy.
		 */
		protected function findCommonHierarchy(t1:OLAPTuple, t2:OLAPTuple):IOLAPHierarchy;
		/**
		 * Returns a new IOLAPSet that is hierarchized version
		 *  of this set.
		 *
		 * @param post              <Boolean (default = false)> If true indicates that children should precede parents.
		 *                            By default, parents precede children.
		 * @return                  <IOLAPSet> A new IOLAPSet that is hierarchized version
		 *                            of this set.
		 */
		public function hierarchize(post:Boolean = false):IOLAPSet;
		/**
		 * Returns information about the relative location of
		 *  two tuples in the set.
		 *
		 * @param t1                <OLAPTuple> The first tuple.
		 * @param t2                <OLAPTuple> The second tuple.
		 * @return                  <int> The following:
		 *                            0 if the tuples are at the same level
		 *                            1 if t2 is higher than t1
		 *                            -1 if t1 is higher than t2
		 */
		protected function sortTuple(t1:OLAPTuple, t2:OLAPTuple):int;
		/**
		 * Returns a new IOLAPSet instance that contains a union of this
		 *  IOLAPSet instance and input.
		 *
		 * @param input             <IOLAPSet> An IOLAPSet instance.
		 * @return                  <IOLAPSet> An IOLAPSet instance that contains a union of this
		 *                            IOLAPSet instance and input.
		 */
		public function union(input:IOLAPSet):IOLAPSet;
	}
}
