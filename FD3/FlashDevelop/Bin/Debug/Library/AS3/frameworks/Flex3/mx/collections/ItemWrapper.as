﻿package mx.collections
{
include "../core/Version.as"
	/**
	 *  @private
 * 
 *  The ItemWrapper class is a simple envelope for an item in a collection.
 *  Its purpose is to provide a way of distinguishing between duplicate items
 *  in a collection -- i.e., giving them unique IDs. It is used by data change
 *  effects for classes derived by ListBase. Distinguishing between duplicate
 *  elements is particularly important for data change effects because it is
 *  necessary to assign common item renderers to common items in a collection
	 */
	public class ItemWrapper
	{
		/**
		 *  The data item being wrapped.
		 */
		public var data : Object;

		/**
		 *  Constructs an instance of the wrapper with the specified data.
	 * 
	 *  @param data The data element to be wrapped.
		 */
		public function ItemWrapper (data:Object);
	}
}
