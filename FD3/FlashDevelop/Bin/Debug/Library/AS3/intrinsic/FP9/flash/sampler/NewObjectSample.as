package flash.sampler 
{
	public final class NewObjectSample extends Sample 
	{
		/**
		 * The NewObjectSample object if it still exists. If the object has been garbage collected, this property is
		 *  undefined and a corresponding DeleteObjectSample exists.
		 */
		public function get object():*;
		
		/// The unique identification number that matches up with a DeleteObjectSample's identification number.
		public const id:Number;
		
		/// The Class object corresponding to the object created within a getSamples() stream.
		public const type:Class;
	}
	
}
