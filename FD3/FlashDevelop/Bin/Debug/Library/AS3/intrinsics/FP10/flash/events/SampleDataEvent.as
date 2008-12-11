package flash.events
{
	/// Dispatched when the player requests new audio data.
	public class SampleDataEvent extends flash.events.Event
	{
		/// The position of the data in the audio stream.
		public var position:Number;

		/// The data in the audio stream.
		public var data:flash.utils.ByteArray;

		/// [FP10] Creates an event object that contains information about audio data events.
		public function SampleDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, theposition:Number=0, thedata:flash.utils.ByteArray=null);

		/// [FP10] Creates a copy of the SampleDataEvent object and sets each property's value to match that of the original.
		public function clone():flash.events.Event;

		/// [FP10] Returns a string that contains all the properties of the SampleDataEvent object.
		public function toString():String;

	}

}

