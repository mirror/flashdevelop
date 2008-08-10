/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	import flash.events.EventDispatcher;
	import flash.media.SoundTransform;
	import flash.media.Microphone;
	import flash.media.Camera;
	public class NetStream extends EventDispatcher {
		/**
		 * The number of seconds of data currently in the buffer. You can use this property with
		 *  the bufferTime property to estimate how close the buffer is to being full - for example,
		 *  to display feedback to a user who is waiting for data to be loaded into the buffer.
		 */
		public function get bufferLength():Number;
		/**
		 * Specifies how long to buffer messages before starting to display the stream. For example,
		 *  to make sure that the first 15 seconds of the stream play without interruption, set
		 *  bufferTime to 15; the application begins playing the stream only after 15 seconds of
		 *  data are buffered.
		 */
		public function get bufferTime():Number;
		public function set bufferTime(value:Number):void;
		/**
		 * The number of bytes of data that have been loaded into the application. You can use this property
		 *  with the bytesTotal property to estimate how close the buffer is to being full - for example,
		 *  to display feedback to a user who is waiting for data to be loaded into the buffer.
		 */
		public function get bytesLoaded():uint;
		/**
		 * The total size in bytes of the file being loaded into the application.
		 */
		public function get bytesTotal():uint;
		/**
		 * Specifies whether the application should try to download a cross-domain policy file from the
		 *  loaded video file's server before beginning to load the video file. This property applies
		 *  when you are using a NetStream object for progressive video download (standalone
		 *  files), or when you are loading files that are outside the calling file's own domain.
		 *  This property is ignored when you are using a NetStream object to get an RTMP asset.
		 */
		public function get checkPolicyFile():Boolean;
		public function set checkPolicyFile(value:Boolean):void;
		/**
		 * Specifies the object on which callback methods are invoked. The default object is this, the
		 *  NetStream object being created. If you set the client property to another object, callback methods will
		 *  be invoked on that other object.
		 */
		public function get client():Object;
		public function set client(value:Object):void;
		/**
		 * The number of frames per second being displayed. If you are exporting video files to be played back on a number
		 *  of systems, you can check this value during testing to help you determine how much compression to apply when
		 *  exporting the file.
		 */
		public function get currentFPS():Number;
		/**
		 * The number of seconds of data in the subscribing stream's
		 *  buffer in live (unbuffered) mode. This property specifies the current
		 *  network transmission delay (lag time).
		 */
		public function get liveDelay():Number;
		/**
		 * The object encoding (AMF version) for this NetStream object. The NetStream object
		 *  inherits its objectEncoding value from the associated NetConnection object.
		 *  It's important to understand this property if your ActionScript 3.0 SWF file needs to
		 *  communicate with servers released prior to Flash Player 9.
		 *  For more information, see the objectEncoding property description
		 *  in the NetConnection class.
		 */
		public function get objectEncoding():uint;
		/**
		 * Controls sound in this NetStream object. For more information, see the SoundTransform class.
		 */
		public function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		/**
		 * The position of the playhead, in seconds.
		 */
		public function get time():Number;
		/**
		 * Creates a stream that can be used for playing video files through the specified NetConnection
		 *  object.
		 *
		 * @param connection        <NetConnection> A NetConnection object.
		 */
		public function NetStream(connection:NetConnection);
		/**
		 * Specifies an audio stream sent over the NetStream object, from a Microphone
		 *  object passed as the source. This method is available
		 *  only to the publisher of the specified stream.
		 *
		 * @param microphone        <Microphone> The source of the audio stream to be transmitted.
		 */
		public function attachAudio(microphone:Microphone):void;
		/**
		 * Starts capturing video from a camera, or stops capturing if
		 *  theCamera is set to null.
		 *  This method is available only to the publisher of the specified stream.
		 *
		 * @param theCamera         <Camera> The source of the video transmission. Valid values are a Camera object
		 *                            (which starts capturing video) and null. If you pass null,
		 *                            the application stops capturing video, and any additional parameters you send are ignored.
		 * @param snapshotMilliseconds<int (default = -1)> Specifies whether the video stream is continuous,
		 *                            a single frame, or a series of single frames used to create time-lapse photography.
		 *                            If you omit this parameter, the application captures all video until you pass
		 *                            a value of null to attachCamera.
		 *                            If you pass 0, the application captures only a single video frame. Use this value
		 *                            to transmit "snapshots" within a preexisting stream. Flash Player
		 *                            or  AIR interprets invalid, negative, or nonnumeric arguments as 0.
		 *                            If you pass a positive number, the application captures a single video frame and then appends a pause
		 *                            of the specified length as a trailer on the snapshot. Use this value to create time-lapse
		 *                            photography effects.
		 */
		public function attachCamera(theCamera:Camera, snapshotMilliseconds:int = -1):void;
		/**
		 * Stops playing all data on the stream, sets the time property to 0,
		 *  and makes the stream available for another use. This method also deletes the local copy
		 *  of a video file that was downloaded through HTTP. Although the application deletes the
		 *  local copy of the file that it creates, a copy might persist in the
		 *  cache directory. If you must completely prevent caching or local storage of the video file,
		 *  use Flash Media Server.
		 */
		public function close():void;
		/**
		 * Pauses playback of a video stream. Calling this method does nothing if the video
		 *  is already paused. To resume play after pausing a video, call resume().
		 *  To toggle between pause and play (first pausing the video, then resuming), call
		 *  togglePause().
		 */
		public function pause():void;
		/**
		 * Begins playback of video files.
		 */
		public function play(... arguments):void;
		/**
		 * Sends streaming audio, video, and text messages from a client to Flash Media Server,
		 *  optionally recording the stream during transmission.
		 *  This method is available only to the publisher of the specified stream.
		 *
		 * @param name              <String (default = null)> A string that identifies the stream. If you pass false,
		 *                            the publish operation stops. Clients that subscribe to this stream must pass this same name
		 *                            when they call NetStream.play(). You don't need to include a file extension
		 *                            for the stream name. Don't follow the stream name with a "/". For example, don't use
		 *                            the stream name "bolero/".
		 * @param type              <String (default = null)> A string that specifies how to publish the stream.
		 *                            Valid values are "record", "append", and "live".
		 *                            The default value is "live".
		 *                            If you pass "record", the application publishes and records live data,
		 *                            saving the recorded data to a new file with a name matching the value passed
		 *                            to the name parameter. The file is stored
		 *                            on the server in a subdirectory within the directory that contains the server application.
		 *                            If the file already exists, it is overwritten.
		 *                            If you pass "append", the application publishes and records live data,
		 *                            appending the recorded data to a file with a name that matches the value passed
		 *                            to the name parameter, stored on the server
		 *                            in a subdirectory within the directory that contains the server application.
		 *                            If no file with a matching name the name parameter is found, it is created.
		 *                            If you omit this parameter or pass "live", the application publishes live data without
		 *                            recording it. If a file with a name that matches the value passed
		 *                            to the name parameter exists, it is deleted.
		 */
		public function publish(name:String = null, type:String = null):void;
		/**
		 * Specifies whether incoming audio plays on the stream.
		 *  This method is available only to clients subscribed to the specified stream,
		 *  not to the stream's publisher.
		 *
		 * @param flag              <Boolean> Specifies whether incoming audio plays on the stream
		 *                            (true) or not (false). The default value is true.
		 */
		public function receiveAudio(flag:Boolean):void;
		/**
		 * Specifies whether incoming video will play on the stream. This method is available
		 *  only to clients subscribed to the specified stream, not to the stream's publisher.
		 *
		 * @param flag              <Boolean> Specifies whether incoming video plays on this stream
		 *                            (true) or not (false). The default value is true.
		 */
		public function receiveVideo(flag:Boolean):void;
		/**
		 * Specifies the frame rate for incoming video. This method is available
		 *  only to clients subscribed to the specified stream, not to the stream's publisher.
		 *
		 * @param FPS               <Number> Specifies the frame rate per second at which the incoming video will play.
		 */
		public function receiveVideoFPS(FPS:Number):void;
		/**
		 * Resumes playback of a video stream that is paused. If the video is already playing, calling this method
		 *  does nothing.
		 */
		public function resume():void;
		/**
		 * Seeks the keyframe (also called an I-frame in the video industry) closest to
		 *  the specified location. The keyframe is placed at an offset, in seconds, from
		 *  the beginning of the stream.
		 *
		 * @param offset            <Number> The approximate time value, in seconds, to move to in a video file.
		 *                            With Flash Media Server, if <EnhancedSeek> is set to true in the Application.xml
		 *                            configuration file (which it is by default), the server
		 *                            generates a keyframe at offset.
		 *                            To return to the beginning of the stream, pass 0 for offset.
		 *                            To seek forward from the beginning of the stream, pass the number of seconds to advance.
		 *                            For example, to position the playhead at 15 seconds from the beginning (or the keyframe
		 *                            before 15 seconds), use myStream.seek(15).
		 *                            To seek relative to the current position, pass NetStream.time + n
		 *                            or NetStream.time - n
		 *                            to seek n seconds forward or backward, respectively, from the current position.
		 *                            For example, to rewind 20 seconds from the current position, use
		 *                            NetStream.seek(NetStream.time - 20).
		 */
		public function seek(offset:Number):void;
		/**
		 * Sends a message on a published stream to all subscribing clients.
		 *  This method is available only to the publisher of the specified stream,
		 *  and is intended for use with Flash Media Server.
		 *  To process and respond to this message, create a handler on the
		 *  NetStream object, for example, ns.HandlerName.
		 *
		 * @param handlerName       <String> The message to be sent; also the name of the ActionScript
		 *                            handler to receive the message. The handler name can be only one level deep
		 *                            (that is, it can't be of the form parent/child) and is relative to the stream object.
		 *                            Do not use a reserved term for a handler name.
		 *                            For example, using "close" as a handler name will cause
		 *                            the method to fail.
		 *                            With Flash Media Server, use @setDataFrame to add a
		 *                            keyframe of metadata to a live stream
		 *                            or @clearDataFrame to remove a keyframe.
		 */
		public function send(handlerName:String, ... arguments):void;
		/**
		 * Pauses or resumes playback of a stream.
		 *  The first time you call this method, it pauses play; the next time, it resumes play.
		 *  You could use this method to let users pause or resume playback by pressing
		 *  a single button.
		 */
		public function togglePause():void;
	}
}
