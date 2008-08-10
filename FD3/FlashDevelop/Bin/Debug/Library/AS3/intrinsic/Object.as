/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public dynamic  class Object {
		/**
		 * A reference to the class object or constructor function for a given object instance.
		 *  If an object is an instance of a class, the constructor
		 *  property holds a reference to the class object.
		 *  If an object is created with a constructor function, the constructor
		 *  property holds a reference to the constructor function.
		 *  Do not confuse a constructor function with a constructor method of a class.
		 *  A constructor function is a Function object used to create objects, and is an
		 *  alternative to using the class keyword for defining classes.
		 */
		public var constructor:Object;
		/**
		 * A reference to the prototype object of a class or function object. The prototype property
		 *  is automatically created and attached to any class or function object that you create. This property is
		 *  static in that it is specific to the class or function that you create. For example, if you create a
		 *  class, the value of the prototype property is shared by all instances of the class and is
		 *  accessible only as a class property. Instances of your class cannot directly access
		 *  the prototype property.
		 */
		public static var prototype:Object;
		/**
		 * Creates an Object object and stores a reference to the object's constructor method in the object's constructor property.
		 */
		public function Object();
		/**
		 * Indicates whether an object has a specified property defined. This method returns true if the target object has
		 *  a property that matches the string specified by the name parameter, and false otherwise.
		 *  The following types of properties cause this method to return true for objects that are instances of a class (as opposed to class objects):
		 *  Fixed instance properties-variables, constants, or methods defined by the object's class that are not static;
		 *  Inherited fixed instance properties-variables, constants, or methods inherited by the object's class;
		 *  Dynamic properties-properties added to an object after it is instantiated (outside of its class definition). To add dynamic properties, the object's defining class must be declared with the dynamic keyword.
		 *
		 * @param name              <String> The property of the object.
		 * @return                  <Boolean> If the target object has the property specified by the name
		 *                            parameter this value is true, otherwise false.
		 */
		AS3 function hasOwnProperty(name:String):Boolean;
		/**
		 * Indicates whether an instance of the Object class is in the prototype chain of the object specified
		 *  as the parameter. This method returns true if the object is in the prototype chain of the
		 *  object specified by the theClass parameter. The method returns false
		 *  if the target object is absent from the prototype chain of the theClass object,
		 *  and also if the theClass parameter is not an object.
		 *
		 * @param theClass          <Object> The class to which the specified object may refer.
		 * @return                  <Boolean> If the object is in the prototype chain of the object
		 *                            specified by the theClass parameter this value is true, otherwise false.
		 */
		AS3 function isPrototypeOf(theClass:Object):Boolean;
		/**
		 * Indicates whether the specified property exists and is enumerable. If true, then the property exists and
		 *  can be enumerated in a for..in loop. The property must exist on the target object because this method does not
		 *  check the target object's prototype chain.
		 *
		 * @param name              <String> The property of the object.
		 * @return                  <Boolean> If the property specified by the name parameter is enumerable this value is true, otherwise false.
		 */
		AS3 function propertyIsEnumerable(name:String):Boolean;
		/**
		 * Sets the availability of a dynamic property for loop operations. The property must exist on the target object because this method does not check the target object's prototype chain.
		 *
		 * @param name              <String> The property of the object.
		 * @param isEnum            <Boolean (default = true)> If set to false, the dynamic property does not show up in for..in loops, and the method propertyIsEnumerable() returns false.
		 */
		public function setPropertyIsEnumerable(name:String, isEnum:Boolean = true):void;
		/**
		 * Returns the string representation of the specified object.
		 *
		 * @return                  <String> A string representation of the object.
		 */
		public function toString():String;
		/**
		 * Returns the primitive value of the specified object. If this object
		 *  does not have a primitive value, the object itself is returned.
		 *
		 * @return                  <Object> The primitive value of this object or the object itself.
		 */
		public function valueOf():Object;
	}
}
