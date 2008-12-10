package mx.containers
{
	import flash.events.Event;
	import mx.core.Application;
	import mx.core.mx_internal;
	import mx.styles.IStyleClient;

	/**
	 *  Alpha values used for the background fill of the container. *  The default value is <code>[0,0]</code>.
	 */
	[Style(name="fillAlphas", type="Array", arrayType="Number", inherit="no")] 
	/**
	 *  Colors used to tint the background of the container. *  Pass the same color for both values for a "flat" looking control. *  The default value is <code>[0xFFFFFF,0xFFFFFF]</code>. * *  <p>You should also set the <code>fillAlphas</code> property to  *  a nondefault value because its default value  *  of <code>[0,0]</code> makes the colors invisible.</p>
	 */
	[Style(name="fillColors", type="Array", arrayType="uint", format="Color", inherit="no")] 

	/**
	 *  The ApplicationControlBar container holds components *  that provide global navigation and application commands.  *  An ApplicationControlBar for an editor, for example, could include  *  Button controls for setting the font weight, a ComboBox control to select *  the font, and a MenuBar control to select the edit mode. Typically, you *  place an ApplicationControlBar container at the top of the application. * *  <p>The ApplicationControlBar container can be in either of the following *  modes:</p>  *  <ul> *    <li>Docked mode: The bar is always at the top of the application's *      drawing area and becomes part of the application chrome. *      Any application-level scroll bars don't apply to the component, so that *      it always remains at the top of the visible area, and the bar expands *      to fill the width of the application. To create a docked bar,  *      set the value of the <code>dock</code> property to *      <code>true</code>.</li> *       *    <li>Normal mode: The bar can be placed anywhere in the application,  *      gets sized and positioned just like any other component,  *      and scrolls with the application.  *      To create a normal bar, set the value of the <code>dock</code> property to *      <code>false</code> (default).</li> *  </ul> * *  <p>The ApplicationControlBar container has the following default sizing characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>The height is the default or explicit height of the tallest child, plus the top and bottom padding of the container.  *               In normal mode, the width is large enough to hold all of its children at the default or explicit width of the children, plus any horizontal gap between the children, plus the left and right padding of the container. In docked mode, the width equals the application width.  *               If the application is not wide enough to contain all the controls in the ApplicationControlBar container, the bar is clipped.</td> *        </tr> *        <tr> *           <td>Default padding</td> *           <td>5 pixels for the top value. *               <br>4 pixels for the bottom value. *               <br>8 pixels for the left and right values.</br> *           </td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:ApplicationControlBar&gt;</code> tag  *  inherits all of the tag attributes of its superclass, and adds the *  following tag attributes. *  Unlike the ControlBar container, it is possible to set the *  <code>backgroundColor</code> style for an ApplicationControlBar *  container.</p> * *  <pre> *  &lt;mx:ApplicationControlBar *    <strong>Properties</strong> *    dock="false|true" *   *    <strong>Styles</strong> *    fillAlphas="[0, 0]" *    fillColors="[0xFFFFFF, 0xFFFFFF]" *    &gt; *    ... *      <i>child tags</i> *    ... *  &lt;/mx:ApplicationControlBar&gt; *  </pre> * *  @includeExample examples/SimpleApplicationControlBarExample.mxml
	 */
	public class ApplicationControlBar extends ControlBar
	{
		/**
		 *  @private	 *  Whether the value of the <code>dock</code> property has changed.
		 */
		private var dockChanged : Boolean;
		/**
		 *  @private	 *  Storage for the dock property.
		 */
		private var _dock : Boolean;

		/**
		 *  If <code>true</code>, specifies that the ApplicationControlBar should be docked to the	 *  top of the application. If <code>false</code>, specifies that the ApplicationControlBar 	 *  gets sized and positioned just like any other component.	 *	 *  @default false
		 */
		public function get dock () : Boolean;
		/**
		 *  @private
		 */
		public function set dock (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function ApplicationControlBar ();
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private	 *  This method forces a recaldculation of docking the AppControlBar.
		 */
		public function resetDock (value:Boolean) : void;
	}
}
