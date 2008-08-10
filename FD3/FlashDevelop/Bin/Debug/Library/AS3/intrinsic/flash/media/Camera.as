/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.media {
	import flash.events.EventDispatcher;
	public final  class Camera extends EventDispatcher {
		/**
		 * The amount of motion the camera is detecting. Values range from 0 (no motion is being detected) to
		 *  100 (a large amount of motion is being detected). The value of this property can help you determine if you need to pass a setting
		 *  to the setMotionLevel() method.
		 */
		public function get activityLevel():Number;
		/**
		 * The maximum amount of bandwidth the current outgoing video feed can use, in bytes.
		 *  A value of 0 means the feed can use as much bandwidth as needed to maintain the desired frame quality.
		 */
		public function get bandwidth():int;
		/**
		 * The rate at which the camera is capturing data, in frames per second.
		 *  This property cannot be set; however, you can use the setMode() method
		 *  to set a related property-fps-which specifies the maximum
		 *  frame rate at which you would like the camera to capture data.
		 */
		public function get currentFPS():Number;
		/**
		 * The maximum rate at which the camera can capture data, in frames per second.
		 *  The maximum rate possible depends on the capabilities of the camera; this frame rate may not be achieved.
		 *  To set a desired value for this property, use the setMode() method.
		 *  To determine the rate at which the camera is currently capturing data, use the currentFPS property.
		 */
		public function get fps():Number;
		/**
		 * The current capture height, in pixels. To set a value for this property,
		 *  use the setMode() method.
		 */
		public function get height():int;
		/**
		 * A zero-based integer that specifies the index of the camera, as reflected in
		 *  the array returned by the names property.
		 */
		public function get index():int;
		/**
		 * The number of video frames transmitted in full (called keyframes)
		 *  instead of being interpolated by the video compression algorithm.
		 *  The default value is 15, which means that every 15th frame is a keyframe.
		 *  A value of 1 means that every frame is a keyframe. The allowed values are
		 *  1 through 48.
		 */
		public function get keyFrameInterval():int;
		/**
		 * Indicates whether a local view of what the camera is capturing is compressed
		 *  and decompressed (true), as it would be for live transmission using
		 *  Flash Media Server, or uncompressed (false). The default value is
		 *  false.
		 */
		public function get loopback():Boolean;
		/**
		 * The amount of motion required to invoke the activity event. Acceptable values range from 0 to 100.
		 *  The default value is 50.
		 */
		public function get motionLevel():int;
		/**
		 * The number of milliseconds between the time the camera stops detecting motion and the time the activity event is invoked. The
		 *  default value is 2000 (2 seconds).
		 */
		public function get motionTimeout():int;
		/**
		 * A Boolean value indicating whether the user has denied access to the camera
		 *  (true) or allowed access (false) in the Flash Player Privacy dialog box.
		 *  When this value changes, the statusevent is dispatched.
		 */
		public function get muted():Boolean;
		/**
		 * The name of the current camera, as returned by the camera hardware.
		 */
		public function get name():String;
		/**
		 * An array of strings indicating the names of all available cameras
		 *  without displaying the Flash Player Privacy dialog box. This array behaves in the
		 *  same way as any other ActionScript array, implicitly providing the zero-based
		 *  index of each camera and the number of cameras on the system (by means of
		 *  names.length). For more information, see the names Array class entry.
		 */
		public static function get names():Array;
		/**
		 * The required level of picture quality, as determined by the amount of compression being applied to each video
		 *  frame. Acceptable quality values range from 1 (lowest quality, maximum compression) to 100 (highest quality, no compression). The
		 *  default value is 0, which means that picture quality can vary as needed to avoid exceeding available bandwidth.
		 */
		public function get quality():int;
		/**
		 * The current capture width, in pixels. To set a desired value for this property,
		 *  use the setMode() method.
		 */
		public function get width():int;
		/**
		 * Returns a reference to a Camera object for capturing video. To begin capturing
		 *  the video, you must attach the Camera object to a Video object (see Video.attachCamera()
		 *  ). To transmit video to Flash Media Server, call NetStream.attachCamera()
		 *  to attach the Camera object to a NetStream object.
		 *
		 * @param name              <String (default = null)> Specifies which camera to get, as determined from the array
		 *                            returned by the names property. For most applications, get the default camera
		 *                            by omitting this parameter. To specify a value for this parameter, use the string representation
		 *                            of the zero-based index position within the Camera.names array. For example, to specify the third
		 *                            camera in the array, use Camera.getCamera("2").
		 * @return                  <Camera> If the name parameter is not specified, this method returns a reference
		 *                            to the default camera or, if it is in use by another application, to the first
		 *                            available camera. (If there is more than one camera installed, the user may specify
		 *                            the default camera in the Flash Player Camera Settings panel.) If no cameras are available
		 *                            or installed, the method returns null.
		 */
		public static function getCamera(name:String = null):Camera;
		/**
		 * Specifies which video frames are transmitted in full (called keyframes)
		 *  instead of being interpolated by the video compression algorithm. This method
		 *  is applicable only if you are transmitting video using Flash Media Server.
		 *
		 * @param keyFrameInterval  <int> A value that specifies which video frames are transmitted in full
		 *                            (as keyframes) instead of being interpolated by the video compression algorithm.
		 *                            A value of 1 means that every frame is a keyframe, a value of 3 means that every third frame
		 *                            is a keyframe, and so on. Acceptable values are 1 through 48.
		 */
		public function setKeyFrameInterval(keyFrameInterval:int):void;
		/**
		 * Specifies whether to use a compressed video stream for a local view of the camera.
		 *  This method is applicable only if you are transmitting video using Flash Media Server;
		 *  setting compress to true lets you see more precisely how the video
		 *  will appear to users when they view it in real time.
		 *
		 * @param compress          <Boolean (default = false)> Specifies whether to use a compressed video stream (true)
		 *                            or an uncompressed stream (false) for a local view of what the camera
		 *                            is receiving.
		 */
		public function setLoopback(compress:Boolean = false):void;
		/**
		 * Sets the camera capture mode to the native mode that best meets the specified requirements.
		 *  If the camera does not have a native mode that matches all the parameters you pass,
		 *  Flash Player selects a capture mode that most closely synthesizes the requested mode.
		 *  This manipulation may involve cropping the image and dropping frames.
		 *
		 * @param width             <int> The requested capture width, in pixels. The default value is 160.
		 * @param height            <int> The requested capture height, in pixels. The default value is 120.
		 * @param fps               <Number> The requested rate at which the camera should capture data, in frames per second.
		 *                            The default value is 15.
		 * @param favorArea         <Boolean (default = true)> Specifies whether to manipulate the width, height, and frame rate if
		 *                            the camera does not have a native mode that meets the specified requirements.
		 *                            The default value is true, which means that maintaining capture size
		 *                            is favored; using this parameter selects the mode that most closely matches
		 *                            width and height values, even if doing so adversely affects
		 *                            performance by reducing the frame rate. To maximize frame rate at the expense
		 *                            of camera height and width, pass false for the favorArea parameter.
		 */
		public function setMode(width:int, height:int, fps:Number, favorArea:Boolean = true):void;
		/**
		 * Specifies how much motion is required to dispatch the activity event.
		 *  Optionally sets the number of milliseconds that must elapse without activity before
		 *  Flash Player considers motion to have stopped and dispatches the event.
		 *
		 * @param motionLevel       <int> Specifies the amount of motion required to dispatch the
		 *                            activity event. Acceptable values range from 0 to 100. The default value is 50.
		 * @param timeout           <int (default = 2000)> Specifies how many milliseconds must elapse without activity
		 *                            before Flash Player considers activity to have stopped and dispatches the activity event.
		 *                            The default value is 2000 milliseconds (2 seconds).
		 */
		public function setMotionLevel(motionLevel:int, timeout:int = 2000):void;
		/**
		 * Sets the maximum amount of bandwidth per second or the required picture quality
		 *  of the current outgoing video feed. This method is generally applicable only if
		 *  you are transmitting video using Flash Media Server.
		 *
		 * @param bandwidth         <int> Specifies the maximum amount of bandwidth that the current outgoing video
		 *                            feed can use, in bytes per second. To specify that Flash Player video can use as much bandwidth
		 *                            as needed to maintain the value of quality, pass 0 for
		 *                            bandwidth. The default value is 16384.
		 * @param quality           <int> An integer that specifies the required level of picture quality,
		 *                            as determined by the amount of compression being applied to each video frame.
		 *                            Acceptable values range from 1 (lowest quality, maximum compression) to 100 (highest
		 *                            quality, no compression). To specify that picture quality can vary as needed to avoid
		 *                            exceeding bandwidth, pass 0 for quality.
		 */
		public function setQuality(bandwidth:int, quality:int):void;
	}
}
