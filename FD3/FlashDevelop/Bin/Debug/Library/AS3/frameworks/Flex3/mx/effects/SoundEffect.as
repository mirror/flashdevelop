package mx.effects
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import mx.effects.effectClasses.SoundEffectInstance;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  Dispatched when the sound file finishes loading.
 *
 *  @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")] 

	/**
	 *  Dispatched when ID3 data is available for an MP3 sound file.
 *
 *  @eventType flash.events.Event.ID3
	 */
	[Event(name="id3", type="flash.events.Event")] 

	/**
	 *  Dispatched when an error occurs during the loading of the sound file.
 *
 *  @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event(name="ioError", type="flash.events.IOErrorEvent")] 

	/**
	 *  Dispatched periodically as the sound file loads.
 *
 *  <p>Within the event object, you can access the number of bytes
 *  currently loaded and the total number of bytes to load.
 *  The event is not guaranteed to be dispatched, which means that
 *  the <code>complete</code> event might be dispatched 
 *  without any <code>progress</code> events being dispatched.</p>
 *
 *  @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")] 

include "../core/Version.as"
	/**
	 *  The SoundEffect class plays an MP3 audio file. 
 *  For example, you could play a sound when a user clicks a Button control. 
 *  This effect lets you repeat the sound, select the source file,
 *  and control the volume and pan. 
 *
 *  <p>You specify the MP3 file using the <code>source</code> property. 
 *  If you have already embedded the MP3 file, using the <code>Embed</code>
 *  keyword, you can pass the Class object of the MP3 file to the
 *  <code>source</code> property. 
 *  Otherwise, specify the full URL to the MP3 file.</p>
 *  
 *  @mxml
 *
 *  <p>The <code>&lt;mx:SoundEffect&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:SoundEffect
 *    <b>Properties</b>
 *    id="ID"
 *    autoLoad="true|false"
 *    bufferTime="1000"
 *    loops="0"
 *    panEasingFunction=""
 *    panFrom="0"
 *    source=""
 *    startTime="0"
 *    useDuration="true|false"
 *    volumeEasingFunction="true|false"
 *    volumeTo="1"
 *     
 *    <b>Events</b>
 *    complete="<i>No default</i>"
 *    id3="<i>No default</i>"
 *    ioError="<i>No default</i>"
 *    progress="<i>No default</i>"
 *  /&gt;
 *  </pre>
 *  
 *  @see mx.effects.effectClasses.SoundEffectInstance
 *  @see flash.media.Sound
 *
 *  @includeExample examples/SoundEffectExample.mxml
	 */
	public class SoundEffect extends Effect
	{
		/**
		 *  @private
		 */
		private var needsLoading : Boolean;
		/**
		 *  @private
	 *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
     *  Storage for the autoLoad property.
		 */
		private var _autoLoad : Boolean;
		/**
		 *  The SoundEffect class uses an internal Sound object to control
     *  the MP3 file.
     *  This property specifies the minimum number of milliseconds 
     *  worth of sound data to hold in the Sound object's buffer.
     *  The Sound object waits until it has at least
     *  this much data before beginning playback,
     *  and before resuming playback after a network stall.
     *
     *  @default 1000
		 */
		public var bufferTime : Number;
		/**
		 *  The number of times to play the sound in a loop, where a value of
     *  0 means play the effect once, a value of 1 means play the effect twice,
     *  and so on. If you repeat the MP3 file, it still uses the setting of the
     *  <code>useDuration</code> property to determine the playback time.
     *
     *  <p>The <code>duration</code> property takes precedence
     *  over this property. 
     *  If the effect duration is not long enough to play the sound
     *  at least once, the sound does not loop.</p>
     *
     *  @default 0
		 */
		public var loops : int;
		/**
		 *  The easing function for the pan effect.
     *  Use this function to interpolate between the values
     *  of <code>panFrom</code> and <code>panTo</code>.
		 */
		public var panEasingFunction : Function;
		/**
		 *  Initial pan of the Sound object.
     *  The value can range from -1.0 to 1.0, where -1.0 uses only the left 
     *  channel, 1.0 uses only the right channel, and 0.0 balances the sound 
     *  evenly between the two channels.
     *
     *  @default 0.0
		 */
		public var panFrom : Number;
		/**
		 *  Final pan of the Sound object.
     *  The value can range from -1.0 to 1.0, where -1.0 uses only the left channel,
     *  1.0 uses only the right channel, and 0.0 balances the sound evenly
     *  between the two channels.
     *
     *  @default 0.0
		 */
		public var panTo : Number;
		/**
		 *  @private
		 */
		private var _sound : Sound;
		/**
		 *  @private
     *  Storage for the source property.
		 */
		private var _source : Object;
		/**
		 *  The initial position in the MP3 file, in milliseconds, 
     *  at which playback should start.
     *
     *  @default 0
		 */
		public var startTime : Number;
		/**
		 *  If <code>true</code>, stop the effect
     *  after the time specified by the <code>duration</code> 
     *  property has elapsed.
     *  If <code>false</code>, stop the effect
     *  after the MP3 finishes playing or looping.
     *
     *  @default true
		 */
		public var useDuration : Boolean;
		/**
		 *  The easing function for the volume effect.
     *  This function is used to interpolate between the values
     *  of <code>volumeFrom</code> and <code>volumeTo</code>.
		 */
		public var volumeEasingFunction : Function;
		/**
		 *  Initial volume of the Sound object.
     *  Value can range from 0.0 to 1.0.
     *
     *  @default 1
		 */
		public var volumeFrom : Number;
		/**
		 *  Final volume of the Sound object.
     *  Value can range from 0.0 to 1.0.
     *
     *  @default 1
		 */
		public var volumeTo : Number;

		/**
		 *  If <code>true</code>, load the MP3 file 
     *  when the <code>source</code> has been specified.
     *
     *  @default true
		 */
		public function get autoLoad () : Boolean;
		/**
		 *  @private
		 */
		public function set autoLoad (value:Boolean) : void;

		/**
		 *  This property is <code>true</code> if the MP3 has been loaded.
		 */
		public function get isLoading () : Boolean;

		/**
		 *  The Sound object that the MP3 file has been loaded into.
		 */
		public function get sound () : Sound;

		/**
		 *  The URL or class of the MP3 file to play.
     *  If you have already embedded the MP3 file, using the <code>Embed</code> keyword, 
     *  you can pass the Class object of the MP3 file to the <code>source</code> property. 
     *  Otherwise, specify the full URL to the MP3 file.
		 */
		public function get source () : Object;
		/**
		 *  @private
		 */
		public function set source (value:Object) : void;

		/**
		 *  Constructor.
     *
     *  @param target The Object to animate with this effect.
		 */
		public function SoundEffect (target:Object = null);

		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;

		/**
		 *  Loads the MP3 if the <code>source</code> property points to a URL.
		 */
		public function load () : void;

		/**
		 *  @private
		 */
		private function attachSoundListeners () : void;

		/**
		 *  @private
		 */
		private function removeSoundListeners () : void;

		/**
		 *  Just act as a proxy for all events from the sound.
		 */
		private function soundEventHandler (event:Event) : void;
	}
}
