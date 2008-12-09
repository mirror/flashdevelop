package flash.net
{
	/// This interface controls the serialization of dynamic properties of dynamic objects.
	public class IDynamicPropertyOutput
	{
		/// Adds a dynamic property to the binary output of a serialized object.
		public function writeDynamicProperty(name:String, value:*):void;

	}

}

