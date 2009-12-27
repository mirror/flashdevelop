package mx.controls.dataGridClasses
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.DataGrid;
	import mx.core.EdgeMetrics;
	import mx.core.FlexSprite;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.events.DataGridEvent;
	import mx.managers.CursorManager;
	import mx.managers.CursorManagerPriority;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleManager;
	import mx.core.mx_internal;
	import mx.effects.easing.Back;

	/**
	 *  The DataGridHeaderBase class defines the base class for the DataGridHeader class,
 *  the class that defines the item renderer for the DataGrid control.
	 */
	public class DataGridHeaderBase extends UIComponent
	{
		/**
		 *  a layer to draw selections
		 */
		var selectionLayer : Sprite;
		/**
		 *  @private
     *  the set of columns for this header
		 */
		var visibleColumns : Array;
		/**
		 *  @private
     *  the set of columns for this header
		 */
		var headerItemsChanged : Boolean;

		/**
		 *  Constructor.
		 */
		public function DataGridHeaderBase ();

		/**
		 *  a function to clear selections
		 */
		function clearSelectionLayer () : void;
	}
}
