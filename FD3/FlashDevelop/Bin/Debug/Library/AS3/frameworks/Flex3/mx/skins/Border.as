package mx.skins
{
	import mx.core.EdgeMetrics;
	import mx.core.IBorder;

include "../core/Version.as"
	/**
	 *  The Border class is an abstract base class for various classes that
 *  draw borders, either rectangular or non-rectangular, around UIComponents.
 *  This class does not do any actual drawing itself.
 *
 *  <p>If you create a new non-rectangular border class, you should extend
 *  this class.
 *  If you create a new rectangular border class, you should extend the
 *  abstract subclass RectangularBorder.</p>
 *
 *  @tiptext
 *  @helpid 3321
	 */
	public class Border extends ProgrammaticSkin implements IBorder
	{
		/**
		 *  The thickness of the border edges.
	 *
	 *  @return EdgeMetrics with left, top, right, bottom thickness in pixels
		 */
		public function get borderMetrics () : EdgeMetrics;

		/**
		 *  Constructor.
		 */
		public function Border ();
	}
}
