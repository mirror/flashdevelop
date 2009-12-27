package mx.skins.halo
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	import mx.core.IContainer;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;

include "../../core/Version.as"
	/**
	 *  The PanelSkin class defines the skin for the Panel, TitleWindow, and Alert components.
	 */
	public class PanelSkin extends HaloBorder
	{
		/**
		 *  @private
		 */
		private var oldHeaderHeight : Number;
		/**
		 *  @private
		 */
		private var oldControlBarHeight : Number;
		/**
		 *  @private
	 *  Internal object that contains the thickness of each edge
	 *  of the border
		 */
		protected var _panelBorderMetrics : EdgeMetrics;
		/**
		 *  We don't use 'is' to prevent dependency issues
		 */
		private static var panels : Object;

		/**
		 *  @private
     *  Return the thickness of the border edges.
     *
     *  @return Object  top, bottom, left, right thickness in pixels
		 */
		public function get borderMetrics () : EdgeMetrics;

		/**
		 *  Constructor
		 */
		public function PanelSkin ();

		/**
		 *  @private
	 *  If borderStyle may have changed, clear the cached border metrics.
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		function drawBorder (w:Number, h:Number) : void;

		/**
		 *  @private
		 */
		function drawBackground (w:Number, h:Number) : void;

		/**
		 *  @private
		 */
		function getBackgroundColorMetrics () : EdgeMetrics;

		private static function isPanel (parent:Object) : Boolean;
	}
}
