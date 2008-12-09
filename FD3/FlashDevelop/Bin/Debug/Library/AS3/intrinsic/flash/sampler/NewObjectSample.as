package flash.sampler
{
	/// The NewObjectSample class represents objects that are created within a getSamples() stream.
	public class NewObjectSample extends flash.sampler.Sample
	{
		/// The unique identification number that matches up with a DeleteObjectSample's identification number.
		public static const id:Number;

		/// The Class object corresponding to the object created within a getSamples() stream.
		public static const type:Class;

		/// The NewObjectSample object if it still exists.
		public var object:*;

	}

}

