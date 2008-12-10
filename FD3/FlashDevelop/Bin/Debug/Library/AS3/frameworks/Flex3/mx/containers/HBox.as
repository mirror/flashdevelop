﻿package mx.containers
{
	import mx.core.mx_internal;

	/**
	 *  The HBox container lays out its children in a single horizontal row. *  You use the <code>&lt;mx:HBox&gt;</code> tag instead of the *  <code>&lt;mx:Box&gt;</code> tag as a shortcut to avoid having to *  set the <code>direction</code> property to *  <code>"horizontal"</code>. *   *  <p>An HBox container has the following default sizing characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>The width is large enough to hold all its children at the default or explicit width of the children,  *               plus any horizontal gap between the children, plus the left and right padding of the container.  *               The height is the default or explicit height of the tallest child,  *               plus the top and bottom padding for the container. *           </td> *        </tr> *        <tr> *           <td>Default padding</td> *           <td>0 pixels for the top, bottom, left, and right values.</td> *        </tr> *     </table> * *  @mxml *   *  <p>The <code>&lt;mx:HBox&gt;</code> tag inherits all of the tag  *  attributes of its superclass, except <code>direction</code>, and adds  *  no new tag attributes.</p> * *  @includeExample examples/HBoxExample.mxml * *  @see mx.containers.Box *  @see mx.containers.VBox
	 */
	public class HBox extends Box
	{
		/**
		 *  @private	 *  Don't allow user to change the direction
		 */
		public function set direction (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function HBox ();
	}
}
