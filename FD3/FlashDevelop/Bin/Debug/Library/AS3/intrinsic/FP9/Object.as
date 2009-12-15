package
{
	/// The Object class is at the root of the ActionScript runtime class hierarchy.
	public class Object extends *
	{
		public static const length : int;

		/// Indicates whether an object has a specified property defined.
		public function hasOwnProperty (V:* = null) : Boolean;

		public static function init () : *;

		/// Indicates whether an instance of the Object class is in the prototype chain of the object specified as the parameter.
		public function isPrototypeOf (V:* = null) : Boolean;

		/// Creates an Object object and stores a reference to the object's constructor method in the object's constructor property.
		public function Object ();

		/// Indicates whether the specified property exists and is enumerable.
		public function propertyIsEnumerable (V:* = null) : Boolean;

		/// Returns the string representation of the specified object.
		public function toString () : String;

		/// Returns the primitive value of the specified object.
		public function valueOf () : Object;

		/// Sets the availability of a dynamic property for loop operations.
		public function setPropertyIsEnumerable (name:String, isEnum:Boolean = true) : void;
	}
}
