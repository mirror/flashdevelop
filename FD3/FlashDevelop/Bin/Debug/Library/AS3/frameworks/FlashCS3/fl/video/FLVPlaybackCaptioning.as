package fl.video
{
import flash.accessibility.Accessibility;
import flash.accessibility.AccessibilityProperties;
import flash.display.*;
import flash.events.*;
import flash.text.*;
import flash.geom.Rectangle;
import flash.geom.Point;
import flash.system.Capabilities;
import flash.utils.*;

/**
* The FLVPlaybackCaptioning component enables captioning for the FLVPlayback component.	 * The FLVPlaybackCaptioning component downloads a Timed Text (TT) XML file	 * and applies those captions to an FLVPlayback component to which this	 * component is partnered.	 *	 * <p>For more information on Timed Text format, see	 * <a href="http://www.w3.org/AudioVideo/TT/" target="_blank">http://www.w3.org/AudioVideo/TT/</a>.  The FLVPlaybackCaptioning component	 * supports a subset of the	 * Timed Text 1.0 specification.  For detailed information on the supported subset, see	 * <a href="../../TimedTextTags.html">Timed Text Tags</a>. The following is a 	 * brief example:</p>	 *	 * <pre>	 * &lt;?xml version="1.0" encoding="UTF-8"?&gt;	 * &lt;tt xml:lang="en" xmlns="http://www.w3.org/2006/04/ttaf1"  xmlns:tts="http://www.w3.org/2006/04/ttaf1#styling"&gt;	 *     &lt;head&gt;	 *         &lt;styling&gt;	 *             &lt;style id="1" tts:textAlign="right"/&gt;	 *             &lt;style id="2" tts:color="
*/
public class FLVPlaybackCaptioning extends Sprite
{
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var ttm : TimedTextManager;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var visibleCaptions : Array;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var hasSeeked : Boolean;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var flvPos : Rectangle;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var prevCaptionTargetHeight : Number;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var captionTargetOwned : Boolean;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var captionTargetLastHeight : Number;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var captionToggleButton : Sprite;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var onButton : Sprite;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var offButton : Sprite;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var captionToggleButtonWaiting : Sprite;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal static const AUTO_VALUE : String;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var _captionTarget : TextField;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var _captionTargetContainer : DisplayObjectContainer;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var cacheCaptionTargetParent : DisplayObjectContainer;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var cacheCaptionTargetIndex : int;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var cacheCaptionTargetAutoLayout : Boolean;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var cacheCaptionTargetLocation : Rectangle;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var cacheCaptionTargetScaleY : Number;
	/**
	* Used when keeing flvplayback skin above the caption         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal var skinHijacked : Boolean;
		private var _autoLayout : Boolean;
		private var _captionsOn : Boolean;
		private var _captionURL : String;
		private var _flvPlaybackName : String;
		private var _flvPlayback : FLVPlayback;
		private var _captionTargetName : String;
		private var _videoPlayerIndex : uint;
		private var _limitFormatting : Boolean;
		private var _track : uint;

	/**
	* Used to display captions; <code>true</code> = display captions, 	 * <code>false</code> = do not display captions.         *          * <p>If you use the <code>captionButton</code> property to allow the         * user to turn captioning on and off, set the <code>showCaptions</code>         * property to <code>false</code>.</p>         *          * @default true         *         * @see #captionButton          *          * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get showCaptions () : Boolean;

	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set showCaptions (b:Boolean) : Void;

	/**
	* URL of the Timed Text XML file that contains caption information (<b>required property</b>).         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get source () : String;

	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set source (url:String) : Void;

	/**
	* Determines whether the FLVPlaybackCaptioning component	 * automatically moves and resizes the TextField object for captioning.	 *	 * 	 * <p>If the <code>autoLayout</code> property is set to <code>true</code>, the DisplayObject instance or 	 * the TextField object containing the captions displays 10 pixels from the bottom	 * of the FLVPlayback instance. The captioning area covers the width of	 * the FLVPlayback instance, maintaining a margin of 10 pixels on each side.</p>	 * 	 * <p>When this property is set to <code>true</code>, the DisplayObject instance	 * or TextField object displays directly over the FLVPlayback instance.	 * If you are creating your own TextField object, you should set	 * <code>autoLayout</code> to <code>false</code>. 	 * If <code>wordWrap = false</code>, the captioning area centers over the FLVPlayback	 * instance, but it can be wider than the FLVPlayback instance.</p>	 * 	 * <p>To control layout, you need to listen for the <code>captionChange</code> event to	 * dete
	*/
		public function get autoLayout () : Boolean;

	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set autoLayout (b:Boolean) : Void;

	/**
	* The instance name of the TextField object or MovieClip enclosing a Textfield object	 * that contains the captions.	 *	 * <p>To specify no target, set this property to an empty string (that is, no target specified)	 * or <code>auto</code>. This property is primarily used	 * in the Component inspector. If you are writing code, use the	 * <code>captionTarget</code> property instead.</p>	 * 	 * @default auto	 *         * @see #captionTarget          *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get captionTargetName () : String;

	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set captionTargetName (tname:String) : Void;

	/**
	* Sets the DisplayObject instance in which to display captions. 	 *	 * <p>If you set the instance as a TextField object, it is targeted directly.	 * If you set the instance as a DisplayObjectContainer	 * containing one or more TextField objects, the captions display in the	 * TextField object with the lowest display index.</p>	 *	 * <p>The <code>DisplayObjectContainer</code> method supports a movie-clip like object	 * with a scale-9 background, which can be scaled when the TextField object size changes.</p>	 *	 * <p>For more complex scaling and drawing, write code to have the	 * <code>DisplayObjectContainer</code> method listen for a <code>captionChange</code> event.</p>	 * <p><b>Note</b> If the <code>captionTargetName</code> or the <code>captionTarget</code> property 	 * is not set, the FLVPlaybackCaptioning instance creates a text field set by the	 * <code>captionTarget</code> property with this formatting:</p>	 *	 * <ul>	 * <li>black background (background = <code>true</code>; backgroun
	*/
		public function get captionTarget () : DisplayObject;

	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set captionTarget (ct:DisplayObject) : Void;

	/**
	* Defines the captionButton FLVPlayback custom UI component instance	 * which provides toggle capabilities to turn captioning on and off. 	 * 	 * <p>The <code>captionButton</code> property functions similarly to the FLVPlayback	 * properties <code>playButton</code>,	 * <code>pauseButton</code>, <code>muteButton</code>, and so on.</p>	 *	 * @see FLVPlayback	 * 	 * @langversion 3.0	 * @playerversion Flash 9.0.28.0	 *
	*/
		public function get captionButton () : Sprite;

		public function set captionButton (s:Sprite) : Void;

	/**
	* Sets an FLVPlayback instance name for the FLVPlayback instance	 * that you want to caption. 	 * 	 * <p>To specify no target, set this to an empty string or <code>auto</code>.	 * The FLVPlayback instance must have the same	 * parent as the FLVPlaybackCaptioning instance.</p>	 * 	 * <p>The FLVPlayback instance name is primarily used in	 * the Component inspector.  If you are writing code,	 * use the <code>flvPlayback</code> property.</p>	 * 	 * <p>If the <code>flvPlaybackName</code> or  	 * the <code>flvPlayback</code> property is not set or set to <code>auto</code>, 	 * the FLVPlaybackCaptioning instance searches for a FLVPlayback	 * instance with the same parent and captions the first one it finds.</p>	 * 	 * @default auto	 *         * @see FLVPlayback FLVPlayback class         * @see #flvPlayback flvPlayback property         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get flvPlaybackName () : String;

	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set flvPlaybackName (flvname:String) : Void;

	/**
	* Sets the FLVPlayback instance to caption.  The FLVPlayback	 * instance must have the same parent as the	 * FLVPlaybackCaptioning instance.	 * <p>If the 	 * <code>flvPlaybackName</code> or	 * <code>flvPlayback</code> property is <b>not</b> set, the	 * FLVPlaybackCaptioning instance will look for a FLVPlayback	 * instance with the same parent and caption the first one it	 * finds.</p>	 *         * @see #flvPlaybackName          *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get flvPlayback () : FLVPlayback;

	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set flvPlayback (fp:FLVPlayback) : Void;

	/**
	* Support for multiple language tracks.  	 * 	 * <p>The best utilization of the <code>track</code> property	 * is to support multiple language tracks with	 * embedded cue points.</p>	 * 	 * <p>You must follow the supported formats for FLVPlaybackCaptioning	 * cue points.</p>	 *	 * <p>If the <code>track</code> property is set to something other than <code>0</code>,	 * the FLVPlaybackCaptioning component searches for a text&lt;n&gt; property on the cue point,	 * where <em>n</em> is the track value.</p> 	 * 	 * <p>For example, if <code>track == 1</code>, then the FLVPlayBackCaptioning component	 * searches for the parameter <code>text1</code> on the cue point.  If 	 * no matching parameter is found, the text property in the cue point parameter is used.</p>	 *	 * @default 0	 * 	 * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get track () : uint;

		public function set track (i:uint) : Void;

	/**
	* Connects the captioning to a specific VideoPlayer in the	 * FLVPlayback component.	 *	 * <p> If you want to use captioning in	 * multiple video players (using the <code>activeVideoPlayerIndex</code>	 * and <code>visibleVideoPlayerIndex</code> properties in the FLVPlayback	 * component), you	 * should create one instance of the FLVPlaybackCaptioning	 * component for each <code>VideoPlayer</code> that you will be using and set	 * this property to correspond to the index.</p>	 * 	 * <p>The VideoPlayer index defaults to         * 0 when only one video player is used.</p>          *          * @see FLVPlayback#activeVideoPlayerIndex          * @see FLVPlayback#visibleVideoPlayerIndex          *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set videoPlayerIndex (v:uint) : Void;

		public function get videoPlayerIndex () : uint;

	/**
	* Limits formatting instructions 	 * from the Timed Text file when set to <code>true</code>.	 *	 * <p>The following styles are <b>not</b> supported if the <code>simpleFormatting</code>	 * property is set to <code>true</code>:</p>	 * 	 * <ul>	 *   <li>tts:backgroundColor</li>	 *   <li>tts:color</li>	 *   <li>tts:fontSize</li>	 *   <li>tts:fontFamily</li>	 *   <li>tts:wrapOption</li>	 * </ul>	 *	 * <p>The following styles <b>are</b> supported if the <code>simpleFormatting</code>	 * property is set to <code>true</code>:</p>	 * 	 * <ul>	 *   <li>tts:fontStyle</li>	 *   <li>tts:fontWeight</li>	 *   <li>tts:textAlign</li>         * </ul>         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set simpleFormatting (b:Boolean) : Void;

		public function get simpleFormatting () : Boolean;

	/**
	* Creates a new FLVPlaybackCaptioning instance.          *           * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function FLVPlaybackCaptioning ();
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function forwardEvent (e:Event) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function startLoad (e:Event) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function hookupCaptionToggle (e:Event) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function handleCaption (e:MetadataEvent) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function handleStateChange (e:VideoEvent) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function handleComplete (e:VideoEvent) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function handlePlayheadUpdate (e:VideoEvent) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function handleSkinLoad (e:VideoEvent) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function handleAddedToStage (e:Event) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function handleFullScreenEvent (e:FullScreenEvent) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function enterFullScreenTakeOver () : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function exitFullScreenTakeOver () : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function cleanupCaptionButton () : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function setupButton (ctrl:Sprite, prefix:String, vis:Boolean) : Sprite;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function handleButtonClick (e:MouseEvent) : void;
	/**
	* This function stolen from UIManager and tweaked.		 *          * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function setupButtonSkin (prefix:String) : Sprite;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function removeOldCaptions (playheadTime:Number, removedCaptionsIn:Array =null) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function findFLVPlayback () : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function createCaptionTarget () : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function layoutCaptionTarget (e:LayoutEvent =null) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function addFLVPlaybackListeners () : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function removeFLVPlaybackListeners () : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function getCaptionText (cp:Object) : String;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function displayCaptionNow () : void;
	/**
	* Keeps screen reader from reading captionTarget		 * 		 * @private
	*/
		internal function silenceCaptionTarget () : void;
}
}
