package flash.media
{
	/// The Sound class lets you work with sound in an application.
	public class Sound extends flash.events.EventDispatcher
	{
		/** 
		 * Dispatched when data is received as a load operation progresses.
		 * @eventType flash.events.ProgressEvent.PROGRESS
		 * @eventType flash.events.ProgressEvent.PROGRESS
		 */
		[Event(name="progress", type="flash.events.ProgressEvent")]

		/** 
		 * Dispatched when a load operation starts.
		 * @eventType flash.events.Event.OPEN
		 * @eventType flash.events.Event.OPEN
		 */
		[Event(name="open", type="flash.events.Event")]

		/** 
		 * Dispatched when an input/output error occurs that causes a load operation to fail.
		 * @eventType flash.events.IOErrorEvent.IO_ERROR
		 * @eventType flash.events.IOErrorEvent.IO_ERROR
		 */
		[Event(name="ioError", type="flash.events.IOErrorEvent")]

		/** 
		 * Dispatched by a Sound object when ID3 data is available for an MP3 sound.
		 * @eventType flash.events.Event.ID3
		 * @eventType flash.events.Event.ID3
		 */
		[Event(name="id3", type="flash.events.Event")]

		/** 
		 * Dispatched when data has loaded successfully.
		 * @eventType flash.events.Event.COMPLETE
		 * @eventType flash.events.Event.COMPLETE
		 */
		[Event(name="complete", type="flash.events.Event")]

		/** 
		 * Dispatched when the player requests new audio data.
		 * @eventType flash.events.SampleDataEvent.SAMPLE_DATA
		 * @eventType flash.events.SampleDataEvent.SAMPLE_DATA
		 */
		[Event(name="sampleData", type="flash.events.SampleDataEvent")]

		/// The URL from which this sound was loaded.
		public var url:String;

		/// The length of the current sound in milliseconds.
		public var length:Number;

		/// Returns the buffering state of external MP3 files.
		public var isBuffering:Boolean;

		/// Returns the currently available number of bytes in this sound object.
		public var bytesLoaded:uint;

		/// Returns the total number of bytes in this sound object.
		public var bytesTotal:int;

		/// Provides access to the metadata that is part of an MP3 file.
		public var id3:flash.media.ID3Info;

		/// Creates a new Sound object.
		public function Sound(stream:flash.net.URLRequest=null, context:flash.media.SoundLoaderContext=null);

		/// Initiates loading of an external MP3 file from the specified URL.
		public function load(stream:flash.net.URLRequest, context:flash.media.SoundLoaderContext=null):void;

		/// Generates a new SoundChannel object to play back the sound.
		public function play(startTime:Number=0, loops:int=0, sndTransform:flash.media.SoundTransform=null):flash.media.SoundChannel;

		/// Closes the stream, causing any download of data to cease.
		public function close():void;

	}

}

