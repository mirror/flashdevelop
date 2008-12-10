﻿package mx.rpc.xml
{
	/**
	 * This internal utility class is used by SimpleXMLDecoder. The class is * basically a dynamic version of the String class (other properties can be * attached to it). * * When you try to get the value of a ComplexString, we attempt to convert the * value to a number or boolean before returning it. * * @private
	 */
	internal dynamic class ComplexString
	{
		public var value : String;

		public function ComplexString (val:String);
		public function toString () : String;
		public function valueOf () : Object;
	}
}
