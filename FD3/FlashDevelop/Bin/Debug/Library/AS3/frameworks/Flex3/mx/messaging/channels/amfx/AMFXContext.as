package mx.messaging.channels.amfx
{
	import mx.logging.ILogger;

	/**
	 * Holds a list of complex object references, object trait info references, * or string references generated while encoding or decoding and AMFX packet. * Note that a new set of reference tables should be used per AMFX packet. * Calling reset() will create new tables for each of these types of references. * @private
	 */
	public class AMFXContext
	{
		/**
		 * Trait Info reference table
		 */
		local var traits : Array;
		/**
		 * Object reference table
		 */
		local var objects : Array;
		/**
		 * Strings reference table
		 */
		local var strings : Array;
		/**
		 * Log for the current encoder/decoder context.
		 */
		public var log : ILogger;

		/**
		 * Constructor.     * Initializes object, trait info and string reference tables.
		 */
		public function AMFXContext ();
		/**
		 * Resets the trait info, object and string reference tables.
		 */
		public function reset () : void;
		/**
		 * Check whether the trait info reference table     * already contains this list of traits. If found,     * the index of the trait info is returned, starting     * from 0. If not found -1 is returned.
		 */
		public function findTraitInfo (traitInfo:Object) : int;
		/**
		 * Check whether the object reference table     * already contains this object. If found, the index     * of the object is returned, starting from 0. If     * not found -1 is returned.
		 */
		public function findObject (object:Object) : int;
		/**
		 * Check whether the string reference table     * already contains this string. If found, the index     * of the string is returned, starting from 0. If     * not found (or if the value passed is the empty string)     * -1 is returned.
		 */
		public function findString (str:String) : int;
		/**
		 * Remember the trait info for an object in this context     * for an encoding or decoding session.
		 */
		public function addTraitInfo (traitInfo:Object) : void;
		/**
		 * Remember an object in this context for an encoding     * or decoding session.
		 */
		public function addObject (obj:Object) : void;
		/**
		 * Remember a string in this context for an encoding     * or decoding session. Note that the empty string     * is not remembered as it should not be serialized     * by reference.
		 */
		public function addString (str:String) : void;
		/**
		 * Retrieve trait info for an object by its reference     * table index.
		 */
		public function getTraitInfo (ref:uint) : *;
		/**
		 * Retrieve an object by its reference table index.
		 */
		public function getObject (ref:uint) : *;
		/**
		 * Retrieve a string by its reference table index.
		 */
		public function getString (ref:uint) : String;
	}
}
