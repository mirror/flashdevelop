package fl.video
{
import flash.display.*;
import flash.events.*;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.net.URLRequest;
import flash.utils.*;

/**
* <p>Functions you can plugin to seek bar or volume bar with, to	 * override std behavior: startHandleDrag(), stopHandleDrag(),	 * positionHandle(), calcPercentageFromHandle(), positionBar().	 * Return true to override standard behavior or return false to allow	 * standard behavior to execute.  These do not override default	 * behavior, but allow you to add addl functionality:	 * addBarControl()</p>	 *	 * <p>Functions you can use for swf based skin controls: layoutSelf()	 * - called after control is laid out to do additional layout.	 * Properties that can be set to customize layout: anchorLeft,	 * anchorRight, anchorTop, anchorLeft.</p>	 *	 * <p>Possible seek bar and volume bar customization variables:	 * handleLeftMargin, handleRightMargin, handleY, handle_mc,	 * progressLeftMargin, progressRightMargin, progressY, progress_mc,	 * fullnessLeftMargin, fullnessRightMargin, fullnessY, fullness_mc,	 * percentage.  These variables will also be set to defaults by	 * UIManager if values are not
*/
public class UIManager
{
		public static const PAUSE_BUTTON : int;
		public static const PLAY_BUTTON : int;
		public static const STOP_BUTTON : int;
		public static const SEEK_BAR_HANDLE : int;
		public static const SEEK_BAR_HIT : int;
		public static const BACK_BUTTON : int;
		public static const FORWARD_BUTTON : int;
		public static const FULL_SCREEN_ON_BUTTON : int;
		public static const FULL_SCREEN_OFF_BUTTON : int;
		public static const MUTE_ON_BUTTON : int;
		public static const MUTE_OFF_BUTTON : int;
		public static const VOLUME_BAR_HANDLE : int;
		public static const VOLUME_BAR_HIT : int;
		public static const NUM_BUTTONS : int;
		public static const PLAY_PAUSE_BUTTON : int;
		public static const FULL_SCREEN_BUTTON : int;
		public static const MUTE_BUTTON : int;
		public static const BUFFERING_BAR : int;
		public static const SEEK_BAR : int;
		public static const VOLUME_BAR : int;
		public static const NUM_CONTROLS : int;
		public static const NORMAL_STATE : uint;
		public static const OVER_STATE : uint;
		public static const DOWN_STATE : uint;
		internal var controls : Array;
		internal var delayedControls : Array;
		public var customClips : Array;
		public var ctrlDataDict : Dictionary;
		internal var skin_mc : Sprite;
		internal var skinLoader : Loader;
		internal var skinTemplate : Sprite;
		internal var layout_mc : Sprite;
		internal var border_mc : DisplayObject;
		internal var borderCopy : Sprite;
		internal var borderPrevRect : Rectangle;
		internal var borderScale9Rects : Array;
		internal var borderAlpha : Number;
		internal var borderColor : uint;
		internal var borderColorTransform : ColorTransform;
		internal var skinLoadDelayCount : uint;
		internal var placeholderLeft : Number;
		internal var placeholderRight : Number;
		internal var placeholderTop : Number;
		internal var placeholderBottom : Number;
		internal var videoLeft : Number;
		internal var videoRight : Number;
		internal var videoTop : Number;
		internal var videoBottom : Number;
		internal var _bufferingBarHides : Boolean;
		internal var _controlsEnabled : Boolean;
		internal var _skin : String;
		internal var _skinAutoHide : Boolean;
		internal var _skinFadingMaxTime : int;
		internal var _skinReady : Boolean;
		internal var __visible : Boolean;
		internal var _seekBarScrubTolerance : Number;
		internal var _progressPercent : Number;
		internal var cachedSoundLevel : Number;
		internal var _lastVolumePos : Number;
		internal var _isMuted : Boolean;
		internal var _volumeBarTimer : Timer;
		internal var _volumeBarScrubTolerance : Number;
		internal var _vc : FLVPlayback;
		internal var _bufferingDelayTimer : Timer;
		internal var _bufferingOn : Boolean;
		internal var _seekBarTimer : Timer;
		internal var _lastScrubPos : Number;
		internal var _playAfterScrub : Boolean;
		internal var _skinAutoHideTimer : Timer;
		internal static const SKIN_AUTO_HIDE_INTERVAL : Number;
		internal var _skinFadingTimer : Timer;
		internal static const SKIN_FADING_INTERVAL : Number;
		internal var _skinFadingIn : Boolean;
		internal var _skinFadeStartTime : int;
		internal var _skinAutoHideMotionTimeout : int;
		internal var _skinAutoHideMouseX : Number;
		internal var _skinAutoHideMouseY : Number;
		internal var _skinAutoHideLastMotionTime : int;
		internal static const SKIN_FADING_MAX_TIME_DEFAULT : Number;
		internal static const SKIN_AUTO_HIDE_MOTION_TIMEOUT_DEFAULT : Number;
		internal var mouseCaptureCtrl : int;
		internal var _fullScreen : Boolean;
		internal var _fullScreenTakeOver : Boolean;
		internal var _fullScreenBgColor : uint;
		internal var cacheStageAlign : String;
		internal var cacheStageScaleMode : String;
		internal var cacheFLVPlaybackParent : DisplayObjectContainer;
		internal var cacheFLVPlaybackIndex : int;
		internal var cacheFLVPlaybackLocation : Rectangle;
		internal var cacheSkinAutoHide : Boolean;
	/**
	* Default value of volumeBarInterval		 *         * @see #volumeBarInterval         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const VOLUME_BAR_INTERVAL_DEFAULT : Number;
	/**
	* Default value of volumeBarScrubTolerance.		 *         * @see #volumeBarScrubTolerance         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const VOLUME_BAR_SCRUB_TOLERANCE_DEFAULT : Number;
	/**
	* Default value of seekBarInterval		 *         * @see #seekBarInterval         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const SEEK_BAR_INTERVAL_DEFAULT : Number;
	/**
	* Default value of seekBarScrubTolerance.		 *         * @see #seekBarScrubTolerance         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const SEEK_BAR_SCRUB_TOLERANCE_DEFAULT : Number;
	/**
	* Default value of bufferingDelayInterval.		 *         * @see #seekBarInterval         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static const BUFFERING_DELAY_INTERVAL_DEFAULT : Number;
		internal static var layoutNameToIndexMappings : Object;
		internal static var layoutNameArray : Array;
		internal static var skinClassPrefixes : Array;
		internal static var customComponentClassNames : Array;
		internal static var buttonSkinLinkageIDs : Array;

	/**
	* If true, we hide and disable certain controls when the		 * buffering bar is displayed.  The seek bar will be hidden, the		 * play, pause, play/pause, forward and back buttons would be		 * disabled.  Default is false.  This only has effect if there         * is a buffering bar control.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get bufferingBarHidesAndDisablesOthers () : Boolean;

		public function set bufferingBarHidesAndDisablesOthers (b:Boolean) : Void;

		public function get controlsEnabled () : Boolean;

		public function set controlsEnabled (flag:Boolean) : Void;

		public function get fullScreenBackgroundColor () : uint;

		public function set fullScreenBackgroundColor (c:uint) : Void;

		public function get fullScreenSkinDelay () : int;

		public function set fullScreenSkinDelay (i:int) : Void;

		public function get fullScreenTakeOver () : Boolean;

		public function set fullScreenTakeOver (v:Boolean) : Void;

	/**
	* String URL of skin swf to download.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get skin () : String;

		public function set skin (s:String) : Void;

		public function get skinAutoHide () : Boolean;

		public function set skinAutoHide (b:Boolean) : Void;

		public function get skinBackgroundAlpha () : Number;

		public function set skinBackgroundAlpha (a:Number) : Void;

		public function get skinBackgroundColor () : uint;

		public function set skinBackgroundColor (c:uint) : Void;

		public function get skinFadeTime () : int;

		public function set skinFadeTime (i:int) : Void;

		public function get skinReady () : Boolean;

	/**
	* Determines how often check the seek bar handle location when		 * scubbing, in milliseconds.         *         * @default 250		 * 		 * @see #SEEK_BAR_INTERVAL_DEFAULT
	*/
		public function get seekBarInterval () : Number;

		public function set seekBarInterval (s:Number) : Void;

	/**
	* Determines how often check the volume bar handle location when		 * scubbing, in milliseconds.         *         * @default 250		 *          * @see #VOLUME_BAR_INTERVAL_DEFAULT         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get volumeBarInterval () : Number;

		public function set volumeBarInterval (s:Number) : Void;

	/**
	* Determines how long after VideoState.BUFFERING state entered		 * we disable controls for buffering.  This delay is put into		 * place to avoid annoying rapid switching between states.         *		 * @default 1000		 *          * @see #BUFFERING_DELAY_INTERVAL_DEFAULT         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get bufferingDelayInterval () : Number;

		public function set bufferingDelayInterval (s:Number) : Void;

	/**
	* Determines how far user can move scrub bar before an update		 * will occur.  Specified in percentage from 1 to 100.  Set to 0		 * to indicate no scrub tolerance--always update volume on		 * volumeBarInterval regardless of how far user has moved handle.         *         * @default 0		 *         * @see #VOLUME_BAR_SCRUB_TOLERANCE_DEFAULT         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get volumeBarScrubTolerance () : Number;

		public function set volumeBarScrubTolerance (s:Number) : Void;

	/**
	* <p>Determines how far user can move scrub bar before an update		 * will occur.  Specified in percentage from 1 to 100.  Set to 0		 * to indicate no scrub tolerance--always update position on		 * seekBarInterval regardless of how far user has moved handle.		 * Default is 5.</p>		 *         * @see #SEEK_BAR_SCRUB_TOLERANCE_DEFAULT         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get seekBarScrubTolerance () : Number;

		public function set seekBarScrubTolerance (s:Number) : Void;

	/**
	* whether or not skin swf controls         * should be shown or hidden         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get visible () : Boolean;

		public function set visible (v:Boolean) : Void;

	/**
	* Constructor.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function UIManager (vc:FLVPlayback);
		internal static function initLayoutNameToIndexMappings () : void;
		internal function handleFullScreenEvent (e:FullScreenEvent) : void;
		internal function handleEvent (e:Event) : void;
		internal function handleSoundEvent (e:SoundEvent) : void;
		internal function handleLayoutEvent (e:LayoutEvent) : void;
		internal function handleIVPEvent (e:IVPEvent) : void;
		public function getControl (index:int) : Sprite;
		public function setControl (index:int, ctrl:Sprite) : void;
		internal function resetPlayPause () : void;
		internal function addButtonControl (ctrl:Sprite) : void;
		internal function handleButtonEvent (e:MouseEvent) : void;
		internal function captureMouseEvent (e:MouseEvent) : void;
		internal function handleMouseUp (e:MouseEvent) : void;
		internal function removeButtonListeners (ctrl:Sprite) : void;
	/**
	* start download of skin swf, called when skin property set.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function downloadSkin () : void;
	/**
	* Loader event handler function         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function handleLoadErrorEvent (e:ErrorEvent) : void;
	/**
	* Loader event handler function         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function handleLoad (e:Event) : void;
		internal function finishLoad (e:Event) : void;
	/**
	* layout all controls from loaded swf		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function layoutSkin () : void;
	/**
	* layout and recolor border_mc, via borderCopy filled with Bitmaps         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function bitmapCopyBorder () : void;
	/**
	* layout individual control from loaded swf		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function layoutControl (ctrl:DisplayObject) : void;
	/**
	* layout individual control from loaded swf		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function calcLayoutControl (ctrl:DisplayObject) : Rectangle;
	/**
	* remove controls from prev skin swf		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function removeSkin () : void;
	/**
	* set custom clip from loaded swf		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function setCustomClip (dispObj:DisplayObject) : void;
	/**
	* set skin clip from loaded swf		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function setSkin (index:int, avatar:DisplayObject) : void;
		internal function setTwoButtonHolderSkin (holderIndex:int, firstIndex:int, firstName:String, secondIndex:int, secondName:String) : Sprite;
		internal function setupButtonSkin (index:int) : Sprite;
		internal function setupButtonSkinState (ctrl:Sprite, definitionHolder:Sprite, skinName:String, defaultSkin:DisplayObject =null ) : DisplayObject;
		internal function setupBarSkinPart (ctrl:Sprite, avatar:DisplayObject, definitionHolder:Sprite, skinName:String, partName:String, required:Boolean =false) : DisplayObject;
		internal function createSkin (definitionHolder:DisplayObject, skinName:String) : DisplayObject;
	/**
	* skin button		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function skinButtonControl (ctrlOrEvent:Object) : void;
	/**
	* helper to skin button		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function applySkinState (ctrlData:ControlData, newState:DisplayObject) : void;
	/**
	* adds seek bar or volume bar		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function addBarControl (ctrl:Sprite) : void;
	/**
	* finish adding seek bar or volume bar onEnterFrame to allow for		 * initialization to complete		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function finishAddBarControl (ctrlOrEvent:Object) : void;
	/**
	* When a bar with a handle is removed from stage, cleanup the handle.		 * When it is added back to stage, put the handle back!		 *		 * @private         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function cleanupHandle (ctrlOrEvent:Object) : void;
	/**
	* Fix up progres or fullness bar		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function fixUpBar (definitionHolder:DisplayObject, propPrefix:String, ctrl:DisplayObject, name:String) : void;
	/**
	* Gets left and right margins for progress or fullness		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function calcBarMargins (ctrl:DisplayObject, type:String, symmetricMargins:Boolean) : void;
		internal static function getNumberPropSafe (obj:Object, propName:String) : Number;
		internal static function getBooleanPropSafe (obj:Object, propName:String) : Boolean;
	/**
	* finish adding buffer bar onEnterFrame to allow for initialization to complete		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function finishAddBufferingBar (e:Event =null) : void;
	/**
	* Place the buffering pattern and mask over the buffering bar         *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function positionMaskedFill (ctrl:DisplayObject, percent:Number) : void;
	/**
	* Default startHandleDrag function (can be defined on seek bar		 * movie clip instance) to handle start dragging the seek bar		 * handle or volume bar handle.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function startHandleDrag (ctrl:Sprite) : void;
	/**
	* Default stopHandleDrag function (can be defined on seek bar		 * movie clip instance) to handle stop dragging the seek bar		 * handle or volume bar handle.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function stopHandleDrag (ctrl:Sprite) : void;
	/**
	* Default positionHandle function (can be defined on seek bar		 * movie clip instance) to handle positioning seek bar handle.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function positionHandle (ctrl:Sprite) : void;
	/**
	* helper for other positioning funcs		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function positionBar (ctrl:Sprite, type:String, percent:Number) : void;
	/**
	* Default calcPercentageFromHandle function (can be defined on		 * seek bar movie clip instance) to handle calculating percentage		 * from seek bar handle position.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function calcPercentageFromHandle (ctrl:Sprite) : void;
	/**
	* Called to signal end of seek bar scrub.  Call from		 * onRelease and onReleaseOutside event listeners.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function handleRelease (index:int) : void;
	/**
	* Called on interval when user scrubbing by dragging seekbar handle.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function seekBarListener (e:TimerEvent) : void;
	/**
	* Called on interval when user scrubbing by dragging volumebar handle.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function volumeBarListener (e:TimerEvent) : void;
	/**
	* Called on interval do delay entering buffering state.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function doBufferingDelay (e:TimerEvent) : void;
		internal function dispatchMessage (index:int) : void;
		internal function setEnabledAndVisibleForState (index:int, state:String) : void;
		internal function setupSkinAutoHide (doFade:Boolean) : void;
		internal function skinAutoHideHitTest (e:TimerEvent, doFade:Boolean =true) : void;
		internal function skinFadeMore (e:TimerEvent) : void;
		internal function enterFullScreenTakeOver () : void;
		internal function exitFullScreenTakeOver () : void;
		internal function hookUpCustomComponents () : void;
}
}
