/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.listClasses {
	import mx.core.UIComponent;
	public class ListBaseContentHolder extends UIComponent {
		/**
		 * Offset, in pixels, for the lower-right corner in the list control of the content defined
		 *  by the ListBase.listContent property.
		 */
		public var bottomOffset:Number = 0;
		/**
		 * Height, in pixels excluding the top and
		 *  bottom offsets, of the central part of the content defined
		 *  by the ListBase.listContent property.
		 */
		public function get heightExcludingOffsets():Number;
		/**
		 * The IViewCursor instance used to fetch items from the
		 *  data provider and pass the items to the renderers.
		 *  At the end of any sequence of code, it must always
		 *  be positioned at the top-most visible item being displayed.
		 */
		public var iterator:IViewCursor;
		/**
		 * Offset, in pixels, for the upper-left corner in the list control of the content defined
		 *  by the ListBase.listContent property.
		 */
		public var leftOffset:Number = 0;
		/**
		 * An Array of Arrays that contains
		 *  the item renderer instances that render each data provider item.
		 *  This is a two-dimensional, row-major array, which means
		 *  an Array of rows that are Arrays of columns.
		 */
		public var listItems:Array;
		/**
		 * Offset, in pixels, for the lower-right corner in the list control of the content defined
		 *  by the ListBase.listContent property.
		 */
		public var rightOffset:Number = 0;
		/**
		 * An Array of ListRowInfo objects that cache row heights and
		 *  other tracking information for the rows defined in
		 *  the listItems property.
		 */
		public var rowInfo:Array;
		/**
		 * The layer in the content defined by the :istbase.listContent property
		 *  where all selection and highlight indicators are drawn.
		 */
		public var selectionLayer:Sprite;
		/**
		 * Offset, in pixels, for the upper-left corner in the list control of the content defined
		 *  by the ListBase.listContent property.
		 */
		public var topOffset:Number = 0;
		/**
		 * A hash table of data provider item renderers currently in view.
		 *  The table is indexed by the data provider item's UID and is used
		 *  to quickly get the renderer used to display a particular item.
		 */
		public var visibleData:Object;
		/**
		 * Width, in pixels excluding the top and
		 *  bottom offsets, of the central part of the content defined
		 *  by the ListBase.listContent property.
		 */
		public function get widthExcludingOffsets():Number;
		/**
		 * Constructor.
		 *
		 * @param parentList        <ListBase> The list-based control.
		 */
		public function ListBaseContentHolder(parentList:ListBase);
		/**
		 * Sets the position and size of the scroll bars and content
		 *  and adjusts the mask.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void;
	}
}
