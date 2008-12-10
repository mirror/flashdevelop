package mx.containers
{
	import mx.core.Container;
	import mx.core.ScrollPolicy;
	import mx.core.mx_internal;
	import mx.core.UIComponent;
	import mx.styles.IStyleClient;

	/**
	 *  The ControlBar container lets you place controls *  at the bottom of a Panel or TitleWindow container. *  The <code>&lt;mx:ControlBar&gt;</code> tag must be the last child tag *  of the enclosing tag for the Panel or TitleWindow container. * *  <p>The ControlBar is a Box with a background *  and default style properties.</p> * *  <p>A ControlBar container has the following default sizing characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>Height is the default or explicit height of the tallest child, plus the top and bottom padding of the container.  *               Width is large enough to hold all of its children at the default or explicit width of the children,  *               plus any horizontal gap between the children, plus the left and right padding of the container.</td> *        </tr> *        <tr> *           <td>Default padding</td> *           <td>10 pixels for the top, bottom, left, and right values.</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:ControlBar&gt;</code> tag inherits all the tag *  attributes but adds no additional attributes:</p> * *  <pre> *  &lt;mx:ControlBar&gt; *    ... *      <i>child tags</i> *    ... *  &lt;/mx:ControlBar&gt; *  </pre> * *  @includeExample examples/SimpleControlBarExample.mxml
	 */
	public class ControlBar extends Box
	{
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;
		/**
		 *  @private
		 */
		public function set includeInLayout (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function ControlBar ();
		/**
		 *  @private
		 */
		public function invalidateSize () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
	}
}
