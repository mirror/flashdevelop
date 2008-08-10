/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import mx.collections.IList;
	public interface IOLAPSet {
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
		 * Returns a new IOLAPSet instance that contains a crossjoin of this
		 *  IOLAPSet instance and input.
		 *
		 * @param input             <IOLAPSet> An IOLAPSet instance.
		 * @return                  <IOLAPSet> An IOLAPSet instance that contains a crossjoin of this
		 *                            IOLAPSet instance and input.
		 */
		public function crossJoin(input:IOLAPSet):IOLAPSet;
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
