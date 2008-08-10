/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.media {
	import flash.display.DisplayObject;
	import flash.net.NetStream;
	public class Video extends DisplayObject {
		/**
		 * Indicates the type of filter applied to decoded video as part of post-processing.
		 *  The default value is 0, which lets the video compressor apply a deblocking filter as needed.
		 */
		public function get deblocking():int;
		public function set deblocking(value:int):void;
		/**
		 * Specifies whether the video should be smoothed (interpolated) when it is scaled. For
		 *  smoothing to work, the player must be in high-quality mode. The default value
		 *  is false (no smoothing).
		 */
		public function get smoothing():Boolean;
		public function set smoothing(value:Boolean):void;
		/**
		 * An integer specifying the height of the video stream, in pixels. For live streams, this
		 *  value is the same as the Camera.height
		 *  property of the Camera object that is capturing the video stream. For FLV files, this
		 *  value is the height of the file that was exported as FLV.
		 */
		public function get videoHeight():int;
		/**
		 * An integer specifying the width of the video stream, in pixels. For live streams, this
		 *  value is the same as the Camera.width
		 *  property of the Camera object that is capturing the video stream. For FLV files, this
		 *  value is the width of the file that was exported as
		 *  an FLV file.
		 */
		public function get videoWidth():int;
		/**
		 * Creates a new Video instance. If no values for the width and
		 *  height parameters are supplied,
		 *  the default values are used. You can also set the width and height properties of the
		 *  Video object after the initial construction, using Video.width and
		 *  Video.height.
		 *  When a new Video object is created, values of zero for width or height are not allowed;
		 *  if you pass zero, the defaults will be applied.
		 *
		 * @param width             <int (default = 320)> The width of the video, in pixels.
		 * @param height            <int (default = 240)> The height of the video, in pixels.
		 */
		public function Video(width:int = 320, height:int = 240);
		/**
		 * Specifies a video stream from a camera to be displayed
		 *  within the boundaries of the Video object in the application.
		 *
		 * @param camera            <Camera> A Camera object that is capturing video data.
		 *                            To drop the connection to the Video object, pass null.
		 */
		public function attachCamera(camera:Camera):void;
		/**
		 * Specifies a video stream to be displayed within the boundaries of the Video object
		 *  in the application.
		 *  The video stream is either an FLV file played
		 *  with NetStream.play(), a Camera object, or null.
		 *  If you use an FLV file, it can be stored on the local file system or on
		 *  Flash Media Server.
		 *  If the value of the netStream argument is
		 *  null, the video is no longer played in the Video object.
		 *
		 * @param netStream         <NetStream> A NetStream object. To drop the connection to the Video object, pass
		 *                            null.
		 */
		public function attachNetStream(netStream:NetStream):void;
		/**
		 * Clears the image currently displayed in the Video object. This is useful when
		 *  you want to display standby
		 *  information without having to hide the Video object.
		 */
		public function clear():void;
	}
}
