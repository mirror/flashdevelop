package flash.net
{
	import flash.net.IDynamicPropertyWriter;

	/// The ObjectEncoding class is used in defining serialization settings in classes that serialize objects (such as FileStream, NetStream, NetConnection, SharedObject, and ByteArray) to work with prior versions of ActionScript.
	public class ObjectEncoding extends Object
	{
		/// Specifies that objects are serialized using the Action Message Format for ActionScript 1.0 and 2.0.
		public static const AMF0 : uint;
		/// Specifies that objects are serialized using the Action Message Format for ActionScript 3.0.
		public static const AMF3 : uint;
		/// Specifies the default (latest) format for the current runtime (either Flash® Player or Adobe® AIR™).
		public static const DEFAULT : uint;

		/// Allows greater control over the serialization of dynamic properties of dynamic objects.
		public static function get dynamicPropertyWriter () : IDynamicPropertyWriter;
		public static function set dynamicPropertyWriter (object:IDynamicPropertyWriter) : void;

		public function ObjectEncoding ();
	}
}
