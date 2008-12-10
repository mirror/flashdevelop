package mx.controls.listClasses
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import mx.collections.IViewCursor;
	import mx.core.FlexShape;
	import mx.core.FlexSprite;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  Background color of the component.
	 */
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no")] 

	/**
	 *  The ListBaseContentHolder class defines a container in a list-based control *  of all of the control's item renderers and item editors. *  Flex uses it to mask areas of the renderers that extend outside *  of the control, and to block certain styles, such as <code>backgroundColor</code>,  *  from propagating to the renderers so that highlights and  *  alternating row colors can show through the control. * *  @see mx.controls.listClasses.ListBase
	 */
	public class ListBaseContentHolder extends UIComponent
	{
		/**
		 *  The layer in the content defined by the <code>:istbase.listContent</code> property      *  where all selection and highlight indicators are drawn.
		 */
		public var selectionLayer : Sprite;
		/**
		 *  A hash table of data provider item renderers currently in view.     *  The table is indexed by the data provider item's UID and is used     *  to quickly get the renderer used to display a particular item.
		 */
		public var visibleData : Object;
		/**
		 *  An Array of Arrays that contains     *  the item renderer instances that render each data provider item.     *  This is a two-dimensional, row-major array, which means      *  an Array of rows that are Arrays of columns.
		 */
		public var listItems : Array;
		/**
		 *  An Array of ListRowInfo objects that cache row heights and      *  other tracking information for the rows defined in      *  the <code>listItems</code> property.
		 */
		public var rowInfo : Array;
		/**
		 *  The IViewCursor instance used to fetch items from the     *  data provider and pass the items to the renderers.     *  At the end of any sequence of code, it must always     *  be positioned at the top-most visible item being displayed.
		 */
		public var iterator : IViewCursor;
		/**
		 *  @private
		 */
		private var parentList : ListBase;
		/**
		 *  @private
		 */
		private var maskShape : Shape;
		/**
		 *  @private
		 */
		local var allowItemSizeChangeNotification : Boolean;
		/**
		 *  Offset, in pixels, for the upper-left corner in the list control of the content defined      *  by the <code>ListBase.listContent</code> property.     *     *  @see mx.controls.listClasses.ListBase#listContent
		 */
		public var leftOffset : Number;
		/**
		 *  Offset, in pixels, for the upper-left corner in the list control of the content defined      *  by the <code>ListBase.listContent</code> property.     *     *  @see mx.controls.listClasses.ListBase#listContent
		 */
		public var topOffset : Number;
		/**
		 *  Offset, in pixels, for the lower-right corner in the list control of the content defined      *  by the <code>ListBase.listContent</code> property.     *     *  @see mx.controls.listClasses.ListBase#listContent
		 */
		public var rightOffset : Number;
		/**
		 *  Offset, in pixels, for the lower-right corner in the list control of the content defined      *  by the <code>ListBase.listContent</code> property.     *     *  @see mx.controls.listClasses.ListBase#listContent
		 */
		public var bottomOffset : Number;

		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;
		/**
		 *  Height, in pixels excluding the top and     *  bottom offsets, of the central part of the content defined      *  by the <code>ListBase.listContent</code> property.     *     *  @see mx.controls.listClasses.ListBase#listContent
		 */
		public function get heightExcludingOffsets () : Number;
		/**
		 *  Width, in pixels excluding the top and     *  bottom offsets, of the central part of the content defined      *  by the <code>ListBase.listContent</code> property.     *     *  @see mx.controls.listClasses.ListBase#listContent
		 */
		public function get widthExcludingOffsets () : Number;

		/**
		 *  Constructor.     *     *  @param parentList The list-based control.
		 */
		public function ListBaseContentHolder (parentList:ListBase);
		/**
		 *  @private
		 */
		public function invalidateSize () : void;
		/**
		 *  Sets the position and size of the scroll bars and content     *  and adjusts the mask.     *     *  @param unscaledWidth Specifies the width of the component, in pixels,     *  in the component's coordinates, regardless of the value of the     *  <code>scaleX</code> property of the component.     *     *  @param unscaledHeight Specifies the height of the component, in pixels,     *  in the component's coordinates, regardless of the value of the     *  <code>scaleY</code> property of the component.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		function getParentList () : ListBase;
	}
}
