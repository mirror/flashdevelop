package mx.containers.utilityClasses
{
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;

include "../../core/Version.as"
	/**
	 *  @private
 *  The ApplicationLayout class is for internal use only.
	 */
	public class ApplicationLayout extends BoxLayout
	{
		/**
		 *  Constructor.
		 */
		public function ApplicationLayout ();

		/**
		 *  @private
	 *  Lay out children as per Application layout rules.
		 */
		public function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
	}
}
