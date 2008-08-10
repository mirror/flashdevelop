package fl.video
{
import flash.events.Event;
import flash.geom.Rectangle;

/**
* Flash<sup>&#xAE;</sup> Player dispatches an AutoLayoutEvent object when the video player is resized      * and laid out automatically. A video player is      * laid out automatically when the     * <code>maintainAspectRatio</code> property or <code>autoSize</code> property is set to      * <code>true</code> or when a new FLV file is loaded.      *      * <p>There is only one type of AutoLayoutEvent object:      * <code>AutoLayoutEvent.AUTO_LAYOUT</code>.</p>     *      * <p>After an attempt to automatically lay out a video player     * occurs, the event object is dispatched even if the dimensions were     * not changed. </p>     *      * <p>A <code>LayoutEvent</code> object is also dispatched in these three scenarios:</p>     * <ul>     * <li>If the video player that laid itself out is visible.</li>     * <li>If there are two video players of different sizes or positions and the      * <code>visibleVideoPlayerIndex</code> property is switched from one video player to another.</li>
*/
public class AutoLayoutEvent extends LayoutEvent implements IVPEvent
{
	/**
	* Defines the value of the          * <code>type</code> property of an          * <code>autoLayout</code> event object.         *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>oldBounds</code></td><td>The values of the <code>x</code>, <code>y</code>,          *        <code>width</code>, and <code>height</code> properties of the target before the <code>autoLayout</code> event occurs.</td></tr>         *     <tr><td><code>oldRegistrationBounds</code></td><td>The values of the <code>registrationX</code>,          * <code>registrationY</code>, <code>registrationWidth</code>, and          * <code>registrationHeight</code> properties of the target b
	*/
		public static const AUTO_LAYOUT : String;
		private var _vp : uint;

	/**
	* The index of the VideoPlayer object involved in this event.         *         * @see FLVPlayback#activeVideoPlayerIndex         * @see FLVPlayback#visibleVideoPlayerIndex         * @see FLVPlayback#getVideoPlayer()         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get vp () : uint;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set vp (n:uint) : Void;

	/**
	* Creates an Event object that contains information about <code>autoLayout</code> events.          * Event objects are passed as parameters to event listeners.         *         * @param type The type of the event. Event listeners can access this information          * through the inherited <code>type</code> property. There is only one type of          * auto layout event: <code>AutoLayoutEvent.AUTO_LAYOUT</code>.         *         * @param bubbles Determines whether the Event object participates in the bubbling          * stage of the event flow. Event listeners can access this information through          * the inherited <code>bubbles</code> property.         *          * @param cancelable Determines whether the Event object can be canceled. Event listeners          * can access this information through the inherited <code>cancelable</code> property.         *          * @param oldBounds Indicates the values of the <code>x</code>, <code>y</code>,          * <code>width</code>, and <
	*/
		public function AutoLayoutEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldBounds:Rectangle = null, oldRegistrationBounds:Rectangle = null, vp:uint =0 );
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function clone () : Event;
}
}
