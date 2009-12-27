package mx.controls
{
	import mx.controls.listClasses.TileBase;
	import mx.controls.listClasses.TileBaseDirection;
	import mx.core.mx_internal;
	import mx.core.ScrollPolicy;

	[Exclude(name="direction", kind="property")] 

	[Exclude(name="maxColumns", kind="property")] 

	[Exclude(name="maxRows", kind="property")] 

	[Exclude(name="variableRowHeight", kind="property")] 

	[DefaultProperty("dataProvider")] 

include "../core/Version.as"
	/**
	 *  The HorizontalList control displays a horizontal list of items. 
 *  If there are more items than can be displayed at once, it
 *  can display a horizontal scroll bar so the user can access
 *  all items in the list.
 *
 *  <p>The HorizontalList control has the following default sizing 
 *     characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>Four columns, with size determined by the 
 *               cell dimensions.</td>
 *        </tr>
 *        <tr>
 *           <td>Minimum size</td>
 *           <td>0 pixels.</td>
 *        </tr>
 *        <tr>
 *           <td>Maximum size</td>
 *           <td>5000 by 5000.</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:HorizontalList&gt;</code> tag inherits all of the 
 *  tag attributes of its superclass and it adds no new tag attributes.</p>
 *
 *  <pre>
 *  &lt;mx:HorizontalList/&gt
 *  </pre>
 *
 *  @includeExample examples/HorizontalListExample.mxml
	 */
	public class HorizontalList extends TileBase
	{
		/**
		 *  Constructor.
		 */
		public function HorizontalList ();
	}
}
