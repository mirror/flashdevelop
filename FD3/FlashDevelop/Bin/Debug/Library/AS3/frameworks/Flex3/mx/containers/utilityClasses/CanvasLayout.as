package mx.containers.utilityClasses
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import mx.containers.Canvas;
	import mx.containers.errors.ConstraintError;
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IConstraintClient;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.MoveEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.styles.StyleManager;
	import flash.utils.Dictionary;
	import mx.containers.utilityClasses.ConstraintColumn;
	import mx.core.IUIComponent;
	import mx.containers.utilityClasses.ConstraintRow;

	/**
	 *  @private *  The CanvasLayout class is for internal use only.
	 */
	public class CanvasLayout extends Layout
	{
		/**
		 *  @private
		 */
		private static var r : Rectangle;
		private var _contentArea : Rectangle;
		private var colSpanChildren : Array;
		private var rowSpanChildren : Array;
		private var constraintCache : Dictionary;
		private var constraintRegionsInUse : Boolean;

		/**
		 *  @private
		 */
		public function set target (value:Container) : void;

		/**
		 *  @private	 *  Restrict a number to a particular min and max.
		 */
		private function bound (a:Number, min:Number, max:Number) : Number;
		/**
		 *  Constructor.
		 */
		public function CanvasLayout ();
		/**
		 *  @private	 *  Measure container as per Canvas layout rules.
		 */
		public function measure () : void;
		/**
		 *  @private	 *  Lay out children as per Canvas layout rules.
		 */
		public function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private	 *  Figure out the content area based on whether there are 	 *  ConstraintColumn instances or ConstraintRow instances 	 *  specified and the constraint style values.
		 */
		private function applyAnchorStylesDuringMeasure (child:IUIComponent, r:Rectangle) : void;
		/**
		 *  @private	 *  Here is a description of the layout algorithm.	 *  It is described in terms of horizontal coordinates,	 *  but the vertical ones are similar.	 *	 *  1. First the actual width for the child is determined.	 *	 *  1a. If both left and right anchors are specified,	 *  the actual width is determined by them.	 *  However, the actual width is subject to the child's	 *  minWidth.	 *	 *  1b. Otherwise, if a percentWidth was specified,	 *  this percentage is applied to the 	 *  ConstraintColumn/Parent's content width	 *  (the widest specified point of content, or the width of	 *  the parent/column, whichever is greater).	 *  The actual width is subject to the child's	 *  minWidth and maxWidth.	 *	 *  1c. Otherwise, if an explicitWidth was specified,	 *  this is used as the actual width.	 *	 *  1d. Otherwise, the measuredWidth is used is used as the	 *  actual width.	 *	 *  2. Then the x coordinate of the child is determined.	 *	 *  Note:If a baseline constraint is specified, the center	 *  of the child (y position) is placed relative to the 	 *  ConstraintRow specified. 	 * 	 *  2a. If a horizonalCenter anchor is specified,	 *  the center of the child is placed relative to the center	 *  of the parent/column. 	 *	 *  2b. Otherwise, if a left anchor is specified,	 *  the left edge of the child is placed there.	 *	 *  2c. Otherwise, if a right anchor is specified,	 *  the right edge of the child is placed there.	 *	 *  2d. Otherwise, the child is left at its previously set	 *  x coordinate.	 *	 *  3. If the width is a percentage, try to make sure it	 *  doesn't overflow the content width (while still honoring	 *  minWidth). We need to wait	 *  until after the x coordinate is set to test this.
		 */
		private function applyAnchorStylesDuringUpdateDisplayList (availableWidth:Number, availableHeight:Number, child:IUIComponent = null) : void;
		/**
		 *  @private	 *  This function measures the bounds of the content area.	 *  It looks at each child included in the layout, and determines	 *  right and bottom edge.	 *	 *  When we are laying out the children, we use the larger of the	 *  content area and viewable area to determine percentages and 	 *  the edges for constraints.	 *  	 *  If the child has a percentageWidth or both left and right values	 *  set, the minWidth is used for determining its area. Otherwise	 *  the explicit or measured width is used. The same rules apply in 	 *  the vertical direction.
		 */
		private function measureContentArea () : Rectangle;
		/**
		 *  @private
		 */
		private function parseConstraints (child:IUIComponent = null) : ChildConstraintInfo;
		/**
		 *  @private	 *  This function measures the ConstraintColumns and 	 *  and ConstraintRows partitioning a Canvas and sets	 *  up their x/y positions. 	 * 	 *  The algorithm works like this (in the horizontal 	 *  direction):	 *  1. Fixed columns honor their pixel values.	 * 	 *  2. Content sized columns whose children span	 *  only that column assume the width of the widest child. 	 * 	 *  3. Those Content sized columns that span multiple 	 *  columns do the following:	 *    a. Sort the children by order of how many columns they	 *    are spanning.	 *    b. For children spanning a single column, make each 	 *    column as wide as the preferred size of the child.	 *    c. For subsequent children, divide the remainder space	 *    equally between shared columns. 	 * 	 *  4. Remaining space is shared between the percentage size	 *  columns. 	 * 	 *  5. x positions are set based on the column widths	 *
		 */
		private function measureColumnsAndRows () : void;
		/**
		 *  @private	 *  Shares available space between content-size columns that have content	 *  spanning them.
		 */
		private function shareColumnSpace (entry:ContentColumnChild, availableWidth:Number) : Number;
		/**
		 *  @private	 *  Shares available space between content-size rows that have content	 *  spanning them.
		 */
		private function shareRowSpace (entry:ContentRowChild, availableHeight:Number) : Number;
		/**
		 *  @private	 *  Collect all the layout constraints for this child and package	 *  into a LayoutConstraints object.	 *  Returns null if the child is not an IConstraintClient.
		 */
		private function getLayoutConstraints (child:IUIComponent) : LayoutConstraints;
		/**
		 *  @private	 *  Parses a constraint expression, like left="col1:10" 	 *  so that an array is returned where the first value is	 *  the boundary (ie: "col1") and the second value is 	 *  the offset (ie: 10)
		 */
		private function parseConstraintExp (val:String) : Array;
		/**
		 *  @private	 *  If a child has been added, listen for its move event.
		 */
		private function target_childAddHandler (event:ChildExistenceChangedEvent) : void;
		/**
		 *  @private	 *  If a child has been removed, stop listening for its move event.
		 */
		private function target_childRemoveHandler (event:ChildExistenceChangedEvent) : void;
		/**
		 *  @private	 *  If a child's position has changed, then the measured preferred	 *  size of this canvas may have changed.
		 */
		private function child_moveHandler (event:MoveEvent) : void;
	}
	/**
	 /////////////////////////////////////////////////////////////////////////////
	 */
	internal class ChildConstraintInfo
	{
		public var left : Number;
		public var right : Number;
		public var hc : Number;
		public var top : Number;
		public var bottom : Number;
		public var vc : Number;
		public var baseline : Number;
		public var leftBoundary : String;
		public var rightBoundary : String;
		public var hcBoundary : String;
		public var topBoundary : String;
		public var bottomBoundary : String;
		public var vcBoundary : String;
		public var baselineBoundary : String;

		/**
		 *  @private
		 */
		public function ChildConstraintInfo (left:Number, right:Number, hc:Number, top:Number, bottom:Number, vc:Number, baseline:Number, leftBoundary:String = null, rightBoundary:String = null, hcBoundary:String = null, topBoundary:String = null, bottomBoundary:String = null, vcBoundary:String = null, baselineBoundary:String = null);
	}
	/**
	 /////////////////////////////////////////////////////////////////////////////
	 */
	internal class ContentColumnChild
	{
		public var leftCol : ConstraintColumn;
		public var leftOffset : Number;
		public var left : Number;
		public var rightCol : ConstraintColumn;
		public var rightOffset : Number;
		public var right : Number;
		public var hcCol : ConstraintColumn;
		public var hcOffset : Number;
		public var hc : Number;
		public var child : IUIComponent;
		public var span : Number;

		/**
		 *  @private
		 */
		public function ContentColumnChild ();
	}
	/**
	 /////////////////////////////////////////////////////////////////////////////
	 */
	internal class ContentRowChild
	{
		public var topRow : ConstraintRow;
		public var topOffset : Number;
		public var top : Number;
		public var bottomRow : ConstraintRow;
		public var bottomOffset : Number;
		public var bottom : Number;
		public var vcRow : ConstraintRow;
		public var vcOffset : Number;
		public var vc : Number;
		public var baselineRow : ConstraintRow;
		public var baselineOffset : Number;
		public var baseline : Number;
		public var child : IUIComponent;
		public var span : Number;

		/**
		 *  @private
		 */
		public function ContentRowChild ();
	}
	/**
	 /////////////////////////////////////////////////////////////////////////////
	 */
	internal class LayoutConstraints
	{
		public var baseline : *;
		public var bottom : *;
		public var horizontalCenter : *;
		public var left : *;
		public var right : *;
		public var top : *;
		public var verticalCenter : *;

		/**
		 *  @private
		 */
		public function LayoutConstraints ();
	}
}
