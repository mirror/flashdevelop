/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.collections {
	import flash.utils.IExternalizable;
	public class ArrayCollection extends ListCollectionView implements IExternalizable {
		/**
		 * The source of data in the ArrayCollection.
		 *  The ArrayCollection object does not represent any changes that you make
		 *  directly to the source array. Always use
		 *  the ICollectionView or IList methods to modify the collection.
		 */
		public function get source():Array;
		public function set source(value:Array):void;
		/**
		 * Constructor.
		 *
		 * @param source            <Array (default = null)> 
		 */
		public function ArrayCollection(source:Array = null);
	}
}
