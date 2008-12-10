﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The BrowserChangeEvent class represents event objects specific to  *  the BrowserManager. *
	 */
	public class BrowserChangeEvent extends Event
	{
		/**
		 *  The <code>BrowserChangeEvent.APPLICATION_URL_CHANGE</code> constant defines the value of the      *  <code>type</code> property of the event object for a <code>applicationURLChange</code> event.     *      *  <p>The properties of the event object have the following values:</p>     *  <table class="innertable">     *     <tr><th>Property</th><th>Value</th></tr>     *     <tr><td><code>bubbles</code></td><td>false</td></tr>     *     <tr><td><code>cancelable</code></td><td>false</td></tr>     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the      *       event listener that handles the event. For example, if you use      *       <code>myButton.addEventListener()</code> to register an event listener,      *       myButton is the value of the <code>currentTarget</code>. </td></tr>     *     <tr><td><code>lastURL</code></td><td>The previous value of the BrowserManager's     *       <code>url</code> property.</td></tr>     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;      *       it is not always the Object listening for the event.      *       Use the <code>currentTarget</code> property to always access the      *       Object listening for the event.</td></tr>     *     <tr><td><code>url</code></td><td>The new value of the BrowserManager's     *       <code>url</code> property.</td></tr>     *  </table>     *     *  @eventType applicationURLChange
		 */
		public static const APPLICATION_URL_CHANGE : String = "applicationURLChange";
		/**
		 *  The <code>BrowserChangeEvent.BROWSER_URL_CHANGE</code> constant defines the value of the      *  <code>type</code> property of the event object for a <code>browserURLChange</code> event.     *      *  <p>The properties of the event object have the following values:</p>     *  <table class="innertable">     *     <tr><th>Property</th><th>Value</th></tr>     *     <tr><td><code>bubbles</code></td><td>false</td></tr>     *     <tr><td><code>cancelable</code></td><td>false</td></tr>     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the      *       event listener that handles the event. For example, if you use      *       <code>myButton.addEventListener()</code> to register an event listener,      *       myButton is the value of the <code>currentTarget</code>. </td></tr>     *     <tr><td><code>lastURL</code></td><td>The previous value of the BrowserManager's     *       <code>url</code> property.</td></tr>     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;      *       it is not always the Object listening for the event.      *       Use the <code>currentTarget</code> property to always access the      *       Object listening for the event.</td></tr>     *     <tr><td><code>url</code></td><td>The new value of the BrowserManager's     *       <code>url</code> property.</td></tr>     *  </table>     *     *  @eventType browserURLChange
		 */
		public static const BROWSER_URL_CHANGE : String = "browserURLChange";
		/**
		 *  The <code>BrowserChangeEvent.URL_CHANGE</code> constant defines the value of the      *  <code>type</code> property of the event object for a <code>urlChange</code> event.     *      *  <p>The properties of the event object have the following values:</p>     *  <table class="innertable">     *     <tr><th>Property</th><th>Value</th></tr>     *     <tr><td><code>bubbles</code></td><td>false</td></tr>     *     <tr><td><code>cancelable</code></td><td>false</td></tr>     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the      *       event listener that handles the event. For example, if you use      *       <code>myButton.addEventListener()</code> to register an event listener,      *       myButton is the value of the <code>currentTarget</code>. </td></tr>     *     <tr><td><code>lastURL</code></td><td>The previous value of the BrowserManager's     *       <code>url</code> property.</td></tr>     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;      *       it is not always the Object listening for the event.      *       Use the <code>currentTarget</code> property to always access the      *       Object listening for the event.</td></tr>     *     <tr><td><code>url</code></td><td>The new value of the BrowserManager's     *       <code>url</code> property.</td></tr>     *  </table>     *     *  @eventType urlChange
		 */
		public static const URL_CHANGE : String = "urlChange";
		/**
		 *  The previous value of the <code>url</code> property in the BrowserManager.
		 */
		public var lastURL : String;
		/**
		 *  The new value of the <code>url</code> property in the BrowserManager.
		 */
		public var url : String;

		/**
		 *  Constructor.     *     *  @param type The event type; indicates the action that caused the event.     *     *  @param bubbles Specifies whether the event can bubble up the display list hierarchy.     *     *  @param cancelable Specifies whether the behavior associated with the event can be prevented.     *     *  @param url Current URL in the browser.     *       *  @param lastURL Previous URL in the browser.
		 */
		public function BrowserChangeEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, url:String = null, lastURL:String = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}
