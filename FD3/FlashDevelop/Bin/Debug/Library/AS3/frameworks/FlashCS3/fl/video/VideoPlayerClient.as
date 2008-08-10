package fl.video
{
/**
* @private     *     * @langversion 3.0     * @playerversion Flash 9.0.28.0
*/
public dynamic class VideoPlayerClient
{
		private var _owner : VideoPlayer;

		public function get owner () : VideoPlayer;

		public function VideoPlayerClient (vp:VideoPlayer);
	/**
	* handles NetStream.onMetaData callback		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function onMetaData (info:Object, ...rest) : void;
	/**
	* handles NetStream.onCuePoint callback		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function onCuePoint (info:Object, ...rest) : void;
}
}
