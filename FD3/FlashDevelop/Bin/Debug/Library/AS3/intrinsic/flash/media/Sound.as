/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.media {
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	public class Sound extends EventDispatcher {
		/**
		 * Returns the currently available number of bytes in this sound object. This is
		 *  usually only useful for externally loaded files.
		 */
		public function get bytesLoaded():uint;
		/**
		 * Returns the total number of bytes in this sound object.
		 */
		public function get bytesTotal():int;
		/**
		 * Provides access to the metadata that is part of an MP3 file.
		 */
		public function get id3():ID3Info;
		/**
		 * Returns the buffering state of external MP3 files. If the value is true,
		 *  any playback is
		 *  currently suspended while the object waits for more data.
		 */
		public function get isBuffering():Boolean;
		/**
		 * The length of the current sound in milliseconds.
		 */
		public function get length():Number;
		/**
		 * The URL from which this sound was loaded. This property is applicable only to Sound
		 *  objects that were loaded using the Sound.load() method. For
		 *  Sound objects that are associated with a sound asset from a SWF file's library, the
		 *  value of the url property is null.
		 */
		public function get url():String;
		/**
		 * Creates a new Sound object. If you pass a valid URLRequest object to the
		 *  Sound constructor, the constructor automatically calls the load() function
		 *  for the Sound object.
		 *  If you do not pass a valid URLRequest object to the Sound constructor,
		 *  you must call the load() function for the Sound object yourself,
		 *  or the stream will not load.
		 *
		 * @param stream            <URLRequest (default = null)> The URL that points to an external MP3 file.
		 * @param context           <SoundLoaderContext (default = null)> An optional SoundLoader context object, which can define the buffer time
		 *                            (the minimum number of milliseconds of MP3 data to hold in the Sound object's
		 *                            buffer) and can specify whether the application should check for a cross-domain
		 *                            policy file prior to loading the sound.
		 */
		public function Sound(stream:URLRequest = null, context:SoundLoaderContext = null);
		/**
		 * Closes the stream, causing any download of data to cease.
		 *  No data may be read from the stream after the close()
		 *  method is called.
		 */
		public function close():void;
		/**
		 * Initiates loading of an external MP3 file from the specified URL. If you provide
		 *  a valid URLRequest object to the Sound constructor, the constructor calls
		 *  Sound.load() for you. You only need to call Sound.load()
		 *  yourself if you
		 *  don't pass a valid URLRequest object to the Sound constructor or you pass a null
		 *  value.
		 *
		 * @param stream            <URLRequest> A URL that points to an external MP3 file.
		 * @param context           <SoundLoaderContext (default = null)> An optional SoundLoader context object, which can define the buffer time
		 *                            (the minimum number of milliseconds of MP3 data to hold in the Sound object's
		 *                            buffer) and can specify whether the application should check for a cross-domain
		 *                            policy file prior to loading the sound.
		 */
		public function load(stream:URLRequest, context:SoundLoaderContext = null):void;
		/**
		 * Generates a new SoundChannel object to play back the sound. This method
		 *  returns a SoundChannel object, which you access to stop the sound and to monitor volume.
		 *  (To control the volume, panning, and balance, access the SoundTransform object assigned
		 *  to the sound channel.)
		 *
		 * @param startTime         <Number (default = 0)> The initial position in milliseconds at which playback should
		 *                            start.
		 * @param loops             <int (default = 0)> Defines the number of times a sound loops back to the startTime value
		 *                            before the sound channel stops playback.
		 * @param sndTransform      <SoundTransform (default = null)> The initial SoundTransform object assigned to the sound channel.
		 * @return                  <SoundChannel> A SoundChannel object, which you use to control the sound.
		 *                            This method returns null if you have no sound card
		 *                            or if you run out of available sound channels. The maximum number of
		 *                            sound channels available at once is 32.
		 */
		public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel;
	}
}
