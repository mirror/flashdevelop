package mx.collections.errors
{
include "../../core/Version.as"
	/**
	 *  The <code>CollectionViewError</code> class represents general errors
 *  within a collection that are not related to specific activities
 *  such as Cursor seeking.
 *  Errors of this class are thrown by the ListCollectionView class.
	 */
	public class CollectionViewError extends Error
	{
		/**
		 *  Constructor.
	 *
	 *  @param message A message providing information about the error cause.
		 */
		public function CollectionViewError (message:String);
	}
}
