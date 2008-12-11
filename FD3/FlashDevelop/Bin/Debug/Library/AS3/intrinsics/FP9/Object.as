package 
{
	/// The Object class is at the root of the ActionScript class hierarchy.
	public class Object
	{
		/// A reference to the prototype object of a class or function object.
		public var prototype:Object;

		/// A reference to the class object or constructor function for a given object instance.
		public var constructor:Function;

		/// Creates an Object object and stores a reference to the object's constructor method in the object's constructor property.
		public function Object();

		/// Indicates whether an object has a specified property defined.
		public function hasOwnProperty(name:String):Boolean;

		/// Indicates whether the specified property exists and is enumerable.
		public function propertyIsEnumerable(name:String):Boolean;

		/// Indicates whether an instance of the Object class is in the prototype chain of the object specified as the parameter.
		public function isPrototypeOf(theClass:Object):Boolean;

		/// Sets the availability of a dynamic property for loop operations.
		public function setPropertyIsEnumerable(name:String, isEnum:Boolean=true):void;

		/// Returns the string representation of the specified object.
		public function toString():String;

		/// Returns the primitive value of the specified object.
		public function valueOf():Object;

	}

}

